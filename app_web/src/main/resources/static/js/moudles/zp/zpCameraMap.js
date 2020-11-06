var myMakeMark = null;//创建标注点
var geoc = new fjzx.map.Geocoder();
var geoc = null;
var clickPoint;//鼠标点击经纬度
var clickAddress="";//鼠标点击地址
var excludeSign = []; //不显示的标志物 id
var map;
var markerMap = new HashMap();
var dataMap = new HashMap();
var makerDialogDivMap = new HashMap(); //用来保存显示框
var nowAnimationId=null;   //当前动画的id
var defaultLongitude;
var defaultLatitude;
var showImageId = null; // 保存显示的图片
var cameraForDlg = null; //弹窗视频预览播放器
var cameraForDlgTk = null;

//==================污染源企业 Start====================
var longitude = "117.76264335320418";
var latitude = "24.329671575212295";
var body_w = $('body').width();
var zoomValue = 9.4;
if (body_w <= 1366) {
    zoomValue = 8.5
}

var map = initMap({
    target: "mapDiv",
    center: [parseFloat(longitude), parseFloat(latitude)],
    layers: fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
    zoom: zoomValue,
    minZoom: zoomValue,
    maxZoom: 23
});

//加载漳浦县区域
setZpxArea();
//加载大气站点
creatMarker("0","aqi");

//地图初始化
function initMap(opt_options){
    var options = opt_options || {};

    var currentLayerGroup = fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP");
    var map = new fjzx.map.Map({
        center: options.center ? options.center : [117.01, 25.12],
        zoom: options.zoom ? options.zoom : 11,
        minZoom: options.minZoom ? options.minZoom : 9,
        maxZoom: options.maxZoom ? options.maxZoom : 18,
        layers: options.layers ? options.layers : [currentLayerGroup],
        target: options.target ? options.target : 'allmap'
    });
    //map.enableScrollWheelZoom(); //启用滚轮放大缩小
    defaultLongitude = options.center ? options.center[0] : 117.01;
    defaultLatitude = options.center ? options.center[1] : 25.12;
    map.setCenter(new fjzx.map.Point(defaultLongitude,defaultLatitude)); // 初始化地图,设置中心点坐标和地图级别。
    //map.addEventListener("click",mapClickEvent);

    //地图缩放控件
    var zoomSlider = new ol.control.ZoomSlider();
    map.addControl(zoomSlider);

    return map;
}

//加载页面数据
initZpPollutionData();
function initZpPollutionData(){
    //加载企业列表
    loadZpPollutionEnterpriseList();

    //初始化企业搜索框
    $('#searchPollutionEnterprise').searchbox({
        searcher: function(value){
            loadZpPollutionEnterpriseList(value);
        }
    });

    //加载地图标注点
    loadZpPollutionEnterpriseAllMarker();
}

//点击marker 动画
function animalMarker(markerId,x,y) {
    var myMarker = markerMap.get(markerId);
    var	 cycleObject  =  myMarker.cycleAnimal(x,y);
    cycleObject.startAnimal();
    cycleObject.setCycleTime(5);
}


