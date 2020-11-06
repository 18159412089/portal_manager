$.parser.onComplete = function () {
    $("#loadingDiv").fadeOut("normal", function () {
        $(this).remove();
    });
};
//全局变量各区县数值Json
var earaJson = {};
var cityArray = [];
var xcqNum = 0, lwqNum = 0, lhsNum = 0, zpxNum = 0, ctxNum = 0, yxxNum = 0, haxNum = 0, zaxNum = 0, njxNum = 0,
    phxNum = 0, dsxNum = 0, glNum = 0, gxNum = 0, csNum = 0, tsNum = 0, zsNum = 0;
var pollutionMapArray = new Array();//污染源地图数组
var countPollutionNum = 0;//污染源总数
var iconMap = new HashMap();
$(function () {
    $('#pollutonId').datagrid('reload');
    //右边列表的缩起/展开小按钮

    $('body').on('click', '[data-toggle="shown"]', function () {
        var target = $(this).attr("data-target");
        var $target = $(target);
        if ($target.hasClass("show")) {
            $target.removeClass("show");
            $(this).removeClass("active");
            $(".map-reduction-box").animate({right:'50px'},400);
            $(".map-gridline-box").animate({right:'50px'},400);
        } else {
            $target.addClass("show");
            $(this).addClass("active");
            $(".map-reduction-box").animate({right:'370px'},500);
            $(".map-gridline-box").animate({right:'50px'},500);
        }
    });

    //小于1366人员列表默认关闭
    var body_w = $('body').width();
    // if (body_w < 1200) {
    //     var $target = $('.map-caselist-container');
    //     $target.removeClass("show");
    //     $target.find('.btn-collapse').removeClass("active");
    // }
    if (body_w < 1026) {
        $(".nav-box").css("width", "610px")
    } else {
        $(".nav-box").css("width", "876px")
    }

    //获取水、气各个标签的各区县数值Json
    $.ajax({
        type: 'POST',
        url: '/env/pollution2/countPollutionByArea',
        async: false,
        success: function (result) {
            earaJson = result.data;
            cityArray = result.county;
            var abridge = result.abridge;
            var html = "";
            for (var i = 0; i < cityArray.length; i++) {
                html += '<li class="item"><div class="personnel-parent alone-personnel-parent tableClass" ' +
                    'onclick="areaClick(this,\'' + cityArray[i] + '\',\'' + abridge[i] + '\')">' + cityArray[i] +
                    '<span id="' + abridge[i] + '">0</span>个</div></li>';
            }
            $('#areaList').html(html);


        }
    });

    //地图还原
    $(".map-reduction-box").click(function () {
        areaName = ""
        setCountyArea()
        getAllPollutionSource();
        areaName = "";
        colorForTab(areaName)
        getTotalForTaglib();
        map.setCenterAndZoom(new fjzx.map.Point("117.76264335320418","24.369671575212295"),9.5);
        pollutionDataPoint();

    });

});

function words() {
    var num = 0;
    $('.no-choice').each(function () {//获取选中的污染源点击事件
        if ($(this).hasClass("choiced")) {
            num++;
            var tid = $(this).attr("id");
            var temp = new Array();
            switch (tid) {
                case "wsclc":
                    temp = earaJson.WadingIndustrialEnterprise;
                    break;
                case "cgpk":
                    temp = earaJson.SeaSewageOutlet;
                    break;
                case "sk":
                    temp = earaJson.SeaIndustrySolidWaste;
                    break;
                case "gyfsqy":
                    temp = earaJson.VOCsEnterprise;
                    break;
                case "wxszzdz":
                    temp = earaJson.ElevatedSourceEnterprise;
                    break;
                case "xly":
                    temp = earaJson.ScatteredEnterprise;
                    break;
                case "fqpk":
                    temp = earaJson.IndustrialSolidWaste;
                    break;
                case "gd":
                    temp = earaJson.IndustrialHazardousWaste;
                    break;
                case "sbc":
                    temp = earaJson.StonePlateIndustry;
                    break;
                case "gyfqqy":
                    temp = earaJson.LicensedMine;
                    break;
                case "fdlydy":
                    temp = earaJson.NonRoadMobileSource;
                    break;
                case "sghfc":
                    temp = earaJson.ThreeSepticTank;
                    break;
            }
            temp = Ams.isNoEmpty(temp) ? temp : new Array();
            for (var i = 0; i < temp.length; i++) {
                for (var j = 0; j < cityArray.length; j++) {
                    if (temp[i][cityArray[j]] != null) {
                        switch (cityArray[j]) {
                            case '长泰县':
                                ctxNum += temp[i][cityArray[j]];
                                break;
                            case '龙海市':
                                lhsNum += temp[i][cityArray[j]];
                                break;
                            case '平和县':
                                phxNum += temp[i][cityArray[j]];
                                break;
                            case '华安县':
                                haxNum += temp[i][cityArray[j]];
                                break;
                            case '漳浦县':
                                zpxNum += temp[i][cityArray[j]];
                                break;
                            case '南靖县':
                                njxNum += temp[i][cityArray[j]];
                                break;
                            case '云霄县':
                                yxxNum += temp[i][cityArray[j]];
                                break;
                            case '诏安县':
                                zaxNum += temp[i][cityArray[j]];
                                break;
                            case '芗城区':
                                xcqNum += temp[i][cityArray[j]];
                                break;
                            case '龙文区':
                                lwqNum += temp[i][cityArray[j]];
                                break;
                            case '东山县':
                                dsxNum += temp[i][cityArray[j]];
                                break;
                            case '台商投资区':
                                tsNum += temp[i][cityArray[j]];
                                break;
                            case '招商局漳州开发区':
                                zsNum += temp[i][cityArray[j]];
                                break;
                            case '常山华侨经济开发区':
                                csNum += temp[i][cityArray[j]];
                                break;
                            case '漳州高新技术产业开发区':
                                gxNum += temp[i][cityArray[j]];
                                break;
                            case '古雷港经济开发区':
                                glNum += Number(temp[i][cityArray[j]]);
                                break;
                        }
                    }
                }
            }
        }
    });

    if ($('.contaminated-personnel-ul').find('li').length == 6) {

        var html = '  截止<i>' + Ams.dateFormat(new Date(), "yyyy年MM月dd日") + '</i>各县（市、区）共上报涉环保5大类型污染源<i>' + num + '</i>种。其中：芗城区<i>' + xcqNum + '</i>个、' +
            '                龙文区<i>' + lwqNum + '</i>个、龙海区<i>' + lhsNum + '</i>个、漳浦县<i>' + zpxNum + '</i>个、云霄县<i>' + yxxNum + '</i>个、诏安县<i>' + zaxNum + '</i>个、' +
            '                东山县<i>' + dsxNum + '</i>个、平和县<i>' + phxNum + '</i>个、南靖县<i>' + njxNum + '</i>个、长泰县<i>' + ctxNum + '</i>个、华安县<i>' + haxNum + '</i>个、' +
            '                漳州开发区<i>' + zsNum + '</i>个、古雷开发区<i>' + glNum + '</i>个、台商投资区<i>' + tsNum + '</i>个、高新区<i>' + gxNum + '</i>个、常山开发区<i>' + csNum + '</i>个。';
        $('#analysis').html(html);
    } else {
        var html = '  截止<i>' + Ams.dateFormat(new Date(), "yyyy年MM月dd日") + '</i>各县（市、区）上报涉环保' + $('.contaminated-personnel-ul').find('li').eq(1).find('.personnel-parent').find('span').text() + '<i>' + num + '</i>种。其中：芗城区<i>' + xcqNum + '</i>个、' +
            '                龙文区<i>' + lwqNum + '</i>个、龙海区<i>' + lhsNum + '</i>个、漳浦县<i>' + zpxNum + '</i>个、云霄县<i>' + yxxNum + '</i>个、诏安县<i>' + zaxNum + '</i>个、' +
            '                东山县<i>' + dsxNum + '</i>个、平和县<i>' + phxNum + '</i>个、南靖县<i>' + njxNum + '</i>个、长泰县<i>' + ctxNum + '</i>个、华安县<i>' + haxNum + '</i>个、' +
            '                漳州开发区<i>' + zsNum + '</i>个、古雷开发区<i>' + glNum + '</i>个、台商投资区<i>' + tsNum + '</i>个、高新区<i>' + gxNum + '</i>个、常山开发区<i>' + csNum + '</i>个。';
        $('#analysis').html(html);
    }
}

$(window).resize(function () {
    //监听窗口变化，小于1366人员列表默认关闭
    var body_w = $('body').width();
    var $target = $('.map-caselist-container');
    if (body_w < 1200) {
        $target.removeClass("show");
        $target.find('.btn-collapse').removeClass("active");
    } else {
        $target.addClass("show");
        $target.find('.btn-collapse').addClass("active");
    }
});

/**
 * 右侧菜单tab伸缩
 */
$(".personnel-list-container").on("click", ".personnel-parent", function () {
    var $p = $(this);
    $p.siblings(".personnel-children").slideToggle("slow", function () {
        if ($(this).is(":visible")) {
            $p.addClass("collapsed");
            $p.next("div").show();
        } else {
            if ($p.hasClass("tableClass")) {
                getTotalForTaglib();
            }
            $p.next("div").hide();
            $p.removeClass("collapsed");
        }
    });
});


/*筛选与tabs的联动*/
$('.no-choice').click(function () {
    var cl_n = $(this);
    var tid = $(this).attr("id");
    var isChoose = false;
    $(".soil-table-box").find(".personnel-parent").removeClass("collapsed")
    $(".soil-table-box").find(".personnel-children").hide()
    if (cl_n.hasClass('choiced')) {
        cl_n.removeClass('choiced');
        clearMapPoint(tid);
        /*if (Ams.isNoEmpty(areaName)) {
            getNumberChanger(tid,Number($(this).text().replace(/[^0-9]/ig,"")),false,false)
        } else {
            getNumberChanger(tid,Number($(this).text().replace(/[^0-9]/ig,"")),false,true)
        }*/
    } else {
        cl_n.addClass('choiced');
        isChoose = true;
        if (Ams.isNoEmpty(areaName)) {
            areaPointMapData();
            // getNumberChanger(tid,Number($(this).text().replace(/[^0-9]/ig,"")),true,false)
        } else {
            pointAboutPollution(tid);
            // getNumberChanger(tid,Number($(this).text().replace(/[^0-9]/ig,"")),true,true)
        }

    }
    areaNameList(tid, isChoose);
});

//地图加载
$(function () {
        var longitude = "117.76264335320418";
        var latitude = "24.369671575212295";
        var body_w = $('body').width();
        var zoomValue = 9.45;
        if (body_w <= 1366) {
            zoomValue = 8.5
        }
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
            zoom: zoomValue,
            minZoom: zoomValue,
            maxZoom: 23
        });
        map.render();
        setCountyArea();
        pollutionDataPoint()

        //--------------------切换卫星图层开始------------------//
        var separation = 8;// 子组件展开时的间距。
        var size = 60;
        $('div.basemap-toggle').on({
            mouseenter: function (e) {
                expand(e);
            },
            mouseleave: function (e) {
                collapse(e);
            }
        });
        $('div.basemap-toggle').find('.basemap').click(function () {
            // 已经选中则返回。
            if (!!$(this).attr("selected")) {
                return;
            }
            var layerGroupName = $(this).attr("layer-group-name");
            $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index', 0);

            // 标记选中状态。
            $(this).attr("selected", "selected");
            //$(this).css("z-index", 10000);
            $(this).animate({
                top: 0
            }, 200);
            collapse(0);
            // 显示当前底图。
            map.getLayers().forEach(function (layer, i) {
                if (layer instanceof ol.layer.Group) {
                    layer.getLayers().forEach(function (sublayer, j) {
                        map.removeLayer(sublayer);
                    });
                }
            });
            var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
            map.setLayerGroup(layerGroup);
            setCountyArea();
        });

        function expand() {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            // 如果已经展开，则返回。
            if (!!$domNode.attr("expand")) {
                return;
            }
            // 标记展开状态。
            $domNode.attr("expand", "expand");
            // 将控制器的高度拉伸到可以覆盖所有展开项的位置，避免越界触发鼠标移出事件。
            $domNode.css("height", (size + separation) * baseMaps.length + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行展开并显示。
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).css("display", "block");
                    $(baseMaps[i]).animate({
                        top: "+=" + (size + separation) * count
                    }, 300, function (count) {
                        $(this).css("display", "block");
                        $(this).css("top", (size + separation) * count + "px");
                    });
                }
            }
        }

        function collapse(time) {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            if (Object.prototype.toString.call(time) !== "[object Number]") {
                time = 200;
            }
            // 如果没有展开，则返回。
            if (!$domNode.attr("expand")) {
                return false;
            }
            // 移出展开状态标记。
            $domNode.removeAttr("expand");
            $domNode.css("height", size + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行收起并隐藏。
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).animate({
                        top: "-=0"
                    }, time, function () {
                        $(this).css("display", "none");
                        $(this).css("top", 0);
                    });
                }
            }
        }

        //--------------------切换卫星图层结束------------------//

        map.removeSelectInteraction();
        $('.no-choice.choiced').each(function () {
            areaNameList($(this).attr("id"), true);
            if (Ams.isNoEmpty(areaName)) {
                areaPointMapData();
            } else {
                pointAboutPollution($(this).attr("id"));
            }
        })


    }
)

/**
 * 清除点位
 */
function clearMapPoint(tid) {
    clearMap(tid)

}


//地图分布点位描述===========================地图点位分布秒点
var wsclcPoint = new Array();
var wsclcMap = new Array();
var cgpkPoint = new Array();
var cgpkMap = new Array();
var skPoint = new Array();
var skMap = new Array();
var gyfqqyPoint = new Array();
var sbcPoint = new Array();
var sghfcPoint = new Array();
var fdlydyPoint = new Array();
var sghfcMap = new Array();
var fdlydyMap = new Array();
var gyfqqyMap = new Array();
var wxszzdzPoint = new Array();
var wxszzdzMap = new Array();
var xlyPoint = new Array();
var xlyMap = new Array();
var fqpkPoint = new Array();
var fqpkMap = new Array();
var gdPoint = new Array();
var gdMap = new Array();
var gyfsqyPoint = new Array();
var gyfsqyMap = new Array();
var sbcMap = new Array();


/**
 * 描述点位
 * @param tid 点位标签id
 */
var allMapPoint = new Array();//所有点位信息都装入这里;
function pointAboutPollution(tid) {
    //关于数据的描点情况书写点位信息
    var data = getTargetData(tid);
    var targetIcon = getIcon(tid);
    var lng = null;
    var lat = null;
    var name = null;

    //自己控制标注点加载速度
    /*var index = 0;
    console.log('data.length:'+data.length);
    var addMarkerInterval = setInterval(function(){
        var obj = data[index];
        console.log('-------------'+index+'--------------');
        if(index>=data.length || data.length <= 0){
            clearInterval(addMarkerInterval);
            return;
        }
        var lng = obj.jd;
        var lat = obj.wd;
        var name = obj.mc;
        if (!(!Ams.isNoEmpty(lng) || !Ams.isNoEmpty(lat) || !Ams.isNoEmpty(name))) {
            var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
                icon: targetIcon,
                map: map,
                title: name
            });

            pointMapPush(tid, tempMarker);
            map.addOverlay(tempMarker);
            addCaseClickEvent(tempMarker, obj);
        }
        index++;
    },300);*/

    //一次性加载全部标注点
    for (i = 0; i < data.length; i++) {
        lng = data[i].jd;
        lat = data[i].wd;
        name = data[i].mc;
        if (!Ams.isNoEmpty(lng) || !Ams.isNoEmpty(lat) || !Ams.isNoEmpty(name)) {
            continue;
        }
        var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
            icon: targetIcon,
            map: map,
            title: name
        });

        pointMapPush(tid, tempMarker);

        map.addOverlay(tempMarker);
        addCaseClickEvent(tempMarker, data[i]);
    }

    //使用聚合标注点显示（以后优化时修改）
    /*console.log(targetIcon.getSrc());
    var tempMarker = new fjzx.map.ClusterMarker({
        map: map,
        iconSmallPath: targetIcon.getSrc(),
        iconBigPath: targetIcon.getSrc(),
        type: 0,
        distance: 50
    });
    var clusterMarkerList = [];
    for (var i = 0; i < data.length; i++) {
        var pointData = data[i];
        pointData.longitude = pointData.jd;
        pointData.latitude = pointData.wd;
        lng = data[i].jd;
        lat = data[i].wd;
        name = data[i].mc;
        if (!Ams.isNoEmpty(lng) || !Ams.isNoEmpty(lat) || !Ams.isNoEmpty(name)) {
            continue;
        }
        clusterMarkerList.push(pointData);
    }
    console.log(clusterMarkerList);
    tempMarker.loadData(clusterMarkerList);*/
}

//地图添加点位
function addCaseClickEvent(markerName, info) {
    //marker点击事件
    markerName.addClick(function () {
        showDetail(info);
    });
}