function loadZpPollutionEnterpriseList(name){
    var allNum = 0 ;
    var name = typeof(name)=='undefined' || name == null ? '' : $('input#searchPollutionEnterprise').val();
    //矿山
    var result2 = '<table id="zpPollutionLicensedMine" class="easyui-datagrid" style="width:auto;height:250px;"></table>';
    $('#mineList').empty();
    $('#mineList').append(result2);
    $.parser.parse($("#mineList"));//使用局部渲染

    $('#zpPollutionLicensedMine').datagrid({
        url: Ams.ctxPath + '/zphb/enter/pollutionLicensedMine/findPage',
        columns: [[
            {field: 'MC', title: '名称', width: '302'}
        ]],
        onSelect: function (rowIndex, rowData) {
            var markerId = 'MINE_'+rowData.ID
            zpPollutionEnterpriseListClick(markerId);
            //点击marker 动画
            animalMarker(markerId);

        },
        pageList: [10],
        rownumbers: true,
        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true, pageSize: 10,
        nowrap: false,
        fitColumns:true,
        onLoadSuccess:function(data){
            $('.mineListContainer').find('span.total').text(data.total);
        }
    });
    $('#zpPollutionLicensedMine').datagrid('getPager').pagination({displayMsg:''});

    //养殖场
    var result3 = '<table id="zpfarmList" class="easyui-datagrid" style="width:auto;height:250px;"></table>';
    $('#farmList').empty();
    $('#farmList').append(result3);
    $.parser.parse($("#farmList"));//使用局部渲染
    $('#zpfarmList').datagrid({
        url: Ams.ctxPath + '/zphb/enter/pollutionRaisingPig/findPage',
        columns: [[
            {field: 'YZC', title: '名称', width: '302'}
        ]],
        pageList: [10],
        rownumbers: true,
        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true, pageSize: 10,
        nowrap: false,
        fitColumns:true,
        onSelect: function (rowIndex, rowData) {
            var markerId = 'FARM_'+rowData.ID
            zpPollutionEnterpriseListClick(markerId);
            //点击marker 动画
            animalMarker(markerId);
        },
        onLoadSuccess:function(data){
            $('.farmListContainer').find('span.total').text(data.total);
        }
    });

    //垃圾中转站
    var result4 = '<table id="zprubbishList" class="easyui-datagrid" style="width:auto;height:250px;"></table>';
    $('#rubbishList').empty();
    $('#rubbishList').append(result4);
    $.parser.parse($("#rubbishList"));//使用局部渲染
    $('#zprubbishList').datagrid({
        url: Ams.ctxPath + '/zphb/enter/pollutionTransferStation/findPage',
        columns: [[
            {field: 'QYMC', title: '名称', width: '302'}
        ]],
        rownumbers: true,
        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true, pageSize: 10,
        nowrap: false,
        fitColumns:true,
        pageList: [10],
        onSelect: function (rowIndex, rowData) {
            var markerId = 'TRANSFER_'+rowData.ID
            zpPollutionEnterpriseListClick(markerId);
            //点击marker 动画
            animalMarker(markerId);
        },
        onLoadSuccess:function(data){
            $('.rubbishListContainer').find('span.total').text(data.total);
        }
    });

    //大气污染
    var result5 = '<table id="zpDqList" class="easyui-datagrid" style="width:auto;height:250px;"></table>';
    $('#DqList').empty();
    $('#DqList').append(result5);
    $.parser.parse($("#DqList"));//使用局部渲染
    $('#zpDqList').datagrid({
        url: Ams.ctxPath + '/zphb/cameraMap/getPolluteList',
        columns: [[
            {field: 'name', title: '名称', width: '302'}
        ]],
        queryParams:{
            lx:'大气',
            qx:'漳浦县',
            mc:""
        },
        rownumbers: true,
        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true, pageSize: 10,
        nowrap: false,
        fitColumns:true,
        pageList: [10],
        onSelect: function (rowIndex, rowData) {
            var markerId = 'AIR_'+rowData.uuid
            zpPollutionEnterpriseListClick(markerId);
            //点击marker 动画
            animalMarker(markerId);
        },
        onLoadSuccess:function(data){
            $('.DqListContainer').find('span.total').text(data.total);
        }
    });


    //水污染源
    var result6 = '<table id="zpSList" class="easyui-datagrid" style="width:auto;height:250px;"></table>';
    $('#SList').empty();
    $('#SList').append(result6);
    $.parser.parse($("#SList"));//使用局部渲染
    $('#zpSList').datagrid({
        url: Ams.ctxPath + '/zphb/cameraMap/getPolluteList',
        columns: [[
            {field: 'name', title: '名称', width: '302'}
        ]],
        queryParams:{
            lx:'水',
            qx:'漳浦县',
            mc:""
        },
        rownumbers: true,
        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true, pageSize: 10,
        nowrap: false,
        fitColumns:true,
        pageList: [10],
        onSelect: function (rowIndex, rowData) {
            var markerId = 'WATER_'+rowData.uuid
            zpPollutionEnterpriseListClick(markerId);
            //点击marker 动画
            animalMarker(markerId);
        },
        onLoadSuccess:function(data){
            $('.SListContainer').find('span.total').text(data.total);
        }
    });
}