var obj;//当前点击的对象
function showDetail(info) {
    obj = info;
    document.getElementById('mc').innerHTML = '<span style="font-weight:bold">名称：</span>' + Ams.formatNUll(info.mc);
    document.getElementById('czwt').innerHTML = '<span style="font-weight:bold">存在问题：</span>' + Ams.formatNUll(info.czwt);
    document.getElementById('zgcs').innerHTML = '<span style="font-weight:bold">整改措施：</span>' + Ams.formatNUll(info.zgcs);
    document.getElementById('zlxm').innerHTML = '<span style="font-weight:bold">治理项目：</span>' + Ams.formatNUll(info.zlxm);
    document.getElementById('wryzl').innerHTML = '<span style="font-weight:bold">污染源种类：</span>' + Ams.formatNUll(info.wryzl);
    document.getElementById('wrylx').innerHTML = '<span style="font-weight:bold">污染源类型：</span>' + Ams.formatNUll(info.wrylx);
    document.getElementById('wcmb201912').innerHTML = Ams.formatNUll(info.wcmb201912);
    document.getElementById('wcmb202006').innerHTML = Ams.formatNUll(info.wcmb202006);
    document.getElementById('wcmb202012').innerHTML = Ams.formatNUll(info.wcmb202012);
    document.getElementById('sdzrZrdw').innerHTML = '<span style="font-weight:bold">属地责任单位：</span>' + Ams.formatNUll(info.bmzrZrdw);
    document.getElementById('bmzrZrdw').innerHTML = '<span style="font-weight:bold">部门责任单位：</span>' + Ams.formatNUll(info.bmzrPhzrdw);
    document.getElementById('bmzrPhzrdw').innerHTML = '<span style="font-weight:bold">配合责任单位：</span>' + Ams.formatNUll(info.bmzrPhzrdw);

    document.getElementById('qx').innerHTML = '<span style="font-weight:bold">区县：</span>' + Ams.formatNUll(info.qx);
    document.getElementById('xz').innerHTML = '<span style="font-weight:bold">乡镇：</span>' + Ams.formatNUll(info.xz);
    document.getElementById('dz').innerHTML = '<span style="font-weight:bold">地址：</span>' + Ams.formatNUll(info.dz);
    document.getElementById('jd').innerHTML = '<span style="font-weight:bold">经度：</span>' + Ams.formatNUll(info.jd);
    document.getElementById('wd').innerHTML = '<span style="font-weight:bold">纬度：</span>' + Ams.formatNUll(info.wd);
    document.getElementById('bz').innerHTML = '<span style="font-weight:bold">备注：</span>' + Ams.formatNUll(info.bz);

    var sdzrdwZrrlxfsArr = formatPhoneAndName(info.sdzrdwZrrlxfs);
    var phzrdwZrrlxfsArr = formatPhoneAndName(info.phzrdwZrrlxfs);
    var bmzrdwZrrlxfsArr = formatPhoneAndName(info.bmzrdwZrrlxfs);
    var ph_lxfs = '-';
    var s = '、';
    var newChar = ",";
    if (Ams.isNoEmpty(phzrdwZrrlxfsArr[1])) {
        ph_lxfs = phzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + phzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + phzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
    }

    var sd_lxfs = '-';
    if (Ams.isNoEmpty(sdzrdwZrrlxfsArr[1])) {
        sd_lxfs = sdzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + sdzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + sdzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
    }

    var bm_lxfs = '-';
    if (Ams.isNoEmpty(bmzrdwZrrlxfsArr[1])) {
        bm_lxfs = bmzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + bmzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + bmzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
    }

    document.getElementById('ph_fzr').innerHTML = '<span style="font-weight:bold">责任人：</span>' + Ams.formatNUll(phzrdwZrrlxfsArr[0]);
    document.getElementById('ph_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + ph_lxfs;
    document.getElementById('sd_fzr').innerHTML = '<span style="font-weight:bold">负责人：</span>' + Ams.formatNUll(sdzrdwZrrlxfsArr[0]);
    document.getElementById('sd_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + sd_lxfs;
    document.getElementById('bm_fzr').innerHTML = '<span style="font-weight:bold">责任人：</span>' + Ams.formatNUll(bmzrdwZrrlxfsArr[0]);
    document.getElementById('bm_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + bm_lxfs;
    $('#infoDlg').dialog('open').dialog('center').dialog('setTitle', '详情');
    findTimelineData();
}

/**
 * 获取目标点位数据
 * @param tid 点位标签id
 * @returns {any[]}
 */
function getTargetData(tid) {
    var data;
    switch (tid) {
        case "wsclc":
            data = wsclcPoint;
            break;
        case "cgpk":
            data = cgpkPoint;
            break;
        case"sk":
            data = skPoint;
            break;
        case "gyfsqy":
            data = gyfsqyPoint;
            break;
        case"wxszzdz":
            data = wxszzdzPoint;
            break;
        case"xly":
            data = xlyPoint;
            break;
        case"fqpk":
            data = fqpkPoint;
            break;
        case"gd":
            data = gdPoint;
            break;
        case"gyfqqy":
            data = gyfqqyPoint;
            break;
        case"sbc":
            data = sbcPoint;
            break;
        case"fdlydy":
            data = fdlydyPoint;
            break;
        case"sghfc":
            data = sghfcPoint;
            break;

    }
    return data;
}

/**
 * 获取右侧污染源标签
 * @param tid 点位标签id
 * @returns {fjzx.map.Icon}
 */
function getIcon(tid) {
    var icon = "";
    var mapIcon = null;
    switch (tid) {
        case "wsclc":
            icon = "/static/images/ssgyqy-icon.png";
            break;
        case "cgpk":
            icon = "/static/images/hypk.png";
            break;
        case"sk":
            icon = "/static/images/hygygtfw-icon.png";
            break;
        case "gyfsqy":
            icon = "/static/images/VOCs-icon.png";
            break;
        case"wxszzdz":
            icon = "/static/images/gjyqy-icon.png";
            break;
        case"xly":
            icon = "/static/images/slwqy-icon.png";
            break;
        case"fqpk":
            icon = "/static/images/gyfq-icon.png";
            break;
        case"gd":
            icon = "/static/images/gywxfw-icon.png";
            break;
        case"gyfqqy":
            icon = "/static/images/stwry-icon.png";
            break;
        case"sbc":
            icon = "/static/images/ybgy-icon.png";
            break;
        case"fdlydy":
            icon = "/static/images/fdlydy-icon.png";
            break;
        case"sghfc":
            icon = "/static/images/sghfc-icon.png";
            break;
    }
    if (iconMap.get(tid) == null) {
        mapIcon = new fjzx.map.Icon(
            icon,
            {
                size: new fjzx.map.Size(30, 30),
                imgSize: new fjzx.map.Size(30, 30),
                anchor: new fjzx.map.Point(0, 30)
            }
        );
        iconMap.put(tid, mapIcon);
    } else {
        mapIcon = iconMap.get(tid);
    }
    return mapIcon;
}

/**
 * 添加点位标识数组
 * @param tid 点位标签id
 * @param tempMark
 */
function pointMapPush(tid, tempMark) {
    var data;
    allMapPoint.push(tempMark);
    switch (tid) {
        case "wsclc":
            data = wsclcMap.push(tempMark);
            break;
        case "cgpk":
            data = cgpkMap.push(tempMark);
            break;
        case"sk":
            data = skMap.push(tempMark);
            break;
        case "gyfsqy":
            data = gyfsqyMap.push(tempMark);
            break;
        case"wxszzdz":
            data = wxszzdzMap.push(tempMark);
            break;
        case"xly":
            data = xlyMap.push(tempMark);
            break;
        case"fqpk":
            data = fqpkMap.push(tempMark);
            break;
        case"gd":
            data = gdMap.push(tempMark);
            break;
        case"gyfqqy":
            data = gyfqqyMap.push(tempMark);
            break;
        case"sbc":
            data = sbcMap.push(tempMark);
            break;
        case"sghfc":
            data = sghfcMap.push(tempMark);
            break;
        case"fdlydy":
            data = fdlydyMap.push(tempMark);
            break;
    }
}

/**
 * 清空点位
 * @param tid 点位标签id
 */
function clearMap(tid) {
    var data;
    switch (tid) {
        case "wsclc":
            data = wsclcMap;
            break;
        case "cgpk":
            data = cgpkMap;
            break;
        case"sk":
            data = skMap;
            break;
        case "gyfqqy":
            data = gyfqqyMap;
            break;
        case"wxszzdz":
            data = wxszzdzMap;
            break;
        case"xly":
            data = xlyMap;
            break;
        case"fqpk":
            data = fqpkMap;
            break;
        case"gd":
            data = gdMap;
            break;
        case"gyfsqy":
            data = gyfsqyMap;
            break;
        case"sbc":
            data = sbcMap;
            break;
        case"fdlydy":
            data = fdlydyMap;
            break;
        case"sghfc":
            data = sghfcMap;
            break;

    }
    for (var i = 0; i < data.length; i++) {
        map.removeOverlay(data[i]);
    }
      if(oneMapPoint.length==1){
          map.removeOverlay(oneMapPoint[0]);
      }
}

// 动态修改元素高度
function ChangeHeight() {
    var alontVal = 101;
    var listHeight = $(window).height() - alontVal;
    $(".contaminated-personnel-list").css("height", listHeight + "px");
}

// 搜索框显示切换
$("#showSearch").click(function () {
    if ($(this).hasClass("select-Search")) {
        $(this).removeClass("select-Search");
        $(this).text("高级搜索")
        $(".searchInfo").hide();
        $(".soil-table-list").show();
    } else {
        $(this).addClass("select-Search");
        $(this).text("返回")
        $(".searchInfo").show();
        $(".soil-table-list").hide();
    }

})


//页面加载完成后执行
$(document).ready(function () {
    ChangeHeight();
    $(".searchInfo").hide();
    $(window).resize(function () {
        ChangeHeight()
    });

})

//----------------加载区县图层------------//
var names = [];
//台商投资区区域范围
var tstzq = [[117.91218541, 24.53546636], [117.91243741, 24.53553036], [117.91250241, 24.53505437], [117.91260241, 24.53509337], [117.91272741, 24.53460438], [117.91319041, 24.53472938], [117.91358541, 24.53469738], [117.91395541, 24.53486637], [117.91425541, 24.53490937], [117.91531041, 24.53476137], [117.91547041, 24.53484337], [117.91554641, 24.53481937], [117.91556041, 24.53467438], [117.91607441, 24.53467338], [117.91597041, 24.53527836], [117.91627941, 24.53540636], [117.91773741, 24.53530236], [117.91888241, 24.53545336], [117.91926241, 24.53507737], [117.91929741, 24.53489437], [117.91967841, 24.53435138], [117.91986141, 24.53442438], [117.92007441, 24.53412639], [117.92025441, 24.53419439], [117.92072441, 24.53399339], [117.92074941, 24.53419939], [117.92132241, 24.53405739], [117.92144841, 24.53414339], [117.92159441, 24.53400339], [117.92195341, 24.53427939], [117.92254941, 24.5335754], [117.92274641, 24.5335934], [117.92282141, 24.5335134], [117.92315441, 24.53294542], [117.92328841, 24.53291342], [117.92344341, 24.53308541], [117.92442941, 24.5337304], [117.92444041, 24.53341441], [117.92470141, 24.53328441], [117.92471641, 24.53299742], [117.92488941, 24.53297942], [117.92502241, 24.53304841], [117.92512041, 24.53279942], [117.92506241, 24.53263942], [117.92543141, 24.53231743], [117.92531241, 24.53270542], [117.92532841, 24.53308541], [117.92543441, 24.53325241], [117.92571741, 24.53343841], [117.92586741, 24.53316641], [117.92612541, 24.53317141], [117.92634441, 24.53298342], [117.92627541, 24.53285742], [117.92645841, 24.53265942], [117.92632041, 24.53261842], [117.92643041, 24.53250143], [117.92635741, 24.53238943], [117.92652841, 24.53224143], [117.92631841, 24.53198444], [117.92663841, 24.53172445], [117.92738341, 24.53147045], [117.92736341, 24.53130645], [117.92706441, 24.53075347], [117.92730941, 24.53070547], [117.92740041, 24.53059047], [117.92735841, 24.53008748], [117.92725041, 24.52986949], [117.92744841, 24.5294695], [117.92765241, 24.5294185], [117.92806141, 24.52900751], [117.92838041, 24.52905951], [117.92855041, 24.52897751], [117.92899941, 24.52868852], [117.92914541, 24.52843352], [117.92927341, 24.52837852], [117.92964041, 24.52829652], [117.93012941, 24.52833652], [117.93029741, 24.52844252], [117.93003641, 24.52808353], [117.92977341, 24.52801853], [117.92947841, 24.52806453], [117.92923341, 24.52765154], [117.92884741, 24.52752054], [117.92891941, 24.52737655], [117.92935541, 24.52707355], [117.92938541, 24.52690256], [117.92947941, 24.52681856], [117.92975341, 24.52677356], [117.92973541, 24.52650057], [117.92994941, 24.52647057], [117.93045841, 24.52620057], [117.93039841, 24.52612557], [117.93061441, 24.52589658], [117.93079041, 24.52596058], [117.93083041, 24.52574758], [117.93103741, 24.52548259], [117.93149641, 24.52538259], [117.93178141, 24.5249516], [117.93226441, 24.5248876], [117.93238541, 24.52462661], [117.93237841, 24.52246566], [117.93211441, 24.52169368], [117.93209441, 24.52138168], [117.93144841, 24.52019071], [117.93129641, 24.51979672], [117.93125841, 24.51943473], [117.93162341, 24.51918473], [117.93247441, 24.51823576], [117.93295241, 24.51785277], [117.93368641, 24.51791676], [117.93340141, 24.51747377], [117.93331341, 24.51708378], [117.93377841, 24.51558782], [117.93504541, 24.51534082], [117.93621541, 24.51491083], [117.93820641, 24.51459184], [117.93993041, 24.51478284], [117.94101241, 24.51427785], [117.94281441, 24.51404185], [117.94361141, 24.51404285], [117.94392841, 24.51388386], [117.94415341, 24.51354886], [117.94378141, 24.5120369], [117.94361341, 24.51081893], [117.94376941, 24.51031294], [117.94401341, 24.51017294], [117.94424941, 24.50989095], [117.94449041, 24.50935996], [117.94454941, 24.50904297], [117.94428941, 24.50848598], [117.94432741, 24.50793299], [117.94455241, 24.507523], [117.94479041, 24.50735601], [117.94507541, 24.50738601], [117.94582541, 24.507752], [117.94624541, 24.507742], [117.94663041, 24.507557], [117.94681841, 24.50708701], [117.94704941, 24.50691302], [117.94771741, 24.50684502], [117.94908641, 24.50652303], [117.95032341, 24.50488906], [117.95121841, 24.50398608], [117.95159541, 24.5035021], [117.95228841, 24.5035661], [117.95272641, 24.50369909], [117.95350541, 24.50374509], [117.95369841, 24.50368309], [117.95399141, 24.5034451], [117.95509041, 24.5032761], [117.95554741, 24.50312311], [117.95595741, 24.50288411], [117.95603341, 24.50265812], [117.95505741, 24.50092116], [117.95498441, 24.50031017], [117.95621341, 24.49833122], [117.95738941, 24.49742124], [117.95795041, 24.49718624], [117.95804141, 24.49705224], [117.95776041, 24.49580127], [117.95842441, 24.4945683], [117.95855341, 24.49363832], [117.95878041, 24.49349833], [117.95930341, 24.49346433], [117.95954041, 24.49327633], [117.95974041, 24.49294834], [117.96048541, 24.49266635], [117.96075741, 24.49235735], [117.95870541, 24.49004641], [117.95004341, 24.46585496], [117.94847941, 24.46126407], [117.94847841, 24.45200628], [117.94719241, 24.45286726], [117.94698441, 24.45307326], [117.94674541, 24.45349725], [117.94650641, 24.45371724], [117.94585341, 24.45406723], [117.94457641, 24.45447323], [117.94390141, 24.45507821], [117.94370341, 24.45517021], [117.94336141, 24.45525821], [117.94267641, 24.45514521], [117.94136841, 24.45587519], [117.93848341, 24.45691917], [117.93774741, 24.45730416], [117.93638741, 24.45763215], [117.93439541, 24.45849213], [117.93343041, 24.45872013], [117.93141741, 24.45935511], [117.93015141, 24.4600031], [117.92863741, 24.46038809], [117.92749641, 24.46089908], [117.92677041, 24.46106907], [117.92635541, 24.46126807], [117.92544241, 24.46152506], [117.92518341, 24.46157006], [117.92485141, 24.46151006], [117.92393441, 24.46204105], [117.92172441, 24.46292103], [117.92103141, 24.46319602], [117.91860141, 24.46388801], [117.91520341, 24.46521098], [117.91425441, 24.46582496], [117.91211641, 24.46720793], [117.90924441, 24.46925289], [117.90758941, 24.47053986], [117.90516441, 24.4730268], [117.90294541, 24.47511275], [117.90088941, 24.47663272], [117.89945841, 24.4774687], [117.89790941, 24.47822268], [117.89420841, 24.47940065], [117.89283241, 24.47977064], [117.88875841, 24.48028263], [117.88804741, 24.48034363], [117.88670441, 24.48064662], [117.88335641, 24.4815356], [117.88235341, 24.4817336], [117.87946541, 24.48194659], [117.87563541, 24.4818656], [117.87459341, 24.4817966], [117.87053641, 24.48191659], [117.86742041, 24.48218859], [117.86612641, 24.48241658], [117.86590041, 24.48249058], [117.86388241, 24.48321056], [117.86152241, 24.48380255], [117.85725541, 24.48470453], [117.85630441, 24.48483653], [117.85492241, 24.48483553], [117.85126941, 24.48543651], [117.84976741, 24.48543051], [117.84837841, 24.48553651], [117.84780141, 24.48553551], [117.84674141, 24.48537351], [117.84491041, 24.48479353], [117.84042841, 24.48397255], [117.83257641, 24.48205159], [117.83071741, 24.4816276], [117.82596341, 24.47977064], [117.82460841, 24.47911266], [117.82383441, 24.47854567], [117.82305241, 24.47813768], [117.82297141, 24.47798068], [117.82303541, 24.47768869], [117.82369141, 24.47650072], [117.82377041, 24.47621172], [117.82288341, 24.47599373], [117.82234341, 24.47683271], [117.82229441, 24.47848367], [117.82184241, 24.47852967], [117.82025241, 24.47838767], [117.81772741, 24.47800168], [117.81553741, 24.4774867], [117.81426441, 24.47700371], [117.81323641, 24.47638772], [117.81289741, 24.47625872], [117.81156541, 24.47588173], [117.80896841, 24.47529375], [117.80840141, 24.47522575], [117.80796841, 24.47531575], [117.80688941, 24.47596973], [117.80518741, 24.47696771], [117.80343441, 24.47775969], [117.80205941, 24.47851367], [117.80118641, 24.47888266], [117.80093341, 24.47891166], [117.80072041, 24.47880367], [117.80122441, 24.47811168], [117.80166241, 24.47688471], [117.80182641, 24.47640272], [117.80207741, 24.47482976], [117.80274041, 24.4729308], [117.80371141, 24.47160583], [117.80436041, 24.47090585], [117.80466441, 24.47021286], [117.80466041, 24.46821691], [117.80460241, 24.46789292], [117.80430941, 24.46757992], [117.80422341, 24.46735993], [117.80403241, 24.46744093], [117.80364441, 24.46743193], [117.80352641, 24.46750393], [117.80313441, 24.46731293], [117.80223041, 24.46711593], [117.79947941, 24.46753292], [117.79807741, 24.46787692], [117.79762341, 24.46792092], [117.79720541, 24.46784692], [117.79698841, 24.46797591], [117.79509741, 24.4685279], [117.79406341, 24.46899689], [117.79272541, 24.46973987], [117.79222441, 24.46991487], [117.79136441, 24.47043286], [117.79001741, 24.47160383], [117.78903741, 24.47220182], [117.78851941, 24.47266781], [117.78692341, 24.47472276], [117.78570341, 24.47694971], [117.78477941, 24.47895266], [117.78435241, 24.48020263], [117.78382941, 24.48126561], [117.78627441, 24.48269658], [117.78671841, 24.48259758], [117.78777341, 24.48338856], [117.78921641, 24.48491152], [117.78981541, 24.4858285], [117.78997241, 24.4861565], [117.79004341, 24.48651349], [117.79032041, 24.48838644], [117.79088041, 24.48891343], [117.79246541, 24.48985541], [117.79103641, 24.49290034], [117.78841041, 24.49639626], [117.78682841, 24.49623226], [117.78669741, 24.49715824], [117.78645941, 24.49775423], [117.78619841, 24.4988532], [117.78589841, 24.49947019], [117.78580241, 24.49999418], [117.78526341, 24.50090616], [117.78505641, 24.50148914], [117.78480541, 24.50519206], [117.78478741, 24.5121349], [117.78754041, 24.5121319], [117.78934641, 24.51230189], [117.78962641, 24.51262289], [117.78992941, 24.51263889], [117.78985041, 24.51341587], [117.79097841, 24.51342887], [117.79098941, 24.51350387], [117.79169041, 24.51351087], [117.79165841, 24.51391286], [117.79220241, 24.51405285], [117.79218841, 24.51415485], [117.79245541, 24.51425885], [117.79253841, 24.51418385], [117.79262541, 24.51378286], [117.79293041, 24.51374786], [117.79299041, 24.51367886], [117.79301141, 24.51305788], [117.79284141, 24.51292488], [117.79253341, 24.51290088], [117.79229941, 24.51271688], [117.79165541, 24.51271888], [117.79153941, 24.51261889], [117.79156841, 24.51240889], [117.79175341, 24.5121279], [117.79224441, 24.5119409], [117.79289641, 24.5118619], [117.79315941, 24.51163391], [117.79325441, 24.51143091], [117.79337041, 24.51111492], [117.79329241, 24.51096492], [117.79356541, 24.51077193], [117.79357941, 24.51087993], [117.79348641, 24.51100192], [117.79355341, 24.51118292], [117.79346541, 24.51140391], [117.79368741, 24.51156091], [117.79370941, 24.5120879], [117.79357841, 24.51243489], [117.79331641, 24.51274088], [117.79335441, 24.51326587], [117.79292641, 24.51428185], [117.79308741, 24.51489083], [117.79281741, 24.51511783], [117.79255341, 24.51520683], [117.79205641, 24.51720778], [117.79403941, 24.51741078], [117.79458641, 24.51781377], [117.79487641, 24.51829076], [117.79536241, 24.51840775], [117.79614241, 24.51920473], [117.79613241, 24.51957473], [117.79594841, 24.51996872], [117.79601541, 24.52008371], [117.79580641, 24.52010471], [117.79546241, 24.51946273], [117.79499841, 24.51908474], [117.79487141, 24.51886174], [117.79465541, 24.51890474], [117.79417241, 24.51919273], [117.79410841, 24.51918273], [117.79398441, 24.51890874], [117.79370341, 24.51877574], [117.79342841, 24.51888474], [117.79319741, 24.51910674], [117.79238241, 24.51891574], [117.79220341, 24.51877574], [117.79191441, 24.51891874], [117.79142241, 24.51816376], [117.79125141, 24.51810476], [117.79070441, 24.51849475], [117.79061741, 24.51845075], [117.79028941, 24.51784277], [117.78883541, 24.51756977], [117.78865941, 24.51750077], [117.78863041, 24.51737878], [117.78700841, 24.51782477], [117.78688341, 24.51768577], [117.78704441, 24.51723778], [117.78753241, 24.51668679], [117.78689541, 24.51659979], [117.78526341, 24.51665179], [117.78534141, 24.51690979], [117.78527941, 24.51731978], [117.78535641, 24.51735278], [117.78518241, 24.51771477], [117.78474141, 24.51941173], [117.78465041, 24.5205957], [117.78476841, 24.52163468], [117.78498541, 24.52258966], [117.78535141, 24.52335564], [117.78545641, 24.52376263], [117.78544641, 24.52425062], [117.78523041, 24.52556359], [117.78479541, 24.52652956], [117.78419441, 24.52742054], [117.78356141, 24.52811953], [117.78230241, 24.52912851], [117.78229241, 24.5293305], [117.78262241, 24.52995349], [117.78276341, 24.53092146], [117.78262141, 24.53174544], [117.78267141, 24.53238643], [117.78322741, 24.53328941], [117.78395541, 24.5337814], [117.78403941, 24.53393439], [117.78402141, 24.53482437], [117.78411641, 24.53562335], [117.78446141, 24.53607434], [117.78472241, 24.53618034], [117.78517041, 24.53658233], [117.78549441, 24.53714732], [117.78564741, 24.53778231], [117.78559241, 24.53843129], [117.78566141, 24.53883328], [117.78625241, 24.53915027], [117.78660141, 24.53914727], [117.78705441, 24.53901628], [117.78728241, 24.53876928], [117.78946741, 24.53966626], [117.78986741, 24.53949527], [117.79024841, 24.53963626], [117.79083241, 24.53958326], [117.79133441, 24.53993026], [117.79142541, 24.54008025], [117.79146141, 24.54038525], [117.79190441, 24.54072024], [117.79283841, 24.54163022], [117.79318741, 24.54180221], [117.79345041, 24.54181021], [117.79362641, 24.54204921], [117.79405041, 24.54295219], [117.79440941, 24.54467115], [117.79467941, 24.54538913], [117.79488741, 24.54541613], [117.79542741, 24.54517013], [117.79648941, 24.54509214], [117.79726141, 24.54480814], [117.79761441, 24.54475714], [117.79865241, 24.54498114], [117.79943241, 24.54548313], [117.80000641, 24.54601612], [117.80053141, 24.54552413], [117.80096741, 24.54534913], [117.80142141, 24.54539413], [117.80200641, 24.54488314], [117.80259441, 24.54492914], [117.80303941, 24.54508414], [117.80540941, 24.54630511], [117.80586541, 24.5468101], [117.80652341, 24.54772208], [117.80701441, 24.54819606], [117.80803741, 24.54967903], [117.80846941, 24.55039101], [117.80860341, 24.550967], [117.80881041, 24.551009], [117.80962641, 24.550837], [117.80981841, 24.550948], [117.80998341, 24.55208697], [117.81008341, 24.55220397], [117.81038541, 24.55233497], [117.81092841, 24.55326295], [117.81080841, 24.55417493], [117.81097641, 24.55475391], [117.81079541, 24.55573789], [117.81037341, 24.55639288], [117.81040241, 24.55669487], [117.81052641, 24.55689286], [117.81122041, 24.55744685], [117.81172641, 24.55814783], [117.81240541, 24.55858183], [117.81265941, 24.55897882], [117.81284941, 24.5594868], [117.81297141, 24.56024579], [117.81283741, 24.56123776], [117.81233341, 24.56261773], [117.81243741, 24.56280973], [117.81267841, 24.56281573], [117.81282041, 24.56296872], [117.81259341, 24.56369871], [117.81244041, 24.5639707], [117.81249341, 24.56449969], [117.81219841, 24.56534167], [117.81342441, 24.56580666], [117.81454141, 24.56561666], [117.81544341, 24.56602265], [117.81580741, 24.56633065], [117.81592941, 24.56729562], [117.81614641, 24.56787961], [117.81649141, 24.5682736], [117.81718941, 24.5682966], [117.81753141, 24.5682166], [117.81796041, 24.56864159], [117.81844841, 24.56854059], [117.81951941, 24.56856359], [117.81957841, 24.56866259], [117.81928641, 24.56911358], [117.81926241, 24.56970457], [117.81942041, 24.57014056], [117.81980441, 24.57061455], [117.82180241, 24.57076554], [117.82330441, 24.57119253], [117.82475241, 24.57080554], [117.82554241, 24.57077754], [117.82630341, 24.57057955], [117.82664541, 24.57063655], [117.82765641, 24.57126453], [117.82828541, 24.57209351], [117.82896641, 24.5724625], [117.82944641, 24.5728615], [117.82959041, 24.57315449], [117.82944441, 24.57366348], [117.82947941, 24.57378547], [117.83102541, 24.57543344], [117.83137441, 24.57566443], [117.83171741, 24.57574643], [117.83220741, 24.57564243], [117.83279441, 24.57528644], [117.83329641, 24.57538444], [117.83378541, 24.57586643], [117.83399541, 24.57656741], [117.83411241, 24.57670641], [117.83526341, 24.5768234], [117.83605341, 24.5770094], [117.83613141, 24.57727639], [117.83640641, 24.57743239], [117.83656741, 24.57768838], [117.83663441, 24.57790638], [117.83655441, 24.57864136], [117.83685541, 24.57878036], [117.83731841, 24.57874436], [117.83763741, 24.57922335], [117.83803841, 24.57943334], [117.83853641, 24.57922235], [117.83992341, 24.57884336], [117.84019241, 24.57865536], [117.84045841, 24.57794138], [117.84062341, 24.5771434], [117.84077941, 24.5770304], [117.84139741, 24.5769864], [117.84158341, 24.5768174], [117.84161141, 24.57600242], [117.84225241, 24.57475445], [117.84228441, 24.57324149], [117.84239941, 24.57290749], [117.84277241, 24.5726685], [117.84345541, 24.5726875], [117.84378841, 24.57240551], [117.84568941, 24.57315149], [117.84636341, 24.57376247], [117.84736741, 24.57358148], [117.84805041, 24.57363148], [117.84876141, 24.57340548], [117.84909041, 24.57347548], [117.84970641, 24.57345248], [117.85040741, 24.57370948], [117.85132341, 24.57387847], [117.85166741, 24.57379447], [117.85219141, 24.57346548], [117.85474441, 24.57381947], [117.85552841, 24.57419846], [117.85574641, 24.57423946], [117.85595341, 24.57410447], [117.85662641, 24.57332848], [117.85693941, 24.57341848], [117.85749941, 24.57383947], [117.85829641, 24.57395847], [117.85918841, 24.57425446], [117.85941441, 24.57439346], [117.85958341, 24.57473345], [117.85965641, 24.57533744], [117.85998041, 24.57533944], [117.86014741, 24.57544344], [117.86025541, 24.57589642], [117.86060541, 24.57627242], [117.86049341, 24.57676041], [117.86067641, 24.57749539], [117.86139841, 24.57795438], [117.86197441, 24.57880036], [117.86194641, 24.57910835], [117.86160841, 24.57941834], [117.86153741, 24.57959034], [117.86162141, 24.57989233], [117.86167941, 24.5811503], [117.86201741, 24.58190429], [117.86327241, 24.58343625], [117.86336341, 24.58363325], [117.86347541, 24.58414523], [117.86338041, 24.58441823], [117.86359241, 24.58460322], [117.86361441, 24.58471622], [117.86356441, 24.58500621], [117.86331041, 24.5855372], [117.86346241, 24.58584619], [117.86345041, 24.58654418], [117.86399241, 24.58712517], [117.86450841, 24.58745916], [117.86487641, 24.58758015], [117.86496341, 24.58769015], [117.86496741, 24.58783415], [117.86463641, 24.58841014], [117.86440941, 24.58910212], [117.86422341, 24.58933611], [117.86399041, 24.58945111], [117.86401341, 24.58963011], [117.86426741, 24.5900091], [117.86471041, 24.59029809], [117.86511941, 24.59091908], [117.86538941, 24.59114607], [117.86557441, 24.59119407], [117.86579141, 24.59110807], [117.86630841, 24.59118607], [117.86688441, 24.59096408], [117.86732941, 24.59108907], [117.86792741, 24.59139607], [117.86839641, 24.59146006], [117.86912241, 24.59139007], [117.86969741, 24.59177306], [117.86993941, 24.59203505], [117.87028341, 24.59206505], [117.87081541, 24.59228105], [117.87114841, 24.59230305], [117.87145141, 24.59256004], [117.87168141, 24.59210705], [117.87203241, 24.59196605], [117.87236341, 24.59194905], [117.87275141, 24.59217005], [117.87321341, 24.59256304], [117.87342141, 24.59262404], [117.87416541, 24.59216305], [117.87432441, 24.59126707], [117.87467741, 24.59101208], [117.87497441, 24.59061508], [117.87527641, 24.59050709], [117.87561441, 24.59055109], [117.87586541, 24.59075608], [117.87643941, 24.59076208], [117.87703241, 24.59141207], [117.87747241, 24.59172806], [117.87817641, 24.59245504], [117.87849441, 24.59298603], [117.87875241, 24.59324302], [117.88007241, 24.59350802], [117.88144541, 24.594053], [117.88222841, 24.594086], [117.88215941, 24.59397901], [117.88216441, 24.59345802], [117.88256941, 24.59301803], [117.88290041, 24.59192405], [117.88355641, 24.59141607], [117.88375241, 24.59135307], [117.88402741, 24.59138107], [117.88434441, 24.59163906], [117.88447841, 24.59164306], [117.88520641, 24.59115407], [117.88593141, 24.59052309], [117.88615641, 24.59052209], [117.88666841, 24.59036209], [117.88736641, 24.59045809], [117.88755341, 24.59041909], [117.88770841, 24.5900981], [117.88856941, 24.58959111], [117.88990041, 24.58834614], [117.89057941, 24.58781015], [117.89111441, 24.58697917], [117.89164241, 24.58638418], [117.89269641, 24.5858062], [117.89307141, 24.5856732], [117.89335341, 24.58478922], [117.89404641, 24.58365425], [117.89461041, 24.58339025], [117.89497741, 24.58306926], [117.89543941, 24.58296726], [117.89595341, 24.58264527], [117.89683941, 24.58177029], [117.89752541, 24.58077931], [117.89847841, 24.58007833], [117.89852841, 24.57963834], [117.89888141, 24.57921135], [117.90024141, 24.57844837], [117.90060941, 24.57846437], [117.90147941, 24.57868136], [117.90311841, 24.57836237], [117.90416241, 24.57805137], [117.90526841, 24.57815637], [117.90565741, 24.57835037], [117.90592441, 24.57756739], [117.90585141, 24.57672941], [117.90651841, 24.57596242], [117.90728041, 24.57502644], [117.90751841, 24.57453546], [117.90805941, 24.5724445], [117.90849741, 24.57145153], [117.90853441, 24.57090154], [117.90868041, 24.57039455], [117.90868241, 24.56984556], [117.90847741, 24.56935058], [117.90811741, 24.56896159], [117.90665141, 24.56858759], [117.90498141, 24.56690463], [117.90497141, 24.56663264], [117.90517841, 24.56622465], [117.90565041, 24.56595465], [117.90562641, 24.56540967], [117.90551541, 24.56502368], [117.90510041, 24.56423969], [117.90489741, 24.56360771], [117.90487841, 24.56302872], [117.90494441, 24.56274373], [117.90478141, 24.56247873], [117.90476941, 24.56224874], [117.90442641, 24.56229974], [117.90433441, 24.56222874], [117.90455241, 24.56214474], [117.90453441, 24.56172075], [117.90474941, 24.56174875], [117.90471641, 24.56158976], [117.90408041, 24.56089277], [117.90368041, 24.56073877], [117.90364341, 24.56046478], [117.90343441, 24.56032078], [117.90334441, 24.56014079], [117.90323041, 24.5598378], [117.90323641, 24.5595808], [117.90306741, 24.55934881], [117.90307541, 24.55923381], [117.90293341, 24.55910081], [117.90274941, 24.55908981], [117.90242541, 24.55888782], [117.90207141, 24.55855983], [117.90158441, 24.55827383], [117.90157641, 24.55813484], [117.90194641, 24.55841483], [117.90206741, 24.55831483], [117.90242941, 24.55828083], [117.90243141, 24.55818983], [117.90260941, 24.55823583], [117.90262941, 24.55790584], [117.90304941, 24.55805684], [117.90342041, 24.55807084], [117.90333541, 24.55771884], [117.90359041, 24.55770784], [117.90362241, 24.55781684], [117.90370141, 24.55780884], [117.90347041, 24.55692186], [117.90265041, 24.55702986], [117.90267041, 24.55667987], [117.90280741, 24.55630188], [117.90272341, 24.55582089], [117.90287441, 24.5555289], [117.90330641, 24.55569989], [117.90341341, 24.55580889], [117.90387641, 24.55592489], [117.90385041, 24.55574989], [117.90393841, 24.5554559], [117.90408241, 24.5553119], [117.90395141, 24.5551889], [117.90406841, 24.55474391], [117.90421241, 24.55489091], [117.90446641, 24.55489191], [117.90447741, 24.55480091], [117.90465141, 24.55482891], [117.90492841, 24.55468991], [117.90496841, 24.55451692], [117.90508241, 24.55449992], [117.90499941, 24.55437892], [117.90512341, 24.55432592], [117.90512041, 24.55425893], [117.90616041, 24.55403693], [117.90625541, 24.55396493], [117.90614041, 24.55361194], [117.90619141, 24.55350594], [117.90605241, 24.55343994], [117.90602341, 24.55267496], [117.90576341, 24.55268396], [117.90535941, 24.55316195], [117.90510241, 24.55308095], [117.90509741, 24.55292196], [117.90538241, 24.55229097], [117.90552341, 24.55237797], [117.90596441, 24.55217897], [117.90619041, 24.55183198], [117.90619741, 24.55164799], [117.90641641, 24.55149299], [117.90635741, 24.55125399], [117.90653741, 24.55062701], [117.90628641, 24.55054201], [117.90648741, 24.54993802], [117.90668841, 24.54995302], [117.90672141, 24.54982703], [117.90672241, 24.54952403], [117.90653241, 24.54946304], [117.90655741, 24.54929104], [117.90644641, 24.54926404], [117.90648341, 24.54876405], [117.90673141, 24.54882605], [117.90676541, 24.54860706], [117.90661441, 24.54856706], [117.90669241, 24.54828406], [117.90657441, 24.54818107], [117.90661741, 24.54804207], [117.90674541, 24.54810407], [117.90680241, 24.54804707], [117.90684941, 24.54789007], [117.90701341, 24.54797307], [117.90717041, 24.54768408], [117.90667341, 24.54747508], [117.90653841, 24.54752908], [117.90596141, 24.54734908], [117.90554741, 24.54739008], [117.90527141, 24.54720909], [117.90528141, 24.54706509], [117.90515541, 24.5467821], [117.90518441, 24.5465001], [117.90531241, 24.54642111], [117.90533241, 24.54626311], [117.90544341, 24.54629411], [117.90544841, 24.54642111], [117.90562241, 24.5465131], [117.90569441, 24.54619711], [117.90605141, 24.54609011], [117.90628141, 24.54583512], [117.90618441, 24.54564612], [117.90625541, 24.54559813], [117.90628441, 24.54525413], [117.90734341, 24.54515113], [117.90721641, 24.54494514], [117.90715841, 24.54462215], [117.90705441, 24.54293519], [117.90729041, 24.54266219], [117.90718341, 24.5424362], [117.90758641, 24.54063724], [117.90685441, 24.54059624], [117.90669541, 24.53915927], [117.90755941, 24.53893328], [117.90778841, 24.53861029], [117.90802141, 24.53851729], [117.90834241, 24.5381923], [117.90867441, 24.53762231], [117.90887841, 24.53775231], [117.90945841, 24.53707932], [117.91071241, 24.53772031], [117.91151841, 24.5379033], [117.91182641, 24.5380393], [117.91201441, 24.53738631], [117.91206341, 24.53723932], [117.91151141, 24.53696532], [117.91167641, 24.53666733], [117.91167241, 24.53605834], [117.91173941, 24.53577135], [117.91202241, 24.53581735], [117.91218541, 24.53546636]];
//招商局漳州开发区
var zsjzzkfq = [[118.03270041, 24.41439315], [118.03287341, 24.41449014], [118.03281641, 24.41418615], [118.03291041, 24.41418015], [118.03290341, 24.41409215], [118.03278341, 24.41405015], [118.03267041, 24.41303418], [118.03347641, 24.41294618], [118.03378941, 24.41319417], [118.03403641, 24.41327217], [118.03420641, 24.41328417], [118.03444741, 24.41318717], [118.03469841, 24.41327317], [118.03552441, 24.41296018], [118.03574841, 24.41323917], [118.03596741, 24.41331317], [118.03643541, 24.41322717], [118.03709041, 24.41299318], [118.03781041, 24.41303518], [118.03826641, 24.41286618], [118.03882941, 24.41297818], [118.04058641, 24.41278418], [118.04091941, 24.41267119], [118.04136041, 24.41264319], [118.04151641, 24.41244819], [118.04184241, 24.41242019], [118.04201941, 24.41252819], [118.04330641, 24.41254519], [118.04353741, 24.41313218], [118.04367741, 24.41429315], [118.04352641, 24.41460814], [118.04266041, 24.41475714], [118.04268041, 24.41482714], [118.04300641, 24.41478814], [118.04306441, 24.41505913], [118.04442441, 24.41483214], [118.04437441, 24.41450914], [118.04497541, 24.41442015], [118.04505041, 24.41468514], [118.04631141, 24.41448814], [118.04629741, 24.41423415], [118.04702141, 24.41409015], [118.04699641, 24.41395716], [118.04665441, 24.41400716], [118.04646241, 24.41307918], [118.04633141, 24.41311718], [118.04617741, 24.4122122], [118.04618641, 24.41130722], [118.04626241, 24.41124822], [118.04703141, 24.41109422], [118.04709941, 24.41143121], [118.04674341, 24.41152421], [118.04677541, 24.41165421], [118.04826541, 24.41141522], [118.04823441, 24.41128822], [118.04786641, 24.41130522], [118.04781341, 24.41093123], [118.04801641, 24.41090823], [118.04847041, 24.41108722], [118.04917641, 24.41100022], [118.04923841, 24.41142521], [118.04939341, 24.41139222], [118.04947741, 24.4119452], [118.04980941, 24.4119462], [118.04992341, 24.41274818], [118.06186841, 24.41076923], [118.06184141, 24.41063823], [118.06446541, 24.41033524], [118.06445541, 24.41016724], [118.06401941, 24.41020724], [118.06400941, 24.40991025], [118.06475341, 24.40984025], [118.06487741, 24.40973025], [118.06488641, 24.40928826], [118.06521341, 24.40925326], [118.06521141, 24.40909227], [118.06541041, 24.40918127], [118.06568241, 24.40906827], [118.06578241, 24.40916627], [118.06589241, 24.40904327], [118.06589041, 24.40870228], [118.06626341, 24.40846728], [118.06645941, 24.40848128], [118.06638841, 24.40818429], [118.06665141, 24.4077253], [118.06675641, 24.4076733], [118.06702141, 24.4077053], [118.06742041, 24.40726531], [118.06773341, 24.4075153], [118.06787641, 24.40727831], [118.06759141, 24.40703832], [118.06799241, 24.40660533], [118.06770541, 24.40612834], [118.06772841, 24.40563835], [118.06780741, 24.40546635], [118.06770341, 24.40523736], [118.06794641, 24.40522336], [118.06798341, 24.40509036], [118.06787041, 24.40502336], [118.06785741, 24.40483137], [118.06804341, 24.40467137], [118.06822241, 24.40418138], [118.06872441, 24.40389739], [118.06883541, 24.40372139], [118.06907841, 24.40361239], [118.06914241, 24.4034954], [118.06914541, 24.4033514], [118.06903741, 24.4032124], [118.06903141, 24.40289641], [118.06895041, 24.40288641], [118.06883541, 24.40308441], [118.06868841, 24.40310041], [118.06844341, 24.40258242], [118.06864541, 24.40214643], [118.06882241, 24.40080146], [118.06874741, 24.39980248], [118.06839941, 24.39930649], [118.06838441, 24.39834952], [118.06843841, 24.39811552], [118.06815641, 24.39666555], [118.06797841, 24.39631156], [118.06743941, 24.39597257], [118.06757641, 24.39556358], [118.06748541, 24.39501259], [118.06756041, 24.3944756], [118.06750141, 24.39423861], [118.06754541, 24.39274964], [118.06715441, 24.39149967], [118.06683041, 24.39107268], [118.06566841, 24.39084069], [118.06506441, 24.39053469], [118.06391741, 24.3901357], [118.06250041, 24.38946372], [118.06157141, 24.38914273], [118.06090341, 24.38882273], [118.06062441, 24.38856474], [118.06018141, 24.38833375], [118.06015441, 24.38816775], [118.05928241, 24.38754876], [118.05806041, 24.38740677], [118.05561841, 24.38727477], [118.05531641, 24.38708177], [118.05535641, 24.38693978], [118.05517241, 24.38684478], [118.05508941, 24.38709377], [118.05492441, 24.38711777], [118.05456341, 24.38688878], [118.05432741, 24.38687778], [118.05434441, 24.38699278], [118.05404741, 24.38703678], [118.05359541, 24.38645979], [118.05309641, 24.3860598], [118.05284641, 24.38553381], [118.05225841, 24.38520982], [118.05208041, 24.38492082], [118.05153441, 24.38460683], [118.05150041, 24.38429984], [118.05160541, 24.38418184], [118.05161641, 24.38401584], [118.05139241, 24.38371885], [118.05128941, 24.38297187], [118.05131441, 24.38072892], [118.05152641, 24.37876296], [118.05229741, 24.37395208], [118.05282341, 24.37158113], [118.05310041, 24.37074115], [118.05390641, 24.36883119], [118.05428741, 24.3682942], [118.05354641, 24.36746122], [118.05346841, 24.36718623], [118.05354841, 24.36709623], [118.05380341, 24.36710823], [118.05442941, 24.36787321], [118.05458941, 24.36795721], [118.05487541, 24.36790421], [118.05521841, 24.36797621], [118.05550041, 24.36793921], [118.05563241, 24.36754922], [118.05584641, 24.36737823], [118.05592441, 24.36708223], [118.05623341, 24.36676724], [118.05652541, 24.36665324], [118.05694241, 24.36580426], [118.05659241, 24.36527927], [118.05601641, 24.36510128], [118.05527241, 24.36531227], [118.05503341, 24.36477729], [118.05500441, 24.3640253], [118.05428641, 24.36356431], [118.05460541, 24.36361231], [118.05413441, 24.36330532], [118.05431441, 24.36292233], [118.05454941, 24.36301733], [118.05448441, 24.36279633], [118.05425941, 24.36280133], [118.05427841, 24.36261634], [118.05338641, 24.36231534], [118.05311841, 24.36267133], [118.05267541, 24.36269233], [118.05256541, 24.36261534], [118.05256741, 24.36220334], [118.05244241, 24.36210835], [118.05181641, 24.36207035], [118.05183241, 24.36244434], [118.05177841, 24.36246934], [118.05152841, 24.36219534], [118.05088041, 24.36233634], [118.05078341, 24.36226034], [118.05101441, 24.36136136], [118.05120641, 24.36124137], [118.05110441, 24.36113737], [118.05118541, 24.36088337], [118.05134241, 24.36075838], [118.05199041, 24.35792344], [118.04380341, 24.35129759], [118.04330941, 24.35073461], [118.04070841, 24.34814867], [118.04036341, 24.34746268], [118.03989841, 24.34704669], [118.03922141, 24.34644271], [118.03773641, 24.34583672], [118.03347341, 24.3424788], [118.03255841, 24.3421158], [118.03173741, 24.34156582], [118.03089141, 24.34112283], [118.03016441, 24.34052184], [118.02956741, 24.33989686], [118.02905541, 24.33966386], [118.02740841, 24.33852189], [118.02586141, 24.33724392], [118.02538141, 24.33673493], [118.02487241, 24.33637594], [118.02409741, 24.33541896], [118.02332541, 24.33596695], [118.01906441, 24.33975886], [118.01857941, 24.33960386], [118.01829941, 24.33959786], [118.01791841, 24.33930087], [118.01773141, 24.33903588], [118.01759841, 24.3379829], [118.01749741, 24.3378729], [118.01702441, 24.33766891], [118.01667241, 24.33759391], [118.01662041, 24.33747191], [118.01642541, 24.33737891], [118.01591741, 24.33728292], [118.01582841, 24.33742891], [118.01586741, 24.33751191], [118.01560241, 24.3378309], [118.01512641, 24.3378329], [118.01505041, 24.3379509], [118.01487541, 24.3378509], [118.01481741, 24.3379549], [118.01515841, 24.33832689], [118.01531841, 24.33838889], [118.01570341, 24.3381879], [118.01592541, 24.33829289], [118.01564341, 24.33847589], [118.01546741, 24.33877988], [118.01562041, 24.33908287], [118.01549141, 24.33915887], [118.01520541, 24.33915087], [118.01506941, 24.33939987], [118.01428841, 24.33947387], [118.01412841, 24.33951687], [118.01400641, 24.33967586], [118.01398441, 24.33987186], [118.01453541, 24.34010185], [118.01472041, 24.34032985], [118.01476141, 24.34069984], [118.01462241, 24.34107383], [118.01399941, 24.34095283], [118.01359641, 24.34067984], [118.01293241, 24.34059284], [118.01287341, 24.34070284], [118.01304041, 24.34079384], [118.01290341, 24.34101983], [118.01260541, 24.34132482], [118.01245941, 24.34132682], [118.01170041, 24.34206881], [118.01156441, 24.34203181], [118.01135341, 24.3422378], [118.01125941, 24.3424008], [118.01130941, 24.3424398], [118.01101541, 24.34268279], [118.01107541, 24.34285479], [118.01091341, 24.34318178], [118.01031541, 24.34354177], [118.01025941, 24.34377277], [118.01159241, 24.34470375], [118.01152241, 24.34497474], [118.01123741, 24.34511874], [118.01132741, 24.34545973], [118.01128341, 24.34567572], [118.01078241, 24.34565672], [118.01058641, 24.34554673], [118.01037941, 24.34602372], [118.01027141, 24.34603272], [118.01019141, 24.34618171], [118.00999741, 24.3466217], [118.00995241, 24.34691769], [118.01047441, 24.3468617], [118.01117941, 24.34710469], [118.01127441, 24.3467717], [118.01158241, 24.3467277], [118.01196541, 24.3467927], [118.01220441, 24.3466787], [118.01300341, 24.3466007], [118.01307141, 24.34643671], [118.01327341, 24.34644571], [118.01321541, 24.34751368], [118.01344141, 24.34753068], [118.01354841, 24.3467047], [118.01423241, 24.3467937], [118.01421641, 24.3468837], [118.01432641, 24.3469147], [118.01427141, 24.34725669], [118.01447341, 24.34733769], [118.01443941, 24.34781767], [118.01661941, 24.34810167], [118.01672041, 24.34828066], [118.01713841, 24.34862166], [118.01751241, 24.34879865], [118.02009441, 24.34973463], [118.02030541, 24.34988263], [118.02091541, 24.35069961], [118.02075841, 24.3510076], [118.02041941, 24.3511366], [118.01993241, 24.3511716], [118.01939541, 24.3510086], [118.01909641, 24.3512676], [118.01874541, 24.35144059], [118.01847141, 24.35145159], [118.01818541, 24.35131959], [118.01801941, 24.35140059], [118.01795541, 24.35154159], [118.01798041, 24.35172259], [118.01838041, 24.35210058], [118.01842741, 24.35226957], [118.01834941, 24.35293756], [118.01855841, 24.35334755], [118.01855441, 24.35414553], [118.01822241, 24.35469652], [118.01771541, 24.35489551], [118.01725641, 24.3552785], [118.01704041, 24.35569949], [118.01697941, 24.35610248], [118.01716041, 24.35646448], [118.01764541, 24.35695947], [118.01780841, 24.35727546], [118.01808041, 24.35791744], [118.01810241, 24.35815944], [118.01803241, 24.35831643], [118.01643041, 24.35836843], [118.01644241, 24.35847543], [118.01634641, 24.35845043], [118.01575141, 24.35782645], [118.01528341, 24.35773045], [118.01503041, 24.35744945], [118.01488741, 24.35738645], [118.01415141, 24.35764045], [118.01391141, 24.35782645], [118.01382341, 24.35800444], [118.01338941, 24.35830843], [118.01327041, 24.35905442], [118.01346741, 24.35957041], [118.01393241, 24.3599734], [118.01441941, 24.36009439], [118.01457041, 24.36021539], [118.01485241, 24.36046338], [118.01488041, 24.36076638], [118.01480241, 24.36192135], [118.01431441, 24.36253834], [118.01331441, 24.3641843], [118.01229841, 24.36508628], [118.01184141, 24.36535427], [118.01164941, 24.36590726], [118.01119341, 24.36607826], [118.01072241, 24.36640825], [118.01030741, 24.36653225], [118.00973441, 24.36653425], [118.00916241, 24.36663424], [118.00747741, 24.36733523], [118.00681841, 24.36753222], [118.00659241, 24.36752922], [118.00632241, 24.36729123], [118.00604941, 24.36716323], [118.00589341, 24.36717023], [118.00547841, 24.36792121], [118.00492241, 24.3684902], [118.00487341, 24.36889919], [118.00424341, 24.36890319], [118.00361741, 24.36909819], [118.00359541, 24.36940018], [118.00396241, 24.36993817], [118.00408641, 24.37041216], [118.00426841, 24.37067915], [118.00398641, 24.37159113], [118.00318941, 24.37209912], [118.00307241, 24.37234411], [118.00277641, 24.37255011], [118.00277741, 24.3728041], [118.00293441, 24.3730951], [118.00305941, 24.37364508], [118.00309241, 24.37476906], [118.00410741, 24.37429607], [118.00487441, 24.37476006], [118.00523941, 24.37452606], [118.00575041, 24.37394908], [118.00625541, 24.37354108], [118.00663341, 24.37346809], [118.00823741, 24.37343309], [118.00925041, 24.37381408], [118.01073941, 24.37420607], [118.01214941, 24.37425007], [118.01228941, 24.37442406], [118.01261841, 24.37463506], [118.01266241, 24.37493905], [118.01301241, 24.37558204], [118.01310341, 24.37640802], [118.01359941, 24.377051], [118.01368541, 24.377295], [118.01364941, 24.37781799], [118.01355541, 24.37804498], [118.01366241, 24.37816298], [118.01346141, 24.37834597], [118.01347141, 24.37851697], [118.01371941, 24.37889496], [118.01439041, 24.37954295], [118.01487641, 24.37955495], [118.01615341, 24.37908596], [118.01636541, 24.37911296], [118.01649541, 24.37935095], [118.01672341, 24.37930395], [118.01689641, 24.37939495], [118.01784941, 24.37934595], [118.01834341, 24.37923995], [118.01861841, 24.37916696], [118.01851841, 24.37869697], [118.01975641, 24.37786499], [118.02038541, 24.37824098], [118.02079841, 24.37813398], [118.02110641, 24.37816498], [118.02171341, 24.37788398], [118.02230341, 24.37777299], [118.02349441, 24.377383], [118.02210941, 24.37907296], [118.02218741, 24.37954895], [118.02181541, 24.37997394], [118.02174441, 24.38015493], [118.02177241, 24.38044993], [118.02161341, 24.38063792], [118.02144041, 24.38109591], [118.02157241, 24.3817569], [118.02179441, 24.38218289], [118.02157441, 24.38262588], [118.02155941, 24.38316086], [118.02167841, 24.38360185], [118.02125841, 24.38416184], [118.02123141, 24.38433684], [118.02139941, 24.38455183], [118.02171041, 24.38462383], [118.02189841, 24.38478383], [118.02201241, 24.38553381], [118.02182441, 24.3860468], [118.02150641, 24.38620879], [118.02124341, 24.38681178], [118.02142841, 24.38707977], [118.02180741, 24.38720077], [118.02208241, 24.38754076], [118.02257741, 24.38755776], [118.02283541, 24.38799675], [118.02277641, 24.38847874], [118.02223941, 24.38903973], [118.02113441, 24.38960572], [118.02030041, 24.3901277], [118.02016241, 24.3902857], [118.02010441, 24.3903937], [118.02014441, 24.39073269], [118.02035841, 24.39133768], [118.02008341, 24.39198766], [118.02007241, 24.39286164], [118.01949041, 24.39341563], [118.01894641, 24.39350563], [118.01860641, 24.39375062], [118.01835641, 24.39412661], [118.01841241, 24.39434961], [118.01867541, 24.3947076], [118.01884041, 24.39517959], [118.01930341, 24.39587357], [118.01951741, 24.39684155], [118.01996941, 24.39747054], [118.02044641, 24.39767153], [118.02088241, 24.39798052], [118.02111341, 24.39816852], [118.02117441, 24.39833652], [118.02165741, 24.39852351], [118.02222241, 24.39851851], [118.02238141, 24.3989365], [118.02263941, 24.40073846], [118.02272941, 24.40131945], [118.02205041, 24.40141745], [118.02131741, 24.40191143], [118.02075941, 24.40209443], [118.02049041, 24.40210443], [118.02011941, 24.40228043], [118.01975241, 24.40208543], [118.01943041, 24.40203143], [118.01897941, 24.40223443], [118.01864341, 24.40213943], [118.01800241, 24.40231342], [118.01788641, 24.40234242], [118.01777841, 24.40204743], [118.01403741, 24.40168444], [118.01506041, 24.40075146], [118.01541141, 24.40064946], [118.01495041, 24.39999148], [118.01412741, 24.39855951], [118.01359141, 24.39872651], [118.01302341, 24.39831152], [118.01258241, 24.39850751], [118.01008041, 24.40133745], [118.00894741, 24.40158144], [118.00852041, 24.40133445], [118.00764241, 24.40121645], [118.00599541, 24.40066446], [118.00145641, 24.39961249], [117.99317441, 24.39931349], [117.98833241, 24.3991565], [117.98825241, 24.39923149], [117.98748641, 24.39930749], [117.98675341, 24.39993548], [117.98581841, 24.40090846], [117.98698141, 24.40111145], [117.98690341, 24.40138945], [117.98706741, 24.40163044], [117.98714141, 24.40296941], [117.98722741, 24.4032544], [117.98719141, 24.4033454], [117.98682741, 24.4035584], [117.98727041, 24.4035394], [117.98740641, 24.40368139], [117.98705841, 24.40399339], [117.98699341, 24.40418538], [117.98775341, 24.40443338], [117.98788341, 24.40463337], [117.98806841, 24.40473037], [117.98811141, 24.40491836], [117.98848641, 24.40521236], [117.98882041, 24.40528836], [117.98924641, 24.40521536], [117.98918341, 24.40544635], [117.98930141, 24.40566035], [117.99009841, 24.40589634], [117.99049341, 24.40587934], [117.99156641, 24.40619634], [117.99234241, 24.40627033], [117.99267641, 24.40645733], [117.99299841, 24.40640933], [117.99335441, 24.40617534], [117.99381441, 24.40616634], [117.99611541, 24.40670632], [117.99753441, 24.40687732], [117.99784241, 24.40732031], [117.99836041, 24.40740331], [117.99827941, 24.4076473], [117.99832241, 24.4078463], [117.99804641, 24.40810929], [117.99812741, 24.40865428], [117.99807741, 24.40869128], [117.99766241, 24.40865128], [117.99688041, 24.40823029], [117.99628541, 24.40800829], [117.99592541, 24.40798829], [117.99571841, 24.40823429], [117.99587141, 24.40851228], [117.99628741, 24.40873628], [117.99657941, 24.40878928], [117.99749341, 24.40917227], [117.99807441, 24.40930726], [117.99847741, 24.40931726], [117.99875641, 24.40911727], [117.99919141, 24.40808129], [117.99923541, 24.4076853], [118.00011141, 24.40744531], [118.00042641, 24.40718731], [118.00096541, 24.40707032], [118.00113941, 24.40709631], [118.00117641, 24.40716131], [118.00097641, 24.40735231], [118.00064041, 24.4076093], [118.00029841, 24.4077563], [118.00054641, 24.40801229], [118.00053541, 24.40809929], [118.00005441, 24.40858228], [117.99965141, 24.40863028], [118.00017141, 24.40978425], [118.00065441, 24.40978025], [118.00075041, 24.40963326], [118.00116341, 24.40961926], [118.00170041, 24.40999425], [118.00173641, 24.41009825], [118.00164141, 24.41043324], [118.00172841, 24.41059923], [118.00886641, 24.41242119], [118.00924341, 24.41260719], [118.01348741, 24.41370716], [118.01364841, 24.41370116], [118.01394341, 24.41351317], [118.01425841, 24.41321217], [118.01470641, 24.41330417], [118.01547941, 24.41305618], [118.01633941, 24.41249819], [118.01703341, 24.41253419], [118.01737941, 24.41247919], [118.01882241, 24.41281018], [118.01941941, 24.41263219], [118.02008641, 24.41291818], [118.02033641, 24.41291118], [118.02072741, 24.41249719], [118.02081741, 24.4119302], [118.02087741, 24.4118822], [118.02225841, 24.41178321], [118.02229941, 24.4119102], [118.02192041, 24.41231819], [118.02163841, 24.41249219], [118.02149441, 24.41277818], [118.02111941, 24.41298018], [118.02090941, 24.41326317], [118.02085241, 24.41377516], [118.02103241, 24.41399416], [118.02141441, 24.41419315], [118.02204841, 24.41421115], [118.02222641, 24.41408115], [118.02228441, 24.41387616], [118.02242141, 24.41385816], [118.02301241, 24.41426715], [118.02440141, 24.41452514], [118.02504141, 24.41337317], [118.02529741, 24.41330717], [118.02624741, 24.41348217], [118.02659341, 24.41336617], [118.02686441, 24.41304918], [118.02676641, 24.41259819], [118.02683541, 24.41242319], [118.02726541, 24.41251319], [118.02756141, 24.41234119], [118.02779241, 24.41235719], [118.02793341, 24.4122862], [118.02821241, 24.41233619], [118.02907741, 24.4122092], [118.02966641, 24.41235119], [118.03010341, 24.4122632], [118.03073741, 24.41271319], [118.03091941, 24.41273219], [118.03122841, 24.41294118], [118.03149841, 24.41292918], [118.03200541, 24.41306318], [118.03259141, 24.41304318], [118.03269141, 24.41405315], [118.03259141, 24.41411315], [118.03259641, 24.41419815], [118.03268441, 24.41419815], [118.03270041, 24.41439315]];
//常山华侨经济开发区
var czhqjjkfq = [[117.36992241, 23.81882667], [117.37051241, 23.81873568], [117.37106141, 23.81817769], [117.37121841, 23.81810269], [117.37172941, 23.81811569], [117.37180741, 23.81805669], [117.37200141, 23.81694272], [117.37203641, 23.81530875], [117.37293841, 23.81477076], [117.37317341, 23.81453077], [117.37332941, 23.81389878], [117.37332841, 23.81358779], [117.37320941, 23.81341579], [117.37247141, 23.81441677], [117.37059641, 23.81520675], [117.36958741, 23.81614073], [117.36915441, 23.8175787], [117.36785641, 23.81930466], [117.36572641, 23.82148661], [117.36512741, 23.8221086], [117.36367441, 23.82368856], [117.36313841, 23.82525053], [117.36345341, 23.82537253], [117.36349441, 23.82602251], [117.36373141, 23.8263655], [117.36400741, 23.8263665], [117.36459641, 23.82601651], [117.36479341, 23.82624651], [117.36502941, 23.8263685], [117.36514741, 23.8265645], [117.36522941, 23.82754748], [117.36499741, 23.82867445], [117.36511541, 23.82900844], [117.36523341, 23.82899645], [117.36637141, 23.82818346], [117.36703841, 23.82751448], [117.36782341, 23.82692449], [117.36790141, 23.82693349], [117.36817941, 23.82784247], [117.36833741, 23.82801847], [117.36849441, 23.82801847], [117.36916241, 23.82778047], [117.36943741, 23.82757348], [117.36994741, 23.82715249], [117.37006441, 23.82683449], [117.37029941, 23.8265675], [117.37057441, 23.8265965], [117.37073241, 23.8266845], [117.37081141, 23.82683849], [117.37069441, 23.82725548], [117.37069641, 23.82781947], [117.37061841, 23.82814946], [117.37093441, 23.82846946], [117.37101341, 23.82864545], [117.37121541, 23.83053341], [117.37074441, 23.8308704], [117.36991941, 23.8310884], [117.36960641, 23.83163639], [117.36905741, 23.83230237], [117.36772441, 23.83364934], [117.36768641, 23.83416533], [117.36753041, 23.83460332], [117.36729441, 23.83468932], [117.36690241, 23.83500331], [117.36710041, 23.8354703], [117.36812541, 23.83626628], [117.36852141, 23.83710326], [117.36879741, 23.83732126], [117.36930941, 23.83752125], [117.36986341, 23.83877723], [117.36978541, 23.83916822], [117.36955041, 23.83929021], [117.36829041, 23.83903222], [117.36770241, 23.83933521], [117.36738841, 23.8398522], [117.36727141, 23.84030419], [117.36715441, 23.84043019], [117.36644641, 23.84036319], [117.36569941, 23.84042219], [117.36558141, 23.84044719], [117.36546341, 23.84061418], [117.36562141, 23.84082218], [117.36573941, 23.84084618], [117.36691941, 23.84087518], [117.36711641, 23.84095318], [117.36731441, 23.84136417], [117.36735541, 23.84184216], [117.36704241, 23.84274514], [117.36668941, 23.84307713], [117.36598341, 23.84355412], [117.36468641, 23.84385711], [117.36452941, 23.84394811], [117.36405841, 23.8444381], [117.36354841, 23.84469309], [117.36292041, 23.84512708], [117.36268541, 23.84572107], [117.36115641, 23.84766503], [117.36119741, 23.84811202], [117.36167341, 23.84951898], [117.36126841, 23.85034297], [117.36124841, 23.85074196], [117.36144941, 23.85093695], [117.36195241, 23.85118195], [117.36196341, 23.85134594], [117.36130541, 23.85124095], [117.36093541, 23.85125694], [117.36041341, 23.85140494], [117.35968641, 23.85175993], [117.35882441, 23.85200693], [117.35848141, 23.85193893], [117.35791541, 23.85162494], [117.35746841, 23.85121595], [117.35719341, 23.85117695], [117.35629341, 23.85158594], [117.35458441, 23.85191393], [117.35423141, 23.85204993], [117.35380641, 23.85241092], [117.35341641, 23.8532249], [117.35328441, 23.8533369], [117.35245241, 23.85295091], [117.35220841, 23.8530619], [117.35195741, 23.85347189], [117.35164541, 23.85480386], [117.35149841, 23.85488586], [117.35112341, 23.85490786], [117.35087741, 23.85516186], [117.35063341, 23.85611584], [117.35067341, 23.85681182], [117.35059741, 23.85696182], [117.34914341, 23.8574708], [117.34846641, 23.8578308], [117.34821841, 23.85845478], [117.34744641, 23.85919877], [117.34718541, 23.85965776], [117.34718541, 23.85981075], [117.34739141, 23.86031274], [117.34693041, 23.86007975], [117.34674041, 23.86018174], [117.34651941, 23.86079373], [117.34650441, 23.86114272], [117.34634641, 23.86121572], [117.34604441, 23.86109872], [117.34612341, 23.86098273], [117.34607541, 23.86064773], [117.34597941, 23.86054574], [117.34582141, 23.86058974], [117.34557941, 23.86086673], [117.34485041, 23.8621237], [117.34402541, 23.86285968], [117.34387041, 23.86318268], [117.34369041, 23.86405866], [117.34356741, 23.86428965], [117.34335641, 23.86445565], [117.34299041, 23.86457465], [117.34222241, 23.86459764], [117.33925041, 23.86374866], [117.33858141, 23.86346067], [117.33788341, 23.86334867], [117.33708241, 23.86276669], [117.33492941, 23.86056374], [117.33440241, 23.85972075], [117.33429641, 23.85892977], [117.33410141, 23.85871378], [117.33344141, 23.85864478], [117.33319841, 23.85870678], [117.33252541, 23.85924776], [117.33210341, 23.85950276], [117.33173841, 23.85960976], [117.32885541, 23.85937676], [117.32735841, 23.85973075], [117.32697241, 23.85973075], [117.32601341, 23.85958376], [117.32394541, 23.85908277], [117.32297941, 23.85906477], [117.32204741, 23.85929676], [117.32072641, 23.86001675], [117.32054741, 23.85999175], [117.32004441, 23.85970975], [117.31928741, 23.85891177], [117.31848441, 23.85843178], [117.31763241, 23.85943376], [117.31731241, 23.86017874], [117.31700841, 23.86047074], [117.31709941, 23.86059773], [117.31760341, 23.86085673], [117.31798841, 23.86146872], [117.31880541, 23.8622267], [117.31914241, 23.86266669], [117.31921841, 23.86282468], [117.31918041, 23.86298568], [117.31893041, 23.86325567], [117.31868441, 23.86393166], [117.31855941, 23.86404566], [117.31801241, 23.86393866], [117.31628341, 23.86416565], [117.31535941, 23.86438665], [117.31524341, 23.86471464], [117.31522441, 23.86560062], [117.31509041, 23.86611961], [117.31467441, 23.86692259], [117.31413441, 23.86753158], [117.31403341, 23.86762558], [117.31364541, 23.86760758], [117.31286441, 23.86718459], [117.31219941, 23.86714459], [117.31179141, 23.86703559], [117.31152041, 23.86703559], [117.31131641, 23.86717559], [117.31080641, 23.86723359], [117.31035841, 23.86698459], [117.31014141, 23.86694759], [117.30978841, 23.86707259], [117.30969441, 23.86732158], [117.30970741, 23.86752058], [117.30958641, 23.86763258], [117.30915241, 23.86764458], [117.30874441, 23.86734658], [117.30852641, 23.86728458], [117.30772641, 23.86742158], [117.30651841, 23.86788057], [117.30635441, 23.86754158], [117.30606341, 23.86730958], [117.30527241, 23.86719159], [117.30451941, 23.86691559], [117.30410841, 23.86686659], [117.30376341, 23.8667056], [117.30305641, 23.8666506], [117.30298341, 23.86625461], [117.30307841, 23.86601261], [117.30359441, 23.86599061], [117.30307641, 23.86540863], [117.30245141, 23.86520563], [117.30108441, 23.86506163], [117.29971741, 23.86549562], [117.29832141, 23.86612461], [117.29809641, 23.86608261], [117.29769241, 23.86567162], [117.29684141, 23.86446565], [117.29532341, 23.86354867], [117.29406741, 23.86261669], [117.29388441, 23.86259169], [117.29358341, 23.86270869], [117.29330841, 23.86303868], [117.29293641, 23.86324667], [117.29260541, 23.86326567], [117.29251841, 23.86317868], [117.29246341, 23.8620087], [117.29224641, 23.86105272], [117.29211441, 23.86082473], [117.29191541, 23.86070373], [117.29130341, 23.86080973], [117.29080741, 23.86096173], [117.28998941, 23.86136272], [117.28908941, 23.86153971], [117.28898941, 23.86140372], [117.28888941, 23.86090273], [117.28898741, 23.86038674], [117.28895341, 23.86009775], [117.28872141, 23.85967276], [117.28867841, 23.85943876], [117.28824241, 23.85892677], [117.28734041, 23.85854178], [117.28671841, 23.85804579], [117.28570941, 23.8576328], [117.28609441, 23.85733781], [117.28687041, 23.85562685], [117.28698541, 23.85529785], [117.28699241, 23.85461387], [117.28690441, 23.85437287], [117.28710841, 23.85418488], [117.28712141, 23.85375689], [117.28672741, 23.85360989], [117.28639141, 23.8532489], [117.28612841, 23.8531549], [117.28577941, 23.8532089], [117.28547241, 23.8531159], [117.28504941, 23.85274791], [117.28482341, 23.85268291], [117.28486641, 23.85291591], [117.28524741, 23.8533169], [117.28513741, 23.85385189], [117.28474541, 23.85391888], [117.28438041, 23.85367789], [117.28417641, 23.85367789], [117.28430841, 23.85421388], [117.28422141, 23.85441387], [117.28394441, 23.85454887], [117.28366741, 23.85456187], [117.28340341, 23.85448187], [117.28297541, 23.85393288], [117.28304041, 23.8532779], [117.28326041, 23.85275891], [117.28341541, 23.85193493], [117.28326041, 23.85138494], [117.28309641, 23.85124095], [117.28264241, 23.85127994], [117.28103641, 23.85213293], [117.27911541, 23.85266491], [117.27888541, 23.85280991], [117.27875241, 23.85299891], [117.27849841, 23.85300991], [117.27817841, 23.85282791], [117.27806041, 23.85264191], [117.27790041, 23.85268191], [117.27758241, 23.8533389], [117.27717141, 23.85376589], [117.27633441, 23.85416988], [117.27620141, 23.85420588], [117.27568041, 23.85401088], [117.27538441, 23.85406788], [117.27526041, 23.85418188], [117.27470141, 23.85441087], [117.27443641, 23.85442587], [117.27404841, 23.85459687], [117.27342641, 23.85469787], [117.27320841, 23.85468387], [117.27302241, 23.85456987], [117.27277341, 23.85459887], [117.27258641, 23.85465587], [117.27241841, 23.85488786], [117.27224441, 23.85482686], [117.27207341, 23.85457087], [117.27172441, 23.85455287], [117.27000541, 23.85416888], [117.26944841, 23.85393488], [117.26872041, 23.85352989], [117.26838741, 23.8530779], [117.26802741, 23.85238292], [117.26777641, 23.85291891], [117.26656441, 23.85407288], [117.26612841, 23.85436987], [117.26587641, 23.85441687], [117.26539141, 23.85466987], [117.26495741, 23.85509486], [117.26398241, 23.85576884], [117.26344041, 23.85596884], [117.26179041, 23.85622483], [117.26098041, 23.85574784], [117.26048941, 23.85572184], [117.25976741, 23.85588184], [117.25893841, 23.85578184], [117.25846641, 23.85551185], [117.25826341, 23.85503486], [117.25777241, 23.85479687], [117.25736841, 23.85498286], [117.25656241, 23.85609884], [117.25615841, 23.85636483], [117.25503141, 23.85631383], [117.25477141, 23.85615483], [117.25468341, 23.85572984], [117.25453941, 23.85546485], [117.25404541, 23.85530985], [117.25358341, 23.85533185], [117.25298341, 23.85573584], [117.25185141, 23.85590684], [117.25129841, 23.85635383], [117.25028341, 23.85654683], [117.25009941, 23.85697082], [117.24961441, 23.85737581], [117.24899241, 23.8576518], [117.24853041, 23.8577808], [117.24783741, 23.8577818], [117.24716841, 23.85790979], [117.24635941, 23.85821979], [117.24607641, 23.85828279], [117.24541541, 23.85802679], [117.24521741, 23.8578088], [117.24492641, 23.8577198], [117.24483841, 23.8576128], [117.24479741, 23.85719381], [117.24446741, 23.85639683], [117.24415041, 23.85590984], [117.24353541, 23.85531885], [117.24331241, 23.85460287], [117.24289941, 23.85375289], [117.24216241, 23.85286991], [117.24185641, 23.85238692], [117.24072041, 23.85108395], [117.24036441, 23.85092795], [117.23876141, 23.85069396], [117.23756441, 23.85034197], [117.23721541, 23.85037596], [117.23704841, 23.85047596], [117.23679641, 23.85116795], [117.23556741, 23.85238292], [117.23483341, 23.8534569], [117.23289041, 23.85518386], [117.23228041, 23.85551385], [117.23093541, 23.85567085], [117.22745641, 23.85566785], [117.22740441, 23.85585284], [117.22826741, 23.85646983], [117.22902541, 23.85724181], [117.22911141, 23.85845978], [117.22873541, 23.85967876], [117.22875341, 23.85984475], [117.22813341, 23.86122372], [117.22794141, 23.8619477], [117.22770741, 23.8622327], [117.22734741, 23.86239369], [117.22676041, 23.8622897], [117.22615741, 23.8623397], [117.22524141, 23.86273169], [117.22424541, 23.86336967], [117.22312441, 23.86444665], [117.22265041, 23.86478664], [117.22256641, 23.86494864], [117.22251741, 23.86587162], [117.22214841, 23.86692459], [117.22221641, 23.86747858], [117.22224141, 23.86971053], [117.22196941, 23.87080051], [117.22161841, 23.87147049], [117.22135641, 23.87175148], [117.22102441, 23.87195948], [117.22025241, 23.87218847], [117.21924441, 23.87224247], [117.21824441, 23.87210548], [117.21743641, 23.87209248], [117.21555041, 23.87274046], [117.21517441, 23.87317545], [117.21511741, 23.87353444], [117.21589441, 23.87504141], [117.21588641, 23.8754114], [117.21572541, 23.87574839], [117.21572841, 23.87591639], [117.21612741, 23.87611339], [117.21616841, 23.87640038], [117.21608741, 23.87652538], [117.21577541, 23.87651338], [117.21546841, 23.87683637], [117.21426941, 23.87753435], [117.21367341, 23.87801734], [117.21318541, 23.87813134], [117.21257041, 23.87811634], [117.21157341, 23.87826534], [117.21105041, 23.87854333], [117.21091041, 23.87870033], [117.21087441, 23.87896632], [117.21067541, 23.87909932], [117.20919341, 23.87885432], [117.20897541, 23.87838933], [117.20883741, 23.87830634], [117.20764941, 23.87856733], [117.20751341, 23.87924132], [117.20697141, 23.87947531], [117.20670141, 23.8798423], [117.20642341, 23.88070728], [117.20637241, 23.88107727], [117.20643641, 23.88163026], [117.20634441, 23.88175726], [117.20576241, 23.88180526], [117.20509041, 23.88221825], [117.20418141, 23.88295923], [117.20307641, 23.88405121], [117.20253541, 23.8842712], [117.20224241, 23.8845242], [117.20210341, 23.88486919], [117.20211841, 23.88504918], [117.20291341, 23.88655415], [117.20323341, 23.88772812], [117.20282941, 23.88792312], [117.20256641, 23.88794012], [117.20205741, 23.88824911], [117.20160941, 23.88926309], [117.19896241, 23.89132504], [117.19870841, 23.89186403], [117.19880041, 23.89220902], [117.19898941, 23.89248602], [117.20095741, 23.89426598], [117.20242441, 23.89521096], [117.20288941, 23.89528695], [117.20398441, 23.89519496], [117.20457241, 23.89545895], [117.20465941, 23.89582294], [117.20427641, 23.89656892], [117.20374341, 23.89728891], [117.20310241, 23.89795389], [117.20288241, 23.89832389], [117.20263841, 23.89848288], [117.20251641, 23.89900787], [117.20150141, 23.89997385], [117.20128541, 23.90008785], [117.20057441, 23.90083683], [117.20024641, 23.90083583], [117.19985941, 23.90048284], [117.19900041, 23.90019084], [117.19787141, 23.90014484], [117.19749341, 23.90024384], [117.19753341, 23.90069883], [117.19808341, 23.90148681], [117.19839841, 23.9020838], [117.19871341, 23.90307378], [117.19875441, 23.90374776], [117.19836341, 23.90453375], [117.19824641, 23.90540373], [117.19832541, 23.90551072], [117.19962241, 23.9066397], [117.20064241, 23.90727068], [117.20083941, 23.90731168], [117.20111341, 23.90715869], [117.20127041, 23.90714969], [117.20193741, 23.90766668], [117.20213441, 23.90770267], [117.20237041, 23.90790867], [117.20276241, 23.90799367], [117.20370541, 23.90851266], [117.20425441, 23.90851066], [117.20476441, 23.90875065], [117.20488341, 23.90891765], [117.20476541, 23.90913864], [117.20480541, 23.90927364], [117.20531541, 23.90952363], [117.20555141, 23.90995562], [117.20647441, 23.91031862], [117.20704341, 23.91063061], [117.20743641, 23.9109566], [117.20790741, 23.9110656], [117.20826041, 23.9110356], [117.20904641, 23.91150759], [117.20896841, 23.91181458], [117.20928241, 23.91199358], [117.20932241, 23.91212457], [117.20889141, 23.91275556], [117.20959841, 23.91317755], [117.20959941, 23.91337855], [117.21042441, 23.91421553], [117.21058141, 23.91418153], [117.21085541, 23.91393053], [117.21171841, 23.91349254], [117.21262041, 23.91337555], [117.21297341, 23.91320955], [117.21313041, 23.91292056], [117.21375741, 23.91258856], [117.21379641, 23.91237257], [117.21454141, 23.91190758], [117.21461941, 23.91176258], [117.21458041, 23.91151759], [117.21469741, 23.91139759], [117.21528541, 23.9110506], [117.21571841, 23.91134459], [117.21622841, 23.91186258], [117.21693541, 23.91188358], [117.21725041, 23.91216457], [117.21760441, 23.91277956], [117.21815441, 23.91312355], [117.21893941, 23.91315555], [117.21937041, 23.91307255], [117.21984241, 23.91283756], [117.22019541, 23.91286556], [117.22058841, 23.91311055], [117.22133641, 23.91426853], [117.22180741, 23.91463052], [117.22247441, 23.91438952], [117.22326041, 23.91446652], [117.22361341, 23.91460552], [117.22381041, 23.91456952], [117.22408441, 23.91437752], [117.22439841, 23.91435152], [117.22510641, 23.91499451], [117.22655941, 23.9152665], [117.22711041, 23.91595649], [117.22766041, 23.91625048], [117.22821041, 23.91638648], [117.22887741, 23.91625448], [117.22974041, 23.91622948], [117.23029041, 23.91576149], [117.23087841, 23.91463652], [117.23158341, 23.91389054], [117.23170041, 23.91358354], [117.23173941, 23.91315055], [117.23279841, 23.91245057], [117.23358241, 23.91166159], [117.23460141, 23.9109016], [117.23507541, 23.91211457], [117.23531141, 23.91236857], [117.23578341, 23.91266956], [117.23613741, 23.91320355], [117.23649141, 23.91345855], [117.23664941, 23.91368554], [117.23672841, 23.91401253], [117.23727941, 23.91432752], [117.23743641, 23.91454652], [117.23759541, 23.9152605], [117.23798941, 23.91577649], [117.23834341, 23.91607149], [117.23905041, 23.91642448], [117.23952341, 23.91728146], [117.23979941, 23.91745645], [117.23999541, 23.91749445], [117.24074041, 23.91700746], [117.24101541, 23.91670747], [117.24121141, 23.91627848], [117.24128941, 23.91626048], [117.24254641, 23.91626248], [117.24278341, 23.91662547], [117.24278441, 23.91697647], [117.24294141, 23.91713246], [117.24415941, 23.91709146], [117.24451341, 23.91700546], [117.24510141, 23.91673147], [117.24604441, 23.91673447], [117.24651541, 23.91647648], [117.24804841, 23.91652948], [117.24844141, 23.91636448], [117.24871541, 23.91614248], [117.24891241, 23.91612449], [117.25017041, 23.91646548], [117.25090941, 23.91681847], [117.25103541, 23.91685947], [117.25115341, 23.91670747], [117.25115241, 23.91598349], [117.25126841, 23.9154735], [117.25189641, 23.91470252], [117.25299341, 23.91279056], [117.25318941, 23.91254457], [117.25440541, 23.91168659], [117.25522941, 23.91072661], [117.25546441, 23.91060461], [117.25652541, 23.91054061], [117.25833341, 23.91023262], [117.26002241, 23.90975663], [117.26045541, 23.90950563], [117.26088641, 23.90901365], [117.26124041, 23.90883065], [117.26139741, 23.90879865], [117.26147641, 23.90885465], [117.26194641, 23.90844566], [117.26214241, 23.90807567], [117.26233941, 23.90793767], [117.26245741, 23.90801667], [117.26249641, 23.90815666], [117.26261441, 23.90816766], [117.26292941, 23.90852766], [117.26320541, 23.90868365], [117.26332341, 23.90869465], [117.26344141, 23.90855266], [117.26367741, 23.90853866], [117.26375541, 23.90845466], [117.26355841, 23.90827466], [117.26355841, 23.90816866], [117.26406941, 23.90806667], [117.26418641, 23.90772067], [117.26414641, 23.90739568], [117.26446041, 23.90709169], [117.26453841, 23.90679969], [117.26497041, 23.90633471], [117.26567641, 23.90587372], [117.26599041, 23.90578772], [117.26622741, 23.90581872], [117.26642441, 23.90607571], [117.26673941, 23.90614371], [117.26705441, 23.9064727], [117.26744841, 23.9066657], [117.26791941, 23.9064577], [117.26815641, 23.90685269], [117.26831341, 23.90693369], [117.26827441, 23.90709169], [117.26851141, 23.90743168], [117.26898241, 23.90727168], [117.26925841, 23.90744468], [117.26941641, 23.90742168], [117.26957241, 23.90726168], [117.26945441, 23.90688269], [117.26996541, 23.90684169], [117.26996341, 23.90621671], [117.27008141, 23.90606071], [117.27015941, 23.90552572], [117.27000141, 23.90524173], [117.27000041, 23.90502773], [117.27015741, 23.90486074], [117.27007841, 23.90439775], [117.27019541, 23.90420175], [117.27039241, 23.90427775], [117.27062941, 23.90466174], [117.27110141, 23.90467474], [117.27173041, 23.90485874], [117.27216441, 23.90508673], [117.27228141, 23.90507473], [117.27251741, 23.90488274], [117.27279241, 23.90501174], [117.27338241, 23.90469474], [117.27381541, 23.90480774], [117.27409141, 23.90510273], [117.27440541, 23.90518373], [117.27444541, 23.90525773], [117.27526741, 23.90345477], [117.27581741, 23.90295578], [117.27593441, 23.90265479], [117.27589341, 23.9020328], [117.27601141, 23.9019358], [117.27628741, 23.9020078], [117.27695641, 23.90252079], [117.27853141, 23.90300678], [117.27927841, 23.90283978], [117.28014341, 23.90235579], [117.28093041, 23.90243679], [117.28151941, 23.9023098], [117.28238541, 23.90242479], [117.28254441, 23.90322578], [117.28274241, 23.90357977], [117.28254641, 23.90391576], [117.28266641, 23.90492674], [117.28243241, 23.90585672], [117.28294441, 23.90597571], [117.28385041, 23.9065277], [117.28507141, 23.9067777], [117.28672541, 23.90737268], [117.28704041, 23.90762268], [117.28727841, 23.90846366], [117.28747641, 23.90883665], [117.28767341, 23.90902364], [117.28802841, 23.90918064], [117.28834341, 23.90966563], [117.28893841, 23.91144559], [117.28933441, 23.91238157], [117.28960941, 23.91249257], [117.29090841, 23.91236757], [117.29141941, 23.91254757], [117.29181341, 23.91246657], [117.29260141, 23.91284956], [117.29307841, 23.91292556], [117.29413641, 23.91307255], [117.29457141, 23.91355754], [117.29472941, 23.91359554], [117.29484641, 23.91356654], [117.29523941, 23.91299555], [117.29689041, 23.91231357], [117.29724441, 23.91194558], [117.29732241, 23.91162659], [117.29763641, 23.91146159], [117.30023341, 23.9111156], [117.30086241, 23.91054261], [117.30129441, 23.90986763], [117.30164741, 23.90956163], [117.30207841, 23.90889765], [117.30255041, 23.90842766], [117.30294141, 23.90749868], [117.30337341, 23.90685269], [117.30356841, 23.9064127], [117.30384041, 23.90486274], [117.30431041, 23.90362377], [117.30438741, 23.90307078], [117.30477941, 23.90249379], [117.30489741, 23.90240779], [117.30533041, 23.9023358], [117.30548641, 23.9019808], [117.30540741, 23.90156381], [117.30548441, 23.90123182], [117.30572041, 23.90099283], [117.30591541, 23.90001385], [117.30603341, 23.89985785], [117.30650441, 23.89960986], [117.30610941, 23.89893687], [117.30610941, 23.89866388], [117.30630441, 23.89822689], [117.30610441, 23.89691992], [117.30637941, 23.89676692], [117.30649741, 23.89646393], [117.30661541, 23.89639693], [117.30748041, 23.89619593], [117.30763641, 23.89582994], [117.30830541, 23.89562495], [117.30952541, 23.89538295], [117.30995741, 23.89505996], [117.31074541, 23.89517896], [117.31121741, 23.89501196], [117.31153141, 23.89472797], [117.31172741, 23.89438097], [117.31200241, 23.89427698], [117.31239541, 23.89372799], [117.31329841, 23.89285301], [117.31404541, 23.89228602], [117.31420141, 23.89191803], [117.31494941, 23.89201303], [117.31569841, 23.89226102], [117.31636841, 23.89233702], [117.31656741, 23.89350199], [117.31688541, 23.89465697], [117.31747941, 23.89599294], [117.31767041, 23.89625393], [117.31901541, 23.89622893], [117.32000041, 23.89649293], [117.32047341, 23.89653393], [117.32224241, 23.89565795], [117.32334441, 23.89528295], [117.32566641, 23.89480597], [117.32609841, 23.89458997], [117.32786841, 23.89413998], [117.32861641, 23.89404298], [117.32969241, 23.89451597], [117.33173941, 23.88371421], [117.33391541, 23.88369322], [117.33398141, 23.88298623], [117.33492641, 23.88294323], [117.33598741, 23.88237824], [117.33641941, 23.88187726], [117.33649641, 23.88163126], [117.33669341, 23.88136127], [117.33716541, 23.88117327], [117.33748041, 23.88116827], [117.33759841, 23.88125227], [117.33803341, 23.88182026], [117.33822941, 23.88174126], [117.33865941, 23.88076928], [117.33929041, 23.88123827], [117.33956641, 23.88117727], [117.33960541, 23.88105527], [117.33948641, 23.88062228], [117.33952441, 23.88022229], [117.33960241, 23.8800443], [117.33987741, 23.8798293], [117.34027141, 23.8798253], [117.34054641, 23.8799173], [117.34121841, 23.88043829], [117.34145341, 23.88043429], [117.34176741, 23.8800203], [117.34219841, 23.87905532], [117.34255141, 23.87879533], [117.34318141, 23.87860833], [117.34333741, 23.87836634], [117.34349341, 23.87777935], [117.34376741, 23.87729036], [117.34427941, 23.87713636], [117.34447541, 23.87695137], [117.34490741, 23.87676137], [117.34530141, 23.87688737], [117.34601141, 23.87732236], [117.34554141, 23.87803334], [117.34573841, 23.87826334], [117.34601541, 23.87892532], [117.34597941, 23.8799673], [117.34605841, 23.88022929], [117.34664941, 23.88019529], [117.34719941, 23.8798153], [117.34814241, 23.87930931], [117.34826041, 23.87922632], [117.34857341, 23.87847933], [117.34876941, 23.87825334], [117.34924141, 23.87814734], [117.34955641, 23.87830234], [117.34971441, 23.87850833], [117.34975441, 23.87872433], [117.35014841, 23.87901732], [117.35034841, 23.8799243], [117.35070441, 23.88056229], [117.35101941, 23.88084028], [117.35232041, 23.88138327], [117.35302841, 23.88149826], [117.35373741, 23.88147427], [117.35409141, 23.88139827], [117.35420741, 23.88091728], [117.35444241, 23.88051129], [117.35456041, 23.88035529], [117.35471741, 23.88040629], [117.35534841, 23.88071528], [117.35625541, 23.88133527], [117.35629541, 23.88164426], [117.35661041, 23.88178626], [117.35668941, 23.88191026], [117.35669141, 23.88237524], [117.35680941, 23.88240924], [117.35696641, 23.88229825], [117.35704441, 23.88190526], [117.35759441, 23.88179726], [117.35771341, 23.88213525], [117.35791041, 23.88227525], [117.35822741, 23.88282123], [117.35913141, 23.88252024], [117.35972141, 23.88254024], [117.35984041, 23.88266824], [117.35976141, 23.88280823], [117.35940741, 23.88273224], [117.35917141, 23.88281824], [117.35913341, 23.88313123], [117.35921241, 23.88321723], [117.35988141, 23.88332922], [117.35992241, 23.88394321], [117.36000141, 23.88397921], [117.36011941, 23.88395021], [117.36031541, 23.88364022], [117.36082541, 23.88311223], [117.36137541, 23.88277324], [117.36200441, 23.88279124], [117.36231941, 23.88290523], [117.36330641, 23.88391121], [117.36523241, 23.88324823], [117.36629441, 23.88316123], [117.36590241, 23.88353822], [117.36586341, 23.88374621], [117.36594241, 23.88387021], [117.36649441, 23.8842232], [117.36739841, 23.88411921], [117.36763541, 23.8841952], [117.36775341, 23.8843782], [117.36720341, 23.88477619], [117.36685141, 23.88520218], [117.36618541, 23.88628416], [117.36614641, 23.88647615], [117.36752441, 23.88682214], [117.36811641, 23.88754813], [117.36856741, 23.88832011], [117.36890641, 23.8886251], [117.36933941, 23.8886681], [117.36981241, 23.8888301], [117.37055741, 23.88839811], [117.37079441, 23.88842711], [117.37122641, 23.88831511], [117.37161841, 23.88797712], [117.37252541, 23.88852211], [117.37299641, 23.88807912], [117.37303441, 23.88779312], [117.37279741, 23.88734413], [117.37299341, 23.88710714], [117.37333041, 23.88694314], [117.37363441, 23.88719614], [117.37393941, 23.88690014], [117.37427341, 23.88695914], [117.37485241, 23.88654515], [117.37527341, 23.88659815], [117.37535141, 23.88647215], [117.37515441, 23.88626416], [117.37507441, 23.88601616], [117.37511341, 23.88577517], [117.37527041, 23.88557417], [117.37526841, 23.88517218], [117.37609041, 23.88380621], [117.37703241, 23.88287723], [117.37722841, 23.88290923], [117.37781941, 23.88333622], [117.37930841, 23.88130627], [117.38033241, 23.88197425], [117.38029441, 23.88232425], [117.38053041, 23.88248024], [117.38108141, 23.88247424], [117.38182741, 23.88220425], [117.38218041, 23.88199425], [117.38269241, 23.88221225], [117.38273241, 23.88249224], [117.38257741, 23.88320723], [117.38261641, 23.88328422], [117.38340241, 23.88298723], [117.38355841, 23.88258724], [117.38379341, 23.88237725], [117.38406841, 23.88235625], [117.38469841, 23.88246324], [117.38477241, 23.88262124], [117.38546741, 23.88304923], [117.38576041, 23.88338922], [117.38591841, 23.88372421], [117.38576241, 23.88407521], [117.38606241, 23.8844872], [117.38602841, 23.88487719], [117.38616541, 23.88513118], [117.38638741, 23.88513718], [117.38629741, 23.88483319], [117.38631441, 23.88463519], [117.38639941, 23.8845262], [117.38634241, 23.88400921], [117.38655641, 23.88357922], [117.38686341, 23.88355222], [117.38686241, 23.88330122], [117.38662841, 23.88325123], [117.38635941, 23.88299923], [117.38640541, 23.88269224], [117.38662541, 23.88262324], [117.38741141, 23.88267024], [117.38752941, 23.88273424], [117.38749141, 23.88299823], [117.38757041, 23.88310323], [117.38792441, 23.88334222], [117.38820041, 23.88342322], [117.38831741, 23.88326522], [117.38831641, 23.88312723], [117.38796241, 23.88269724], [117.38796141, 23.88245324], [117.38811741, 23.88190226], [117.38850841, 23.88142827], [117.38996141, 23.88088128], [117.38968541, 23.88057529], [117.38917341, 23.88042229], [117.38893841, 23.88061928], [117.38842841, 23.88084128], [117.38783841, 23.88097128], [117.38772041, 23.88093328], [117.38756241, 23.88061528], [117.38748341, 23.88037129], [117.38752141, 23.8801323], [117.38807141, 23.8798063], [117.38905341, 23.8796893], [117.39027041, 23.87928331], [117.39085941, 23.87888532], [117.39109341, 23.87829334], [117.39121041, 23.87818034], [117.39164241, 23.87797634], [117.39254541, 23.87773735], [117.39301741, 23.87779535], [117.39376541, 23.87819034], [117.39423841, 23.87873133], [117.39486841, 23.87923532], [117.39546041, 23.8798793], [117.39636541, 23.88023629], [117.39699541, 23.88072828], [117.39738941, 23.88121727], [117.39754741, 23.88131327], [117.39884141, 23.88070828], [117.39943141, 23.88060028], [117.40006541, 23.88037929], [117.40033241, 23.8800643], [117.40052641, 23.87939331], [117.40056441, 23.87882932], [117.40056041, 23.87768035], [117.40067641, 23.87701037], [117.40036041, 23.87627338], [117.40012141, 23.8754434], [117.40000341, 23.8753644], [117.39929641, 23.8753394], [117.39850941, 23.87481542], [117.39803741, 23.87467742], [117.39729141, 23.87497641], [117.39654541, 23.87508441], [117.39599541, 23.87505341], [117.39591641, 23.87496141], [117.39591641, 23.87486941], [117.39622941, 23.87474842], [117.39638641, 23.87448642], [117.39634541, 23.87390644], [117.39673741, 23.87369844], [117.39685341, 23.87325645], [117.39724541, 23.87285146], [117.39732341, 23.87263046], [117.39728341, 23.87249447], [117.39669341, 23.87220947], [117.39696841, 23.87199848], [117.39771441, 23.87204448], [117.39790941, 23.87154549], [117.39790941, 23.87143749], [117.39759441, 23.8712305], [117.39731741, 23.87077951], [117.39743541, 23.87072251], [117.39767141, 23.87076951], [117.39786741, 23.87068151], [117.39857641, 23.8711395], [117.39877241, 23.8711755], [117.39889041, 23.8711595], [117.39904641, 23.8709315], [117.39936141, 23.8709685], [117.39943941, 23.87075451], [117.39896641, 23.87038351], [117.39880741, 23.86987553], [117.39849341, 23.86984053], [117.39841441, 23.86966053], [117.39809941, 23.86940854], [117.39790141, 23.86907454], [117.39699641, 23.86828056], [117.39683741, 23.86791257], [117.39669641, 23.86784257], [117.39640441, 23.86764758], [117.39565741, 23.86754358], [117.39546141, 23.86757758], [117.39491241, 23.86790357], [117.39471541, 23.86785257], [117.39471441, 23.86766558], [117.39506741, 23.86740458], [117.39522341, 23.86705059], [117.39494841, 23.86684359], [117.39435641, 23.86618361], [117.39427741, 23.86606461], [117.39431641, 23.86586362], [117.39435541, 23.86579062], [117.39494441, 23.86582362], [117.39549541, 23.86594861], [117.39565241, 23.86582862], [117.39525841, 23.86539363], [117.39498241, 23.86520063], [117.39407741, 23.86487764], [117.39329141, 23.86475764], [117.39231041, 23.86530763], [117.39211441, 23.86524763], [117.39207441, 23.86517263], [117.39234841, 23.86469164], [117.39266241, 23.86450165], [117.39270041, 23.86419265], [117.39266041, 23.86397866], [117.39238341, 23.86351167], [117.39230441, 23.86315968], [117.39167341, 23.86239869], [117.39139341, 23.86086073], [117.39249241, 23.86065473], [117.39268841, 23.86036374], [117.39308041, 23.86014574], [117.39382741, 23.86018074], [117.39410141, 23.85983475], [117.39465041, 23.85945176], [117.39476641, 23.85886277], [117.39519641, 23.85818979], [117.39519541, 23.85799079], [117.39499841, 23.8576468], [117.39499741, 23.8574678], [117.39526941, 23.85639783], [117.39526841, 23.85594884], [117.39550141, 23.85531885], [117.39573641, 23.85505486], [117.39628641, 23.85479587], [117.39648141, 23.85452687], [117.39679241, 23.8534499], [117.39679141, 23.8530599], [117.39690841, 23.85297591], [117.39727541, 23.85299891], [117.39757741, 23.8530289], [117.39741841, 23.85277191], [117.39702441, 23.85241792], [117.39674941, 23.85233592], [117.39608241, 23.85243392], [117.39537341, 23.85203893], [117.39615641, 23.85121795], [117.39615541, 23.85064696], [117.39599641, 23.85016897], [117.39544541, 23.84981998], [117.39516941, 23.84952298], [117.39465541, 23.84851801], [117.39473141, 23.84771002], [117.39488741, 23.84739103], [117.39465041, 23.84691104], [117.39453041, 23.84631106], [117.39547241, 23.84611306], [117.39555141, 23.84597806], [117.39539341, 23.84586107], [117.39441041, 23.84564607], [117.39397941, 23.84584307], [117.39346941, 23.84594606], [117.39240741, 23.84589906], [117.39217241, 23.84603206], [117.39197841, 23.84665305], [117.39162641, 23.84711904], [117.39115541, 23.84741503], [117.39025241, 23.84781602], [117.38970441, 23.84830301], [117.38935141, 23.84839101], [117.38899741, 23.84837201], [117.38840641, 23.84802102], [117.38817041, 23.84801702], [117.38789541, 23.84785302], [117.38769841, 23.84785102], [117.38730641, 23.84807102], [117.38683641, 23.848568], [117.38644341, 23.848765], [117.38593241, 23.848585], [117.38549841, 23.84812301], [117.38486641, 23.84690804], [117.38482541, 23.84643005], [117.38553141, 23.84590507], [117.38580441, 23.84521908], [117.38600041, 23.84496609], [117.38658841, 23.84457209], [117.38717741, 23.8443251], [117.38725541, 23.8441421], [117.38725441, 23.84387811], [117.38662541, 23.84367411], [117.38623041, 23.84320713], [117.38603241, 23.84283313], [117.38599241, 23.84248414], [117.38618841, 23.84212015], [117.38677641, 23.84163016], [117.38826641, 23.84071518], [117.38846141, 23.84039219], [117.38850041, 23.8400622], [117.38869541, 23.8398052], [117.38900941, 23.8397052], [117.38963841, 23.8397852], [117.38991341, 23.8397442], [117.38971841, 23.84012319], [117.38932641, 23.84053719], [117.38932741, 23.84077618], [117.38944641, 23.84104217], [117.38956441, 23.84109817], [117.38976041, 23.84106017], [117.39011341, 23.84078818], [117.39034841, 23.84071118], [117.39086041, 23.84084818], [117.39117541, 23.84120617], [117.39113641, 23.84128017], [117.39090041, 23.84134917], [117.39078341, 23.84149516], [117.39062841, 23.84193615], [117.39066741, 23.84226515], [117.39102241, 23.84247214], [117.39161141, 23.84252514], [117.39275041, 23.84227215], [117.39412441, 23.84207215], [117.39541941, 23.84168616], [117.39573341, 23.84147816], [117.39589041, 23.84126317], [117.39588941, 23.84103517], [117.39549441, 23.84049219], [117.39525741, 23.8399442], [117.39505841, 23.83906722], [117.39490041, 23.83892322], [117.39474241, 23.83859423], [117.39462241, 23.83779125], [117.39438541, 23.83740126], [117.39383341, 23.83677527], [117.39379341, 23.83648828], [117.39387141, 23.83640328], [117.39410741, 23.83638628], [117.39426441, 23.83648828], [117.39481441, 23.83656327], [117.39501241, 23.83673627], [117.39513041, 23.83698227], [117.39509241, 23.83721226], [117.39520941, 23.83728026], [117.39603441, 23.83697827], [117.39626841, 23.83649028], [117.39626741, 23.83610229], [117.39602941, 23.8356293], [117.39606741, 23.8352163], [117.39583041, 23.83468832], [117.39586941, 23.83448732], [117.39606441, 23.83418733], [117.39606441, 23.83404733], [117.39582741, 23.83377634], [117.39547341, 23.83354234], [117.39547141, 23.83295436], [117.39640941, 23.83156639], [117.39633041, 23.8311944], [117.39648641, 23.8307964], [117.39644541, 23.83054441], [117.39660141, 23.83015842], [117.39660141, 23.82996142], [117.39648141, 23.82939744], [117.39620541, 23.82925644], [117.39530241, 23.82897844], [117.39443541, 23.82817546], [117.39372941, 23.82840646], [117.39294341, 23.82840146], [117.39180241, 23.82782147], [117.39113341, 23.82738048], [117.39093641, 23.82734548], [117.39042641, 23.82738248], [117.38980141, 23.82861145], [117.38929141, 23.82894645], [117.38874141, 23.82911844], [117.38791641, 23.82919744], [117.38677641, 23.82902344], [117.38634141, 23.82796547], [117.38626041, 23.82735848], [117.38629841, 23.82677049], [117.38637641, 23.8265535], [117.38676741, 23.82601551], [117.38680641, 23.82568352], [117.38782641, 23.82512253], [117.38774641, 23.82483554], [117.38715441, 23.82411955], [117.38723241, 23.82390756], [117.38715241, 23.82342457], [117.38691641, 23.82315858], [117.38691541, 23.82289658], [117.38707141, 23.82239759], [117.38706941, 23.8219016], [117.38647941, 23.82164461], [117.38691041, 23.82115262], [117.38690941, 23.82095562], [117.38675141, 23.82062963], [117.38651541, 23.82063463], [117.38553541, 23.82129662], [117.38526241, 23.8220946], [117.38510641, 23.82244859], [117.38498841, 23.82254359], [117.38487041, 23.82256159], [117.38435941, 23.82233059], [117.38441641, 23.8218966], [117.38480741, 23.82063263], [117.38495141, 23.82067363], [117.38537541, 23.82040164], [117.38557141, 23.82011964], [117.38560941, 23.81983865], [117.38565241, 23.81969365], [117.38542541, 23.81930766], [117.38524041, 23.81851968], [117.38513041, 23.81841568], [117.38495241, 23.81725871], [117.38382241, 23.81687472], [117.38325241, 23.81674472], [117.38265341, 23.81693172], [117.38115941, 23.81683672], [117.38084641, 23.81707671], [117.37809441, 23.81704871], [117.37825541, 23.81826469], [117.37754741, 23.81816869], [117.37676041, 23.8178317], [117.37656341, 23.81784969], [117.37633341, 23.8176367], [117.37499841, 23.81693072], [117.37440441, 23.81676872], [117.37423741, 23.81687172], [117.37459941, 23.8178217], [117.37446141, 23.81854168], [117.37388641, 23.81868468], [117.37363441, 23.81850568], [117.37332241, 23.81842868], [117.37309241, 23.81847968], [117.37283141, 23.81838568], [117.37243941, 23.81862268], [117.37220341, 23.81865668], [117.37196641, 23.81860768], [117.37184841, 23.81844268], [117.37145541, 23.81846168], [117.37090541, 23.81879367], [117.37047441, 23.81919866], [117.37008141, 23.81913067], [117.36992241, 23.81882667]];
//古雷港经济开发区
var glgjjkfq = [[117.49349441, 23.98874185], [117.49389941, 23.98907884], [117.49414441, 23.98918684], [117.49492141, 23.98931783], [117.49577641, 23.98966183], [117.49610541, 23.98989982], [117.49620541, 23.99009082], [117.49617941, 23.99112279], [117.49532141, 23.99254676], [117.49521141, 23.99289975], [117.49521441, 23.99319575], [117.49544341, 23.99375873], [117.49600641, 23.99465171], [117.49620341, 23.9951137], [117.49628741, 23.99553269], [117.49606141, 23.99597668], [117.49606541, 23.99627368], [117.49626741, 23.99663267], [117.49667441, 23.99696866], [117.49666941, 23.99809363], [117.49675741, 23.99829063], [117.49716441, 23.99871162], [117.49732141, 23.99921561], [117.49728741, 23.9995456], [117.49655841, 24.00083357], [117.49657941, 24.00106157], [117.49682741, 24.00163855], [117.49668741, 24.00202055], [117.49612741, 24.00291553], [117.49552941, 24.00315452], [117.49523841, 24.00338851], [117.49505441, 24.00368851], [117.49509741, 24.0039245], [117.49527141, 24.0041635], [117.49598941, 24.00467249], [117.49674441, 24.00541747], [117.49765341, 24.00702543], [117.49792641, 24.00705443], [117.49894441, 24.00678844], [117.49936241, 24.00695843], [117.49965141, 24.00692844], [117.50006241, 24.00670244], [117.50047341, 24.00625245], [117.50152941, 24.00645645], [117.50229641, 24.00673644], [117.50242041, 24.00698143], [117.50237641, 24.00763042], [117.50249341, 24.00778442], [117.50328441, 24.00792841], [117.50380441, 24.00820241], [117.50420341, 24.00794041], [117.50452841, 24.00800541], [117.50524741, 24.0083534], [117.50592441, 24.00895039], [117.50616141, 24.00889739], [117.50642541, 24.0084134], [117.50659241, 24.0083934], [117.50671641, 24.0084904], [117.50701041, 24.00911539], [117.50706241, 24.00974937], [117.50657841, 24.01185932], [117.50591141, 24.01331529], [117.50588941, 24.01395328], [117.50626741, 24.01442727], [117.50637941, 24.01494825], [117.50651141, 24.01510025], [117.50814441, 24.01590223], [117.50901641, 24.01648822], [117.50957341, 24.01627022], [117.50986341, 24.01626622], [117.51012941, 24.01634622], [117.51063641, 24.01667221], [117.51123241, 24.01667121], [117.51188841, 24.0174182], [117.51214341, 24.01818918], [117.51198641, 24.01901916], [117.51190041, 24.01923416], [117.51145541, 24.01963715], [117.51116241, 24.02012414], [117.51090141, 24.02082012], [117.51091741, 24.02109611], [117.51107841, 24.02132911], [117.51156641, 24.0215991], [117.51232541, 24.02219809], [117.51301641, 24.02298107], [117.51405241, 24.02362206], [117.51447341, 24.02377505], [117.51624041, 24.02402905], [117.51641641, 24.02397705], [117.51677141, 24.02367606], [117.51714041, 24.02355806], [117.51851341, 24.02434204], [117.51895041, 24.02443804], [117.51932141, 24.02443004], [117.51991641, 24.02403705], [117.52046141, 24.02313907], [117.52132341, 24.02290607], [117.52220641, 24.02225709], [117.52278141, 24.02214309], [117.52301641, 24.02231409], [117.52329441, 24.02274408], [117.52377341, 24.02304607], [117.52397141, 24.02325607], [117.52408641, 24.02396305], [117.52397141, 24.02488303], [117.52448041, 24.02564401], [117.52521441, 24.026082], [117.52625941, 24.02652099], [117.52665041, 24.02683198], [117.52674241, 24.02719798], [117.52738541, 24.02735997], [117.52796241, 24.02703498], [117.52868041, 24.026168], [117.52919041, 24.02603], [117.52999341, 24.026005], [117.53024641, 24.02583101], [117.53071041, 24.02510402], [117.53123641, 24.02450004], [117.53165941, 24.02363406], [117.53226441, 24.02280108], [117.53296541, 24.02146911], [117.53355041, 24.02085312], [117.53437441, 24.02040813], [117.53528241, 24.02035513], [117.53566841, 24.02051113], [117.53768641, 24.0217701], [117.53906141, 24.02234009], [117.53992141, 24.02292207], [117.54040541, 24.02341506], [117.54084441, 24.02437204], [117.54112541, 24.02471403], [117.54150841, 24.02485803], [117.54246741, 24.02470903], [117.54296041, 24.02481903], [117.54417641, 24.02557001], [117.54452741, 24.026172], [117.54467441, 24.02661099], [117.54522541, 24.026213], [117.54569341, 24.02637899], [117.54719541, 24.026306], [117.54914741, 24.02701098], [117.54987141, 24.02775796], [117.55105241, 24.02860794], [117.55162241, 24.02935493], [117.55233441, 24.02893594], [117.55303741, 24.02837395], [117.55415241, 24.02781796], [117.55485741, 24.02760297], [117.55521141, 24.02762297], [117.55536941, 24.02773496], [117.55572241, 24.02857295], [117.55619341, 24.02871194], [117.55661341, 24.02897494], [117.55690741, 24.02889994], [117.55800841, 24.02798896], [117.55942941, 24.02753597], [117.55996741, 24.02760597], [117.56108541, 24.02802896], [117.56224941, 24.02894194], [117.56267941, 24.02898594], [117.56276241, 24.02920793], [117.56264641, 24.02945793], [117.56226041, 24.02956792], [117.56192241, 24.02982092], [117.56169841, 24.03008991], [117.56158741, 24.0304179], [117.56154441, 24.0307079], [117.56191641, 24.03113489], [117.56219641, 24.03166888], [117.56217841, 24.03232686], [117.56211241, 24.03251786], [117.56178041, 24.03295485], [117.56166341, 24.03327584], [117.56164441, 24.03409982], [117.56181541, 24.03547579], [117.56201341, 24.03588978], [117.56241841, 24.03587678], [117.56322241, 24.03653077], [117.56385641, 24.03669576], [117.56399041, 24.03680176], [117.56481641, 24.03694176], [117.56519641, 24.03708775], [117.56594241, 24.03793073], [117.56701541, 24.03802373], [117.56780641, 24.03793773], [117.56848041, 24.03773974], [117.56883741, 24.03735275], [117.56933141, 24.03698175], [117.56944241, 24.03662076], [117.56936141, 24.03598178], [117.56936041, 24.03572378], [117.56943741, 24.03554879], [117.57171141, 24.03651577], [117.57206341, 24.03703175], [117.57262041, 24.03832172], [117.57325741, 24.03912071], [117.57366841, 24.0395347], [117.57426941, 24.03981169], [117.57480641, 24.04037468], [117.57639541, 24.04135766], [117.57637141, 24.04151065], [117.57557741, 24.04277162], [117.57552041, 24.04294262], [117.57560641, 24.04315362], [117.57633341, 24.04325361], [117.57650541, 24.04341861], [117.57672741, 24.04407359], [117.57708341, 24.04434559], [117.57732541, 24.04431359], [117.57784341, 24.0438936], [117.57841541, 24.0437486], [117.57928141, 24.0436806], [117.58111741, 24.0438556], [117.58131741, 24.0439606], [117.58225241, 24.04530357], [117.58275141, 24.04689753], [117.58289641, 24.04771751], [117.58345041, 24.04895248], [117.58372641, 24.04937047], [117.58453541, 24.05019146], [117.58543941, 24.05081544], [117.58655841, 24.05101144], [117.58856141, 24.05217741], [117.58885541, 24.05201241], [117.58918441, 24.05142543], [117.58944441, 24.05124743], [117.59007541, 24.05128343], [117.59065841, 24.05116143], [117.59132541, 24.05054645], [117.59309341, 24.05049345], [117.59323741, 24.05041345], [117.59351541, 24.04939747], [117.59413241, 24.04858049], [117.59520341, 24.0483375], [117.59609141, 24.04847749], [117.59778141, 24.0481725], [117.59789441, 24.0480635], [117.59823641, 24.04735352], [117.59884641, 24.04697653], [117.59902341, 24.04515157], [117.59928441, 24.04455758], [117.60037341, 24.04311962], [117.60075041, 24.04276062], [117.60112341, 24.04262563], [117.60156341, 24.04259563], [117.60258341, 24.04263663], [117.60408741, 24.04286562], [117.60456841, 24.04287362], [117.60548441, 24.04272062], [117.60662641, 24.04215664], [117.60737441, 24.04251963], [117.60779841, 24.04237963], [117.60901141, 24.04176665], [117.60980641, 24.04170365], [117.61012241, 24.04159965], [117.61032741, 24.04144665], [117.61053941, 24.04145865], [117.61102741, 24.04107566], [117.61138841, 24.04065167], [117.61210241, 24.04018368], [117.61226941, 24.03991869], [117.61227541, 24.03982469], [117.61207941, 24.0395347], [117.61222241, 24.0394357], [117.61227341, 24.0392997], [117.61204441, 24.03888871], [117.61209041, 24.03849172], [117.61195741, 24.03783874], [117.61164741, 24.03743474], [117.61173041, 24.03726375], [117.61209741, 24.03730275], [117.61214141, 24.03753574], [117.61237841, 24.03793873], [117.61262541, 24.03807373], [117.61300341, 24.03810373], [117.61311541, 24.03804973], [117.61331341, 24.03755974], [117.61350941, 24.03752774], [117.61364841, 24.03785974], [117.61416241, 24.03805073], [117.61421141, 24.03813973], [117.61392941, 24.03851972], [117.61377641, 24.03889771], [117.61326341, 24.0392887], [117.61323441, 24.0394617], [117.61377241, 24.03991469], [117.61397741, 24.03999769], [117.61414141, 24.04025868], [117.61458841, 24.04024868], [117.61480641, 24.04038568], [117.61492941, 24.04024568], [117.61477941, 24.0395607], [117.61490641, 24.0392037], [117.61517941, 24.0392877], [117.61563241, 24.0392977], [117.61591241, 24.0395437], [117.61608741, 24.03913071], [117.61621041, 24.03851472], [117.61663841, 24.03806373], [117.61770541, 24.03734875], [117.61817341, 24.03720575], [117.61856541, 24.03723075], [117.61880441, 24.03746674], [117.61944141, 24.03877571], [117.62060241, 24.04016068], [117.62095641, 24.04075267], [117.62097641, 24.04082767], [117.62076741, 24.04112566], [117.62089241, 24.04152165], [117.62081241, 24.04200364], [117.62107041, 24.04266963], [117.62125341, 24.04288662], [117.62159641, 24.04298162], [117.62198741, 24.04291062], [117.62220141, 24.04265663], [117.62235441, 24.04221064], [117.62248541, 24.04203364], [117.62285941, 24.04176465], [117.62315841, 24.04179365], [117.62332441, 24.04190464], [117.62397541, 24.04273762], [117.62421941, 24.04285862], [117.62457941, 24.04276262], [117.62486641, 24.04279762], [117.62571441, 24.04239363], [117.62583041, 24.04252463], [117.62597741, 24.04318161], [117.62613441, 24.04343161], [117.62634741, 24.04358861], [117.62697541, 24.0438326], [117.62747041, 24.04465458], [117.62761841, 24.04470258], [117.62796941, 24.04425259], [117.62815841, 24.04416459], [117.62851341, 24.04416359], [117.62875541, 24.0438726], [117.62939041, 24.04348761], [117.62959841, 24.04352661], [117.62997841, 24.0439336], [117.63061241, 24.04411259], [117.63151241, 24.04416659], [117.63233241, 24.0439586], [117.63338041, 24.04332961], [117.63464441, 24.04243163], [117.63482541, 24.04219664], [117.63595041, 24.04165265], [117.63627541, 24.04156165], [117.63661641, 24.04165065], [117.63708341, 24.04205564], [117.63773741, 24.04246863], [117.63835441, 24.04263363], [117.63878641, 24.04325261], [117.63921641, 24.04358261], [117.63954741, 24.0439626], [117.63985341, 24.04459658], [117.64045441, 24.04502957], [117.64082841, 24.04557356], [117.64152241, 24.04600355], [117.64200441, 24.04648454], [117.64222941, 24.04630354], [117.64295841, 24.04571156], [117.64366441, 24.04545556], [117.64437441, 24.04536656], [117.64616441, 24.04449959], [117.64692341, 24.0438766], [117.64709041, 24.0438546], [117.64757641, 24.04412859], [117.64786341, 24.04413459], [117.64823841, 24.0438146], [117.64885341, 24.04356461], [117.64904341, 24.04335861], [117.64922141, 24.04297162], [117.64935941, 24.04296862], [117.64969641, 24.04323861], [117.65113941, 24.04292962], [117.65123941, 24.04288462], [117.65132941, 24.04262763], [117.65145241, 24.04253163], [117.65195841, 24.04253563], [117.65286641, 24.04227763], [117.65310441, 24.04179665], [117.65339841, 24.04161865], [117.65362641, 24.04165765], [117.65409641, 24.04199164], [117.65431741, 24.04203064], [117.65498341, 24.04182065], [117.65523041, 24.04151265], [117.65539041, 24.04142165], [117.65589541, 24.04123466], [117.65609441, 24.04123966], [117.65652441, 24.04140765], [117.65713741, 24.04228963], [117.65738041, 24.04244363], [117.65835141, 24.04205764], [117.65903141, 24.04162165], [117.65932641, 24.04097866], [117.65949041, 24.04087667], [117.66016041, 24.04085167], [117.66083241, 24.04105866], [117.66172941, 24.04086467], [117.66202041, 24.04099966], [117.66222741, 24.04136066], [117.66280341, 24.04172965], [117.66319341, 24.04226064], [117.66327541, 24.04344961], [117.66338641, 24.0439746], [117.66349541, 24.04426159], [117.66377041, 24.04462158], [117.66397241, 24.04475458], [117.66416741, 24.04478158], [117.66523641, 24.04471458], [117.66543641, 24.04494257], [117.66553241, 24.04547756], [117.66568441, 24.04579856], [117.66590841, 24.04591155], [117.66646841, 24.04593455], [117.66699541, 24.04579856], [117.66719641, 24.04567656], [117.66754941, 24.04540556], [117.66777041, 24.04513357], [117.66786441, 24.04485758], [117.66780641, 24.04353161], [117.66802841, 24.04302062], [117.66834141, 24.04263663], [117.66920641, 24.04238963], [117.66959941, 24.04185265], [117.67002141, 24.04150465], [117.67030541, 24.04143065], [117.67091241, 24.04147365], [117.67164941, 24.04064367], [117.67264041, 24.04026268], [117.67338541, 24.0393977], [117.67396041, 24.03912071], [117.67457841, 24.03897271], [117.67487541, 24.03877971], [117.67556241, 24.03781874], [117.67582241, 24.03785774], [117.67620041, 24.03826273], [117.67627841, 24.03857272], [117.67626641, 24.0393857], [117.67632141, 24.0395767], [117.67688341, 24.03995369], [117.67712441, 24.03992369], [117.67739341, 24.0396077], [117.67766141, 24.03889071], [117.67788141, 24.03860272], [117.67817241, 24.03860272], [117.67851941, 24.03881571], [117.67900041, 24.03862872], [117.67915741, 24.03864472], [117.67968041, 24.03892571], [117.68021041, 24.03877971], [117.68054241, 24.03847472], [117.68059241, 24.03802673], [117.68101741, 24.03804773], [117.68158741, 24.03772474], [117.68168741, 24.03712075], [117.68189941, 24.03691676], [117.68206441, 24.03708675], [117.68206941, 24.03741574], [117.68218041, 24.03764774], [117.68256241, 24.03775274], [117.68276241, 24.03790873], [117.68228541, 24.03854672], [117.68240541, 24.03905971], [117.68241041, 24.0394877], [117.68293841, 24.03967269], [117.68367241, 24.03978969], [117.68492141, 24.03987069], [117.68567641, 24.03983469], [117.68577741, 24.03976169], [117.68577541, 24.03967069], [117.68550941, 24.03916371], [117.68512141, 24.03899571], [117.68481041, 24.03873772], [117.68428241, 24.03854672], [117.68398941, 24.03829372], [117.68352841, 24.03815973], [117.68338341, 24.03801873], [117.68339041, 24.03791173], [117.68400741, 24.03798373], [117.68424741, 24.03792673], [117.68458741, 24.03781274], [117.68500041, 24.03744574], [117.68594441, 24.03712075], [117.68605541, 24.03699075], [117.68608841, 24.03654577], [117.68640741, 24.03627977], [117.68665341, 24.03637477], [117.68677741, 24.03654377], [117.68691041, 24.03697176], [117.68693541, 24.03743474], [117.68717341, 24.03780074], [117.68730841, 24.03789073], [117.68761341, 24.03792873], [117.68831841, 24.03765674], [117.68850941, 24.03768174], [117.68926841, 24.03803973], [117.68970141, 24.03803373], [117.68995141, 24.03787473], [117.69085241, 24.03673576], [117.69192941, 24.03607278], [117.69277841, 24.03583378], [117.69322841, 24.03550779], [117.69333041, 24.0351748], [117.69336741, 24.0349998], [117.69370341, 24.0349828], [117.69415541, 24.03524879], [117.69515341, 24.03646177], [117.69576141, 24.03676476], [117.69608241, 24.03705675], [117.69614041, 24.03727675], [117.69650341, 24.03758274], [117.69672741, 24.03761374], [117.69756941, 24.03706975], [117.69771541, 24.03681576], [117.69804441, 24.03651577], [117.69822441, 24.03604678], [117.69861141, 24.03550979], [117.69881241, 24.0350778], [117.69902841, 24.03418082], [117.69922041, 24.03394582], [117.69949641, 24.03386883], [117.70022741, 24.03403082], [117.70078541, 24.03429782], [117.70106241, 24.03453381], [117.70120641, 24.03454381], [117.70121641, 24.03335084], [117.70099141, 24.03253286], [117.70105841, 24.03229586], [117.70124141, 24.03212986], [117.70243841, 24.03169987], [117.70260741, 24.03151288], [117.70424641, 24.03257785], [117.70483541, 24.03186587], [117.70573241, 24.03273585], [117.70635341, 24.03251186], [117.70654041, 24.03227086], [117.70761941, 24.03283685], [117.70822341, 24.03325184], [117.70833841, 24.03324184], [117.70889841, 24.03175187], [117.70886541, 24.03166487], [117.70834341, 24.03133088], [117.70843741, 24.03113889], [117.70892841, 24.03133988], [117.70900541, 24.03130488], [117.70967641, 24.03009791], [117.70964941, 24.02951992], [117.70995641, 24.02938393], [117.709, 24.03], [117.69, 23.983], [117.709, 23.952], [117.656, 23.922], [117.637, 23.895], [117.624, 23.83], [117.63, 23.805], [117.644, 23.794], [117.625, 23.777], [117.624, 23.766], [117.614, 23.764], [117.613, 23.758], [117.615, 23.758], [117.615, 23.758], [117.613, 23.758], [117.612, 23.751], [117.593, 23.739], [117.59, 23.719], [117.58, 23.729], [117.594, 23.746], [117.586, 23.746], [117.581, 23.775], [117.595, 23.778], [117.615, 23.813], [117.597, 23.878], [117.566, 23.884], [117.572, 23.899], [117.565, 23.902], [117.56, 23.894], [117.548, 23.902], [117.551, 23.911], [117.544, 23.9], [117.538, 23.914], [117.536, 23.907], [117.524, 23.917], [117.511, 23.913], [117.513, 23.919], [117.506, 23.922], [117.482, 23.919], [117.459, 23.927], [117.455, 23.929], [117.453, 23.931], [117.452, 23.936], [117.457, 23.94], [117.456, 23.941], [117.454, 23.942], [117.454, 23.945], [117.457, 23.942], [117.46, 23.942], [117.469, 23.944], [117.473, 23.952], [117.475, 23.953], [117.479, 23.958], [117.48, 23.958], [117.482, 23.967], [117.488, 23.972], [117.485, 23.973], [117.484, 23.975], [117.485, 23.98], [117.484, 23.983], [117.492, 23.985], [117.494, 23.988], [117.49349441, 23.98874185]];
//漳州高新技术产业开发区
var zzgxjscykfq = [[117.66239141, 24.46364501], [117.66244141, 24.46348702], [117.66429141, 24.46301303], [117.66382941, 24.46155906], [117.66571341, 24.46103607], [117.66555441, 24.46059208], [117.66587841, 24.46044809], [117.66580541, 24.46025309], [117.66564641, 24.46026909], [117.66547241, 24.4600651], [117.66536341, 24.4600151], [117.66505341, 24.4600531], [117.66484041, 24.4597321], [117.66442841, 24.4597771], [117.66430941, 24.45921512], [117.66412041, 24.45902612], [117.66379541, 24.45842513], [117.66353241, 24.45846213], [117.66352041, 24.45822914], [117.66340841, 24.45802414], [117.66326041, 24.45807714], [117.66319541, 24.45823114], [117.66239741, 24.45824614], [117.66216741, 24.45817314], [117.66208041, 24.45824114], [117.66142941, 24.45822014], [117.66138341, 24.45814014], [117.66104441, 24.45819514], [117.66089141, 24.45788415], [117.65991841, 24.45798314], [117.65918441, 24.45817814], [117.65910241, 24.45786415], [117.65876341, 24.45776915], [117.65890741, 24.45674517], [117.65924841, 24.45580319], [117.65953941, 24.45526021], [117.65992341, 24.45474822], [117.66058341, 24.45278326], [117.66058641, 24.45247427], [117.66037841, 24.4513393], [117.66061341, 24.4511293], [117.66071241, 24.45073131], [117.66130841, 24.45055732], [117.66128741, 24.45037632], [117.66151141, 24.45030632], [117.66179541, 24.45043732], [117.66196141, 24.45070431], [117.66248741, 24.45049932], [117.66229641, 24.45001433], [117.66250241, 24.44988733], [117.66239041, 24.44945934], [117.66277241, 24.44932534], [117.66267741, 24.44915935], [117.66268341, 24.44890135], [117.66388641, 24.44878936], [117.66410141, 24.44870736], [117.66369941, 24.44596342], [117.66347141, 24.44469545], [117.66326741, 24.44399847], [117.66293141, 24.44305549], [117.66353341, 24.4427575], [117.66337641, 24.44219551], [117.66349441, 24.44210851], [117.66350641, 24.44194551], [117.66267341, 24.44157452], [117.66263841, 24.44125453], [117.66253441, 24.44104953], [117.66252841, 24.44082754], [117.66261641, 24.44068854], [117.66307541, 24.44039155], [117.66347841, 24.44085954], [117.66377041, 24.44069754], [117.66448141, 24.44095154], [117.66483941, 24.44067954], [117.66502241, 24.44067454], [117.66570241, 24.44019055], [117.66558541, 24.44001956], [117.66572941, 24.43992056], [117.66619041, 24.43997356], [117.66642741, 24.43975656], [117.66677341, 24.43995356], [117.66730741, 24.43964257], [117.66833341, 24.43950657], [117.66885741, 24.43905058], [117.66939041, 24.43890158], [117.66997041, 24.43851759], [117.67080941, 24.43744562], [117.67196741, 24.43622965], [117.67203541, 24.43600865], [117.67173741, 24.43538466], [117.67181141, 24.43514767], [117.67173741, 24.43476068], [117.67173241, 24.4340127], [117.67184841, 24.43352971], [117.67197841, 24.43343271], [117.67217141, 24.43349071], [117.67235841, 24.4336497], [117.67250141, 24.43424969], [117.67247541, 24.43487968], [117.67270441, 24.43546466], [117.67271241, 24.43564666], [117.67171341, 24.43717462], [117.67125141, 24.43774961], [117.67139841, 24.43789561], [117.67303141, 24.4382076], [117.67411541, 24.43841459], [117.67434041, 24.4383826], [117.67546741, 24.43713162], [117.67572241, 24.43673263], [117.67650841, 24.43666463], [117.67727241, 24.43690963], [117.67765141, 24.43729562], [117.67766141, 24.43745862], [117.67755841, 24.43752562], [117.67720741, 24.43751562], [117.67712641, 24.43758161], [117.67694741, 24.4380746], [117.67740441, 24.43864459], [117.67804641, 24.43878659], [117.67921641, 24.43861259], [117.67936141, 24.43864959], [117.67957841, 24.43848859], [117.67964141, 24.43853659], [117.67982841, 24.43842159], [117.67987541, 24.43851659], [117.68023141, 24.43845059], [117.68018641, 24.43690963], [117.68047441, 24.43651864], [117.68054841, 24.43615565], [117.68072341, 24.43598865], [117.68075841, 24.43581465], [117.68122741, 24.43571666], [117.68103141, 24.43481168], [117.68077541, 24.43450968], [117.68349441, 24.43340871], [117.68429641, 24.43261473], [117.68409341, 24.43193574], [117.68409641, 24.43155875], [117.68425841, 24.43120676], [117.68421441, 24.43104376], [117.68382241, 24.43050778], [117.68381841, 24.43025278], [117.68414241, 24.43028978], [117.68467341, 24.43104076], [117.68563841, 24.43064577], [117.68627941, 24.42984079], [117.68674941, 24.4296658], [117.68695141, 24.4294288], [117.68732141, 24.4294198], [117.68759841, 24.4295408], [117.68815141, 24.4293738], [117.68843241, 24.42914581], [117.68987341, 24.42907881], [117.69028841, 24.42891881], [117.69061041, 24.42845482], [117.69071141, 24.42782384], [117.69078241, 24.42759584], [117.69092041, 24.42744385], [117.69145941, 24.42700186], [117.69154941, 24.42678786], [117.69175041, 24.42661187], [117.69202641, 24.42652187], [117.69325041, 24.42570389], [117.69338241, 24.42549589], [117.69348941, 24.42489691], [117.69363341, 24.42473591], [117.69378241, 24.42437192], [117.69408041, 24.42408992], [117.69479141, 24.42273296], [117.69417341, 24.42258496], [117.69380441, 24.42159998], [117.69364341, 24.42147198], [117.69329441, 24.42148698], [117.69284641, 24.42165498], [117.69241141, 24.42150498], [117.69208441, 24.42111699], [117.69147841, 24.420613], [117.69083841, 24.41954703], [117.69018841, 24.41901904], [117.68996441, 24.41895304], [117.68955941, 24.41811906], [117.68763941, 24.41706109], [117.68716941, 24.41695909], [117.68678941, 24.4163431], [117.68633241, 24.41602811], [117.68619241, 24.41573012], [117.68518541, 24.41510713], [117.68400541, 24.41482614], [117.68358441, 24.41460614], [117.68340141, 24.41439915], [117.68306241, 24.41374016], [117.68290841, 24.41306918], [117.68292841, 24.41242119], [117.68270641, 24.41135322], [117.68273741, 24.41081723], [117.68252441, 24.41046924], [117.68224641, 24.41035824], [117.68171441, 24.41042224], [117.68104541, 24.41017824], [117.68033641, 24.41022124], [117.67947641, 24.40939926], [117.67887541, 24.40933826], [117.67848041, 24.40943726], [117.67809841, 24.40931626], [117.67777641, 24.40909227], [117.67717341, 24.40902627], [117.67691141, 24.40892727], [117.67660541, 24.40869928], [117.67648341, 24.40840028], [117.67628641, 24.40822229], [117.67602341, 24.40810529], [117.67557841, 24.40808229], [117.67514041, 24.4078333], [117.67501141, 24.4077093], [117.67497541, 24.40739631], [117.67511041, 24.40709931], [117.67557241, 24.40704332], [117.67639341, 24.40677532], [117.67796741, 24.40657533], [117.67805841, 24.40648933], [117.67808041, 24.40633933], [117.67802441, 24.40541135], [117.67806141, 24.40521636], [117.67814941, 24.40517036], [117.67829941, 24.40516936], [117.67865341, 24.40555835], [117.67910641, 24.40586634], [117.67959441, 24.40576234], [117.67973141, 24.40563535], [117.67985541, 24.40536035], [117.67950841, 24.40423438], [117.67938041, 24.40416238], [117.67883441, 24.40428038], [117.67856341, 24.40421838], [117.67841741, 24.40364639], [117.67817641, 24.4032224], [117.67819441, 24.40306541], [117.67830841, 24.40300441], [117.67890941, 24.40312441], [117.67995841, 24.40291241], [117.68037141, 24.40252542], [117.68042141, 24.40228043], [117.68035941, 24.40191743], [117.68016741, 24.40163344], [117.67985541, 24.40142144], [117.67902341, 24.40114745], [117.67768441, 24.40173944], [117.67656741, 24.40151544], [117.67644241, 24.40128245], [117.67638041, 24.40042147], [117.67621141, 24.40023347], [117.67600141, 24.40013147], [117.67538741, 24.40024447], [117.67520741, 24.40015547], [117.67522241, 24.39997848], [117.67551941, 24.39952249], [117.67548041, 24.39928449], [117.67496241, 24.3989425], [117.67466241, 24.3988755], [117.67428441, 24.39845651], [117.67398341, 24.39834552], [117.67376841, 24.39777053], [117.67383041, 24.39741654], [117.67411841, 24.39681055], [117.67403941, 24.39640556], [117.67386741, 24.39638956], [117.67364841, 24.39648156], [117.67357241, 24.39687155], [117.67330741, 24.39702955], [117.67292641, 24.39686855], [117.67255941, 24.39697755], [117.67240641, 24.39709654], [117.67236641, 24.39731854], [117.67263241, 24.39770953], [117.67267841, 24.39786053], [117.67261941, 24.39792952], [117.67239341, 24.39792253], [117.67212241, 24.39777253], [117.67197241, 24.39779353], [117.67143241, 24.39802752], [117.67129041, 24.39816552], [117.67103241, 24.39823552], [117.67070241, 24.39804352], [117.67048341, 24.39764153], [117.67009841, 24.39868351], [117.66968341, 24.3989975], [117.66926041, 24.3990495], [117.66898441, 24.3989715], [117.66847641, 24.3991025], [117.66812141, 24.39924349], [117.66790141, 24.39947949], [117.66767341, 24.39960349], [117.66729241, 24.39950449], [117.66674141, 24.39954449], [117.66647041, 24.39943349], [117.66626541, 24.3989185], [117.66630541, 24.39858651], [117.66602441, 24.39787053], [117.66599341, 24.39734454], [117.66580041, 24.39657456], [117.66556741, 24.39650456], [117.66494741, 24.39680455], [117.66472841, 24.39675255], [117.66478541, 24.39649556], [117.66504641, 24.39605657], [117.66552341, 24.39547658], [117.66540441, 24.39518359], [117.66434041, 24.39437861], [117.66416241, 24.39416461], [117.66422541, 24.39405261], [117.66433241, 24.39403061], [117.66469041, 24.39407761], [117.66488141, 24.39370362], [117.66538141, 24.39329963], [117.66544441, 24.39315563], [117.66518941, 24.39230565], [117.66476741, 24.39175667], [117.66478441, 24.39152067], [117.66496041, 24.39125268], [117.66497641, 24.39091569], [117.66486441, 24.39062269], [117.66460441, 24.3903437], [117.66458441, 24.38992171], [117.66429141, 24.38976271], [117.66437841, 24.38950972], [117.66449541, 24.38931672], [117.66477441, 24.38918273], [117.66570041, 24.38928772], [117.66599341, 24.38943072], [117.66635141, 24.38939772], [117.66664841, 24.38825275], [117.66677141, 24.38810275], [117.66708041, 24.38794575], [117.66713641, 24.38781276], [117.66690841, 24.38762676], [117.66643441, 24.38756976], [117.66639141, 24.38749876], [117.66644441, 24.38737577], [117.66678441, 24.38716677], [117.66679441, 24.38694778], [117.66661141, 24.38663278], [117.66665041, 24.38650379], [117.66705341, 24.38628879], [117.66703841, 24.38559281], [117.66741741, 24.38512082], [117.66736241, 24.38492882], [117.66723141, 24.38483783], [117.66721941, 24.38464583], [117.66737141, 24.38441184], [117.66787541, 24.38444083], [117.66867041, 24.38328386], [117.66883741, 24.38264088], [117.66904541, 24.38233688], [117.66957641, 24.38200789], [117.66993941, 24.3814139], [117.66930041, 24.38188289], [117.66855741, 24.38222489], [117.66790941, 24.38349086], [117.66693541, 24.38387885], [117.66680741, 24.38463783], [117.66683441, 24.38507582], [117.66671241, 24.38526882], [117.66624441, 24.38567981], [117.66615541, 24.3860018], [117.66587341, 24.38631179], [117.66586641, 24.38706477], [117.66537741, 24.38782576], [117.66507441, 24.38804975], [117.66482541, 24.38840074], [117.66440041, 24.38876774], [117.66318941, 24.38944972], [117.66279141, 24.38958472], [117.66192241, 24.38909873], [117.66052741, 24.38856574], [117.65964441, 24.38782576], [117.65953241, 24.38757476], [117.65931641, 24.38742477], [117.65901541, 24.38698478], [117.65852541, 24.38674278], [117.65826841, 24.38628879], [117.65714141, 24.38573581], [117.65677141, 24.38530582], [117.65658441, 24.38529582], [117.65618541, 24.38544681], [117.65602841, 24.38539981], [117.65589641, 24.38525682], [117.65485341, 24.38351086], [117.65464741, 24.38285087], [117.65481641, 24.38210289], [117.65535541, 24.3816689], [117.65599641, 24.38081692], [117.65612841, 24.38059392], [117.65614541, 24.38020693], [117.65583241, 24.37999594], [117.65494741, 24.37978194], [117.65470341, 24.37963795], [117.65446641, 24.37924395], [117.65437341, 24.37877796], [117.65416341, 24.37852097], [117.65356741, 24.37831098], [117.65278241, 24.37833997], [117.65236641, 24.37820398], [117.65192641, 24.37821698], [117.65099341, 24.37759899], [117.65050641, 24.37758399], [117.64963541, 24.37807198], [117.64845041, 24.37886496], [117.64821141, 24.37892396], [117.64749941, 24.37885996], [117.64700341, 24.37891196], [117.64683741, 24.37905196], [117.64666641, 24.37946795], [117.64633941, 24.37985594], [117.64610341, 24.38000694], [117.64587241, 24.37994794], [117.64500941, 24.37961895], [117.64453841, 24.37953595], [117.64397541, 24.37857997], [117.64360141, 24.37832097], [117.64295241, 24.37811598], [117.64207641, 24.37823798], [117.64169541, 24.37787999], [117.64103741, 24.37788199], [117.63995141, 24.37759599], [117.63944241, 24.37759199], [117.63879941, 24.37800298], [117.63835441, 24.37843797], [117.63817541, 24.37892096], [117.63800641, 24.37908596], [117.63732341, 24.37900896], [117.63692941, 24.37886796], [117.63665541, 24.37890196], [117.63622841, 24.37907196], [117.63585141, 24.37938595], [117.63529941, 24.37952595], [117.63451341, 24.37958495], [117.63372441, 24.37986294], [117.63333641, 24.38015793], [117.63311641, 24.38054192], [117.63309141, 24.38076292], [117.63317741, 24.38111491], [117.63380741, 24.38230188], [117.63400441, 24.38326386], [117.63399441, 24.38354285], [117.63392541, 24.38376385], [117.63312941, 24.38478483], [117.63288641, 24.38522482], [117.63286041, 24.38539581], [117.63303341, 24.3857598], [117.63294241, 24.38630679], [117.63251941, 24.38732877], [117.63171641, 24.38815475], [117.63130541, 24.38894373], [117.63176941, 24.38929272], [117.63251141, 24.39003971], [117.63263641, 24.3902397], [117.63273441, 24.39062769], [117.63269841, 24.39084369], [117.63224241, 24.39113268], [117.63159141, 24.39124968], [117.63139041, 24.39148767], [117.63122241, 24.39178367], [117.63088641, 24.39339463], [117.63056341, 24.3944696], [117.63060141, 24.3946146], [117.63081341, 24.3948216], [117.63176441, 24.39544758], [117.63197941, 24.39571158], [117.63203741, 24.39632856], [117.63199641, 24.39691455], [117.63211741, 24.39771153], [117.63201741, 24.39839851], [117.63254041, 24.39966748], [117.63246141, 24.40005848], [117.63210941, 24.40042947], [117.63191341, 24.40058046], [117.63121641, 24.40072846], [117.63098741, 24.40095746], [117.63072341, 24.40192543], [117.63089941, 24.40259642], [117.63087041, 24.40310541], [117.63060941, 24.40373739], [117.63107641, 24.40472537], [117.63110941, 24.40506336], [117.63090541, 24.40543935], [117.63022041, 24.40624833], [117.62997841, 24.40633233], [117.62991741, 24.40643633], [117.63023841, 24.40822729], [117.63093741, 24.41038324], [117.63100741, 24.4118602], [117.63105441, 24.41233919], [117.63090041, 24.41293718], [117.63082241, 24.41297518], [117.62864741, 24.41236419], [117.62740241, 24.4122012], [117.62743741, 24.41245519], [117.62717541, 24.41308218], [117.62730641, 24.41441615], [117.62713141, 24.41460114], [117.62740841, 24.41555212], [117.62743741, 24.41683609], [117.62586541, 24.41747608], [117.62582141, 24.41738508], [117.62557841, 24.41825706], [117.62513341, 24.41830906], [117.62468841, 24.41778607], [117.62450441, 24.4163471], [117.62363041, 24.41569912], [117.62306441, 24.41577112], [117.62243641, 24.4165811], [117.62030241, 24.41772707], [117.62026141, 24.41796007], [117.62040541, 24.41918704], [117.62109741, 24.41927303], [117.62171541, 24.41975002], [117.62184541, 24.42009402], [117.62261041, 24.420744], [117.62323341, 24.420967], [117.62428341, 24.420926], [117.62482441, 24.42118299], [117.62478041, 24.42196597], [117.62492641, 24.42212397], [117.62492741, 24.42233596], [117.62509241, 24.42247196], [117.62545441, 24.42260296], [117.62546541, 24.42279995], [117.62519341, 24.42322094], [117.62497141, 24.42375793], [117.62482441, 24.42384793], [117.62430641, 24.42392993], [117.62369041, 24.42422692], [117.62351541, 24.42444292], [117.62341641, 24.42489491], [117.62322541, 24.4250949], [117.62288541, 24.4252479], [117.62236941, 24.4253539], [117.62223941, 24.42542589], [117.62196941, 24.42580188], [117.62145841, 24.42606088], [117.62128241, 24.42645487], [117.62105341, 24.42656087], [117.62092241, 24.42674486], [117.62094841, 24.42727885], [117.62089041, 24.42738685], [117.62049341, 24.42745585], [117.62014041, 24.42763684], [117.61976941, 24.42805983], [117.61946141, 24.42828083], [117.61871941, 24.42841582], [117.61837441, 24.42904881], [117.61794741, 24.42901881], [117.61771241, 24.42915381], [117.61729841, 24.42996779], [117.61627541, 24.43128676], [117.61594741, 24.43136876], [117.61548541, 24.43125676], [117.61527141, 24.43131376], [117.61499041, 24.43153675], [117.61480941, 24.43175575], [117.61452841, 24.43240073], [117.61419741, 24.43260773], [117.61303941, 24.4340207], [117.61295141, 24.43449268], [117.61280141, 24.43460968], [117.61258341, 24.43465168], [117.61211341, 24.43461768], [117.61171141, 24.43469568], [117.61156341, 24.43475968], [117.61129641, 24.43504667], [117.61086541, 24.43513867], [117.61063441, 24.43535766], [117.61021241, 24.43601065], [117.60970141, 24.43640364], [117.60950241, 24.43646964], [117.60835241, 24.43621365], [117.60805041, 24.43622465], [117.60778741, 24.43633364], [117.60754041, 24.43655864], [117.60628941, 24.43704163], [117.60481341, 24.43750462], [117.60467741, 24.43762261], [117.60429441, 24.4382296], [117.60448941, 24.43950457], [117.60415941, 24.44027455], [117.60349841, 24.44097654], [117.60287941, 24.44098754], [117.60161241, 24.44080154], [117.60083841, 24.44087354], [117.60038841, 24.44071454], [117.60016141, 24.44076854], [117.60007341, 24.44089054], [117.60005641, 24.44137553], [117.59998041, 24.44156852], [117.59965941, 24.44212651], [117.59930441, 24.4423805], [117.60013541, 24.44203651], [117.60086841, 24.44203351], [117.60100141, 24.44214251], [117.60094641, 24.4426185], [117.60112441, 24.44279149], [117.60095041, 24.44317349], [117.60054741, 24.44329848], [117.60001041, 24.44334248], [117.59957341, 24.44308849], [117.59887141, 24.44303649], [117.59844441, 24.4423785], [117.59852041, 24.44204551], [117.59843041, 24.44202351], [117.59798341, 24.44227651], [117.59767641, 24.44224851], [117.59744641, 24.44205451], [117.59697141, 24.44128653], [117.59681641, 24.44134553], [117.59657941, 24.44190151], [117.59634641, 24.44196051], [117.59580841, 24.44170252], [117.59557041, 24.44145252], [117.59544141, 24.44140053], [117.59528841, 24.44148052], [117.59519141, 24.44174952], [117.59529441, 24.44210851], [117.59597841, 24.4427615], [117.59644541, 24.44282449], [117.59624741, 24.44320448], [117.59641041, 24.44343548], [117.59657741, 24.44344848], [117.59667841, 24.44369947], [117.59690841, 24.44392547], [117.59682741, 24.44405547], [117.59652241, 24.44399847], [117.59597541, 24.44345948], [117.59578241, 24.44312249], [117.59538941, 24.4427085], [117.59506341, 24.44285449], [117.59505141, 24.44312949], [117.59563541, 24.44409446], [117.59565041, 24.44445646], [117.59584141, 24.44507544], [117.59572241, 24.44529544], [117.59552541, 24.44518644], [117.59544441, 24.44447846], [117.59518741, 24.44384347], [117.59469841, 24.44374947], [117.59446041, 24.44393847], [117.59431141, 24.44392347], [117.59437841, 24.44306349], [117.59407041, 24.4425685], [117.59412541, 24.44186252], [117.59345441, 24.44132053], [117.59242941, 24.44118953], [117.59211541, 24.44127353], [117.59180641, 24.44174852], [117.59196241, 24.4427035], [117.59161241, 24.44289949], [117.59129641, 24.4427125], [117.59110041, 24.4423415], [117.59084341, 24.4423385], [117.59059841, 24.44195351], [117.59025141, 24.44216351], [117.59033841, 24.4427535], [117.59026941, 24.44290149], [117.59015941, 24.44295249], [117.58997541, 24.44280849], [117.58966941, 24.44231351], [117.58940241, 24.4423615], [117.58879541, 24.44193451], [117.58823941, 24.44188052], [117.58778541, 24.44217451], [117.58685741, 24.4423245], [117.58696641, 24.4424895], [117.58835141, 24.44332648], [117.58806341, 24.44471245], [117.58799241, 24.44560443], [117.58777841, 24.44599742], [117.58699341, 24.4469254], [117.58681541, 24.44831737], [117.58685341, 24.44917935], [117.58716641, 24.44929034], [117.58732341, 24.44927235], [117.58760141, 24.44880236], [117.58893141, 24.44820337], [117.58946641, 24.44772338], [117.59108241, 24.44792338], [117.59117741, 24.44798337], [117.59117341, 24.44807037], [117.59058541, 24.44890735], [117.59032441, 24.44973033], [117.58994941, 24.45009833], [117.58932341, 24.45092931], [117.58898741, 24.4511663], [117.58855341, 24.45097531], [117.58794641, 24.4511733], [117.58720441, 24.4510693], [117.58657441, 24.45145129], [117.58628841, 24.4510783], [117.58607741, 24.4510753], [117.58517541, 24.45163629], [117.58507841, 24.45161029], [117.58495441, 24.4513393], [117.58483441, 24.4513203], [117.58457741, 24.45177629], [117.58433441, 24.45187928], [117.58418641, 24.45208628], [117.58387541, 24.45215728], [117.58332441, 24.45283226], [117.58338641, 24.45316926], [117.58333441, 24.45343925], [117.58354841, 24.45379824], [117.58356541, 24.45398924], [117.58301141, 24.4556252], [117.58290741, 24.4555672], [117.58267841, 24.45503021], [117.58264341, 24.45467222], [117.58275841, 24.45412723], [117.58272441, 24.45382324], [117.58242841, 24.45367124], [117.58200041, 24.45316126], [117.58171541, 24.45302826], [117.58131741, 24.45317226], [117.58127141, 24.45335425], [117.58148641, 24.45431723], [117.58118341, 24.45449322], [117.58131841, 24.45507721], [117.58126841, 24.45517721], [117.58329141, 24.45762415], [117.58292441, 24.45778715], [117.58227741, 24.45768615], [117.58157141, 24.45795315], [117.58155241, 24.45803014], [117.58125741, 24.45815114], [117.58125941, 24.45832314], [117.58092341, 24.45857613], [117.58076541, 24.45861513], [117.58047541, 24.45849113], [117.57989941, 24.45866513], [117.57995441, 24.45834214], [117.57991241, 24.45819214], [117.57979041, 24.45808214], [117.57951141, 24.45801114], [117.57925941, 24.45804214], [117.57865941, 24.45833814], [117.57771541, 24.45802514], [117.57745041, 24.45819414], [117.57723641, 24.45844213], [117.57769341, 24.45883413], [117.57783341, 24.45910912], [117.57816841, 24.46045909], [117.57816941, 24.46120507], [117.57792041, 24.46301403], [117.57786441, 24.46337702], [117.57733341, 24.46347302], [117.57717041, 24.46367001], [117.57657041, 24.46393401], [117.57654541, 24.46463199], [117.57613341, 24.46497998], [117.57577741, 24.46512798], [117.57548941, 24.46515298], [117.57546441, 24.46530298], [117.57533141, 24.46538297], [117.57448541, 24.46510598], [117.57439741, 24.46504098], [117.57442741, 24.46485299], [117.57387341, 24.46465399], [117.57334041, 24.464149], [117.57279841, 24.46386601], [117.57274941, 24.46377501], [117.57289241, 24.46343802], [117.57250641, 24.46313203], [117.57230041, 24.46282003], [117.57249641, 24.46262604], [117.57277941, 24.46238104], [117.57204441, 24.46151306], [117.57192541, 24.46105907], [117.57184141, 24.46098008], [117.57094941, 24.46096108], [117.56937441, 24.46036609], [117.56828641, 24.46042009], [117.56831841, 24.46090708], [117.56843941, 24.46127807], [117.56907641, 24.46207205], [117.56890941, 24.46237904], [117.56855341, 24.46227705], [117.56865741, 24.46262204], [117.57020241, 24.46325302], [117.57050641, 24.46287903], [117.57077441, 24.46290203], [117.57162041, 24.46337002], [117.57130641, 24.46375701], [117.57091341, 24.46450599], [117.57040941, 24.46504998], [117.57020741, 24.46541597], [117.56969241, 24.46551997], [117.56947741, 24.46543997], [117.56891541, 24.46503198], [117.56872941, 24.46499898], [117.56871341, 24.46512798], [117.56926141, 24.46549397], [117.57024041, 24.46655895], [117.57060241, 24.46668994], [117.57097241, 24.46669294], [117.57187741, 24.46627895], [117.57215341, 24.46626595], [117.57246741, 24.46643595], [117.57327041, 24.46714593], [117.57378841, 24.46716893], [117.57415941, 24.46735793], [117.57423041, 24.46752093], [117.57552841, 24.46740693], [117.57621141, 24.46744993], [117.57635241, 24.46828191], [117.57696741, 24.46827091], [117.57749741, 24.4684799], [117.57763541, 24.46887289], [117.57805441, 24.46911889], [117.57842841, 24.46973887], [117.57876941, 24.47032286], [117.57895141, 24.47102584], [117.57734841, 24.47034586], [117.57578041, 24.46996587], [117.57495641, 24.46959888], [117.57404041, 24.46951488], [117.57353341, 24.46914089], [117.57340741, 24.4684019], [117.57307341, 24.4685909], [117.57306741, 24.46883089], [117.57316241, 24.46899089], [117.57344141, 24.46912989], [117.57281141, 24.47028686], [117.57387441, 24.47072685], [117.57401241, 24.47086285], [117.57418641, 24.47141584], [117.57418141, 24.47180583], [117.57407041, 24.47217382], [117.57377941, 24.47243581], [117.57316541, 24.47255381], [117.57242441, 24.47219782], [117.57184141, 24.47270081], [117.57143941, 24.47320579], [117.57103441, 24.47338079], [117.57292041, 24.4730168], [117.57338241, 24.4727958], [117.57457241, 24.4728158], [117.57491441, 24.47196682], [117.57538841, 24.47197682], [117.57660041, 24.47227382], [117.57729941, 24.4731568], [117.57731341, 24.4730328], [117.57740341, 24.4730058], [117.57784241, 24.47318679], [117.57760641, 24.47357179], [117.57704341, 24.47380378], [117.57653041, 24.47431777], [117.57644941, 24.47461976], [117.57665141, 24.47526375], [117.57704341, 24.47593873], [117.57791941, 24.47690471], [117.57830141, 24.47706571], [117.57866341, 24.47688371], [117.57883441, 24.47659172], [117.57893341, 24.47562974], [117.57952441, 24.47619173], [117.57984941, 24.47628872], [117.58015941, 24.47651872], [117.58047541, 24.47656872], [117.58073341, 24.47691271], [117.58119641, 24.47699571], [117.58161041, 24.4772767], [117.58225541, 24.4773987], [117.58271841, 24.47772969], [117.58288741, 24.47767469], [117.58256641, 24.47683371], [117.58263041, 24.47659672], [117.58238241, 24.47586473], [117.58243041, 24.47551574], [117.58252441, 24.47539874], [117.58227041, 24.47530775], [117.58213541, 24.47501975], [117.58222341, 24.47474876], [117.58241941, 24.47464576], [117.58312941, 24.47450476], [117.58328341, 24.47432277], [117.58332041, 24.47391978], [117.58290641, 24.4729168], [117.58332441, 24.47257481], [117.58348941, 24.47255381], [117.58363641, 24.47260381], [117.58401441, 24.4729718], [117.58475941, 24.47409477], [117.58543741, 24.47376878], [117.58519341, 24.47320379], [117.58473741, 24.47255581], [117.58431141, 24.47229382], [117.58397541, 24.47238781], [117.58368441, 24.47194382], [117.58434241, 24.47144983], [117.58535041, 24.47201182], [117.58562041, 24.47223782], [117.58578441, 24.47323079], [117.58590041, 24.47341379], [117.58631741, 24.47400378], [117.58650641, 24.47387378], [117.58689441, 24.47460176], [117.58704941, 24.47472476], [117.58714041, 24.47467476], [117.58751341, 24.47531375], [117.58803941, 24.47584073], [117.58841941, 24.47644772], [117.58794441, 24.47669871], [117.58778541, 24.47685771], [117.58726641, 24.47784269], [117.58684841, 24.47819468], [117.58681841, 24.47872667], [117.58668241, 24.47884266], [117.58657941, 24.47901766], [117.58692741, 24.47998764], [117.58650641, 24.48012663], [117.58594341, 24.48004964], [117.58573041, 24.47994364], [117.58545041, 24.47970264], [117.58535241, 24.47931965], [117.58518141, 24.47929365], [117.58502441, 24.47911966], [117.58444441, 24.47887366], [117.58429341, 24.47883466], [117.58407341, 24.47889266], [117.58374641, 24.47922466], [117.58361441, 24.47927065], [117.58368441, 24.47937365], [117.58370541, 24.47990664], [117.58354041, 24.48011264], [117.58317341, 24.48130361], [117.58171641, 24.47981464], [117.58152141, 24.47994464], [117.58135841, 24.47992664], [117.58050641, 24.47926166], [117.57930541, 24.47852067], [117.57905541, 24.47851967], [117.57763241, 24.47947065], [117.57745141, 24.47940965], [117.57648441, 24.47844967], [117.57694741, 24.47815968], [117.57634341, 24.47699371], [117.57655041, 24.47656372], [117.57681041, 24.47627572], [117.57619641, 24.47574274], [117.57582441, 24.47340379], [117.57563841, 24.47326779], [117.57122341, 24.47397878], [117.57085341, 24.47397878], [117.57100941, 24.47467176], [117.57097341, 24.47511875], [117.57187041, 24.47518975], [117.57318541, 24.47559574], [117.57428141, 24.47649572], [117.57522141, 24.47752969], [117.57598641, 24.47777169], [117.57609541, 24.47792669], [117.57615341, 24.47830868], [117.57598341, 24.47905566], [117.57603041, 24.47943465], [117.57622641, 24.47976564], [117.57686341, 24.48025263], [117.57735041, 24.48110961], [117.57745041, 24.4814786], [117.57745441, 24.48205059], [117.57773641, 24.48256458], [117.57808641, 24.48274057], [117.57975941, 24.48272557], [117.58022841, 24.48310057], [117.58039541, 24.48344856], [117.58050441, 24.48479453], [117.58078041, 24.48531252], [117.58094441, 24.4860665], [117.58122441, 24.48658349], [117.58132641, 24.48733247], [117.58166941, 24.48781646], [117.58230241, 24.48831645], [117.58274441, 24.48938442], [117.58314441, 24.48983241], [117.58349741, 24.49009041], [117.58388241, 24.49001841], [117.58467341, 24.4902924], [117.58519541, 24.4903374], [117.58566741, 24.49066539], [117.58588941, 24.49108138], [117.58602041, 24.49107638], [117.58617741, 24.49119338], [117.58684441, 24.49207836], [117.58707441, 24.49282334], [117.58727641, 24.49396832], [117.58725841, 24.49415731], [117.58702541, 24.4946883], [117.58707841, 24.49506629], [117.58700141, 24.49523129], [117.58650641, 24.49552228], [117.58648941, 24.49569928], [117.58657741, 24.49585927], [117.58702441, 24.49628126], [117.58770341, 24.49673325], [117.58830441, 24.49751523], [117.58864441, 24.49774223], [117.58923841, 24.49791423], [117.59006741, 24.49789123], [117.59030341, 24.49820522], [117.59088341, 24.49942119], [117.59144541, 24.50000018], [117.59175441, 24.50047117], [117.59186041, 24.50098215], [117.59180941, 24.50120015], [117.59143141, 24.50147414], [117.59109941, 24.50203913], [117.59015241, 24.50252712], [117.59005741, 24.50267612], [117.59136941, 24.50498906], [117.59299041, 24.50624703], [117.59330941, 24.50689802], [117.59387941, 24.50736101], [117.59424941, 24.50804899], [117.59462941, 24.50856598], [117.59466941, 24.50889197], [117.59440841, 24.50952196], [117.59460441, 24.50999595], [117.59492141, 24.51043494], [117.59538141, 24.51075793], [117.59640641, 24.51127392], [117.59677141, 24.51168891], [117.59717941, 24.51240389], [117.59774541, 24.51306288], [117.59795441, 24.51314387], [117.59813641, 24.51299888], [117.59817741, 24.51250789], [117.59841841, 24.51243889], [117.60029241, 24.51324387], [117.60086741, 24.51333087], [117.60098341, 24.51352686], [117.60085141, 24.51365486], [117.60030241, 24.51381986], [117.60016041, 24.51404085], [117.60013541, 24.51430785], [117.60057841, 24.51498383], [117.60070041, 24.51561982], [117.60083041, 24.51592281], [117.60139441, 24.5165528], [117.60205641, 24.51709778], [117.60222241, 24.51712578], [117.60270641, 24.51692079], [117.60411041, 24.51591781], [117.60461341, 24.51575881], [117.60494041, 24.51580281], [117.60493841, 24.51600581], [117.60390141, 24.51695879], [117.60354941, 24.51742578], [117.60641441, 24.51877374], [117.60638341, 24.51835375], [117.60611141, 24.51725478], [117.60597741, 24.51696779], [117.60557241, 24.5164388], [117.60566141, 24.5161938], [117.60584741, 24.51599581], [117.60758041, 24.51508183], [117.60847041, 24.51405885], [117.61015841, 24.51284288], [117.61082141, 24.51260089], [117.61223741, 24.51227589], [117.61234341, 24.51224489], [117.61331541, 24.5119579], [117.61335441, 24.5119459], [117.61522541, 24.51121292], [117.61753041, 24.51030894], [117.61757041, 24.51029294], [117.61772041, 24.51023394], [117.62261641, 24.50816299], [117.62274241, 24.50811899], [117.62338941, 24.50793799], [117.62412341, 24.507627], [117.62479241, 24.507538], [117.62533141, 24.50751], [117.62604541, 24.507776], [117.62696241, 24.50788899], [117.62847141, 24.507567], [117.63285041, 24.50644603], [117.63501541, 24.50570905], [117.63721041, 24.50540605], [117.63822441, 24.50543005], [117.63871341, 24.50521206], [117.63951341, 24.50508906], [117.63959441, 24.50494906], [117.63949941, 24.50402108], [117.63940541, 24.50380309], [117.63894841, 24.5034891], [117.63814241, 24.50356709], [117.63802541, 24.5034681], [117.63807841, 24.50196113], [117.63759541, 24.50199013], [117.63744341, 24.50191913], [117.63663341, 24.50154114], [117.63620241, 24.50119115], [117.63645741, 24.50093616], [117.63634941, 24.50001618], [117.63668941, 24.4988772], [117.63663241, 24.49872321], [117.63609241, 24.49842121], [117.63473041, 24.49851821], [117.63464841, 24.49849021], [117.63455041, 24.49829222], [117.63350541, 24.49861421], [117.63313841, 24.49867721], [117.63297241, 24.49863521], [117.63281741, 24.49842221], [117.63290841, 24.49801022], [117.63279641, 24.49772923], [117.63281741, 24.49746024], [117.63247541, 24.49715024], [117.63236141, 24.49681425], [117.63180041, 24.49695625], [117.63077541, 24.49746024], [117.63051241, 24.49747623], [117.63044541, 24.49709524], [117.63054441, 24.49657426], [117.63051541, 24.49591627], [117.63051541, 24.49561528], [117.63065141, 24.49523629], [117.63070541, 24.4948023], [117.63171041, 24.4947763], [117.63198041, 24.4945913], [117.63222641, 24.4945603], [117.63263341, 24.49390932], [117.63275741, 24.49381732], [117.63365241, 24.49355133], [117.63401841, 24.49353333], [117.63436541, 24.4947563], [117.63483541, 24.4947923], [117.63543541, 24.4945073], [117.63687941, 24.4945523], [117.63749541, 24.4948533], [117.63781241, 24.49508529], [117.63824241, 24.49556928], [117.63852341, 24.49571228], [117.63855241, 24.49500829], [117.63780541, 24.49418931], [117.63753841, 24.49418631], [117.63762341, 24.49395732], [117.63826041, 24.49386032], [117.63846341, 24.49393532], [117.63868041, 24.49377632], [117.63849541, 24.49353433], [117.63813941, 24.49337733], [117.63822441, 24.49322033], [117.63788241, 24.49283634], [117.63819841, 24.49167937], [117.63792841, 24.49156937], [117.63787041, 24.49138038], [117.63820841, 24.49059839], [117.63757441, 24.4903314], [117.63745941, 24.49007841], [117.63837241, 24.4901454], [117.63865841, 24.49002841], [117.63871841, 24.48989841], [117.63915941, 24.48982541], [117.63966941, 24.48882543], [117.64006641, 24.48855444], [117.64007341, 24.48825645], [117.64053341, 24.48821145], [117.64055041, 24.48804345], [117.64039341, 24.48785746], [117.63983841, 24.48750946], [117.63969241, 24.48724647], [117.64049641, 24.48678648], [117.64059441, 24.48680348], [117.64082941, 24.48697948], [117.64135741, 24.48811845], [117.64157241, 24.48836045], [117.64181341, 24.48848644], [117.64312141, 24.48853444], [117.64391641, 24.48877744], [117.64397941, 24.48941642], [117.64410941, 24.48939942], [117.64455241, 24.48934742], [117.64556941, 24.48891343], [117.64712841, 24.48784246], [117.64729241, 24.48782846], [117.64794341, 24.48812645], [117.64846441, 24.48846244], [117.64854941, 24.48840444], [117.64876741, 24.48844644], [117.64807641, 24.48770246], [117.64980141, 24.48693348], [117.65025941, 24.48689348], [117.65046241, 24.48687648], [117.65102241, 24.48663149], [117.65079541, 24.4859815], [117.65057041, 24.4859445], [117.65083441, 24.48545251], [117.65108641, 24.48556851], [117.65156241, 24.48462053], [117.65232841, 24.48485453], [117.65251341, 24.48466953], [117.65259941, 24.48428354], [117.65579241, 24.48561851], [117.65579141, 24.4861055], [117.65607541, 24.48620249], [117.65613741, 24.4860395], [117.65633541, 24.4860065], [117.65638541, 24.48629849], [117.65660741, 24.48644849], [117.65680141, 24.4861365], [117.65707641, 24.4859755], [117.65742641, 24.4861285], [117.65756541, 24.4860255], [117.65764341, 24.4860775], [117.65790341, 24.4858365], [117.65785041, 24.48560851], [117.65802841, 24.48553951], [117.65853041, 24.48513152], [117.65844841, 24.48492552], [117.65876841, 24.48473353], [117.65846841, 24.48410754], [117.65871341, 24.48394955], [117.65889041, 24.48402154], [117.65935741, 24.48365455], [117.65932241, 24.48358955], [117.65957241, 24.48346056], [117.65947041, 24.48312957], [117.65954841, 24.48298457], [117.65949941, 24.48291057], [117.65965241, 24.48271458], [117.65932041, 24.48247558], [117.65948641, 24.48226559], [117.65949141, 24.48209059], [117.65929341, 24.48199959], [117.65932641, 24.48187359], [117.65863441, 24.4815326], [117.65896541, 24.4815876], [117.65946641, 24.4817976], [117.65987141, 24.4816116], [117.65992041, 24.4814446], [117.66012941, 24.48132361], [117.66006541, 24.48107561], [117.66036641, 24.48092162], [117.66026841, 24.48045363], [117.66051441, 24.48012363], [117.66059541, 24.48011564], [117.66012641, 24.47447376], [117.65950241, 24.47343779], [117.65916041, 24.47327879], [117.65894841, 24.47330279], [117.65979641, 24.4730018], [117.66009141, 24.47269081], [117.66032541, 24.47256581], [117.66030741, 24.47235981], [117.66049941, 24.47218282], [117.66078641, 24.47206582], [117.66087341, 24.47189782], [117.66111141, 24.47174083], [117.66159741, 24.47164483], [117.66143741, 24.47069785], [117.66152541, 24.47042486], [117.66125341, 24.47019186], [117.66167541, 24.46904089], [117.66201341, 24.46908089], [117.66235041, 24.4687639], [117.66311041, 24.4686639], [117.66293941, 24.46826491], [117.66280341, 24.46751093], [117.66284741, 24.46706394], [117.66272641, 24.46647395], [117.66263141, 24.46517098], [117.66231141, 24.464447], [117.66235641, 24.464111], [117.66229941, 24.46373001], [117.66239141, 24.46364501]];
//龙海市区域坐标
var lhsqyzb = [[117.56515764907373,24.468794601971922],[117.57295650192219,24.468020785833264],[117.57316892203869,24.468460798931716],[117.57341168788611,24.468384934604398],[117.57353307080982,24.469189096473986],[117.57406412110106,24.469538072379656],[117.57503518449074,24.469568418110583],[117.5758545192258,24.469932566881717],[117.5774931886959,24.47037257998017],[117.57893461091497,24.47102501319512],[117.57876770939487,24.470190505594605],[117.57805458471806,24.469113232146665],[117.5776145716196,24.468870466299244],[117.5774931886959,24.46843045320079],[117.5769469655392,24.46832424314254],[117.5764007423825,24.468293897411613],[117.5762338408624,24.46747456267656],[117.57426136835208,24.46752008127295],[117.5740792939665,24.46730766115646],[117.57376066379177,24.46715593250182],[117.57324478636599,24.467125586770894],[117.5722737229763,24.46629107917038],[117.57183370987785,24.46623038770852],[117.57099920227733,24.46668557367244],[117.57045297912063,24.466655227941512],[117.56981571877115,24.466169696246666],[117.56928466847991,24.465547608762645],[117.56870809959229,24.46510759566419],[117.56876879105414,24.46486482981677],[117.56901155690156,24.465077249933262],[117.56966399011651,24.465502090166254],[117.57021021327321,24.465365534377078],[117.57086264648817,24.46456137250749],[117.57162128976135,24.463393061866768],[117.57083230075723,24.462922703037385],[117.57043780625517,24.46293787590285],[117.57021021327321,24.46328685180852],[117.56866258099589,24.46258889999718],[117.56855637093766,24.46223992409151],[117.56889017397786,24.462361307015218],[117.56907224836343,24.462073022571403],[117.56843498801395,24.461223342105423],[117.56831360509022,24.460828847603363],[117.5682832593593,24.460388834504908],[117.56936053280724,24.46035848877398],[117.57095368368095,24.46090471193068],[117.57197026566703,24.460980576258002],[117.5719854385325,24.46151162654924],[117.57283511899848,24.462361307015218],[117.57237993303455,24.462892357306455],[117.5728654647294,24.46340823473223],[117.57275925467115,24.46383307496522],[117.5735027250789,24.464242742332747],[117.57386687385002,24.46465240970027],[117.57438275127579,24.464864829816765],[117.57444344273766,24.465092422798726],[117.57529312320364,24.46535036151161],[117.57549037045466,24.465289670049756],[117.57549037045466,24.46504690420233],[117.57594555641859,24.465077249933262],[117.57652212530621,24.464622063969344],[117.57658281676807,24.463924112158004],[117.57711386705931,24.463696519176043],[117.5773262871758,24.463499271925013],[117.57788768319797,24.463393061866764],[117.57819114050723,24.460844020468826],[117.57775112740877,24.458871547958516],[117.57722007711754,24.458416361994598],[117.57769043594692,24.458006694627073],[117.57867667220208,24.45834049766728],[117.57926841395518,24.45802945392527],[117.57952635266807,24.457991521761613],[117.57980705067915,24.45806738608893],[117.57992084717013,24.45817359614718],[117.57997395219925,24.458363256965477],[117.57987532857373,24.458697060005683],[117.58045189746136,24.458492226321923],[117.58076294120337,24.4586060228129],[117.58096777488714,24.45856050421651],[117.58124088646548,24.458302565503622],[117.58124088646548,24.458150836848983],[117.58154434377477,24.45802945392527],[117.58156710307296,24.45791565743429],[117.5822650548843,24.4576804780196],[117.58292507453199,24.457771515212386],[117.5832816368704,24.457619786557746],[117.58124847289821,24.455169368785324],[117.58132433722552,24.455063158727075],[117.58116502213815,24.45446383054125],[117.58146847944744,24.45430451545388],[117.58125605933095,24.45328034703507],[117.58132433722554,24.45312861838043],[117.58169607242941,24.45301482188945],[117.58200711617143,24.453151377678623],[117.58243954283714,24.45367484153713],[117.58269748155003,24.453818983759035],[117.58277334587734,24.45415278679924],[117.58265196295363,24.454706596388675],[117.58268230868457,24.45506315872708],[117.58287955593559,24.455563863287388],[117.58301611172477,24.455616968316512],[117.58356992131421,24.453940366682748],[117.58352440271781,24.45371277370079],[117.58331956903405,24.45340931639151],[117.58339543336136,24.453121031947695],[117.58332715546678,24.452802401772953],[117.58388855148894,24.452165141423468],[117.58419200879823,24.452074104230686],[117.58433615102012,24.451876856979656],[117.58457133043483,24.451755474055943],[117.58484444201315,24.45131546095748],[117.58498858423505,24.451330633822945],[117.58508720786057,24.45161891826676],[117.58520100435155,24.45165685043042],[117.58605827125027,24.451095454408254],[117.58631620996314,24.45107269511006],[117.58658173510877,24.451444430313924],[117.58719623616005,24.451087867975524],[117.58793970656778,24.451178905168305],[117.58859213978273,24.45096648505181],[117.58899422071752,24.45116373230284],[117.5893128508923,24.450951312186355],[117.59030667358017,24.44972989651651],[117.59057978515852,24.448902975348727],[117.59114118118069,24.448159504940993],[117.59117152691162,24.447939498391765],[117.59089841533327,24.447893979795374],[117.58948733884513,24.447704318977074],[117.58892594282297,24.448205023537383],[117.5875831442294,24.448804351723208],[117.58732520551652,24.449259537687126],[117.58717347686188,24.449289883418054],[117.58683967382167,24.449183673359805],[117.58680174165802,24.448212609970117],[117.58699140247631,24.446884984242022],[117.58779556434591,24.44597461231419],[117.5880079844624,24.445580117812124],[117.58806108949153,24.444639400153363],[117.58834937393534,24.443326947290732],[117.58696864317812,24.442484853257486],[117.58685484668715,24.442317951737383],[117.58780315077864,24.44215863665001],[117.58825075030983,24.441877938638928],[117.5888349056302,24.44192345723532],[117.58939630165236,24.44234829746831],[117.58968458609617,24.44230277887192],[117.58998804340544,24.442826242730423],[117.59016253135827,24.442947625654135],[117.59029150071473,24.442917279923208],[117.59033701931112,24.442727619104907],[117.59024598211833,24.442135877351816],[117.5906177173222,24.441946216533516],[117.59084531030416,24.442325538170113],[117.59109566258431,24.442340711035577],[117.5913080827008,24.442720032672177],[117.59160395357735,24.442902107057744],[117.59195292948303,24.442682100508517],[117.59179361439566,24.44169586425336],[117.59210465813764,24.441278610453104],[117.59243087474512,24.44117998682759],[117.59344745673121,24.441324129049494],[117.59414540854254,24.441870352206198],[117.5940619577825,24.442575890450268],[117.5943957608227,24.443069008577847],[117.59430472362992,24.443941448342024],[117.59448679801548,24.44393386190929],[117.59468404526652,24.44374420109099],[117.59519233625956,24.443842824716505],[117.59546544783791,24.444502844364187],[117.59552613929976,24.4451704504446],[117.5957233865508,24.445307006233776],[117.59585994233997,24.445071826819085],[117.59563993579074,24.444442152902333],[117.59563234935801,24.44404007196754],[117.59504060760491,24.443114527174238],[117.59506336690312,24.442826242730423],[117.59537441064512,24.442704859806714],[117.59578407801266,24.44312211360697],[117.59596615239822,24.44347108951264],[117.59655789415132,24.44401731266934],[117.59682341929692,24.44404007196754],[117.59691445648971,24.443903516178363],[117.59665651777682,24.443683509629135],[117.59657306701678,24.44344074378171],[117.59640616549667,24.443417984483517],[117.5962468504093,24.443182805068826],[117.5964592705258,24.442826242730423],[117.59597373883095,24.442757964835835],[117.59526820058687,24.442090358755422],[117.59518474982683,24.44176414214795],[117.5952985463178,24.44146068483867],[117.59546544783791,24.441399993376816],[117.59561717649255,24.44145309840594],[117.59580683731085,24.44171862355156],[117.59636823333301,24.441938630100783],[117.59658823988224,24.441885525071662],[117.59680824643146,24.441362061213155],[117.59697514795157,24.44127102402037],[117.59744550678096,24.442052426591765],[117.59768827262837,24.442249673842795],[117.59799931637038,24.44226484670826],[117.59839381087245,24.442014494428104],[117.59853036666162,24.442029667293568],[117.59844691590158,24.442378643199238],[117.59887175613456,24.443023489981453],[117.59960005367682,24.443099354308774],[117.60004006677528,24.443342120156196],[117.60061663566292,24.44328142869434],[117.60096561156858,24.44316004577063],[117.60117044525235,24.442765551268568],[117.60095043870312,24.44259106331573],[117.60101113016498,24.44212070448635],[117.60086698794306,24.442014494428104],[117.60012351753534,24.442022080860834],[117.59928900993482,24.44238622963197],[117.59968350443688,24.44211311805362],[117.60005523964074,24.44137723407862],[117.60007041250621,24.440884115951043],[117.60018420899719,24.440747560161867],[117.60041180197915,24.440694455132743],[117.60084422864487,24.440861356652846],[117.60164080408173,24.440793078758258],[117.60290773834797,24.440982739576555],[117.60349189366832,24.440982739576555],[117.60415949974873,24.440277201332485],[117.60450847565441,24.4394502801647],[117.60431122840338,24.438183345898462],[117.60471330933817,24.437568844847174],[117.60485745156008,24.437455048356195],[117.60642784313559,24.436984689526813],[117.60756580804538,24.43653708999563],[117.60781616032554,24.4363170834464],[117.60805133974023,24.436210873388152],[117.60839272921316,24.436218459820886],[117.6094927619593,24.436453639235577],[117.6097051820758,24.43639294777372],[117.61022105950157,24.435998453271658],[117.61063831330183,24.435361192922173],[117.61091142488019,24.435095667776555],[117.61130591938225,24.43504256274743],[117.61157144452787,24.434746691870885],[117.61214042698276,24.43457979035078],[117.61258044008122,24.43464806824537],[117.61280803306317,24.43459496321625],[117.61297493458328,24.434465993859803],[117.61303562604513,24.434003221463154],[117.61420393668585,24.432576972109544],[117.61453773972606,24.432394897723977],[117.6148563699008,24.431681773047174],[117.61526603726833,24.431310037843307],[117.61548604381755,24.43123417351599],[117.61595640264693,24.431378315737895],[117.61626744638895,24.43127210567965],[117.6173447198369,24.42992172065336],[117.6177240414735,24.42910997235104],[117.6179895666191,24.42899617586006],[117.6183688882557,24.42903410802372],[117.6187482098923,24.428381674808772],[117.61946892100184,24.428275464750524],[117.61981789690749,24.4280326989031],[117.62015928638043,24.42764579083377],[117.62049308942063,24.4274637164482],[117.62088758392271,24.427395438553614],[117.62097862111548,24.427236123466244],[117.6209103432209,24.4267278324732],[117.62105448544281,24.426553344520368],[117.62128207842477,24.426454720894853],[117.62142622064667,24.426075399258252],[117.6219800302361,24.42579470124717],[117.62225314181445,24.42540020674511],[117.6229055750294,24.425240891657737],[117.62323937806963,24.42505881727217],[117.62340627958973,24.424884329319337],[117.62352007608071,24.42440638405722],[117.62365663186988,24.424231896104388],[117.62428630578664,24.42390567949691],[117.62483252894333,24.423844988035057],[117.62499943046343,24.42373877797681],[117.62519667771446,24.42319255482011],[117.62546220286008,24.422805646750778],[117.62544702999462,24.42258564020155],[117.62506770835802,24.422487016576035],[117.62491597970337,24.422327701488662],[117.62493115256885,24.42209252207397],[117.62476425104875,24.4219332069866],[117.62481735607787,24.421166977280674],[117.62429389221937,24.42091662500052],[117.62322420520417,24.420969730029643],[117.6226400498838,24.420749723480416],[117.62184347444695,24.420097290265467],[117.62170691865778,24.4197255550616],[117.62110759047195,24.41928554196315],[117.62039446579514,24.4191793319049],[117.6202427371405,24.417927570504126],[117.62029584216963,24.41769997752217],[117.62241245690184,24.416569599045104],[117.62307247654952,24.415750264310052],[117.62367180473534,24.415697159280928],[117.62450631233585,24.416349592495877],[117.62469597315416,24.41779860114768],[117.62515115911808,24.41829171927526],[117.62556841291834,24.4182537871116],[117.62581117876576,24.41735858804923],[117.6258946295258,24.417495143838405],[117.62745743466859,24.416804778459795],[117.62738915677399,24.415522671328095],[117.62712363162838,24.414551607938403],[117.62729811958121,24.4143847064183],[117.62716915022477,24.413011562093818],[117.62746502110132,24.412397061042526],[117.62740432963946,24.412177054493302],[117.62865609104023,24.41233636958067],[117.63081063793611,24.41298121636289],[117.63094719372528,24.412890179170105],[117.631068576649,24.412260505253354],[117.63093960729256,24.4103487242049],[117.63021889618302,24.408141072279896],[117.62992302530648,24.406479643511595],[117.62998371676834,24.406312741991492],[117.6302113097503,24.406252050529638],[117.63090926156164,24.405409956496392],[117.6311140952454,24.405053394157992],[117.63106857664901,24.404727177550516],[117.63061339068508,24.403710595564434],[117.63087891583069,24.40307333521495],[117.63090926156163,24.402557457789175],[117.63070442787786,24.401821573814175],[117.63100029875442,24.40094913405],[117.63122030530364,24.400713954635307],[117.63191825711498,24.4005698124134],[117.63248723956988,24.40006152142036],[117.63254034459901,24.39963668118737],[117.6320168807405,24.398415265517524],[117.63212309079876,24.397679381542527],[117.6319941214423,24.396852460374742],[117.63203205360597,24.3961545085634],[117.63197136214411,24.395668976868553],[117.63177411489308,24.395448970319325],[117.63081063793612,24.394819296402574],[117.63059821781962,24.39461446271881],[117.6305451127905,24.394432388333243],[117.63090167512891,24.393339942019843],[117.63122789173637,24.39170127254974],[117.63163755910391,24.391208154422163],[117.63225964658793,24.391139876527575],[117.63269965968638,24.390859178516493],[117.63272241898457,24.390570894072678],[117.6325858631954,24.390100535243295],[117.63200170787503,24.389516379922934],[117.63128858319823,24.388901878871646],[117.63174376916214,24.388097717002058],[117.63253275816626,24.38728596869974],[117.63295759839926,24.386276973146387],[117.63305622202478,24.385730749989687],[117.63286656120648,24.385412119814944],[117.63286656120648,24.385184526832983],[117.63387555675985,24.3838113825085],[117.634012112549,24.383507925199222],[117.63397418038534,24.383105844264428],[117.63381486529798,24.382263750231182],[117.63313967278484,24.381080266724993],[117.63310174062117,24.380700945088396],[117.63311691348665,24.3804885249719],[117.6333217471704,24.38017748122989],[117.63369348237427,24.379843678189683],[117.63454316284025,24.379555393745868],[117.63527904681524,24.379502288716743],[117.63586320213561,24.379380905793035],[117.63620459160855,24.379077448483752],[117.63665219113973,24.378887787665455],[117.636955648449,24.378857441934528],[117.63732738365287,24.379016757021898],[117.63799498973329,24.379092621349216],[117.63818465055158,24.378933306261846],[117.63836672493714,24.37840984240334],[117.63947434411601,24.377537402639167],[117.63999780797452,24.377575334802824],[117.64107508142246,24.377886378544837],[117.64171234177195,24.377878792112103],[117.64207649054308,24.37821259515231],[117.64294134387453,24.378129144392265],[117.64363170925313,24.37831121877783],[117.64399585802427,24.37857674392345],[117.64456484047916,24.37951746158221],[117.64608212702555,24.379987820411593],[117.64633247930571,24.379836091756953],[117.64669662807684,24.37942642438943],[117.64683318386602,24.379031929887365],[117.64703043111705,24.378895374098192],[117.64756906784102,24.378834682636334],[117.6482290874887,24.378918133396386],[117.64844909403791,24.378849855501798],[117.65048984444282,24.377560161937364],[117.65101330830132,24.377575334802827],[117.65192368022916,24.37819742228685],[117.65240162549127,24.37819742228685],[117.65279611999333,24.37832639164329],[117.65360028186292,24.378311218777828],[117.65419202361602,24.378531225327055],[117.65440444373252,24.378804336905404],[117.6544954809253,24.379267109302052],[117.65470031460906,24.379631258073186],[117.65495066688922,24.37979057316056],[117.65582310665339,24.379980233978856],[117.6561796689918,24.380207826960817],[117.6561341503954,24.38061749432834],[117.65535274782401,24.381687181343548],[117.65482169753277,24.382104435143805],[117.6546396231472,24.38285549198427],[117.65487480256189,24.383538270930146],[117.65593690314438,24.385313496189426],[117.65605828606809,24.385434879113138],[117.65620242829,24.385434879113138],[117.65658933635933,24.385275564025765],[117.65677899717763,24.385290736891232],[117.65713555951602,24.385745922855147],[117.65830387015674,24.38629973244458],[117.65850870384051,24.38676250484123],[117.65901699483355,24.386974924957727],[117.65932803857557,24.387422524488915],[117.65954045869205,24.38756666671082],[117.6596694280485,24.387847364721903],[117.66054186781267,24.388575662264174],[117.66196053073355,24.38911429898814],[117.66279503833407,24.389584657817522],[117.66324263786525,24.38943292916288],[117.66438060277504,24.388780495947934],[117.66490406663355,24.388363242147676],[117.6651544189137,24.38795357478015],[117.6653668390302,24.387832191856436],[117.66585995715778,24.38706596215051],[117.66588271645597,24.386239040982726],[117.66616341446705,24.385965929404374],[117.66625445165984,24.385616953498705],[117.66671722405647,24.385267977593035],[117.66681584768199,24.385093489640198],[117.66680826124926,24.38459278507989],[117.66698274920209,24.383879660403085],[117.66789312112992,24.38347757946829],[117.66856072721036,24.382187885903857],[117.66938764837815,24.38181615069999],[117.66995663083304,24.38137613760154],[117.66958489562917,24.381998225085557],[117.66903108603974,24.38234720099123],[117.6688565980869,24.382650658300506],[117.66869728299953,24.383295505082724],[117.66787794826449,24.384456229290713],[117.66736965727144,24.384410710694322],[117.66723310148227,24.384623130810816],[117.66721792861681,24.38486589665824],[117.66737724370418,24.384926588120095],[117.66743034873329,24.385146594669322],[117.66704344066397,24.38560178063324],[117.66705861352943,24.386330078175508],[117.6666489461619,24.38648939326288],[117.66663377329644,24.386679054081178],[117.66680826124927,24.386921819928602],[117.66677791551834,24.387210104372418],[117.66644411247813,24.387369419459787],[117.66635307528536,24.387528734547157],[117.66651239037273,24.38760459887448],[117.66692205774025,24.38761218530721],[117.66714206428948,24.387817018990972],[117.66708137282762,24.387976334078346],[117.66677791551834,24.38808254413659],[117.66665653259463,24.388257032089427],[117.66635307528536,24.389410169864686],[117.66599651294695,24.389440515595613],[117.66570822850314,24.389288786940973],[117.66474475154618,24.389174990449995],[117.66450198569876,24.3893191326719],[117.66428197914954,24.38975155933762],[117.66460060932427,24.389933633723185],[117.66460819575701,24.390366060388907],[117.66487372090262,24.39061641266906],[117.66501786312453,24.39091986997834],[117.66496475809541,24.39126125945128],[117.66477509727711,24.391511611731435],[117.66475992441164,24.391746791146126],[117.6651999375101,24.392308187168297],[117.66544270335751,24.393165454067006],[117.66532890686653,24.393339942019843],[117.66491165306628,24.393688917925513],[117.66470681938252,24.394090998860307],[117.66424404698587,24.394045480263916],[117.66418335552402,24.394159276754895],[117.66434267061138,24.394402042602316],[117.6654123576266,24.39518344517371],[117.66551856768484,24.395471729617523],[117.66506338172091,24.396071057803347],[117.66479785657529,24.39650348446907],[117.66473716511344,24.396761423181957],[117.66494958522993,24.39678418248015],[117.66556408628122,24.396526243767266],[117.66579167926318,24.396564175930926],[117.66601927224514,24.39736833780051],[117.66604203154334,24.397869042360824],[117.6662923838235,24.398612512768555],[117.66627721095803,24.398923556510564],[117.66648963107453,24.399439433936337],[117.66674756978742,24.399545643994585],[117.66730896580958,24.399507711830925],[117.66766552814798,24.39959874902371],[117.66790829399541,24.399469779667264],[117.66813588697737,24.39921942738711],[117.66899315387607,24.39894631580876],[117.66925109258896,24.39901459370335],[117.66968351925469,24.398976661539688],[117.67008560018948,24.39866561779768],[117.67047250825881,24.397611103647936],[117.67071527410623,24.398028357448194],[117.67102631784824,24.398218018266494],[117.67131460229206,24.39811939464098],[117.67197462193974,24.397755245869842],[117.67230842497995,24.39782352376443],[117.6725815365583,24.39790697452448],[117.67261188228922,24.397732486571645],[117.67244498076911,24.39739868353144],[117.67239946217272,24.39709522622216],[117.67293051246396,24.39685246037474],[117.67330983410056,24.397011775462108],[117.67359811854438,24.39682970107654],[117.6736512235735,24.396450379439944],[117.67387881655546,24.396382101545356],[117.67404571807556,24.39639727441082],[117.67412158240288,24.396806941778348],[117.67380295222814,24.39747454785876],[117.67380295222814,24.3977931780335],[117.67396985374825,24.398354574055666],[117.67430365678845,24.39845319768118],[117.67468297842505,24.398885624346903],[117.67498643573433,24.39895390224149],[117.67547196742917,24.399272532416234],[117.67551748602557,24.39952288469639],[117.67522161514901,24.399985657093037],[117.6751912694181,24.400175317911337],[117.67544162169824,24.400243595805925],[117.67601060415313,24.400122212882213],[117.67623061070238,24.400281527969586],[117.6764278579534,24.40044084305696],[117.67644303081886,24.40129052352294],[117.67656441374258,24.401510530072166],[117.67770237865237,24.401730536621393],[117.679014831515,24.401131208435565],[117.6799176170101,24.401434665744844],[117.68020590145392,24.401631912995875],[117.68036521654129,24.401905024574226],[117.68044866730135,24.402276759778093],[117.68039556227222,24.402549871356445],[117.6799631356065,24.40291402012758],[117.67893138075495,24.403134026676806],[117.67832446613639,24.403020230185824],[117.67818032391449,24.40307333521495],[117.67819549677995,24.40324023673505],[117.6784458490601,24.403665076968043],[117.67857481841655,24.404196127259283],[117.67884034356216,24.404264405153867],[117.67939415315159,24.404165781528352],[117.67954588180623,24.40422647299021],[117.67987968484644,24.405341678601808],[117.6797279561918,24.40566789520928],[117.6795838139699,24.405789278132993],[117.67908310940959,24.405865142460314],[117.6786582691766,24.40554651228557],[117.67828653397272,24.40516719064897],[117.67808170028897,24.40520512281263],[117.67802859525985,24.405409956496396],[117.67808170028897,24.406502402809796],[117.67795273093252,24.406601026435315],[117.67639751222247,24.406767927955418],[117.67555541818922,24.407063798831953],[117.6751002322253,24.407116903861077],[117.67499402216706,24.407405188304892],[117.67500160859979,24.407723818479635],[117.67559335035288,24.40808796725077],[117.67604094988407,24.40808796725077],[117.67633682076061,24.40825486877087],[117.6764733765498,24.408399010992778],[117.67660993233896,24.408687295436593],[117.67692856251371,24.408945234149485],[117.67720167409205,24.409021098476806],[117.67781617514335,24.409096962804124],[117.67811963245262,24.409316969353352],[117.67851412695468,24.409445938709794],[117.67888586215855,24.409332142218815],[117.67947760391164,24.40939283368067],[117.68033487081036,24.410212168415722],[117.68106316835262,24.410181822684795],[117.68173077443303,24.410424588532216],[117.68226941115701,24.410356310637628],[117.68255010916809,24.410462520695877],[117.68274735641913,24.410811496601546],[117.68270942425546,24.411395651921907],[117.68293701723742,24.41244257963892],[117.68291425793923,24.41309501285387],[117.68305840016113,24.413739859636085],[117.68337703033588,24.414407465716497],[117.68362738261604,24.414627472265725],[117.68405980928175,24.41483989238222],[117.68519018775882,24.415082658229643],[117.68619918331217,24.415750264310056],[117.68633573910134,24.41605372161933],[117.68682127079619,24.41635717892861],[117.68717024670185,24.4169716799799],[117.68960549160882,24.417995848398714],[117.68992412178355,24.418951738922942],[117.69028827055469,24.419042776115724],[117.69083449371138,24.419543480676033],[117.69145658119541,24.420681445585828],[117.69241247171963,24.421531126051807],[117.69286765768355,24.421637336110056],[117.69362630095675,24.42145526172449],[117.69423321557531,24.422593226634284],[117.69480978446293,24.422744955288923],[117.69412700551706,24.424171204642533],[117.69378561604412,24.4243532790281],[117.69366423312042,24.4247098413665],[117.69348215873485,24.424891915752067],[117.69338353510933,24.425521589668822],[117.69325456575288,24.425718836919852],[117.69203315008303,24.426515412356707],[117.69172210634103,24.426606449549492],[117.6915476183882,24.42679611036779],[117.69147175406087,24.427008530484287],[117.69078138868227,24.427592685804647],[117.69061448716216,24.42847271200155],[117.69028827055469,24.428943070830933],[117.68987101675444,24.429072040187375],[117.68842959453536,24.4291251452165],[117.6881792422552,24.429375497496654],[117.68757991406939,24.429534812584023],[117.68733714822196,24.42939825679485],[117.6869198944217,24.429443775391242],[117.68676057933435,24.429678954805933],[117.68628263407223,24.429845856326036],[117.68563020085728,24.430657604628355],[117.68469706963124,24.43102933983222],[117.68414326004181,24.430278282991758],[117.6838094570016,24.43025552369356],[117.68382462986708,24.43051346240645],[117.68422671080187,24.43103692626495],[117.68424947010006,24.431226587083252],[117.68410532787816,24.43153763082526],[117.68409015501268,24.43193212532733],[117.68427981583098,24.43260731784047],[117.68349841325958,24.43341147971006],[117.68078247034154,24.434511512456194],[117.68103282262169,24.434814969765473],[117.68121489700727,24.435710168827843],[117.68075971104334,24.43581637888609],[117.68072936531242,24.435983280406194],[117.68055487735958,24.436150181926298],[117.680486599465,24.436521917130165],[117.68018314215571,24.43690123876676],[117.68022866075212,24.438441284611347],[117.67989485771191,24.4385247353714],[117.67981140695186,24.438426111745883],[117.67966726472996,24.438547494669596],[117.67956864110444,24.438464043909544],[117.67933346168975,24.438653704727844],[117.67909069584232,24.43860818613145],[117.67805135455805,24.43879784694975],[117.67736098917943,24.43864611829511],[117.67695132181191,24.438084722272947],[117.67719408765933,24.437500566952586],[117.67764927362325,24.437462634788925],[117.67765686005598,24.43725780110516],[117.67727753841939,24.43690882519949],[117.67650372228073,24.436643300053873],[117.67572231970934,24.436719164381195],[117.67544920813098,24.43717435034511],[117.67437952111577,24.438388179582226],[117.67406847737375,24.438410938880423],[117.67142081235029,24.43790264788738],[117.67122356509927,24.43775091923274],[117.67273326521293,24.435619131635057],[117.67266498731834,24.43535360648944],[117.67247532650003,24.434868074794593],[117.67249808579824,24.434185295848717],[117.67235394357633,24.433669418422944],[117.67218704205622,24.433479757604644],[117.671967035507,24.433411479710056],[117.67180772041962,24.433593554095623],[117.67173944252504,24.43401080789588],[117.67170909679412,24.43473910543815],[117.67181530685235,24.435171532103872],[117.67170909679412,24.43539912508583],[117.67205048626705,24.436006039704388],[117.67198220837246,24.436263978417273],[117.67078355200081,24.437477807654393],[117.66996421726576,24.438532321804132],[117.6693800619454,24.438911643440733],[117.66884901165416,24.439078544960836],[117.66831037493019,24.43953373092475],[117.66727862007865,24.439632354550266],[117.66677032908561,24.43995098472501],[117.66644411247813,24.439738564608515],[117.66618617376524,24.439973744023206],[117.66570822850314,24.439905466128618],[117.6655792591467,24.44003443548506],[117.66570822850314,24.440193750572433],[117.66504062242272,24.440656522969082],[117.66481302944077,24.440694455132743],[117.66449439926602,24.440952393845627],[117.66376610172375,24.44068686870001],[117.66347781727994,24.440861356652846],[117.66306814991242,24.440390997823464],[117.66260537751576,24.440694455132743],[117.66250675389026,24.44083859735465],[117.66255985891938,24.441043431038413],[117.66264330967942,24.441301369751297],[117.66268124184309,24.441597240627846],[117.66347023084721,24.441931043668053],[117.66352333587633,24.442105531620886],[117.66333367505803,24.4422041552464],[117.6635385087418,24.442788310566762],[117.66293918055597,24.44305383571238],[117.6634929901454,24.44472285091341],[117.66410749119669,24.44869814166496],[117.663872311782,24.44881952458867],[117.66267365541034,24.448918148214187],[117.66268124184307,24.449183673359805],[117.6627798654686,24.449335402014444],[117.66240054383199,24.449464371370887],[117.66250675389024,24.449911970902072],[117.66230192020649,24.450025767393054],[117.66247640815932,24.450503712655166],[117.66194535786808,24.450723719204394],[117.6617860427807,24.45041267546238],[117.66151293120237,24.450306465404136],[117.66127775178767,24.450374743298724],[117.66129292465314,24.450564404117024],[117.66072394219825,24.450723719204394],[117.66061014570725,24.451148559437385],[117.66036737985984,24.45136097955388],[117.66058738640906,24.452461012300013],[117.66058738640906,24.45279481534022],[117.65990460746319,24.454790047148727],[117.65951769939386,24.455298338141766],[117.65925976068097,24.455791456269345],[117.65891837120803,24.45673217392811],[117.65877422898612,24.457756342346922],[117.6590776862954,24.45786255240517],[117.65917630992092,24.45816600971445],[117.65990460746319,24.45796876246342],[117.6608832572856,24.457877725270635],[117.66105774523844,24.458196355445377],[117.66140672114412,24.458143250416253],[117.66145982617324,24.4582494604745],[117.66209708652272,24.458226701176304],[117.66218053728277,24.458143250416253],[117.6623777845338,24.458234287609038],[117.66318953283613,24.458234287609038],[117.66325781073071,24.458074972521665],[117.66343229868355,24.458029453925274],[117.66353092230906,24.4582494604745],[117.66352333587633,24.458454294158265],[117.66377368815648,24.45842394842734],[117.66409990476396,24.45901569018043],[117.66431232488046,24.459197764565996],[117.6644412942369,24.45976674702089],[117.6648206158735,24.459736401289963],[117.6650557952882,24.46003985859924],[117.66538201189566,24.460017099301044],[117.66565512347401,24.460275038013933],[117.66580685212865,24.460252278715735],[117.66588271645597,24.460464698832233],[117.66554132698303,24.460601254621405],[117.6657006420704,24.46103368128713],[117.66383437961835,24.461572318011097],[117.66428956558227,24.463028913095638],[117.6624460624284,24.463499271925016],[117.66239295739928,24.463651000579656],[117.66228674734103,24.46374962420517],[117.66236261166834,24.46412894584177],[117.66230950663922,24.464455162449244],[117.66265089611215,24.465183459991515],[117.66274193330494,24.466503499286876],[117.66284055693045,24.467072481741774],[117.66281779763226,24.46752766770569],[117.66293918055597,24.46826355168069],[117.6631136685088,24.468673219048217],[117.66236261166834,24.468779429106462],[117.66199087646447,24.469098059281205],[117.6616874191552,24.46904495425208],[117.66123223319127,24.470190505594605],[117.66152051763508,24.47043327144203],[117.66142189400958,24.470683623722184],[117.66161155482787,24.471662273544606],[117.6611411959985,24.471730551439194],[117.66089843015106,24.47190503939203],[117.66075428792918,24.47207952734486],[117.66048117635083,24.472155391672178],[117.66031427483072,24.472375398221406],[117.66033703412891,24.472572645472436],[117.66008668184877,24.472724374127075],[117.65979081097223,24.473005072138157],[117.65900182196809,24.473308529447436],[117.65925976068098,24.47328577014924],[117.65948735366294,24.473422325938415],[117.66013220044516,24.474469253655425],[117.6605949728418,24.48014390533894],[117.66027634266706,24.48043218978275],[117.66038255272531,24.48092530791033],[117.66007909541602,24.48107703656497],[117.66012461401242,24.481350148143317],[117.65989702103046,24.481456358201566],[117.65988943459773,24.481638432587133],[117.65947976723021,24.481805334107236],[117.65902458126628,24.481592913990742],[117.65865284606242,24.481524636096154],[117.65932803857557,24.481873612001824],[117.65926734711371,24.482002581358266],[117.65951011296113,24.48210120498378],[117.65949494009567,24.482283279369348],[117.65930527927738,24.482488113053112],[117.65965425518304,24.482715706035073],[117.6595025265284,24.482890193987906],[117.65957080442298,24.48301157691162],[117.65946459436474,24.483155719133524],[117.65956321799025,24.483466762875537],[117.6593356250083,24.48367918299203],[117.65888043904437,24.484028158897704],[117.6586983646588,24.483944708137653],[117.65845559881139,24.484104023225022],[117.65875905612066,24.48474887000724],[117.65844042594591,24.48494611725827],[117.65854663600416,24.485158537374765],[117.65802317214566,24.48555303187683],[117.65782592489462,24.485621309771417],[117.65791696208741,24.485856489186105],[117.65765902337452,24.486084082168066],[117.65740867109437,24.48614477362992],[117.65704452232323,24.485970285677087],[117.65680175647582,24.48613718719719],[117.65660450922478,24.486433058073732],[117.65636174337736,24.486288915851826],[117.65635415694463,24.48600821784074],[117.6561341503954,24.48603856357167],[117.65605069963534,24.486205465091775],[117.65577758805699,24.486106841466256],[117.65578517448974,24.485598550473217],[117.65259128630957,24.484301270476053],[117.65250783554953,24.48468059211265],[117.65231817473122,24.484847493632753],[117.65156711789076,24.484627487083525],[117.65108158619591,24.48556820474229],[117.6508388203485,24.485446821818577],[117.65055053590467,24.48592476708069],[117.6507933017521,24.48595511281162],[117.65103606759952,24.4866151324593],[117.65106641333045,24.487017213394093],[117.65397960349952,24.495013313493583],[117.65800041284747,24.49701613173482],[117.66400886757117,24.491963567535336],[117.67200496767066,24.487912412456467],[117.68116937841087,24.489004858769867],[117.69518910609953,24.495862993959562],[117.7070239411614,24.491918048938942],[117.71910154207067,24.490825602625538],[117.73409233314904,24.480872202881205],[117.74028286225831,24.48105427726677],[117.74629131698202,24.482996404046155],[117.74513817920678,24.486880657604917],[117.75005418761708,24.48797310391832],[117.75418120702327,24.490886294087396],[117.76698710547481,24.503995649848225],[117.78519454403153,24.516922931223487],[117.78527799479158,24.516657406077865],[117.78690907782895,24.516604301048744],[117.78753116531297,24.516680165376062],[117.78702287431993,24.517271907129157],[117.78687114566529,24.517658815198484],[117.78702287431993,24.517818130285857],[117.78860085232817,24.51736294432194],[117.78870706238642,24.51752225940931],[117.79032297255833,24.51783330315132],[117.79064160273307,24.518462977068072],[117.79123334448617,24.518114001162402],[117.79145335103539,24.518167106191527],[117.79192370986478,24.51892574946472],[117.79221199430859,24.51877402081008],[117.79239406869415,24.51891816303199],[117.79322098986194,24.519107823850288],[117.79344099641116,24.518872644435596],[117.7936837622586,24.51877402081008],[117.7939948060006,24.51891816303199],[117.79414653465523,24.519191274610343],[117.7946396527828,24.518887817301064],[117.79488241863022,24.518842298704673],[117.79501138798666,24.519077478119364],[117.79548933324878,24.51945679975596],[117.79578520412532,24.52010923297091],[117.79602796997276,24.52006371437452],[117.79591417348178,24.519934745018077],[117.7961114207328,24.51957059624694],[117.79612659359826,24.519160928879415],[117.79534519102687,24.518402285606218],[117.79489000506295,24.51828848911524],[117.79457896132095,24.517795370987663],[117.79402515173152,24.517408462918333],[117.79202991992301,24.51720362923457],[117.79253821091606,24.51520839742606],[117.79286442752354,24.515094600935083],[117.79308443407277,24.514897353684052],[117.79290994611993,24.51427526620003],[117.79336513208385,24.513258684213948],[117.79329685418926,24.51273522035544],[117.79357755220033,24.512431763046163],[117.79370652155677,24.512044854976832],[117.79368376225858,24.511544150416523],[117.7934485828439,24.51141518106008],[117.79354720646941,24.511164828779926],[117.79347892857481,24.51102068655802],[117.7935699657676,24.510770334277865],[117.79331961348745,24.510944822230698],[117.7933575456511,24.511134483049],[117.79316788483281,24.511635187609308],[117.79289477325446,24.511870367024],[117.79223475360678,24.511923472053123],[117.79173404904647,24.51214347860235],[117.7915747339591,24.5124165901807],[117.79153680179543,24.512591078133536],[117.79164301185368,24.512742806788175],[117.79227268577044,24.512720047489978],[117.79251545161786,24.51290970830828],[117.79284925465807,24.512902121875545],[117.79298581044725,24.513061436962918],[117.79301615617817,24.5136986973124],[117.7928568410908,24.51378214807245],[117.79262924810884,24.51378214807245],[117.79253821091605,24.51419940187271],[117.79243200085781,24.514252506901833],[117.79218164857765,24.514153883276318],[117.79219682144311,24.514032500352606],[117.79166577115188,24.513903530996163],[117.79168094401734,24.513516622926833],[117.79099057863874,24.513524209359566],[117.79096781934054,24.513417999301318],[117.78982985443075,24.513402826435854],[117.7899133051908,24.51265176959539],[117.78961743431425,24.512621423864463],[117.78936708203409,24.512310380122454],[117.78752357888023,24.512113132871423],[117.78478487666399,24.512120719304153],[117.78501246964593,24.50138591698843],[117.78695459642532,24.496105759806984],[117.78828980858614,24.496348525654405],[117.79126369021706,24.492464272095642],[117.79253821091604,24.48997592215956],[117.79023193536553,24.488337252689455],[117.78992847805627,24.48572751982966],[117.78695459642533,24.482510872351305],[117.78392002333256,24.48117566019048],[117.78689390496348,24.474499599386355],[117.79071746706039,24.470676037289447],[117.79733283640266,24.467641464196664],[117.80273437650781,24.467095241039964],[117.8046765032872,24.467580772734806],[117.80461581182534,24.4707367287513],[117.8026129935841,24.473043004301818],[117.80188469604184,24.476502417627593],[117.80073155826658,24.478930076101822],[117.80825729953668,24.475349279852335],[117.81341607379441,24.476259651780172],[117.81505474326453,24.477352098093576],[117.81875692243771,24.478080395635846],[117.8222163357635,24.47844454440698],[117.82215564430165,24.476684492013163],[117.82306601622948,24.47589550300904],[117.82409777108101,24.47632034324203],[117.82300532476762,24.47789832125028],[117.82537229177998,24.479597682182238],[117.83083452334701,24.481600500423475],[117.84497563395938,24.484695764978113],[117.84764605828103,24.48560613690595],[117.85140892891609,24.485484753982238],[117.85565733124598,24.48475645643997],[117.8617871688934,24.483785393050276],[117.86609626268515,24.48245018088945],[117.8698591333202,24.48178257480904],[117.88193673422948,24.48190395773275],[117.88873417795732,24.48008321387708],[117.89310396321093,24.4797797565678],[117.89978002401506,24.477352098093576],[117.90748783967074,24.466913166654393],[117.91501358094084,24.45865912784202],[117.90894443475527,24.45186168411418],[117.90870166890784,24.446763601318303],[117.90263252272227,24.434625308947165],[117.89316465467279,24.43219765047294],[117.88952316696145,24.434382543099744],[117.87932700136969,24.431954884625515],[117.87956976721712,24.4285561627616],[117.88782380602949,24.427585099371907],[117.8965633765367,24.4232153141183],[117.90190422518,24.414961275305924],[117.90870166890784,24.412290850984274],[117.90530294704392,24.4093776608152],[117.89583507899444,24.4093776608152],[117.89826273746867,24.402580217087362],[117.90336082026454,24.39966702691829],[117.90396773488311,24.398999420837885],[117.90302701722435,24.39801318458273],[117.90601607172074,24.3939468566384],[117.91207004504083,24.395054475817265],[117.92193240759237,24.394053066696646],[117.93507210908412,24.39599519347603],[117.94827250203775,24.394811709969844],[117.9593183480955,24.399667026918298],[117.97886099881302,24.400638090307986],[117.9850515279223,24.403915429248194],[117.98687227177797,24.40215537685438],[117.98687227177797,24.40118431346469],[117.98571913400271,24.40063809030799],[117.98760056932024,24.39906011229974],[117.98857163270992,24.398999420837885],[118.00198444578002,24.39948495253273],[118.00878188950787,24.401548462235823],[118.01029917605426,24.401305696388402],[118.01278752599035,24.398149740371906],[118.01369789791818,24.398635272066752],[118.0144868869223,24.398331814757473],[118.01533656738827,24.40057739884613],[118.01418342961303,24.401851919545102],[118.0177642258625,24.401912611006956],[118.01790078165169,24.40234503767268],[118.01864425205942,24.40214779042165],[118.01899322796508,24.402238827614433],[118.01946358679447,24.402033993930672],[118.01978980340195,24.40210227182526],[118.02013877930762,24.402284346210827],[118.02055603310788,24.402087098959797],[118.02136778141019,24.401889851708763],[118.022080906087,24.401404320013917],[118.02273333930195,24.401313282821135],[118.0223691905308,24.39890079721237],[118.02221746187615,24.39850630271031],[118.02165606585399,24.39850630271031],[118.02117053415914,24.39831664189201],[118.02110225626456,24.398126981073712],[118.02044223661687,24.397649035811597],[118.01995670492204,24.39746696142603],[118.0194939325254,24.39682970107654],[118.0193042717071,24.395828291955922],[118.018826326445,24.39516068587551],[118.01865942492489,24.394675154180664],[118.018401486212,24.394341351140458],[118.01834838118288,24.394136517456694],[118.01860631989577,24.39376478225283],[118.0189477093687,24.39348408424175],[118.0194711732272,24.393408219914427],[118.02008567427849,24.392846823892263],[118.02008567427849,24.39194403839716],[118.0203739587223,24.39132953734587],[118.02013119287489,24.390715036294583],[118.02008567427849,24.39035088752345],[118.02035878585684,24.3900550166469],[118.0222478076071,24.38903084822809],[118.02277885789834,24.38849221150412],[118.02283196292747,24.38794598834742],[118.02258161064731,24.387543907412624],[118.02206573322154,24.387505975248963],[118.02179262164319,24.387172172208757],[118.02142088643932,24.38709630788144],[118.02124639848648,24.386800437004894],[118.02151951006482,24.386155590222675],[118.02181538094136,24.386041793731696],[118.02202021462513,24.385503157007726],[118.02189883170142,24.384767273032725],[118.02167123871945,24.384607957945356],[118.02140571357384,24.384532093618034],[118.02123122562101,24.384312087068807],[118.02127674421743,24.384069321221386],[118.02167123871949,24.383614135257467],[118.02156502866124,24.38312860356262],[118.02157261509397,24.382597553271385],[118.02180020807593,24.38215754017293],[118.02154985579575,24.381709940641745],[118.02145123217024,24.38106509385953],[118.02161054725761,24.380632667193808],[118.02178503521044,24.38045817924097],[118.02174710304679,24.380147135498962],[118.02219470257798,24.37951746158221],[118.02213401111612,24.379069862051022],[118.02346922327695,24.377385673984527],[118.0222933262035,24.377795341352055],[118.0217015844504,24.377886378544837],[118.02110984269731,24.37815949012319],[118.0207532803589,24.378151903690455],[118.02038913158778,24.37824294088324],[118.0197291119401,24.377863619246643],[118.01852286913571,24.37869812684716],[118.0186139063285,24.379183658542004],[118.0178552630553,24.379342973629377],[118.01691454539653,24.379403665091232],[118.01673247101097,24.379289868600253],[118.01648211873082,24.37935814649484],[118.0163834951053,24.37908503491649],[118.01614831569061,24.379069862051026],[118.01486620855891,24.37954780731314],[118.0143655039986,24.37954780731314],[118.01368272505272,24.37888020123273],[118.01347030493622,24.378508466028862],[118.01346271850349,24.37831121877783],[118.01366755218726,24.378167076555922],[118.01356134212901,24.37803810719948],[118.01364479288907,24.37780292778479],[118.01368272505272,24.377287050359016],[118.0135841014272,24.377013938780664],[118.01309856973236,24.376399437729376],[118.01302270540505,24.375564930128856],[118.01264338376845,24.374912496913907],[118.01262062447024,24.374631798902826],[118.01228682143004,24.374426965219065],[118.01215026564087,24.374244890833495],[118.01072401628726,24.37418419937164],[118.00920672974087,24.373804877735044],[118.00825842564937,24.373440728963907],[118.00664251547747,24.37345590182937],[118.00623284810995,24.37356211188762],[118.00573214354964,24.373971779255147],[118.00526178472025,24.374502829546383],[118.00485970378546,24.374768354692],[118.00411623337773,24.37433592802628],[118.00307689209342,24.374768354691998],[118.00303895992975,24.373600044051276],[118.00292516343877,24.37306140732731],[118.00278102121688,24.372811055047155],[118.00276584835142,24.37253035703607],[118.00309206495888,24.372340696217773],[118.0031679292862,24.372097930370348],[118.00398726402126,24.37158963937731],[118.00427554846509,24.37066409458401],[118.0040403690504,24.37039098300566],[118.00396450472309,24.36989027844535],[118.00360035595195,24.369381987452307],[118.00363070168288,24.369070943710298],[118.00422244343598,24.36891162862293],[118.00487487665092,24.36891162862293],[118.00492039524731,24.368509547688134],[118.00550455056766,24.367887460204113],[118.00587628577154,24.367166749094576],[118.00608111945529,24.367151576229112],[118.00633905816818,24.367280545585555],[118.0065818240156,24.367515725000246],[118.00684734916122,24.36753089786571],[118.00752254167436,24.367326064181945],[118.0091915568754,24.366620525937876],[118.0097605393303,24.36652190231236],[118.010306762487,24.36652190231236],[118.01073918915273,24.366392932955918],[118.01121713441484,24.366059129915712],[118.0116799068115,24.365884641962875],[118.01187715406252,24.36532324594071],[118.01231716716097,24.365080480093287],[118.01329581698339,24.36420045389638],[118.0143199854022,24.36252385226262],[118.01480551709705,24.361894178345864],[118.01488896785709,24.36070310840695],[118.01482827639524,24.360422410395863],[118.01441860902771,24.360088607355657],[118.01391031803468,24.359974810864678],[118.01347030493622,24.359572729929884],[118.01326547125245,24.359026506773183],[118.0133944406089,24.358267863499986],[118.01381169440916,24.358009924787098],[118.0139634230638,24.357759572506943],[118.01419860247849,24.35762301671777],[118.01489655428983,24.357372664437616],[118.01509380154086,24.357456115197667],[118.0152455301955,24.357721640343286],[118.01576140762127,24.357805091103337],[118.01634556294164,24.35847269718375],[118.01648970516354,24.358457524318286],[118.01646694586535,24.358343727827307],[118.01802216457541,24.358313382096377],[118.01811320176819,24.35813130771081],[118.01808285603727,24.357911301161582],[118.01762767007334,24.356909892040964],[118.01714213837849,24.35646229250978],[118.01696006399293,24.35608297087318],[118.01705110118571,24.3556126120438],[118.0172862806004,24.355210531109005],[118.01770353440065,24.3548767280688],[118.01822699825917,24.354702240115966],[118.01853804200118,24.354156016959262],[118.01856080129939,24.353275990762356],[118.01834838118289,24.352911841991222],[118.0184242455102,24.352183544448952],[118.01831044901922,24.352024229361582],[118.01796147311356,24.35171318561957],[118.01793112738262,24.35151593836854],[118.01804492387362,24.3513642097139],[118.01822699825918,24.351288345386582],[118.0184697641066,24.35144766047395],[118.01874287568495,24.351432487608488],[118.01912219732155,24.35124282679019],[118.01941048176536,24.350984888077303],[118.01994911848934,24.35115937603014],[118.02045740948235,24.35111385743375],[118.02073810749343,24.351000060942766],[118.0208974225808,24.350673844335294],[118.02029809439497,24.34984692316751],[118.02001739638389,24.349702780945602],[118.0175290464478,24.3487999954505],[118.01708903334935,24.348617921064932],[118.01674764387641,24.348276531591996],[118.01661867451998,24.348086870773695],[118.0144413683259,24.347783413464416],[118.01447171405685,24.34734340036596],[118.01425170750763,24.347252363173176],[118.01435791756587,24.34691856013297],[118.0141758431803,24.346895800834776],[118.01423653464217,24.3467592450456],[118.01356892856175,24.346751658612867],[118.01342478633984,24.34754064761699],[118.01320477979061,24.3474951290206],[118.01330340341613,24.346433028438124],[118.01307581043417,24.346425442005394],[118.01299994610685,24.34661510282369],[118.01221854353545,24.346668207852815],[118.01198336412077,24.34679717720926],[118.01162680178237,24.34671372644921],[118.01127782587669,24.346774417911064],[118.01117920225118,24.347123393816734],[118.0104964233053,24.346865455103845],[118.00995778658134,24.346903387267506],[118.00998054587953,24.346592343525497],[118.01025365745788,24.346038533936063],[118.01040538611252,24.346008188205136],[118.01058746049809,24.34552265651029],[118.01078470774911,24.345651625866733],[118.0113005851749,24.34567438516493],[118.01132334447308,24.345469551481166],[118.0112323072803,24.345105402710033],[118.0115205917241,24.344961260488123],[118.01161921534963,24.344688148909775],[118.01026124389061,24.343777776981938],[118.010306762487,24.343519838269053],[118.0109212635383,24.343178448796113],[118.01107299219292,24.34285223218864],[118.01099712786561,24.342677744235804],[118.01155852388777,24.34201013815539],[118.01174059827333,24.342063243184516],[118.01241579078648,24.341342532074982],[118.01262062447024,24.34130459991132],[118.0130378782705,24.340803895351012],[118.01287097675039,24.340697685292767],[118.01296201394318,24.34056112950359],[118.0136068607254,24.340659753129106],[118.0140089416602,24.34094803757292],[118.01460068341328,24.341084593362098],[118.01475999850065,24.34067492599457],[118.01470689347153,24.34031836365617],[118.01451723265323,24.340075597808745],[118.01399376879473,24.33986317769225],[118.01400135522746,24.33967351687395],[118.01416067031484,24.339506615353848],[118.0150558693772,24.33939281886287],[118.01518483873365,24.33914246658271],[118.01548070961019,24.339157639448175],[118.01561726539936,24.339089361553587],[118.01546553674473,24.33875555851338],[118.01563243826483,24.338482446935032],[118.01592072270864,24.33829278611673],[118.01568554329396,24.338186576058483],[118.01530622165735,24.338383823309513],[118.01513932013725,24.33831554541493],[118.01480551709705,24.337981742374723],[118.01489655428983,24.33781484085462],[118.01506345580994,24.337951396643792],[118.01513932013725,24.337830013720083],[118.0155793332357,24.33781484085462],[118.0159358955741,24.33728379056338],[118.01661108808725,24.337458278516216],[118.0166945388473,24.337602420738122],[118.01749870071689,24.337845186585547],[118.01762767007334,24.338004501672916],[118.01772629369884,24.338998324360805],[118.01790836808442,24.339324540968278],[118.01831803545194,24.339590066113896],[118.01859873346302,24.33959765254663],[118.01907667872514,24.339741794768535],[118.02409889719371,24.335409941678588],[118.02935629507695,24.339946628452296],[118.03372608033055,24.342738435697658],[118.03894554605014,24.346501306332712],[118.05181213596356,24.358154067009004],[118.05314734812438,24.354876728068795],[118.0597020260048,24.357183003619312],[118.06273659909758,24.356576089000754],[118.06819883066458,24.359974810864674],[118.07208308422335,24.357183003619312],[118.07402521100273,24.359064438936844],[118.07493558293056,24.35687954631004],[118.08070127180686,24.35985342794097],[118.0881663216151,24.355969174382203],[118.09514583972852,24.359914119402823],[118.10698067479038,24.34911103919251],[118.10522062239656,24.3478972099554],[118.10710205771409,24.344984019786324],[118.105038548011,24.344984019786324],[118.10619168578624,24.342920510083232],[118.10400679315944,24.342920510083232],[118.10515993093472,24.338793490677045],[118.10989386495946,24.336062374893537],[118.11377811851823,24.336972746821374],[118.11717684038214,24.331874664025495],[118.1150526392172,24.330782217712095],[118.1151740221409,24.327929719004874],[118.1199686476275,24.32616966661106],[118.12106109394091,24.31888669118838],[118.11893689277595,24.32574482637807],[118.11687338307286,24.325987592225495],[118.11335327828523,24.323863391060545],[118.11608439406874,24.313727916930645],[118.12197146586874,24.316034192481162],[118.13301731192647,24.30814430243992],[118.12998273883369,24.299890263627546],[118.1332600777739,24.296006010068783],[118.12992204737182,24.293942500365688],[118.12585571942749,24.296855690534763],[118.12512742188522,24.290725852887338],[118.12597710235121,24.287934045641975],[118.12901167544399,24.28902649195538],[118.13107518514707,24.28204697384197],[118.13690156548522,24.281986282380114],[118.13702294840893,24.279922772677022],[118.13811539472233,24.277737880050218],[118.13593050209553,24.27688819958424],[118.13605188501924,24.27500676426671],[118.13902576665016,24.273853626491455],[118.13787262887492,24.27179011678836],[118.14011821296357,24.269787298547122],[118.1361125764811,24.263900226747122],[118.13356353508316,24.263960918208976],[118.12178939148316,24.2700907558564],[118.10376402731204,24.262140174353306],[118.09799833843574,24.25285438068939],[118.09799833843574,24.24077677978011],[118.09575275434707,24.2428402894832],[118.0949030738811,24.25018395636774],[118.09302163856357,24.25212608314712],[118.08397861074707,24.255039273316196],[118.07190100983779,24.254068209926505],[118.06310074786872,24.246906617427534],[118.05800266507283,24.23865257861516],[118.04999139210788,24.237984972534743],[118.04568229831612,24.233797261666698],[118.04100905575324,24.22281210707082],[118.04015937528726,24.216257429190406],[118.03803517412231,24.212858707326486],[118.03512198395325,24.217714024274944],[118.03208741086046,24.217714024274944],[118.03190533647489,24.219231310821336],[118.0229836915821,24.221901735142986],[118.02401544643365,24.234040027514123],[118.02905283776767,24.237074600606906],[118.03020597554293,24.245996245499697],[118.02207331965427,24.25412890138836],[118.02601826467489,24.258013154947125],[118.0262610305223,24.26104772803991],[118.02820315730169,24.266145810835788],[118.02510789274706,24.266206502297642],[118.02717140245015,24.27409639233888],[118.02589688175117,24.277980645897646],[118.0310556560089,24.2780413373595],[118.03014528408107,24.280104847062592],[118.02389406350993,24.28307872869352],[118.00690045419034,24.283018037231667],[118.00404795548312,24.28605261032445],[117.99215242895941,24.280044155600738],[117.98893578148106,24.284110483545067],[117.99021030218003,24.28605261032445],[117.99002822779447,24.289208566340946],[117.98705434616355,24.29109000165847],[117.9812279658254,24.288965800493525],[117.97097110877178,24.296127392992496],[117.95713345546869,24.288905109031667],[117.95476648845631,24.290240321192492],[117.95701207254497,24.29200037358631],[117.9531278189862,24.29382111744198],[117.95591962623158,24.298979891699712],[117.95288505313879,24.297948136848166],[117.95288505313879,24.295277712526516],[117.95088223489755,24.29703776492033],[117.94815111911404,24.29588462714507],[117.94693728987693,24.30699116466466],[117.9450558545594,24.308993982905896],[117.94378133386043,24.309176057291463],[117.9450558545594,24.311118184070846],[117.94098952661507,24.313788608392496],[117.93522383773879,24.30911536582961],[117.93522383773879,24.305959409813113],[117.93200719026044,24.306020101274967],[117.92982229763362,24.303956591571875],[117.92199309905423,24.301104092864662],[117.92090065274084,24.299040583161567],[117.9220537905161,24.29491356375538],[117.9300043720192,24.290058246806925],[117.9300043720192,24.286962982252284],[117.93200719026044,24.2839284091595],[117.92690910746455,24.280893836066717],[117.92812293670167,24.277919954435788],[117.92508836360888,24.269847990008984],[117.91106863592022,24.269847990008984],[117.90609193604806,24.266995491301767],[117.90196491664186,24.266995491301767],[117.8980806630831,24.268937618081146],[117.89613853630372,24.26693479983991],[117.88897694380475,24.27506745572857],[117.88284710615733,24.277009582507954],[117.88205811715319,24.2737929350296],[117.87689934289547,24.270940436322384],[117.8671280175367,24.275128147190426],[117.86706732607485,24.272032882635784],[117.86093748842742,24.274885381343005],[117.85784222387278,24.271911499712076],[117.85996642503773,24.270940436322384],[117.85778153241093,24.26887692661929],[117.84673568635318,24.273064637487334],[117.84691776073876,24.279073092211046],[117.84194106086659,24.28095452752857],[117.84418664495524,24.285142238396613],[117.84169829501917,24.28629537617187],[117.84103068893876,24.29011893826878],[117.83702505245628,24.292971436975996],[117.84012031701091,24.29309281989971],[117.8398775511635,24.296066701530638],[117.83696436099441,24.302924836720333],[117.83575053175731,24.3031069111059],[117.83799611584597,24.304077974495588],[117.83811749876968,24.30814430243992],[117.83210904404596,24.31293892792652],[117.82901377949132,24.313909991316212],[117.82610058932225,24.312028555998683],[117.82403707961916,24.314941746167758],[117.82427984546658,24.317065947332708],[117.82100250652637,24.318037010722396],[117.82294463330575,24.319614988730645],[117.8230053247676,24.32119296673889],[117.8281034075635,24.321010892353325],[117.83508292567691,24.31615557540487],[117.83484015982948,24.314820363244046],[117.84218382671402,24.313909991316212],[117.8449756339594,24.316094883943016],[117.83999893408722,24.320039828963637],[117.82197356991608,24.32811179339044],[117.8120808616336,24.324045465446112],[117.80406958866864,24.327929719004874],[117.8020667704274,24.32799041046673],[117.80006395218616,24.325926900763637],[117.79272028530163,24.327080038538895],[117.78707597934905,24.330053920169824],[117.7870152878872,24.333877482266733],[117.7701430614913,24.33703343828323],[117.75915790689542,24.341888755231686],[117.75666955695934,24.34097838330385],[117.75794407765831,24.33897556506261],[117.7550915789511,24.338065193134778],[117.75102525100677,24.329082856780136],[117.74817275229954,24.333877482266733],[117.73967594763974,24.335880300507974],[117.73196813198408,24.329932537246115],[117.72608106018409,24.34201013815539],[117.72802318696347,24.34771513556983],[117.72711281503562,24.350992474510033],[117.72207542370161,24.353905664679107],[117.72013329692223,24.35299529275127],[117.71995122253666,24.356029865844057],[117.71187925810986,24.360035502326532],[117.70708463262326,24.356940237771894],[117.70805569601295,24.351963537899728],[117.70508181438203,24.350931783048182],[117.70295761321707,24.347775827031686],[117.70489973999645,24.343163275930653],[117.7049604314583,24.33970386260488],[117.70987643986862,24.337943810211065],[117.7140034592748,24.331024983559516],[117.71697734090573,24.330053920169824],[117.71806978721914,24.32902216531828],[117.72104366885007,24.32902216531828],[117.71989053107481,24.323863391060545],[117.71485313974078,24.321860572819308],[117.71090819472016,24.314820363244046],[117.70405005953046,24.313909991316212],[117.70192585836551,24.31718733025642],[117.69901266819645,24.316034192481162],[117.6981022962686,24.317065947332708],[117.69901266819645,24.3191294570358],[117.69094070376964,24.33703343828323],[117.69106208669335,24.34504471124818],[117.68390049419438,24.343102584468795],[117.68189767595314,24.349111039192508],[117.68590331243561,24.35190284643787],[117.68280804788098,24.35074970866261],[117.68104799548716,24.355908482920345],[117.67898448578407,24.355058802454366],[117.67686028461912,24.34401295639663],[117.67321879690778,24.342981201545083],[117.66690688487479,24.338975565062608],[117.6670282677985,24.334666471270854],[117.66897039457788,24.332967110338895],[117.66290124839232,24.32908285678013],[117.66186949354076,24.32082881796776],[117.6559217302789,24.317976319260545],[117.65397960349952,24.315184512015183],[117.65519343273664,24.3079015365925],[117.65312992303355,24.30705185612652],[117.64803184023766,24.301225475788375],[117.64803184023766,24.292971436976],[117.64014195019644,24.28605261032445],[117.63492248447685,24.276827508122388],[117.63516525032426,24.271608042402796],[117.63091684799437,24.265842353526505],[117.63103823091808,24.260440813421347],[117.62788227490158,24.258013154947122],[117.62594014812221,24.253825444079077],[117.62193451163974,24.251883317299697],[117.62102413971189,24.254310975773922],[117.61786818369539,24.255099964778047],[117.61210249481911,24.248241829588356],[117.60409122185416,24.245025182110002],[117.60087457437581,24.246967308889385],[117.59893244759643,24.25224746607083],[117.59292399287271,24.254189592850214],[117.5880079844624,24.25309714653681],[117.58709761253455,24.256920708633718],[117.58382027359436,24.26025873903578],[117.58284921020466,24.264142992594543],[117.58491271990775,24.26620650229764],[117.58412373090363,24.26796655469145],[117.59001080270363,24.27603851911826],[117.5881293673861,24.283018037231663],[117.59699032081703,24.28799473710383],[117.59905383052013,24.291878990662596],[117.60002489390983,24.297280530767754],[117.59583718304178,24.301346858712083],[117.59504819403766,24.3089939829059],[117.58509479429333,24.310147120681158],[117.58400234797992,24.30705185612652],[117.58084639196343,24.30705185612652],[117.57696213840467,24.304017283033733],[117.57684075548096,24.30602010127497],[117.5671908130459,24.30686978174095],[117.5651273033428,24.31293892792652],[117.56081820955106,24.314881054705904],[117.55996852908507,24.3191294570358],[117.55681257306858,24.32010052042549],[117.55608427552632,24.30996504629559],[117.55317108535723,24.308872599982188],[117.5459488013964,24.308872599982188],[117.54315699415105,24.311846481613117],[117.53793752843146,24.307780153668787],[117.53799821989331,24.3132423852358],[117.53290013709744,24.315123820553325],[117.533082211483,24.319008074112087],[117.53405327487269,24.3239240825224],[117.53508502972424,24.32264956182343],[117.53502433826239,24.31700525587085],[117.54000103813455,24.321132275277037],[117.53981896374898,24.325077220297658],[117.53714853942733,24.326958655615183],[117.53508502972423,24.3340595566523],[117.53599540165206,24.336123066355395],[117.5300476383902,24.336062374893537],[117.52986556400464,24.33205673841106],[117.52889450061495,24.331024983559516],[117.5219756739634,24.334848545656424],[117.51584583631598,24.335940991969828],[117.51493546438815,24.338065193134778],[117.50807732919844,24.33703343828323],[117.50795594627473,24.33982524552859],[117.51117259375309,24.341888755231686],[117.51026222182526,24.352873909827565],[117.50886631820258,24.355119493916224],[117.50091573669948,24.356818854848186],[117.49976259892422,24.35900374747499],[117.49563557951804,24.359125130398702],[117.49302584665824,24.363009383957465],[117.49399691004794,24.37004959353272],[117.49108371987887,24.376847037260557],[117.48895951871393,24.379153312811074],[117.49005196502732,24.3799423018152],[117.49096233695516,24.38315894929355],[117.49011265648917,24.389956393021386],[117.4941789844335,24.391959211262623],[117.49612111121289,24.390927456411077],[117.49405760150978,24.400031175689435],[117.4980025465304,24.40695000234098],[117.50097642816132,24.409195586429643],[117.5011585025469,24.411016330285314],[117.50613520241906,24.411926702213147],[117.51287195468504,24.4108949473616],[117.51602791070154,24.414050903378097],[117.51912317525618,24.416053721619335],[117.51687759116751,24.42005935810181],[117.50419307563969,24.42509674943583],[117.50194749155102,24.428009939604905],[117.50310062932628,24.430983821235834],[117.49909499284381,24.433047330938926],[117.50006605623349,24.435960521108],[117.50407169271598,24.437720573501814],[117.50419307563969,24.44033030636161],[117.50219025739845,24.447006367165734],[117.49508935636133,24.45113338657192],[117.4999446733098,24.45501764013068],[117.49988398184794,24.459387425384293],[117.50200818301289,24.458780510765735],[117.5021295659366,24.461208169239963],[117.50103711962319,24.46223992409151],[117.50127988547062,24.468915984895634],[117.50279717201701,24.470129814132747],[117.50103711962319,24.472193323835842],[117.50103711962319,24.474135450615226],[117.49927706722939,24.474074759153368],[117.50085504523763,24.478080395635843],[117.49703148314072,24.479901139491513],[117.49818462091598,24.48111496872863],[117.4967887172933,24.482268106503884],[117.49988398184794,24.482996404046155],[117.5000660562335,24.484999222287392],[117.49606041975103,24.486941349066775],[117.49606041975103,24.48815517830389],[117.49927706722937,24.49410294156575],[117.50206887447474,24.495074004955438],[117.50297924640257,24.498958258514204],[117.50510344756752,24.49901894997606],[117.50583174510979,24.501932140145133],[117.51086913644382,24.501082459679154],[117.51505684731185,24.501750065759566],[117.5207618447263,24.49616645126884],[117.52786274576341,24.49301049525234],[117.52968348961909,24.48712342345234],[117.52488886413248,24.484938530825534],[117.52397849220465,24.482814329660584],[117.53095801031806,24.48287502112244],[117.53593471019022,24.47583481154718],[117.53896928328301,24.473953376229655],[117.54200385637579,24.47292162137811],[117.54503842946858,24.474074759153368],[117.55207863904383,24.46867321904821],[117.55110757565414,24.471161568984293],[117.55365661705208,24.469826356823468],[117.56515764907373,24.468794601971922]];

var kfqs = [tstzq, zsjzzkfq, czhqjjkfq, glgjjkfq, zzgxjscykfq];
var kfqNames = ["台商投资区", "招商局漳州开发区", "常山华侨经济开发区", "古雷港经济开发区", "漳州高新技术产业开发区"];

/**
 * 地区分区块描线
 */
var countyAreaPolygons = null;

function setCountyArea(tempArea) {
    var poyjSONArr = [];
    $.ajax({
        type: 'POST',
        async: true,
        dataType: 'json',
        url: 'https://api.tianditu.gov.cn/administrative?postStr={%22searchWord%22:%22%E6%BC%B3%E5%B7%9E%E5%B8%82%22,%22searchType%22:%221%22,%22needSubInfo%22:%22true%22,%22needAll%22:%22true%22,%22needPolygon%22:%22true%22,%22needPre%22:%22true%22}&tk=7ca2bb2feccc647effa30f35238a1fe3',
        success: function (result) {
            if (countyAreaPolygons == null) {
                countyAreaPolygons = new fjzx.map.DrawGeoJSON({
                    map: map,
                    zIndex: 10000,
                    customType: 'poly',
                    selectType: 'click'
                });
                clickPloyAction2(countyAreaPolygons);
            }
            countyAreaPolygons.closeModifyFeature()
            if (result.returncode == "100") { //100 正常
                var child = result.data[0].child;
                var tempFeature;
                for (var i = 0; i < child.length; i++) {
                    var points = child[i].points;
                    //for (var j = 0; j < points.length; j++) {
                    var arr = points[0].region.split(',');
                    var coordinates = [];
                    var pencilColor = "";

                    for (var n = 0; n < arr.length; n++) {
                        var arr2 = arr[n].split(' ');
                        coordinates.push([parseFloat(arr2[0]), parseFloat(arr2[1])]);
                    }
                    
                    if (child[i].name == "龙海市") {
                        coordinates = lhsqyzb;
                    }

                    names.push(child[i].name);
                    if (child[i].name == "芗城区" || child[i].name == "漳浦县" || child[i].name == "诏安县") {
                        var pencilColor = "#228B22";
                    } else if (child[i].name == "龙文区" || child[i].name == "南靖县" || child[i].name == "云霄县") {
                        var pencilColor = "#ffe600";
                    } else if (child[i].name == "华安县" || child[i].name == "龙海市" || child[i].name == "东山县") {
                        var pencilColor = "#c99979";
                    } else {//child[i].name == "平和县" || child[i].name == "长泰县"
                        var pencilColor = "#f58f98";
                    }
                    var strokeColor = pencilColor;
                    var strokeWidth = "2"
                    if (tempArea != undefined && tempArea != "台商投资区" && tempArea != "招商局漳州开发区"
                        && tempArea != "常山华侨经济开发区" && tempArea != "古雷港经济开发区" && tempArea != "漳州高新技术产业开发区") {
                        if (child[i].name == tempArea) {
                            pencilColor = "#f8f8f7"
                            strokeColor = "#0099ff";
                            strokeWidth = "3"
                            tempFeature = {
                                "layout": "XY",
                                "coordinates": [coordinates],
                                "type": "Polygon",
                                "featureId": "p" + i,
                                "pencilColor": pencilColor,
                                "pencilSize": "3",
                                "opacity": "1",
                                "strokeColor": strokeColor,
                                "strokeWidth": strokeWidth
                            };
                        } else {
                            var feature = {
                                "layout": "XY",
                                "coordinates": [coordinates],
                                "type": "Polygon",
                                "featureId": "p" + i,
                                "pencilColor": pencilColor,
                                "pencilSize": "3",
                                "opacity": "1",
                                "strokeColor": strokeColor,
                                "strokeWidth": strokeWidth
                            };
                            poyjSONArr.push({
                                "typeString": "Polygon",
                                "feature": JSON.stringify(feature),
                                "name": child[i].name,
                                "id": i
                            });
                        }
                    } else {
                        var feature = {
                            "layout": "XY",
                            "coordinates": [coordinates],
                            "type": "Polygon",
                            "featureId": "p" + i,
                            "pencilColor": pencilColor,
                            "pencilSize": "3",
                            "opacity": "1",
                            "strokeColor": strokeColor,
                            "strokeWidth": strokeWidth
                        };
                        poyjSONArr.push({
                            "typeString": "Polygon",
                            "feature": JSON.stringify(feature),
                            "name": child[i].name,
                            "id": i
                        });
                    }
                    //}
                }
                if (tempFeature != undefined) {
                    poyjSONArr.push({
                        "typeString": "Polygon",
                        "feature": JSON.stringify(tempFeature),
                        "name": tempArea,
                        "id": "hasSelectedFeature"
                    });
                }

                for (var i = 0; i < kfqs.length; i++) {

                    if (kfqNames[i] == tempArea) {
                        var feature = {
                            "layout": "XY",
                            "coordinates": [kfqs[i]],
                            "type": "Polygon",
                            "featureId": "p111",
                            "pencilColor": "#f8f8f7",
                            "pencilSize": "3",
                            "opacity": "1",
                            "strokeColor": "#0099ff",
                            "strokeWidth": "3"
                        };
                        poyjSONArr.push({
                            "typeString": "Polygon",
                            "feature": JSON.stringify(feature),
                            "name": kfqNames[i],
                            "id": "hasSelectedFeature"
                        });
                    } else {
                        var feature = {
                            "layout": "XY",
                            "coordinates": [kfqs[i]],
                            "type": "Polygon",
                            "featureId": "kfq" + i,
                            "pencilColor": "#f47920",
                            "pencilSize": "3",
                            "opacity": "1",
                            "strokeColor": "#f47920",
                            "strokeWidth": "2"
                        };
                        poyjSONArr.push({
                            "typeString": "Polygon",
                            "feature": JSON.stringify(feature),
                            "name": kfqNames[i],
                            "id": "kfq_" + i
                        });
                    }

                }
                countyAreaPolygons.load(poyjSONArr);

                var $domNode = $('div.basemap-toggle');
                var baseMaps = $domNode.children(".basemap");
                var locationHref = window.location.href;
                if (locationHref.indexOf("pollutionInfos")>0 || locationHref.indexOf("pollutionInfodq")>0) {
                    countyAreaPolygons.setAreaNoColor()
                } else if (!$(baseMaps[0]).attr("selected")) {
                    countyAreaPolygons.setAreaNoColor()
                }
                
                if ($(".map-gridline-box").hasClass("map-gridline-select")) {
                    setGridlines();
                }
                
            }
        }
    });
}

/**
 * 点击地图区域响应事件
 * @param drawGeojson
 */
function clickPloyAction2(drawGeojson) {
    drawGeojson.setSelectAction(function (e, selectInteraction) {
        var features = selectInteraction.getFeatures();
        if (features.array_.length == 0) {
            //判断是否为区县内的点击
            areaName = ""
            // setCountyArea()
            getAllPollutionSource();
            areaName = "";
            colorForTab(areaName)
        }
        features.forEach(function (feature, index, array) {
            var geometry = feature.getGeometry();
            var coordinates = geometry.getCoordinates();
            if (feature.id_ != "hasSelectedFeature") {
                areaName = names[feature.id_];
                //if(feature.values_.name != ""){
                areaName = feature.values_.name;
                //}
                // areaPointMapData();
                colorForTab(areaName)
                // setCountyArea(areaName)
            }

        });
    })

}

var areaName;

/**
 * 点位描述
 * @param lng
 * @param lat
 * @param name
 * @param targetIcon
 * @param tid
 */
function areaPoint(lng, lat, name, targetIcon, tid, data) {
    //点位信息描述
    var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
        icon: targetIcon,
        map: map,
        title: name
    });
    pointMapPush(tid, tempMarker);
    map.addOverlay(tempMarker);
    addCaseClickEvent(tempMarker, data)
}

/**
 * 区域点位描述
 */
function areaPointMapData() {
    $('.no-choice').each(function () {//获取选中的污染源点击事件
        if ($(this).hasClass("choiced")) {
            var tid = $(this).attr("id");
            clearMap(tid);//先清除点位;然后再描点位
            var dataPoint = getTargetData(tid);//获取点位信息
            var length = dataPoint.length;
            var targetIcon = getIcon(tid);
            var lng;
            var lat;
            var name;
            for (var i = 0; i < length; i++) {
                lng = dataPoint[i].jd;
                lat = dataPoint[i].wd
                name = dataPoint[i].mc
                if (!Ams.isNoEmpty(lng) || !Ams.isNoEmpty(lat) || !Ams.isNoEmpty(name)) {
                    continue;
                }

                if (checkPointInArea(lng, lat, areaName)) {
                    areaPoint(lng, lat, name, targetIcon, tid, dataPoint[i])
                }
            }
        }
    })
}

/**
 * 获取所有污染源id
 */
function getAllPollutionSource() {
    $('.no-choice').each(function () {//获取选中的污染源点击事件
        if ($(this).hasClass("choiced")) {
            pointAboutPollution($(this).attr("id"));
        }
    })
}

//区域划分的第二级下拉数据显示
var areaClicChange = 0;

function areaClick(idthis, areaN, idVal) {
    if (($(idthis).hasClass("tableClass collapsed") || $(idthis).hasClass("select-part collapsed")) && areaClicChange == 0) {
        areaName = ""
        setCountyArea()
        getAllPollutionSource();
        initPollutionMap(pollutionMapData);
        return;
    }
    setCountyArea(areaN);
    areaClicChange = 0;
    areaName = areaN;
    areaPointMapData();
    countTR1 = 0;//突然污染
    countST1 = 0;//
    countPollutionNum1 = 0;//污染源总数
    countPollutionAIRNum1 = 0;//大气污染
    totalCount1 = 0;//总计污染源个数
    countHY1 = 0;
    html = '<div class="personnel-children" ><ul>';
    var array = {};
    $.ajax({
        url: "/env/pollution2/getEnterpriseByQxAndLxAndZlCount",
        type: "POST",
        data: {
            "qx": areaN,
        },
        success: function (data) {
            array = data;
        },
        dataType: "json",
        async: false
    });
    $('.no-choice').each(function () {//获取选中的污染源点击事件
        if ($(this).hasClass("choiced")) {
            var tid = $(this).attr("id");
            var child = getLabel(tid, areaN, idVal,array);
            html += child;
        }
    });
    html += '</ul></div>';
    $(".tableClass").removeClass("collapsed");
    $(".tableClass").removeClass("select-part");
    $(".tableClass").nextAll("div").remove();
    $(idthis).addClass("collapsed");
    $(idthis).addClass("select-part");
    $('#' + idVal).parent('div').nextAll("div").empty("");
    $('#' + idVal).parent('div').after(html);

}

//区域划分的第三级下拉数据拼接
function getLabel(tid, areaName, areaId,array) {
    var total = 0;
    var result2 = '';
    switch (tid) {
        case "wsclc":
            if(Ams.isNoEmpty(array.涉水工业企业)){
                if (array.涉水工业企业 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=涉水工业企业&qx=' + areaName + '&lx=水\')">涉水工业企业 <span>' + array.涉水工业企业 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.涉水工业企业;
                }
            }
            break;
        case "cgpk":
            if (Ams.isNoEmpty(array.海洋排污口)) {
                if (array.海洋排污口 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=海洋排污口&qx=' + areaName + '&lx=海洋\')">海洋排污口 <span>' + array.海洋排污口 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.海洋排污口;
                }
            }
            break;
        case "sk":
            if (Ams.isNoEmpty(array.涉海工业固废)) {
                if (array.涉海工业固废 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=涉海工业固废&qx=' + areaName + '&lx=海洋\')">涉海工业固废 <span>' + array.涉海工业固废 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.涉海工业固废;
                }
            }
            break;
        case "gyfsqy":
            if (Ams.isNoEmpty(array.VOCs企业)) {
                if (array.VOCs企业 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=VOCs企业&qx=' + areaName + '&lx=大气\')">VOCs企业 <span>' + array.VOCs企业 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.VOCs企业;
                }
            }
            break;
        case "wxszzdz":
            if (Ams.isNoEmpty(array.高架源企业)) {
                if (array.高架源企业 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=高架源企业&qx=' + areaName + '&lx=大气\')">高架源企业 <span>' + array.高架源企业 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.高架源企业;
                }
            }
            break;
        case "xly":
            if (Ams.isNoEmpty(array.散乱污企业)) {
                if (array.散乱污企业 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=散乱污企业&qx=' + areaName + '&lx=大气\')">散乱污企业 <span>' + array.散乱污企业 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.散乱污企业;
                }
            }
            break;
        case "fqpk":
            if (Ams.isNoEmpty(array.工业固废)) {
                if (array.工业固废 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=工业固废&qx=' + areaName + '&lx=土壤\')">工业固废 <span>' + array.工业固废 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.工业固废;
                }
            }
            break;
        case "gd":
            if (Ams.isNoEmpty(array.工业危险废物)) {
                if (array.工业危险废物 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=工业危险废物&qx=' + areaName + '&lx=土壤\')">工业危险废物 <span>' + array.工业危险废物 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.工业危险废物;
                }
            }
            break;
        case "sbc":
            if (Ams.isNoEmpty(array.石板材行业)) {
                if (array.石板材行业 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=石板材行业&qx=' + areaName + '&lx=生态\')">石板材行业 <span>' + array.石板材行业 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.石板材行业;
                }
            }
            break;
        case "gyfqqy":
            if (Ams.isNoEmpty(array.持证矿山)) {
                if (array.持证矿山 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=持证矿山&qx=' + areaName + '&lx=生态\')">持证矿山 <span>' + array.持证矿山 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.持证矿山;
                }
            }
            break;
        case "sghfc":
            if (Ams.isNoEmpty(array.三格化粪池)) {
                if (array.三格化粪池 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=三格化粪池&qx=' + areaName + '&lx=土壤\')">三格化粪池 <span>' + array.三格化粪池 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.三格化粪池;
                }
            }
            break;
        case "fdlydy":
            if (Ams.isNoEmpty(array.非道路移动源)) {
                if (array.非道路移动源 != 0) {
                    result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                        'onclick="dataRelaod(\'' + tid + '\',\'' + tid + areaId + '\',\'/env/pollution2/getEnterpriseByQxAndLxAndZl?zl=非道路移动源&qx=' + areaName + '&lx=大气\')">非道路移动源 <span>' + array.非道路移动源 + '个</span></div>' +
                        '<div class="personnel-children two"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                        '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                        'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                    total = array.非道路移动源;
                }
            }
            break;
    }
    setPollutionData1(tid, total, true);
    return result2;
}

//datagrid加载触发事件
function dataRelaod(tid, dgid, url) {
    if($('#'+dgid).parents('.two').prev().hasClass('collapsed')){
        return;
    }
    $('#' + dgid).datagrid({
        url: url,
        columns: [[
            {field: 'name', title: '名称', width: '302'}
        ]],
        rownumbers: true,

        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true,
        pagePosition: 'bottom',
        pageSize: 10,
        nowrap: false,
        showHeader:false,
        onClickRow: function (index, data) {

            clearAllMapPoint(data.jd, data.wd, data.mc, getIcon(tid), tid, data);
            map.setCenter(new fjzx.map.Point(data.jd, data.wd));
        },
        onDblClickRow: function (index, row) {
            //todo
            showDetail(row);
        },
        onLoadSuccess: function () {
            $(this).datagrid('getPanel').find('tr.datagrid-row').bind('mouseover', function (e) {
                var index = parseInt($(this).attr('datagrid-row-index'));
                this.style.background = '#f2f0cc'
            });
            $(this).datagrid('getPanel').find('tr.datagrid-row').bind('mouseout', function (e) {
                var index = parseInt($(this).attr('datagrid-row-index'));
                this.style.background = 'white'
            });
        }
    });
}

/**
 * 搜索框响应enter事件
 */
$('#queryMc').textbox({
    inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
        keyup: function (event) {
            if (event.keyCode == 13) {
                doSearch();
            }
        }
    })
});

/**
 * 高级搜索查询事件
 */
function doSearch() {
    $('#searchDG').datagrid({
        url: '/env/pollution2/listByMc',
        queryParams: {
            "mc": $('#queryMc').val().trim()
        },
        onDblClickRow: function (index, row) {
            //todo
            showDetail(row);
        },
        onClickRow: function (index, data) {
            map.setCenter(new fjzx.map.Point(data.jd, data.wd));
            for(var obj in wryzlId){
                     if(wryzlId[obj]==data.wryzl){
                         clearAllMapPoint(data.jd, data.wd, data.mc, getIcon(obj), obj, data);
                         break;
                     }
            }
        },
        onLoadSuccess: function () {
            $(this).datagrid('getPanel').find('tr.datagrid-row').bind('mouseover', function (e) {
                var index = parseInt($(this).attr('datagrid-row-index'));
                this.style.background = '#f2f0cc'
            });
            $(this).datagrid('getPanel').find('tr.datagrid-row').bind('mouseout', function (e) {
                var index = parseInt($(this).attr('datagrid-row-index'));
                this.style.background = 'white'
            });
        }
    });
}

/**
 * 点位标签与区域划分数值相加减联动
 * @param tid 点位信息描述
 * @param isChoose 是否被选中
 */
function areaNameList(tid, isChoose) {
    var temp = {};
    switch (tid) {
        case "wsclc":
            temp = earaJson.WadingIndustrialEnterprise;
            break;
        case "cgpk":
            temp = earaJson.SeaSewageOutlet;
            break;
        case "sk":
            temp = earaJson.SeaIndustrySolidWaste;
            break;
        case "gyfsqy":
            temp = earaJson.VOCsEnterprise;
            break;
        case "wxszzdz":
            temp = earaJson.ElevatedSourceEnterprise;
            break;
        case "xly":
            temp = earaJson.ScatteredEnterprise;
            break;
        case "fqpk":
            temp = earaJson.IndustrialSolidWaste;
            break;
        case "gd":
            temp = earaJson.IndustrialHazardousWaste;
            break;
        case "sbc":
            temp = earaJson.StonePlateIndustry;
            break;
        case "gyfqqy":
            temp = earaJson.LicensedMine;
            break;
        case "fdlydy":
            temp = earaJson.NonRoadMobileSource;
            break;
        case "sghfc":
            temp = earaJson.ThreeSepticTank;
            break;
    }
    var xcq = Number($("#xcq").text());
    var lwq = Number($("#lwq").text());
    var lhs = Number($("#lhs").text());
    var zpx = Number($("#zpx").text());
    var njx = Number($("#njx").text());
    var yxx = Number($("#yxx").text());
    var zax = Number($("#zax").text());
    var dsx = Number($("#dsx").text());
    var phx = Number($("#phx").text());
    var ctx = Number($("#ctx").text());
    var hax = Number($("#hax").text());
    var tstzq = Number($("#tstzq").text());
    var zsjzzkfq = Number($("#zsjzzkfq").text());
    var glgjjkfq = Number($("#glgjjkfq").text());
    var zzgxjscykfq = Number($("#zzgxjscykfq").text());
    var cshqjjkfq = Number($("#cshqjjkfq").text());
    temp = Ams.isNoEmpty(temp) ? temp : new Array();
    for (var i = 0; i < temp.length; i++) {
        for (var j = 0; j < cityArray.length; j++) {
            if (temp[i][cityArray[j]] != null) {
                switch (cityArray[j]) {
                    case '长泰县':
                        isChoose ? ctx += temp[i][cityArray[j]] : ctx -= temp[i][cityArray[j]];
                        break;
                    case '龙海市':
                        isChoose ? lhs += temp[i][cityArray[j]] : lhs -= temp[i][cityArray[j]];
                        break;
                    case '平和县':
                        isChoose ? phx += temp[i][cityArray[j]] : phx -= temp[i][cityArray[j]];
                        break;
                    case '华安县':
                        isChoose ? hax += temp[i][cityArray[j]] : hax -= temp[i][cityArray[j]];
                        break;
                    case '漳浦县':
                        isChoose ? zpx += temp[i][cityArray[j]] : zpx -= temp[i][cityArray[j]];
                        break;
                    case '南靖县':
                        isChoose ? njx += temp[i][cityArray[j]] : njx -= temp[i][cityArray[j]];
                        break;
                    case '云霄县':
                        isChoose ? yxx += temp[i][cityArray[j]] : yxx -= temp[i][cityArray[j]];
                        break;
                    case '诏安县':
                        isChoose ? zax += temp[i][cityArray[j]] : zax -= temp[i][cityArray[j]];
                        break;
                    case '芗城区':
                        isChoose ? xcq += temp[i][cityArray[j]] : xcq -= temp[i][cityArray[j]];
                        break;
                    case '龙文区':
                        isChoose ? lwq += temp[i][cityArray[j]] : lwq -= temp[i][cityArray[j]];
                        break;
                    case '东山县':
                        isChoose ? dsx += temp[i][cityArray[j]] : dsx -= temp[i][cityArray[j]];
                        break;
                    case '台商投资区':
                        isChoose ? tstzq += temp[i][cityArray[j]] : tstzq -= temp[i][cityArray[j]];
                        break;
                    case '招商局漳州开发区':
                        isChoose ? zsjzzkfq += temp[i][cityArray[j]] : zsjzzkfq -= temp[i][cityArray[j]];
                        break;
                    case '常山华侨经济开发区':
                        isChoose ? cshqjjkfq += temp[i][cityArray[j]] : cshqjjkfq -= temp[i][cityArray[j]];
                        break;
                    case '漳州高新技术产业开发区':
                        isChoose ? zzgxjscykfq += temp[i][cityArray[j]] : zzgxjscykfq -= temp[i][cityArray[j]];
                        break;
                    case '古雷港经济开发区':
                        isChoose ? glgjjkfq += temp[i][cityArray[j]] : glgjjkfq -= temp[i][cityArray[j]];
                        break;
                }
            }
        }
    }

    $("#xcq").html(xcq);
    $("#lwq").html(lwq);
    $("#lhs").html(lhs);
    $("#zpx").html(zpx);
    $("#njx").html(njx);
    $("#yxx").html(yxx);
    $("#zax").html(zax);
    $("#dsx").html(dsx);
    $("#phx").html(phx);
    $("#ctx").html(ctx);
    $("#hax").html(hax);
    $("#tstzq").html(tstzq);
    $("#zsjzzkfq").html(zsjzzkfq);
    $("#cshqjjkfq").html(cshqjjkfq);
    $("#zzgxjscykfq").html(zzgxjscykfq);
    $("#glgjjkfq").html(glgjjkfq);
}