/**
 * 污染源企业列表点击事件
 * @param markerId
 */
function zpPollutionEnterpriseListClick(markerId){
    var type = markerId.split('_')[0];
    var id = markerId.split('_')[1];

    var pollutionMarker = markerMap.get(markerId);
    if(pollutionMarker == null){
        layer.msg('该企业暂无地图标注点！');
        return;
    }

    var point = pollutionMarker.getMarkerPoint();
    map.setCenterAndZoom(point,15);
    //指定漳浦龙口热电厂
    if(showPointEnterprise(type,markerId)){
        return ;
    }
    if(type=='AIR' || type=='WATER'){
        getZpPollutionEnterpriseInfoForAirWater(type, id, function(res){
            showDetailForAirWater(res);
        });
    }else{
        getZpPollutionEnterpriseInfo(type, id, function(res){
            showDetail(res)
        });
    }
}
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + "年" + month + "月" + strDate+"日";
    return currentdate;
}

//datagrid加载触发事件
function dataRelaod(dgid, url){
    $('#'+dgid).datagrid({
        url: url,
        columns: [[
            {field: 'name', title: '名称', width: '302'}
        ]],
        rownumbers: true,
        singleSelect: true,
        striped: false,
        autoRowHeight: false,
        pagination: true,
        pageSize: 10,
        fitColumns:true,
        nowrap: false
    });
}


function loadZpPollutionEnterpriseAllMarker(name){
    var name = typeof(name)=='undefined' || name == null ? '' : name;
    //矿山
    getZpPollutionLicensedMineMarker(name, function(res){
        var mineMarkerList =  res;
        $.each(mineMarkerList,function(index,value){
            var mine = value;
            mine.type = 'MINE';
            mine.typeName = '矿山';
            mine.icon = Ams.ctxPath+'/static/images/zhangpu/mine.png';
            mine.markerId = mine.type+'_'+mine.ID;

            var type = mine.type;
            var markerId = mine.markerId;
            var recordName = mine.YZC;
            var longitude = mine.JD;
            var latitude = mine.WD;

            showPoint(type, markerId, recordName, longitude,latitude,mine)
        });
    });
    //养殖场
    getZpPollutionRaisingPigMarker(name, function(res){
        var farmMarkerList = res;
        $.each(farmMarkerList,function(index,value){
            var farm = value;
            farm.type = 'FARM';
            farm.typeName = '养殖场';
            farm.icon = Ams.ctxPath+'/static/images/zhangpu/farm.png';
            farm.markerId = farm.type+'_'+farm.ID;

            var type = farm.type;
            var markerId = farm.markerId;
            var recordName = farm.YZC;
            var longitude = farm.JD;
            var latitude = farm.WD;

            showPoint(type, markerId, recordName, longitude,latitude,farm)
        });
    });
    //垃圾中转站
    getZpPollutionTransferStationMarker(name, function(res){
        var transferStationMarkerList = res;
        $.each(transferStationMarkerList,function(index,value){
            var transferStation = value;
            transferStation.type = 'TRANSFER';
            transferStation.typeName = '垃圾中转站';
            transferStation.icon = Ams.ctxPath+'/static/images/zhangpu/transfer.png';
            transferStation.markerId = transferStation.type+'_'+transferStation.ID;

            var type = transferStation.type;
            var markerId = transferStation.markerId;
            var recordName = transferStation.YZC;
            var longitude = transferStation.JD;
            var latitude = transferStation.WD;

            showPoint(type, markerId, recordName, longitude,latitude,transferStation)
        });
    });

    //大气
    getZpPollutionSourceMarker('大气',name,function(res){
        var airMarkerList = res;
        $.each(airMarkerList,function(index,value){
            var airMarker = value;
            airMarker.type = 'AIR';
            airMarker.typeName = '大气污染源';
            airMarker.icon = Ams.ctxPath+'/static/images/slwqy-icon.png';
            airMarker.markerId = airMarker.type+'_'+airMarker.uuid;

            var type = airMarker.type;
            var markerId = airMarker.markerId;
            var recordName = airMarker.mc;
            var longitude = airMarker.jd;
            var latitude = airMarker.wd;
            dataMap.put(markerId, airMarker);
            showPoint(type, markerId, recordName, longitude,latitude,airMarker)
        });
    });
    getZpPollutionSourceMarker('水',name,function(res){
        var waterMarkerList = res;
        $.each(waterMarkerList,function(index,value){
            var waterMarker = value;
            waterMarker.type = 'WATER';
            waterMarker.typeName = '水污染源';
            waterMarker.icon = Ams.ctxPath+'/static/images/ssgyqy-icon.png';
            waterMarker.markerId = waterMarker.type+'_'+waterMarker.uuid;

            var type = waterMarker.type;
            var markerId = waterMarker.markerId;
            var recordName = waterMarker.mc;
            var longitude = waterMarker.jd;
            var latitude = waterMarker.wd;
            dataMap.put(markerId, waterMarker);
            showPoint(type, markerId, recordName, longitude,latitude,waterMarker)
        });
    });
}


/**
 * 获取所有矿山名称及经纬度接口
 * @param name
 * @param successCallback
 */
function getZpPollutionLicensedMineMarker(name, successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionLicensedMine/findList',
        dataType: 'json',
        data: {'name': name},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}

/**
 * 获取所有养殖场名称及经纬度接口
 * @param name
 * @param successCallback
 */
function getZpPollutionRaisingPigMarker(name, successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionRaisingPig/findList',
        dataType: 'json',
        data: {'name': name},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}


/**
 * 获取所有垃圾中转站名称及经纬度接口
 * @param name
 * @param successCallback
 */
function getZpPollutionTransferStationMarker(name, successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionTransferStation/findList',
        dataType: 'json',
        data: {'name': name},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}


/**
 * 获取所有大气污染源、水污染源名称及经纬度接口
 * @param name
 * @param successCallback
 */
function getZpPollutionSourceMarker(type,name, successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/cameraMap/getPolluteAll',
        dataType: 'json',
        data: {'lx':type,'qx':'漳浦县'},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        },
        error: function(res){
            console.log(res);
        }
    });
}

//获取矿山总数
function getZpPollutionLicensedMineTotal(successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionLicensedMine/findTotal',
        dataType: 'json',
        //data: {'search': search, 'pageNo': page, 'pageSize': pageSize},
        data: {},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}
//获取养殖场总数
function getZpPollutionRaisingPigTotal(successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionRaisingPig/findTotal',
        dataType: 'json',
        //data: {'search': search, 'pageNo': page, 'pageSize': pageSize},
        data: {},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}

//获取矿山列表
function getZpPollutionLicensedMineList(name,page, pageSize, successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionLicensedMine/findPage',
        dataType: 'json',
        data: {'name': name, 'pageNo': page, 'pageSize': pageSize},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}
//获取养猪场列表
function getZpPollutionRaisingPigList(name,page, pageSize, successCallback){
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/enter/pollutionRaisingPig/findPage',
        dataType: 'json',
        data: {'name': name, 'pageNo': page, 'pageSize': pageSize},
        success: function (res) {
            if(typeof successCallback) successCallback(res);
        }
    });
}