//点击地图区域,页面右侧相应高亮显示
function colorForTab(name) {
    var id
    $(".tableClass").each(function () {
        $(this).removeClass("select-part");
        if (Ams.isNoEmpty(name) && $(this).text().trim().indexOf(name) != -1) {

            $(this).addClass("select-part collapsed");

            id = $(this).find("span").eq(0).attr("id");

            // alert(name)
            // alert(this);
            areaClicChange = 1;
            areaClick(this, name, $(this).find("span").eq(0).attr("id"))
            //控制是由区域点击产生的事件
            // $(this).find("span").eq(0).attr("id").parent()
        }
    })

    // $(".soil-table-box").find(".personnel-parent").removeClass("collapsed");
    //
    // $(".soil-table-box").find(".personnel-children").hide();

    $("#" + id).parent().addClass("collapsed")
    $("#" + id).parent().next().show();
}

var pollutionMapNewPollution = {
    "wsclc": "WadingIndustrialEnterprise",
    "cgpk": "SeaSewageOutlet",
    "sk": "SeaIndustrySolidWaste",
    "gyfsqy": "VOCsEnterprise",
    "wxszzdz": "ElevatedSourceEnterprise",
    "xly": "ScatteredEnterprise",
    "fqpk": "IndustrialSolidWaste",
    "gd": "IndustrialHazardousWaste",
    "gyfqqy": "LicensedMine",
    "sbc": "StonePlateIndustry",
    "sghfc": "ThreeSepticTank",
    "fdlydy": "NonRoadMobileSource"
}
//污水处理厂对应涉水工业企业;常规排口对应海洋排污口;水库对应海洋固体废物;工业废气企业对应vocs企业;微型水质自动站对应高架源企业;小流域对应散乱污企业;废气排口->工业固废;工地->工业危险废物;工业废气企业->生态污染源企业;
var wryzlId = {
    "wsclc": "涉水工业企业",
    "cgpk": "海洋排污口",
    "sk": "海洋固体废物",
    "gyfsqy": "VOCs企业",
    "wxszzdz": "应高架源企业",
    "xly": "散乱污企业",
    "fqpk": "工业固废",
    "gd": "工业危险废物",
    "gyfqqy": "生态污染源企业",
    "sbc": "石板材行业",
    "sghfc": "三格化粪池",
    "fdlydy": "非道路移动源"
}
var pollutionMapData;

function pollutionDataPoint() {
    $.ajax({
        type: "post",
        url: "/env/pollution2/pollutionPointData",
        async: true,
        data: {polluteCode: $("span.ant-radio-button-checked input").val(), category: "3"},
        success: function (result) {
            countTR = 0;//突然污染
            countST = 0;//
            countPollutionNum = 0;//污染源总数
            countPollutionAIRNum = 0;//大气污染
            totalCount = 0;//总计污染源个数
            countHY = 0;
            var objId;
            pollutionMapData = result;
            initPollutionMap(pollutionMapData);
        },
        error: function () {
        },
        dataType: 'json'
    });
}

//==============================原先的污染源现在对应的是图标形式
var countTR = 0;//突然污染
var countST = 0;//
var countPollutionNum = 0;//污染源总数
var countPollutionAIRNum = 0;//大气污染
var totalCount = 0;//总计污染源个数
var countHY = 0;

function setPollutionData(tid, data) {
    var icon = getIconForPollution(tid);
    if (!Ams.isNoEmpty(data)) {
        data = new Array();
    }
    switch (tid) {
        case "wsclc":
            wsclcPoint = data;
            countPollutionNum += data.length;
            $("#wsclc").empty();
            $("#wsclc").append('<span><img src="' + icon + '"></span>涉水工业企业(' + data.length + ')');
            break;
        case "cgpk":
            cgpkPoint = data;
            countHY += data.length;
            $("#cgpk").empty();
            $("#cgpk").append('<span><img src="' + icon + '"></span>海洋排污口(' + data.length + ')');
            break;
        case "sk":
            skPoint = data;
            countHY += data.length;
            $("#sk").empty();
            $("#sk").append('<span><img src="' + icon + '"></span>涉海工业固废(' + data.length + ')');
            break;
        case "gyfsqy":
            gyfsqyPoint = data;
            countPollutionAIRNum += data.length;
            $("#gyfsqy").empty();
            $("#gyfsqy").append('<span><img src= "' + icon + '"></span>VOCs企业(' + data.length + ')');
            break;
        case "wxszzdz":
            wxszzdzPoint = data;
            countPollutionAIRNum += data.length;
            $("#wxszzdz").empty();
            $("#wxszzdz").append('<span><img src="' + icon + '"></span>高架源企业(' + data.length + ')');
            break;
        case "xly":
            xlyPoint = data;
            countPollutionAIRNum += data.length;
            $("#xly").empty();
            $("#xly").append('<span><img src="' + icon + '"></span>散乱污企业(' + data.length + ')');
            break;
        case "fqpk":
            fqpkPoint = data;
            countTR += data.length;
            $("#fqpk").empty();
            $("#fqpk").append('<span><img src="' + icon + '"></span>工业固废(' + data.length + ')');
            break;
        case "gd":
            gdPoint = data;
            countTR += data.length;
            $("#gd").empty();
            $("#gd").append('<span><img src="' + icon + '"></span>工业危险废物(' + data.length + ')');
            break;
        case "gyfqqy":
            gyfqqyPoint = data;
            countST += data.length;
            $("#gyfqqy").empty();
            $("#gyfqqy").append('<span><img src="' + icon + '"></span>持证矿山(' + data.length + ')');
            break;
        case"sbc":
            sbcPoint = data;
            countST += data.length;
            $("#sbc").empty();
            $("#sbc").append('<span><img src="' + icon + '"></span>石板材行业(' + data.length + ')');
            break;
        case"fdlydy":
            fdlydyPoint = data;
            countPollutionAIRNum += data.length;
            $("#fdlydy").empty();
            $("#fdlydy").append('<span><img src="' + icon + '"></span>非道路移动源(' + data.length + ')');
            break;
        case"sghfc":
            sghfcPoint = data;
            countTR += data.length;
            $("#sghfc").empty();
            $("#sghfc").append('<span><img src="' + icon + '"></span>三格化粪池(' + data.length + ')');
            break;
        default:
            break;
    }
    pointAboutPollution(tid);
    getTotalForTaglib();
}