//根据类型和id 获取相应污染源企业信息
function getZpPollutionEnterpriseInfo(type, id, successCallback){
    type = type.toUpperCase();
    if(type == 'MINE'){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/zphb/enter/pollutionLicensedMine/get',
            dataType: 'json',
            data: {'id': id},
            success: function (res) {
                var mineDataObj = {}
                if(res.length>0){
                    var mine = res[0];
                    mineDataObj = {
                        CZWT:  mine.CZWT,   //存在问题
                        DZ:  mine.DZ,       //地址
                        ID:  mine.ID,       //ID
                        JD:  mine.JD,       //经度
                        WD:  mine.WD,       //纬度
                        MC:  mine.MC,       //名称
                        XZ:  mine.XZ,       //乡镇
                        WRYLX:  mine.WRYLX, //污染源类型
                        WRYZL:  mine.WRYZL, //污染源种类
                        ZGCS:  mine.ZGCS,   //整改措施
                        ZLXM:  mine.ZLXM,   //治理项目
                        BZ:  mine.BZ,       //备注
                        EP_CODE: mine.EP_CODE,
                        CHANNEL_IDS: mine.CHANNEL_IDS,
                        SEQNO: mine.SEQNO,

                        name: mine.MC,
                        address: mine.DZ,
                        longitude: mine.JD,
                        latitude: mine.WD,
                        township: mine.XZ
                    };

                }
                if(typeof successCallback) successCallback(mineDataObj);
            }
        });
    }else if(type == 'FARM'){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/zphb/enter/pollutionRaisingPig/get',
            dataType: 'json',
            data: {'id': id},
            success: function (res) {
                var farmDataObj = {}
                if(res.length>0) {
                    var farm = res[0];
                    farmDataObj = {
                        BSDM: farm.BSDM,   //畜禽标识代码
                        FRDB: farm.FRDB,   //法人代表
                        HGZH: farm.HGZH,   //动物防疫条件合格证号
                        HPGM: farm.HPGM,   //环评规模(头)
                        ID: farm.ID,
                        JD: farm.JD,       //经度
                        LXDH: farm.LXDH,   //联系电话
                        NC: farm.NC,       //农场
                        SFZ: farm.SFZ,     //身份证号码
                        WD: farm.WD,       //纬度
                        WSBA: farm.WSBA,   //是否办理环评网上备案
                        XKZH: farm.XKZH,   //种畜禽生产经营许可证号
                        XXDZ: farm.XXDZ,   //详细地址
                        XYDM: farm.XYDM,   //统一社会信用代码
                        YZC: farm.YZC,     //养殖场名称
                        YZDM: farm.YZDM,   //畜禽养殖代码
                        ZYSS: farm.ZYSS,   //粪污主要设施
                        EP_CODE: farm.EP_CODE,
                        CHANNEL_IDS: farm.CHANNEL_IDS,
                        SEQNO: farm.SEQNO,

                        name: farm.YZC,
                        address: farm.XXDZ,
                        longitude: farm.JD,
                        latitude: farm.WD,
                        township: farm.NC
                    };
                }
                if(typeof successCallback) successCallback(farmDataObj);
            }
        });
    }else if(type == 'TRANSFER'){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/zphb/enter/pollutionTransferStation/get',
            dataType: 'json',
            data: {'id': id},
            success: function (res) {
                var transferDataObj = {}
                if(res.length>0) {
                    var transfer = res[0];
                    transferDataObj = {
                        WRYBM: transfer.WRYBM,      //污染源编码
                        WRYMC: transfer.WRYMC,      //标准污染源名称
                        JC: transfer.JC,            //简称
                        GMBM: transfer.GMBM,        //规模编码
                        QYMC: transfer.QYMC,        //企业名称
                        CYM: transfer.CYM,          //曾用名
                        QYLX: transfer.QYLX,        //企业类型
                        ZCLX: transfer.ZCLX,        //登记注册类型
                        SSHY: transfer.SSHY,        //所属行业
                        HYDM: transfer.HYDM,        //行业代码
                        QYDZ: transfer.QYDZ,        //企业地址
                        FRDM: transfer.FRDM,        //法人代码
                        DBMC: transfer.DBMC,        //法人代表姓名
                        DH: transfer.DH,            //电话
                        HBBM: transfer.HBBM,        //污染源环保部门
                        LBBM: transfer.LBBM,        //单位类别编码
                        SSLY: transfer.SSLY,        //所属流域
                        LYBM: transfer.LYBM,        //所属流域编码
                        GZCD: transfer.GZCD,        //关注程度
                        KYSJ: transfer.KYSJ,        //开业时间（投产日期）
                        KYSJ: transfer.KYSJ,        //开业时间（投产日期）
                        JD: transfer.JD,            //经度
                        WD: transfer.WD,            //纬度
                        ID: transfer.ID,
                        WZ: transfer.WZ,            //网址
                        JGLX: transfer.JGLX,        //污染源监管类型
                        GYYQMC: transfer.GYYQMC,       //所在工业园区名称
                        YB: transfer.YB,            //邮编
                        HBLXR: transfer.HBLXR,       //环保联系人
                        HBLXRDH: transfer.HBLXRDH,       //环保联系人电话
                        HBLXRSJ: transfer.HBLXRSJ,       //环保联系人手机
                        HBLXRCZ: transfer.HBLXRCZ,       //环保联系人传真
                        YHMC: transfer.YHMC,            //银行名称
                        YHZH: transfer.YHZH,            //银行账户
                        YXDZ: transfer.YXDZ,        //邮箱地址
                        CZ: transfer.CZ,            //传真
                        ZZHBRYS: transfer.ZZHBRYS,       //专职环保人员数
                        TXDZ: transfer.TXDZ,        //通讯地址
                        WRYZRR: transfer.WRYZRR,       //污染源责任人
                        LXR: transfer.LXR,          //联系人
                        LSGX: transfer.LSGX,        //隶属关系
                        DWZZ: transfer.DWZZ,        //单位资质
                        BZLX: transfer.BZLX,        //总投资币种类
                        ZTZ: transfer.ZTZ,          //总投资（万元）
                        HBZTZBZ: transfer.HBZTZBZ,       //环保总投资币种
                        HBTZ: transfer.HBTZ,        //环保投资（万元）
                        XZQMC: transfer.XZQMC,       //行政区名称
                        XZQDM: transfer.XZQDM,       //行政区代码
                        UPDATE_DATE: transfer.UPDATE_DATE,       //最后更新时间
                        EP_CODE: transfer.EP_CODE,
                        CHANNEL_IDS: transfer.CHANNEL_IDS,
                        SEQNO: transfer.SEQNO,

                        name: transfer.QYMC,
                        address: transfer.QYDZ,
                        longitude: transfer.JD,
                        latitude: transfer.WD,
                        township: transfer.XZQMC
                    };
                }
                if(typeof successCallback) successCallback(transferDataObj);
            }
        });
    }
}