function getTotalForTaglib() {
    $("#countPollution").html(countPollutionNum);//水污染总数
    $("#countPollutionARINum").html(countPollutionAIRNum);//空气污染总数
    $("#countTR").html(countTR);//空气污染总数
    $("#countST").html(countST);//土壤污染总数
    $("#countHY").html(countHY);//空气污染总数
    totalCount = countPollutionNum + countPollutionAIRNum + countTR + countST + countHY;
    $("#dateTime").text("截止" + Ams.dateFormat(new Date(), "yyyy年MM月dd日") + "共排查各类污染源企业" + totalCount + "个");
}

function getTotalForTaglib1() {
    $("#countPollution").html(countPollutionNum1);//水污染总数
    $("#countPollutionARINum").html(countPollutionAIRNum1);//空气污染总数
    $("#countTR").html(countTR1);//空气污染总数
    $("#countST").html(countST1);//土壤污染总数
    $("#countHY").html(countHY1);//空气污染总数
    totalCount1 = countPollutionNum1 + countPollutionAIRNum1 + countTR1 + countST1 + countHY1;
    $("#dateTime").text("截止" + Ams.dateFormat(new Date(), "yyyy年MM月dd日") + "共排查各类污染源企业" + totalCount1 + "个");
}

function getIconForPollution(tid) {//获取污染源图标
    var icon;
    switch (tid) {
        case "wsclc":
            icon = "/static/images/ssgyqy-icon.png";
            break;
        case "cgpk":
            icon = "/static/images/hypk.png";
            break;
        case"sk":
            icon = "/static/images/hygygtfw-icon.png";
            break;
        case "gyfsqy":
            icon = "/static/images/VOCs-icon.png";
            break;
        case"wxszzdz":
            icon = "/static/images/gjyqy-icon.png";
            break;
        case"xly":
            icon = "/static/images/slwqy-icon.png";
            break;
        case"fqpk":
            icon = "/static/images/gyfq-icon.png";
            break;
        case"gd":
            icon = "/static/images/gywxfw-icon.png";
            break;
        case"gyfqqy":
            icon = "/static/images/stwry-icon.png";
            break;
        case"sbc":
            icon = "/static/images/ybgy-icon.png";
            break;
        case"fdlydy":
            icon = "/static/images/fdlydy-icon.png";
            break;
        case"sghfc":
            icon = "/static/images/sghfc-icon.png";
            break;
    }
    return icon;
}