//根据类型和id 获取相应污染源企业信息
function getZpPollutionEnterpriseInfoForAirWater(type, id, successCallback){
    type = type.toUpperCase();
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/zphb/cameraMap/getPollutionEnterpriseInfoById',
        dataType: 'json',
        data: {'uuid': id},
        success: function (res) {
            var dataObj = {}
            if(res.length>0){
                dataObj = res[0];
            }
            if(typeof successCallback) successCallback(dataObj);
        }
    });
}
//==================污染源企业 End====================

function showPoint(type, markerId, recordName, longitude,latitude,record,showPointCallBack) {
    var content = "<div><input type='hidden' name='maker_type' value='"+type+"' /><input type='hidden' name='maker_value' value='"+JSON.stringify(record)+"' /></div>";
    var title = record.typeName;

    var iconMap = new fjzx.map.Icon(record.icon, new fjzx.map.Size(34,38));
    iconMap.setImageOffset(new fjzx.map.Size(-24,-26)) ;

    if (type == "MINE") {//矿山
        createMarker(markerId,recordName,longitude,latitude,iconMap,content,title);
    }else if (type == "FARM") {//养殖场
        createMarker(markerId,recordName,longitude,latitude,iconMap,content,title);
    }else if (type == "TRANSFER") {//垃圾中转站
        createMarker(markerId,recordName,longitude,latitude,iconMap,content,title);
    }else if (type == "AIR" || type == "WATER") {//空气污染源、水污染源
        createMarker(markerId,recordName,longitude,latitude,iconMap,content,title);
    }else{
        createMarker(markerId,recordName,longitude,latitude,iconMap,content,title);
    }
}
//指定漳浦龙口热电厂
function  showPointEnterprise(type,markerId){
    var flag = false ;
    var id = markerId.split('_')[1];
    if(type=='AIR' && id == "6008650") {
        var airData = dataMap.get(markerId);
        var obj = {
            "address": airData.dz,
            "latValue": airData.jd,
            "longValue": airData.wd,
            "peId": airData.uuid,
            "peName": airData.mc,
            "pointStatus": "normal"
        }
        showEnterprise(obj);
        flag = true;
    }
    return flag ;
}
function createMarker(markerId,recordName,longitude,latitude,iconMap,content,title){
    if (markerMap.get(markerId) != null) {
        map.removeOverlay(markerMap.get(markerId));//移除原来的坐标
    }
    var point = new fjzx.map.Point(longitude,latitude);
    var markerTemp = new fjzx.map.Marker(point, {
        markerId: markerId,
        icon: iconMap
    });
    map.addOverlay(markerTemp);
    markerMap.put(markerId, markerTemp);


    markerTemp.addClick(function(e){
        var markerId = e.getMarkerId();
        var type = markerId.split('_')[0];
        var id = markerId.split('_')[1];
        //指定漳浦龙口热电厂
         if(showPointEnterprise(type,markerId)){
             return ;
         }
         if(type=='AIR' || type=='WATER'){
            getZpPollutionEnterpriseInfoForAirWater(type, id, function(res){
                showDetailForAirWater(res);
            });
        }else{
            getZpPollutionEnterpriseInfo(type, id, function(res){
                showDetail(res);
            });
        }
    });
    markerTemp.setTitle(title);

    return markerTemp;
}