/**
 * 短信发送
 * @param obj
 */
function sendMsg(person, phone) {
    Ams.sendMassageToUser(phone, person);
}

function formatPhoneAndName(str) {
    var newName = "";
    var newPhone = "";
    var reg = /[\u4e00-\u9fa5]/g;
    var newPhoneAndName = new Array();
    if (Ams.isNoEmpty(str)) {
        var strs = str.split(',');
        for (var i = 0; i < strs.length; i++) {
            if (i < strs.length - 1) {
                newName += Ams.isNoEmpty(strs[i].match(reg)) ? strs[i].match(reg).join('')+ "、" : '';
                if (Ams.isNoEmpty(strs[i].replace(/[^0-9]/ig, ""))) newPhone += strs[i].replace(/[^0-9]/ig, "") + "、";
            } else {
                newName += Ams.isNoEmpty(strs[i].match(reg)) ? strs[i].match(reg).join('') : '';
                newPhone += strs[i].replace(/[^0-9]/ig, "");
            }
        }
    }
    newPhoneAndName.push(newName);
    newPhoneAndName.push(newPhone);
    return newPhoneAndName;
}


/**
 * 保存
 * @type {string}
 */
function saveActach() {
    $.messager.progress({title: '提示', msg: '附件保存中......', text: ''});
    $('#source').val('pollutionMapInfo');
    $('#mcid').val(obj.mc);
    $('#jdid').val(obj.jd);
    $('#wdid').val(obj.wd);
    $('#fm').form('submit', {
        url: Ams.ctxPath + '/env/pollution2/save',
        iframe: false,
        onSubmit: function () {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close');	// hide progress bar while the form is invalid
            }
            return isValid;
        },
        success: function (result) {
            var result = JSON.parse(result);
            if (result.type == 'E') {
                layer.msg(result.message);
            } else {
                $('#uploadDlg').dialog('close');
                layer.msg('操作成功！');
                findTimelineData();
            }
            $('#fm').form('clear');
            $.messager.progress('close');
        }
    });
}