function showDetail(info) {
    document.getElementById('name').innerHTML = '<span style="font-weight:bold">名称：</span>' + Ams.formatNUll(info.name);
    document.getElementById('address').innerHTML = '<span style="font-weight:bold">地址：</span>' + Ams.formatNUll(info.address);
    document.getElementById('township').innerHTML = '<span style="font-weight:bold">乡镇：</span>' + Ams.formatNUll(info.township);
    document.getElementById('longitude').innerHTML = '<span style="font-weight:bold">经度：</span>' + Ams.formatNUll(info.longitude);
    document.getElementById('latitude').innerHTML = '<span style="font-weight:bold">纬度：</span>' + Ams.formatNUll(info.latitude);

    var name = Ams.formatNUll(info.name);
    if(name.match(RegExp(/马头山/))){
        document.getElementById('panorama').innerHTML = '<span style="font-weight:bold">全景图：</span><a href="https://720yun.com/t/9bvknmrqg7w?scene_id=31882366" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改前</a>'
            +'&nbsp;&nbsp;<a href="https://720yun.com/t/4avkiw2hsdq?scene_id=34721822" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改后</a>';
        document.getElementById('distributedMap').innerHTML = '';
    }else if(name.match(RegExp(/蔡坑/))){
        document.getElementById('panorama').innerHTML = '<span style="font-weight:bold">全景图：</span><a href="https://720yun.com/t/9bvknmrqg7w?scene_id=32411087" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改前</a>'
            +'&nbsp;&nbsp;<a href="https://720yun.com/t/06vknb7lp7l?scene_id=32411087" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改中</a>'
            +'&nbsp;&nbsp;<a href="https://720yun.com/t/1fvkiw2hspy?scene_id=32411087" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改后</a>';
        document.getElementById('distributedMap').innerHTML = '<span style="font-weight:bold">矿区分布图：</span><a href="'+Ams.ctxPath+'/static/images/zhangpu/cai_keng_kuang_qu_fen_bu_tu.jpg" target="_blank" style="color: #0ab7ff;text-decoration: underline;">矿区分布图</a>';
    }else if(name.match(RegExp(/东方/))){
        document.getElementById('panorama').innerHTML = '<span style="font-weight:bold">全景图：</span><a href="https://720yun.com/t/06vknb7lp7l?scene_id=32411087" target="_blank" style="color: #0ab7ff;text-decoration: underline;">矿区全景图</a>';
        document.getElementById('distributedMap').innerHTML = '';
    }else if(name.match(RegExp(/许明通洗砂场/))){
        document.getElementById('panorama').innerHTML = '<a href="'+Ams.ctxPath+'/static/images/zhangpu/许明通整改前.png" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改前</a>'
            +'&nbsp;&nbsp;<a href="'+Ams.ctxPath+'/static/images/zhangpu/许明通整改中.png" target="_blank" style="color: #0ab7ff;text-decoration: underline;">整改中</a>';
        document.getElementById('distributedMap').innerHTML = '';
    }else{
        document.getElementById('panorama').innerHTML = '';
        document.getElementById('distributedMap').innerHTML = '';
    }

    $('#zpCameraChannelList').empty();
    if(info.CHANNEL_IDS != null){
        var channelIds = info.CHANNEL_IDS.split(',');
        var channelListHtml = '<span style="font-weight:bold">视频监控：</span>';
        $.each(channelIds, function(index, value){
            var channelId = value;
            var channelName = channelId.split(':').length > 0 ? '监控'+channelId.split(':')[1] : '';
            channelListHtml += '<a class="camera-channel" href="javascript:void(0);" target="_self" style="color: #0ab7ff;text-decoration: underline;margin-right:10px;" channel-id="'+channelId+'">'+channelName+'</a>';
            document.getElementById('zpCameraChannelList').innerHTML = channelListHtml;
        });
        $('#zpCameraChannelList').find('a.camera-channel').click(function(){
            var channelId = $(this).attr('channel-id');
            var channelName = channelId.split(':').length > 0 ? '监控'+channelId.split(':')[1] : '';
            console.log('点击了'+channelName);
            showZpCamera(channelId, channelName);
        });
    }

    $('#zpEnterpriseInfoDialog').dialog('open').dialog('center').dialog('setTitle', '详情');
}