$('#picFile').filebox({
    onChange: function (newValue, oldValue) {
        var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
        var filename = newValue.substring(0, newValue.lastIndexOf('.'));
        $('#picnameid').textbox('setValue', filename);
    }
});

function findTimelineData() {
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/env/pollution2/findTimelineData',
        data: {
            'mc': obj.mc,
            'jd': obj.jd,
            'wd': obj.wd,
            'source':'pollutionMapInfo'

        },
        beforeSend: function () {
            loadIndex = layer.load(1, {
                shade: [0.1, '#fff']
            });
        },
        complete: function () {
            layer.close(loadIndex);
        },
        success: function (result) {
            var list = result.allTimeLineData;
            var html = '';
            var pic;
            var suffix;
            var pic;
            var img;
            html += '<div class="time-axis-container">';
            html += '<ul>';
            for (var obj in list) {
                // html += '<div class="time-axis-head">';
                // html += '<span>上传时间：'+Ams.timeDateFormat(list[obj].createDate)+'</span>';
                // html += '<a class="delete-tag" onclick="deleteActach(\''+list[obj].uuid+'\',\''+list[obj].picture+'\')"> 刪除</a>';
                // // html += '<a class="title-link-tag" style="line-height: 22px;" onclick="$(\'#uploadDlg\').dialog(\'open\').dialog(\'center\').dialog(\'setTitle\', \'上传附件\')"> 上传附件</a>';
                // html += '</div>';
                // html += '<div class="time-axis-content">';
                // html += '';
                // html += '<div class="img-box">';
                // html += '<img style="cursor: pointer" title="点击放大" class="bigImg" onclick="showBigImg(\''+list[obj].picture+'\')" src="/environment/waterAttachment/download/' + list[obj].picture +'/3" width="100%;">';
                // html += '</div>';
                // html += '</div>';
                // html += '<p>描述：' + Ams.formatNUll(list[obj].describe) + '</p>';
                // html += '<hr/>';


                html += '<li class="item highlight">';
                html += '<div class="time-axis-part">';
                html += '<div class="time-axis-head">';
                html += '<span>上传时间：' + Ams.timeDateFormat(list[obj].createDate) + '</span>';
                html += '<a class="delete-tag" onclick="deleteActach(\'' + list[obj].uuid + '\',\'' + list[obj].picture + '\')"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>';
                html += '</div>';
                html += '<div class="time-axis-content">';
                html += '<div class="img-box">';

                pic = list[obj].picname;
                suffix = pic == null ? '' : pic.substring(pic.lastIndexOf('.') + 1, pic.length).toLowerCase();
                if (suffix == 'mp4' || suffix == 'mp3') {
                    img = '<img style="cursor: pointer" title="点击播放" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/VIDEO.jpg" width="100%;">'
                } else if (suffix == 'pdf') {
                    img = '<img style="cursor: pointer" title="点击查看" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/PDF.jpg" width="100%;">'
                } else if (suffix == 'rar' || suffix == 'zip') {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/rar.png" width="100%;">'
                } else if (suffix == 'doc' || suffix == 'docx') {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/WORD.jpg" width="100%;">'
                } else if (suffix == 'xls' || suffix == 'xlsx') {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/excel.jpg" width="100%;">'
                } else if (suffix == 'bmp' || suffix == 'png' || suffix == 'gif' || suffix == 'jpg') {
                    img = '<img style="cursor: pointer" title="点击查看" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/environment/waterAttachment/download/' + list[obj].picture + '/3" width="100%;">';
                } else {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/other.jpg" width="100%;">'
                }
                html += img;
                html += '</div>';
                html += '</div>';
                html += '<p>描述：</p>';
                html += '<p>' + Ams.formatNUll(list[obj].describe) + '</p>';
                html += '</div>';
                html += '</li>';
            }
            html += '</ul>';
            html += '</div>';

            $('#timeData').html(html);
            if (result.type == 'E') {
                layer.msg(result.message);
            }
        },
        dataType: 'json'
    });
}

/**
 * 删除
 * @type {string}
 */
function deleteActach(uuid, picid) {
    $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
        if (r) {
            $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
            var loadIndex = '';
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/env/pollution2/deleteActach',
                data: {
                    'uuid': uuid,
                    "picture": picid
                },
                beforeSend: function () {
                    loadIndex = layer.load(1, {
                        shade: [0.1, '#fff']
                    });
                },
                complete: function () {
                    layer.close(loadIndex);
                },
                success: function (result) {
                    $.messager.progress('close');
                    if (result.type == 'E') {
                        layer.msg(result.message);
                    } else {
                        findTimelineData();
                        layer.msg('操作成功');
                    }
                },
                error: function () {
                    $.messager.progress('close');
                    $.messager.show({
                        title: '错误',
                        msg: '删除失败！'
                    });
                },
                dataType: 'json'
            });
        }
    });
}

//图片放大
function showBigImg(idthis, picid, picname) {
    picname = picname.substring(picname.lastIndexOf('.') + 1, picname.length);
    if (picname == 'mp4') {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        $('#video').attr("src", Ams.ctxPath + '/debrief/StandingBook/browse/' + picid);
    } else {
        window.open('/debrief/StandingBook/browse/' + picid);
    }
    // imgShow("#outerdiv", "#innerdiv", "#bigimg", idthis);

}

// 播放
function play(mongoid) {
    $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
    //$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
    $('#video').attr("src", Ams.ctxPath + '/debrief/StandingBook/browse/' + mongoid);
}

var myVideo = document.getElementById("video");//获取video对象
// 关闭视频后关闭声音
$("#videoDlg").dialog({
    onClose: function () {
        myVideo.pause();
    }
});

function imgShow(outerdiv, innerdiv, bigimg, _this) {
    var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
    $(bigimg).attr("src", src);//设置#bigimg元素的src属性

    /*获取当前点击图片的真实大小，并显示弹出层及大图*/
    $("<img/>").attr("src", src).load(function () {
        var windowW = $(window).width();//获取当前窗口宽度
        var windowH = $(window).height();//获取当前窗口高度
        var realWidth = this.width;//获取图片真实宽度
        var realHeight = this.height;//获取图片真实高度
        var imgWidth, imgHeight;
        var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

        if (realHeight > windowH * scale) {//判断图片高度
            imgHeight = windowH * scale;//如大于窗口高度，图片高度进行缩放
            imgWidth = imgHeight / realHeight * realWidth;//等比例缩放宽度
            if (imgWidth > windowW * scale) {//如宽度扔大于窗口宽度
                imgWidth = windowW * scale;//再对宽度进行缩放
            }
        } else if (realWidth > windowW * scale) {//如图片高度合适，判断图片宽度
            imgWidth = windowW * scale;//如大于窗口宽度，图片宽度进行缩放
            imgHeight = imgWidth / realWidth * realHeight;//等比例缩放高度
        } else {//如果图片真实高度和宽度都符合要求，高宽不变
            imgWidth = realWidth;
            imgHeight = realHeight;
        }
        $(bigimg).css("width", imgWidth);//以最终的宽度对图片缩放

        var w = (windowW - imgWidth) / 2;//计算图片与窗口左边距
        var h = (windowH - imgHeight) / 2;//计算图片与窗口上边距
        $(innerdiv).css({"top": h, "left": w});//设置#innerdiv的top和left属性
        $(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg
    });

    $(outerdiv).click(function () {//再次点击淡出消失弹出层
        $(this).fadeOut("fast");
    })
}

function scroll() {
    $(document).on("mousewheel DOMMouseScroll", function (e) {
        var delta = (e.originalEvent.wheelDelta && (e.originalEvent.wheelDelta > 0 ? 1 : -1)) ||
            //chrome & ie
            (e.originalEvent.detail && (e.originalEvent.detail > 0 ? -1 : 1));
// firefox   
        var img = $("#bigimg");//获取操作元素
        if (delta > 0) {//放大
// 向上滚
            var oWidth = img.width();//取得图片的实际宽度
            var oHeight = img.height(); //取得图片的实际高度
            img.width(oWidth + 50);
            img.height(oHeight + 50 / oWidth * oHeight);

        } else if (delta < 0) {//缩小
//向下滚
            var oWidth = img.width(); //取得图片的实际宽度
            var oHeight = img.height(); //取得图片的实际高度
            if (img.width() > 100 || img.height() > 75) {//判断如果图片缩小到原图大小就停止缩小(100和75分别为原图的宽高)
                img.width(oWidth - 50);
                img.height(oHeight - 50 / oWidth * oHeight);
            }
        }
    });
}

var params = {
    zoomVal: 1,
    left: 0,
    top: 0,
    currentX: 0,
    currentY: 0,
    flag: false
};

//图片缩放
function bbimg(o) {
    var o = o.getElementsByTagName("img")[0];
    params.zoomVal += event.wheelDelta / 1200;
    if (params.zoomVal >= 0.2) {
        o.style.transform = "scale(" + params.zoomVal + ")";
    } else {
        params.zoomVal = 0.2;
        o.style.transform = "scale(" + params.zoomVal + ")";
        return false;
    }
}

//获取相关CSS属性
var getCss = function (o, key) {
    return o.currentStyle ? o.currentStyle[key] : document.defaultView.getComputedStyle(o, false)[key];
};
//拖拽的实现
var startDrag = function (bar, target, callback) {
    if (getCss(target, "left") !== "auto") {
        params.left = getCss(target, "left");
    }
    if (getCss(target, "top") !== "auto") {
        params.top = getCss(target, "top");
    }
    //o是移动对象
    bar.onmousedown = function (event) {
        params.flag = true;
        if (!event) {
            event = window.event;
            //防止IE文字选中
            bar.onselectstart = function () {
                return false;
            }
        }
        var e = event;
        params.currentX = e.clientX;
        params.currentY = e.clientY;
    };
    document.onmouseup = function () {
        params.flag = false;
        if (getCss(target, "left") !== "auto") {
            params.left = getCss(target, "left");
        }
        if (getCss(target, "top") !== "auto") {
            params.top = getCss(target, "top");
        }
    };
    document.onmousemove = function (event) {
        var e = event ? event : window.event;

        if (params.flag) {
            var nowX = e.clientX, nowY = e.clientY;
            var disX = nowX - params.currentX, disY = nowY - params.currentY;
            target.style.left = parseInt(params.left) + disX + "px";
            target.style.top = parseInt(params.top) + disY + "px";

            if (typeof callback == "function") {
                callback((parseInt(params.left) || 0) + disX, (parseInt(params.top) || 0) + disY);
            }

            if (event.preventDefault) {
                event.preventDefault();
            }
            return false;
        }


    }
};
startDrag(document.getElementById("bigimg"), document.getElementById("bigimg"))

//========================显示数据中的标签需要做的变量改变
var countTR1 = 0;//突然污染
var countST1 = 0;//
var countPollutionNum1 = 0;//污染源总数
var countPollutionAIRNum1 = 0;//大气污染
var totalCount1 = 0;//总计污染源个数
var countHY1 = 0;

function setPollutionData1(tid, total, target) {
    var icon = getIconForPollution(tid);
    switch (tid) {
        case "wsclc":
            target ? countPollutionNum1 += total : countPollutionNum1 -= total;
            $("#wsclc").empty();
            $("#wsclc").append('<span><img src="' + icon + '"></span>涉水工业企业(' + total + ')');
            break;
        case "cgpk":
            target ? countHY1 += total : countHY1 += total;
            $("#cgpk").empty();
            $("#cgpk").append('<span><img src="' + icon + '"></span>海洋排污口(' + total + ')');
            break;
        case "sk":
            target ? countHY1 += total : countHY1 -= total;
            $("#sk").empty();
            $("#sk").append('<span><img src="' + icon + '"></span>涉海工业固废(' + total + ')');
            break;
        case "gyfsqy":
            target ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            $("#gyfsqy").empty();
            $("#gyfsqy").append('<span><img src= "' + icon + '"></span>VOCs企业(' + total + ')');
            break;
        case "wxszzdz":
            target ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            $("#wxszzdz").empty();
            $("#wxszzdz").append('<span><img src="' + icon + '"></span>高架源企业(' + total + ')');
            break;
        case "xly":
            target ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            $("#xly").empty();
            $("#xly").append('<span><img src="' + icon + '"></span>散乱污企业(' + total + ')');
            break;
        case "fqpk":
            target ? countTR1 += total : countTR1 -= total;
            $("#fqpk").empty();
            $("#fqpk").append('<span><img src="' + icon + '"></span>工业固废(' + total + ')');
            break;
        case "gd":
            target ? countTR1 += total : countTR1 -= total;
            $("#gd").empty();
            $("#gd").append('<span><img src="' + icon + '"></span>工业危险废物(' + total + ')');
            break;
        case "gyfqqy":
            target ? countST1 += total : countST1 -= total;
            $("#gyfqqy").empty();
            $("#gyfqqy").append('<span><img src="' + icon + '"></span>持证矿山(' + total + ')');
            break;
        case"sbc":
            target ? countST1 += total : countST1 -= total;
            $("#sbc").empty();
            $("#sbc").append('<span><img src="' + icon + '"></span>石板材行业(' + total + ')');
            break
        case"sghfc":
            target ? countTR1 += total : countTR1 -= total;
            $("#sghfc").empty();
            $("#sghfc").append('<span><img src="' + icon + '"></span>三格化粪池(' + total + ')');
            break;
        case"fdlydy":
            target ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            $("#fdlydy").empty();
            $("#fdlydy").append('<span><img src="' + icon + '"></span>非道路移动源(' + total + ')');
            break;
        default:
            break;
    }
    getTotalForTaglib1();
}

/*
*tid标签id total数字改变flag增加true减少false;flag1是否是地图点击
 */
function getNumberChanger(tid, total, flag, flag1) {
    switch (tid) {
        case "wsclc":
            if (flag1) {
                flag ? countPollutionNum += total : countPollutionNum -= total;
            } else {
                flag ? countPollutionNum1 += total : countPollutionNum1 -= total;
            }
            break;
        case "cgpk":
            if (flag1) {
                flag ? countHY += total : countHY -= total;
            } else {
                flag ? countHY1 += total : countHY1 -= total;
            }
            break;
        case "sk":
            if (flag1) {
                flag ? countHY += total : countHY -= total;
            } else {
                flag ? countHY1 += total : countHY1 -= total;
            }
            break;
        case "gyfsqy":
            if (flag1) {
                flag ? countPollutionAIRNum += total : countPollutionAIRNum -= total;
            } else {
                flag ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            }
            break;
        case "wxszzdz":
            if (flag1) {
                flag ? countPollutionAIRNum += total : countPollutionAIRNum -= total;
            } else {
                flag ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            }
            break;
        case "xly":
            if (flag1) {
                flag ? countPollutionAIRNum += total : countPollutionAIRNum -= total;
            } else {
                flag ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            }
            break;
        case "fqpk":
            if (flag1) {
                flag ? countTR += total : countTR -= total;
            } else {
                flag ? countTR1 += total : countTR1 -= total;
            }
            break;
        case "gd":
            if (flag1) {
                flag ? countTR += total : countTR -= total;
            } else {
                flag ? countTR1 += total : countTR1 -= total;
            }
            break;
        case "gyfqqy":
            if (flag1) {
                flag ? countST += total : countST -= total;
            } else {
                flag ? countST1 += total : countST1 -= total;
            }
            break;
        case"sbc":
            if (flag1) {
                flag ? countST += total : countST -= total;
            } else {
                flag ? countST1 += total : countST1 -= total;
            }
            break;
        case"fdlydy":
            if (flag1) {
                flag ? countPollutionAIRNum += total : countPollutionAIRNum -= total;
            } else {
                flag ? countPollutionAIRNum1 += total : countPollutionAIRNum1 -= total;
            }
            break;
        case"sghfc":
            if (flag1) {
                flag ? countTR += total : countTR -= total;
            } else {
                flag ? countTR1 += total : countTR1 -= total;
            }
            break;
        default:
            break;
    }
    if (flag1) {
        getTotalForTaglib();
    } else {
        getTotalForTaglib1();
    }
}

function initPollutionMap(result) {
    $('.no-choice').each(function () {//获取选中的污染源点击事件
        if ($(this).hasClass("choiced")) {
            objId = $(this).attr("id")
            setPollutionData(objId, result[pollutionMapNewPollution[objId]])
        }
    })
}

$(document).ready(function () {
    words();
});

//清除所有点位然后铺入一个点位
var  oneMapPoint=new Array();//一个点位信息
function clearAllMapPoint(lng, lat, name, targetIcon, tid, data) {
    for (var i = 0; i < allMapPoint.length; i++) {
        map.removeOverlay(allMapPoint[i]);
    }
    if(oneMapPoint.length==1){
        map.removeOverlay(oneMapPoint[0]);
    }
    var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
        icon: targetIcon,
        map: map,
        title: name
    });
    map.addOverlay(tempMarker);
    addCaseClickEvent(tempMarker, data);
    oneMapPoint[0]=tempMarker;
}