function showDetailForAirWater(info) {
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

    //视频监控
    $('#cameraChannelList').empty();
    if(info.CHANNEL_IDS != null){
        var channelIds = info.channelIds.split(',');
        var channelListHtml = '<span style="font-weight:bold">视频监控：</span>';
        $.each(channelIds, function(index, value){
            var channelId = value;
            var channelName = channelId.split(':').length > 0 ? '监控'+channelId.split(':')[1] : '';
            channelListHtml += '<a class="camera-channel" href="javascript:void(0);" target="_self" style="color: #0ab7ff;text-decoration: underline;margin-right:10px;" channel-id="'+channelId+'">'+channelName+'</a>';
            document.getElementById('cameraChannelList').innerHTML = channelListHtml;
        });
        $('#cameraChannelList').find('a.camera-channel').click(function(){
            var channelId = $(this).attr('channel-id');
            var channelName = channelId.split(':').length > 0 ? '监控'+channelId.split(':')[1] : '';
            console.log('点击了'+channelName);
            showZpCamera(channelId, channelName);
        });
    }

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
    $('#airWaterDialog').dialog('open').dialog('center').dialog('setTitle', '详情');
    findTimelineData();
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
 * 短信发送
 * @param obj
 */
function sendMsg(person, phone) {
    Ams.sendMassageToUser(phone, person);
}


/**
 * 单个视频监控弹窗
 * @param info
 */
function showZpCamera(channelId, channelName) {
    if(cameraForDlg == null){
        cameraForDlg = new fjzx.camera.Camera({
            "elementId": "fjzx-camera-dialog",
            "playerCount": 1
        });
        cameraForDlg.initPlayers();
        cameraForDlg.initPTZControl('camera-control-dialog');
    }
    setTimeout(function(){
        var opt = {
            chanid: channelId,
            name: channelName
        }
        cameraForDlg.startView(opt);
    },500);

    $('#zpCameraDlg').dialog('open').dialog('center').dialog('setTitle', '视频监控');
}