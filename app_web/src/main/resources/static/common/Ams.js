var Ams = {
    ctxPath: "",
    addCtx: function (ctx) {
        if (this.ctxPath == "") {
            this.ctxPath = ctx;
        }
    },

    /**
     * 确认询问弹窗
     * @param title 提示信息头
     * @param msg 询问信息内容
     * @param callback 回调函数
     */
    confirm: function (title, msg, callback) {//询问框
        $.messager.confirm(title, msg, function (r) {
            if (r) {
                if (jQuery.isFunction(callback))
                    callback.call();
            }
        });
    },

    /**
     * 前端控制台输出
     * @param  msg 输出信息内容
     */
    log: function (msg) {
        console.log(msg);
    },
    /**
     * 弹窗提示
     * @param title 弹窗提示标题
     * @param msg 提示信息内容
     */
    alert: function (title, msg) {
        $.messager.alert({
            title: title,
            msg: msg
        });
    },

    /**
     * 信息提示
     * @param msg 提示信息内容
     */
    info: function (msg) {
        $.messager.show({
            title: "提示信息",
            msg: msg,
            showType: 'show'
        });
    },
    /**
     * 成功信息提示
     * @param msg 提示信息内容
     */

    success: function (msg) {
        // $.messager.show({
        //     title: "<div><img width='25px' heigth='25px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/smile.png'/>成功信息</div>",
        //     msg: '<textarea style="width: 100%;border: 0px;height: 100%">' + msg + '</textarea>',
        //     style: {left: screen.width / 2 - 140, top: screen.height / 3},
        //     timeout: 1000,
        //     showType: 'show'
        // });
        layer.msg(msg, {icon: 1});
    },

    /**
     * 失败信息提示
     * @param msg 提示信息内容
     */
    error: function (msg) {
        // $.messager.show({
        //     title: "<div><img width='25px' heigth='25px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/sad.png'/>失败信息</div>",
        //     style: {left: screen.width / 2 - 140, top: screen.height / 3},
        //     timeout: 1000,
        //     msg: '<textarea style="width: 100%;border: 0px;height: 100%">' + msg + '</textarea>',
        //     showType: 'show'
        // });
        layer.msg(msg, {icon: 2});
    },

    /**
     * 警告信息提示
     * @param msg 提示信息内容
     */
    wornMsg: function (msg) {
        layer.msg(msg, {icon: 7});
    },

    /**
     * 详细信息提示
     * @param title 提示标题
     * @param info 提示信息
     */
    infoDetail: function (title, info) {
        var display = "";
        if (typeof info == "string") {
            display = info;
        } else {
            if (info instanceof Array) {
                for (var x in info) {
                    display = display + info[x] + "<br/>";
                }
            } else {
                display = info;
            }
        }
        $.messager.show({
            title: title,
            msg: '<div style="padding: 20px;">' + display + '</div>',
            // timeout: 1000,
            showType: 'show',
            style: {
                right: '',
                top: document.body.scrollTop + document.documentElement.scrollTop,
                bottom: ''
            }
        });
    },
    eventParseObject: function (event) {//获取点击事件的源对象
        event = event ? event : window.event;
        var obj = event.srcElement ? event.srcElement : event.target;
        return $(obj);
    },
    /**
     * 下划线改成驼峰
     * @param str
     * @returns {string}
     */
    underLineToCamel: function (str) {
        var strArr = str.split('_');
        for (var i = 1; i < strArr.length; i++) {
            strArr[i] = strArr[i].charAt(0).toUpperCase() + strArr[i].substring(1);
        }
        var result = strArr.join('');
        return result.charAt(0).toUpperCase() + result.substring(1);
    },
    randomNum: function (minNum, maxNum) {
        switch (arguments.length) {
            case 1:
                return parseInt(Math.random() * minNum + 1, 10);
                break;
            case 2:
                return parseInt(Math.random() * (maxNum - minNum + 1) + minNum, 10);
                break;
            default:
                return 0;
                break;
        }
    },
    /**
     * 时间格式化
     * @param value
     * @param fmt 格式化类型自定义
     * @returns {string}自定义格式化类型
     */
    dateFormat: function (value, fmt) {
        if (typeof value != 'undefined' && null != value) {
            var date = new Date(value);
            fmt = typeof fmt != 'undefined' ? fmt : 'yyyy-MM-dd HH:mm:ss';
            var o = {
                "M+": date.getMonth() + 1,
                "d+": date.getDate(),
                "H+": date.getHours(),
                "m+": date.getMinutes(),
                "s+": date.getSeconds(),
                "q+": Math.floor((date.getMonth() + 3) / 3),
                "S": date.getMilliseconds()
            };
            var year = date.getFullYear();
            var yearstr = year + '';
            yearstr = yearstr.length >= 4 ? yearstr : '0000'.substr(0, 4 - yearstr.length) + yearstr;

            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (yearstr + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        return '';
    },
    /**
     * 时间比较
     * @param start 起始时间  字符串
     * @param end  结束时间  字符串
     * @returns true：结束时间大于起始时间 false：相反
     */
    timeComparison: function (start, end) {
        if (Ams.isNoEmpty(start) && Ams.isNoEmpty(end)) {
            var startTime = new Date(start);
            var endTime = new Date(end);
            if (endTime - startTime >= 0) {
                return true;
            }
            Ams.wornMsg('起始时间不能大于结束时间');
            return false;
        }
        Ams.wornMsg('时间不能为空！');
        return false;
    },
    //格式化时间
    formatNum: function (value) {
        if (Ams.isNoEmpty(value)) {
            return "<span title='" + Math.round(value * 100) / 100 + "'>" + Math.round(value * 100) / 100 + "</span>";
        }
        return "<span title='" + 0 + "'>0</span>";
    },
    /**
     * 格式化时间到天
     * @param value
     * @returns {string}yyyy-MM-dd
     */
    stdDateFormat: function (value) {
        var temp = Ams.dateFormat(value, 'yyyy-MM-dd');
        if ('' == temp) {
            return '';
        }
        return "<span title='" + temp + "'>" + temp + "</span>";
    },
    /**
     * 格式化时间到月
     * @param value
     * @returns {string}yyyy-MM
     */
    dateMonthFormat: function (value) {
        var temp = Ams.dateFormat(value, 'yyyy-MM');
        if ('' == temp) {
            return '';
        }
        return "<span title='" + temp + "'>" + temp + "</span>";
    },
    /**
     * 格式化时间到年
     * @param value
     * @returns {string}yyyyenviromonit/airDayData
     */
    dateYearFormat: function (value) {
        var temp = Ams.dateFormat(value, 'yyyy');
        if ('' == temp) {
            return '';
        }
        return "<span title='" + temp + "'>" + temp + "</span>";
    },


    /**
     * 时间格式化到秒
     * @param value
     * @returns {string} yyyy-MM-dd HH:mm:ss
     */
    timeDateFormat: function (value) {
        var temp = Ams.dateFormat(value, 'yyyy-MM-dd HH:mm:ss');
        if ('' == temp) {
            return '';
        }
        return "<span title='" + temp + "'>" + temp + "</span>";
    },
    /**
     * 格式化列提示信息
     * @param value
     * @param row
     * @param index
     * @returns {string}
     */
    tooltipFormat: function (value, row, index) {
        if (undefined == value || '' == value) {
            return "-";
        }
        return "<span title='" + value + "'>" + value + "</span>";
    },

    /**
     * 根据文件id下载文件
     * @param fileId 文件id
     */
    download: function (fileId) {
        fileId = encodeURIComponent(fileId);
        window.location.href = Ams.ctxPath + "/file/download/" + fileId;
    },

    /**
     * 根据之判断是否是男、女
     * @param value
     * @returns {string}
     */
    formatSex: function (value) {
        var temp = '';
        if (null != value) {
            if (value == 1) {
                temp = '男';
            } else if (value == 2) {
                temp = '女';
            } else {
                temp = '';
            }
        }
        return temp;
    },

    /**
     * 根据值判断是禁用、启用
     * @param value
     * @returns {string}
     */
    formatEnable: function (value) {
        var temp = '';
        if (null != value) {
            if (value == 0) {
                temp = '禁用';
            } else if (value == 1) {
                temp = '启用';
            } else {
                temp = '';
            }
        }
        return temp;
    },

    /**
     * 根据值判断是否是还是否
     * @param value
     * @returns {string}
     */
    formatEnableSave: function (value) {
        var temp = '';
        if (null != value) {
            if (value == 0) {
                temp = '否';
            } else if (value == 1) {
                temp = '是';
            }
        }
        return temp;
    },
    /**
     * 根据值判断已分配、未分配
     * @param value
     * @returns {string}
     */
    formatAssign: function (value) {
        var temp = '';
        if (null != value) {
            if (value == true) {
                temp = '已分配';
            } else {
                temp = '未分配';
            }
            return temp;
        }
    },
    formatCircle: function (value) {
        var html = "<div style='width:100%;height:100%; position:relative;'> <span style='  position: absolute;margin: auto;top: 0;left: 0;right: 0;bottom: 0; border-radius: 50%;height: 18px;width: 18px;display: inline-block;background: "
        var color = "#FFFFFF";
        if (null != value) {
            if (value == 1) {
                html += "#00FF00";
            } else {
                html += "#FF3030"
            }

        }
        html += " ;vertical-align: top;'>  </span> </div>"
        return html;
    },
    /**
     * 根据类型判断状态严重滞后、整治中等
     * @param value
     * @returns {string}
     */
    formatDebriefing: function (value) {
        var temp = '';
        if (null != value) {
            if (value == '0') {
                temp = '滞后';
            } else if (value == '1') {
                temp = '整治中';
            } else {
                temp = '完成';
            }
            return temp;
        }
    },

    /**
     * 根据类型判断状态严重滞后、严重滞后等
     * @param value
     * @returns {string}
     */
    formatDebriefingDetail: function (value) {
        var temp = '';
        if (null != value) {
            if (value == '1') {
                temp = '严重滞后';
            } else if (value == '2') {
                temp = '严重滞后';
            } else if (value == '3') {
                temp = '时序进度';
            } else if (value == '4') {
                temp = '完成整改';
            } else {
                temp = '已经销号';
            }
            return temp;
        }
    },

    /**
     * 根据类型判断是文档、图片视频等
     * @param value
     * @returns {string}
     */
    formatAttachType: function (value) {
        var temp = '';
        if (null != value) {
            if (value == '0') {
                temp = '其他';
            } else if (value == '1') {
                temp = 'PDF文档';
            } else if (value == '2') {
                temp = '图片';
            } else {
                temp = '视频';
            }
            return temp;
        }
    },
    /**
     *  根据条件格式化列渲染为红色
     * @param value
     * @param row
     * @param index
     * @returns {string}
     */
    redFontFormat: function (value, row, index) {
        if (undefined == value || '' == value) {
            return "-";
        } else if (row.polluteCodes.indexOf(this.field) > -1) {
            return "<span title='" + value + "' style='color:red;'>" + value + "</span>";
        }
        return "<span title='" + value + "'>" + value + "</span>";

    },

    /**
     * 判断对象是否为空
     * @param obj 需要判断的对象
     * @returns {boolean} 空为false;不为空为true
     */
    isNoEmpty: function (obj) {
        if (typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0) {
            return false;
        } else {
            return true;
        }
    },
    /**
     * 根据div打印成图片
     * @param id  某个div的id 这个方法的打印图片是会重新打开新页面
     */
    printById: function (id) {
        $("#printImg exportImg").hide();
        html2canvas(document.getElementById(id), {
            allowTaint: true,
            taintTest: false,
            onrendered: function (canvas) {
                canvas.id = "mycanvas";
                //生成base64图片数据
                var dataUrl = canvas.toDataURL();
                var newImg = document.createElement("img");
                newImg.src = dataUrl;
                var printWindow = window.open(newImg.src);
                printWindow.document.write('<img width="100%" src="' + newImg.src + '" />');
                printWindow.document.close();//这句话一定要添加，否则不能预览
                printWindow.onload = function () {
                    printWindow.print();
                };
            }
        });
        $("#printImg exportImg").show();
    },

    /**
     * 界面导出PDF
     * @param id 需要导出成图片的div的id
     * @param title 导出PDF的标题
     */
    exportPdfById: function (id, title) {
        var loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });
        $("#printImg").hide();
        $("#exportImg").hide();
        $("#searchBar1").hide();
        html2canvas(document.getElementById(id), {
            background: '#FFF',//设置背景颜色
            onrendered: function (canvas) {
                var contentWidth = canvas.width;
                var contentHeight = canvas.height;
                //一页pdf显示html页面生成的canvas高度;
                var pageHeight = contentWidth / 592.28 * 841.89;
                //未生成pdf的html页面高度
                var leftHeight = contentHeight;
                //页面偏移
                var position = 0;
                //a4纸的尺寸[595.28,841.89]，html页面生成的canvas在pdf中图片的宽高
                var imgWidth = 555.28;
                var imgHeight = 555.28 / contentWidth * contentHeight;

                var pageData = canvas.toDataURL('image/jpeg', 1.0);

                var pdf = new jsPDF('', 'pt', 'a4');

                //有两个高度需要区分，一个是html页面的实际高度，和生成pdf的页面高度(841.89)
                //当内容未超过pdf一页显示的范围，无需分页
                if (leftHeight < pageHeight) {
                    pdf.addImage(pageData, 'JPEG', 20, 0, imgWidth, imgHeight);
                } else {
                    while (leftHeight > 0) {
                        pdf.addImage(pageData, 'JPEG', 20, position, imgWidth, imgHeight)
                        leftHeight -= pageHeight;
                        position -= 841.89;
                        //避免添加空白页
                        if (leftHeight > 0) {
                            pdf.addPage();
                        }
                    }
                }
                pdf.save(title + '.pdf');
            }
        });
        $("#exportImg").show();
        $("#printImg").show();
        $("#searchBar1").show();
        layer.close(loadIndex);
        layer.msg('导出成功！', {icon: 1})
    },

    /**
     * 根据div打印成图片
     * @param id  某个div的id
     */
    doPrint: function (id) {
        var loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });
        $(document.body).append("<div id='printFrame'></div>");
        var printAreaDiv = document.getElementById(id); //待打印区域dom对象
        $("#printImg").hide();
        $("#exportImg").hide();
        html2canvas(printAreaDiv) //代入打印对象参数，生成canvas图形
            .then(function (canvas) {//返回canvas对象
                var dataUrl = canvas.toDataURL();//获取canvas对象图形的外部url
                var newImg = document.createElement("img");//创建img对象
                newImg.src = dataUrl;//将canvas图形url赋给img对象
                newImg.setAttribute("width", "100%");//设置图片的宽度;
                $('#printFrame').append(newImg).printArea();//打印img，注意不能直接打印img对象，需要包裹一层div
                $('#printFrame').remove(); //打印完毕释放包裹层内容（图像）//
            });
        $("#printImg").show();
        $("#exportImg").show();
        layer.close(loadIndex);
    },

    /**
     * 查看图标
     * @returns {string}
     */
    setImageSee: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/see.png'/>";
    },

    /**
     * 编辑图标
     * @returns {string}
     */
    setImageEdit: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/edit.png'/>";
    },

    /**
     * 删除图标
     * @returns {string}
     */
    setImageDelete: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/delete.png'/>";
    },

    /**
     * 设置图标
     * @returns {string}
     */
    setImageSet: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/set.png'/>";
    },
    /**
     * 下载图标
     * @returns {string}
     */
    setImageDown: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/down.png'/>";
    },
    /**
     * 派发图标
     * @returns {string}
     */
    setImageDistribute: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/distribute.png'/>";
    },
    /**
     * 附件图标
     * @returns {string}
     */
    setImageAttachment: function () {
        return "<img width='20px' heigth='20px' style='vertical-align:-4px;margin:0 3px 0px 5px;' src='/static/images/attachment.png'/>";
    },
    /**
     * 获取时间格式化(cutDay为往前几天，0为当天)
     * @param cutDay
     * @returns {string} 2018-09
     */
    getNowDate: function (cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay * 60000 * 60 * 24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        var date = d.getDate();
        if (month >= 0 && month <= 9) {
            month = "0" + month;
        }
        var currentdate = year + "-" + month;
        return currentdate;
    }, getNowDate_toSecond: function (cutDay) {
        //获取时间格式化(cutDay为往前几天，0为当天)
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay * 60000 * 60 * 24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        var date = d.getDate();
        if (date >= 0 && date <= 9) {
            date = "0" + date;
        }
        var hours = d.getHours();
        if (hours >= 0 && hours <= 9) {
            hours = "0" + hours;
        }
        var minutes = d.getMinutes();
        if (minutes >= 0 && minutes <= 9) {
            minutes = "0" + minutes;
        }
        var seconds = d.getSeconds();
        if (seconds >= 0 && seconds <= 9) {
            seconds = "0" + seconds;
        }
        var currentdate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
        return currentdate;

    },
    /**
     * 获取当前时间和当前年度的第一天 2019.05.28 2019-01-01
     * @param isnow ‘0’第一天  ‘1’ 当前时间
     * @param pattern 数据拼接的格式【-】【.】...
     * @returns {*}
     */
    nowDayOrFirstDayOfYear: function (isnow, pattern) {
        var d = new Date();
        var year = d.getFullYear();
        var month;
        var day;
        if (isnow == '1') {
            month = d.getMonth() + 1;
            day = d.getDate();
        } else {
            month = '1';
            day = '1';
        }
        if (month >= 0 && month <= 9) {
            month = "0" + month;
        }
        if (day >= 0 && day <= 9) {
            day = "0" + day;
        }
        return year + pattern + month + pattern + day;
    },
    formatBgclByWtQuality: function (value) {
        switch (value) {
            case 'Ⅰ':
                return 'month-item alone-month2';
                break;
            case 'Ⅱ':
                return 'month-item alone-month2';
                break;
            case 'Ⅲ':
                return 'month-item alone-month3';
                break;
            case 'Ⅳ':
                return 'month-item alone-month4';
                break;
            case 'Ⅴ':
                return 'month-item alone-month5';
                break;
            case '劣Ⅴ':
                return 'month-item alone-month6';
                break;
            default:
                return 'month-item';
                break;
        }
    }, formatRglBg: function (value) {
        switch (value) {
            case 'Ⅰ':
                return 'home-border-panel water-blue';
                break;
            case 'Ⅱ':
                return 'home-border-panel water-blue';
                break;
            case 'Ⅲ':
                return 'home-border-panel water-green';
                break;
            case 'Ⅳ':
                return 'home-border-panel water-yellow';
                break;
            case 'Ⅴ':
                return 'home-border-panel water-orange';
                break;
            case '劣Ⅴ':
                return 'home-border-panel water-red';
                break;
            default:
                return 'home-border-panel water-gray';
                break;
        }
    }, fmtByWtQuality: function (value) {
        switch (value) {
            case 'FIRSR':
                return 'Ⅰ';
                break;
            case 'SECOND':
                return 'Ⅱ';
                break;
            case 'THIRD':
                return 'Ⅲ';
                break;
            case 'FOURTH':
                return 'Ⅳ';
                break;
            case 'FIFTH':
                return 'Ⅴ';
                break;
            case 'OTHER':
                return '劣Ⅴ';
                break;
            default:
                return '-';
                break;
        }
    },
    /**
     * 格式化断面类型
     * @param value
     * @returns {string}
     */
    fmtSectionType: function (value) {
        switch (value) {
            case '1':
                return '国控';
                break;
            case '2':
                return '省控';
                break;
            case '3':
                return '其他';
                break;
            default:
                return '-';
                break;
        }
    },
    /**
     * 字段格式化
     */
    formatStatus: function (status) {
        if (status == "OVER") {
            return "完成整改";
        } else if (status == "ONTIME") {
            return "达到序时进度";
        } else if (status == "PASS") {
            return "超过序时进度";
        } else if (status == "NOTSTART") {
            return "尚未启动";
        } else if (status == "NOTREACH") {
            return "未达到序时进度";
        } else if (status == "SENDACCOUNT") {
            return "完成交账销号";
        } else {
            return "";
        }
    },
    /**
     * 设置表格分页
     * @param tblId 表格id
     */
    setPageDg: function (tblId) {
        $("#" + tblId).datagrid('getPager').pagination({
            showPageList: false,
            showRefresh: false,
            layout: ['first', 'prev', 'links', 'next', 'last'],
            links: 3
        });
        $("#" + tblId).datagrid('resize');
    },
    /**
     * 设置表格AQi背景色
     */
    setAQIBackground: function (value, row, index) {
        if (value >= 0 && value < 50) {
            return 'background-color:#00e400;color:#fff;';
        } else if (value >= 50 && value < 100) {
            return 'background-color:#ffff00;color:#404040;';
        } else if (value >= 100 && value < 150) {
            return 'background-color:#ff7e00;color:#fff;';
        } else if (value >= 150 && value < 200) {
            return 'background-color:#ff0000;color:#fff;';
        } else if (value >= 200 && value < 300) {
            return 'background-color:#99004c;color:#fff;';
        } else if (value >= 300 && value < 500) {
            return 'background-color:#7e0023;color:#fff;';
        } else {
            return 'background-color:#b8b8b8;color:#fff;';
        }
    },
    /**
     * 设置表格水质类别背景色
     */
    setWaterCategoryBackground: function (value, row, index) {
        if (value >= 0 && value < 10) {
            return 'background-color:#2BA4E9;color:#fff;';
        } else if (value >= 10 && value < 20) {
            return 'background-color:#45B97C;color:#fff;';
        } else if (value >= 20 && value < 30) {
            return 'background-color:#FFFF00;color:#404040;';
        } else if (value >= 30 && value < 40) {
            return 'background-color:#F47920;color:#fff;';
        } else if (value >= 40 && value < 50) {
            return 'background-color:#D02032;color:#fff;';
        } else {
            return 'background-color:#b8b8b8;color:#fff;';
        }
    },
    //两个时间相差天数 兼容firefox chrome
    datedifference: function (sDate1, sDate2) {    //sDate1和sDate2是2006-12-18格式
        var dateSpan,
            tempDate,
            iDays;
        sDate1 = Date.parse(sDate1);
        sDate2 = Date.parse(sDate2);
        dateSpan = sDate2 - sDate1;
        dateSpan = Math.abs(dateSpan);
        iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
        return iDays
    },
    weatherIcon:
        function (weatherType) {//获取天气图标
            switch (weatherType) {
                case"阵雨":
                    return "icon iconcustom iconzhenyu";
                case"雾":
                    return "icon iconcustom iconzhenyu";
                case "闪电":
                    return "icon iconcustom iconshandian";
                case"阴天":
                    return "icon iconcustom iconyintian";
                case"中雨":
                    return "icon iconcustom iconzhongyu";
                case"雷雨":
                    return "icon iconcustom iconleiyu";
                case"阵雪":
                    return "icon iconcustom iconzhenxue";
                case"小雪":
                    return "icon iconcustom iconxiaoxue";
                case"霾":
                    return "icon iconcustom iconmai";
                case"大雨":
                    return "icon iconcustom icondayu";
                case"阵雨":
                    return "icon iconcustom iconzhenyu";
                case"多云":
                    return "icon iconcustom iconduoyun";
                case"大雪":
                    return "icon iconcustom icondaxue";
                case"小雨":
                    return "icon iconcustom iconxiaoyu";
                default:
                    return "icon iconcustom iconzhire";
            }
        }, /**
     * 设置表格字体颜色色
     */
    setFontColor: function (value, row, index) {
        switch (value) {
            case 'FIRSR':
                return 'color:#2ba4e9';
                break;
            case 'SECOND':
                return 'color:#2ba4e9';
                break;
            case 'THIRD':
                return 'color:#45B97C';
                break;
            case 'FOURTH':
                return 'color:#FFFF00';
                break;
            case 'FIFTH':
                return 'color:#F47920';
                break;
            case 'OTHER':
                return 'color:#D02032';
                break;
            default:
                return 'color:#B8B8B8';
                break;
        }
    },
    /**
     * 设置表格字体颜色色
     */
    setAQIFontColor: function (value, row, index) {
        if (value >= 0 && value < 50) {
            return 'color:#00e400;';
        } else if (value >= 50 && value < 100) {
            return 'color:#ffff00;';
        } else if (value >= 100 && value < 150) {
            return 'color:#ff7e00;';
        } else if (value >= 150 && value < 200) {
            return 'color:#ff0000;';
        } else if (value >= 200 && value < 300) {
            return 'color:#99004c;';
        } else if (value >= 300 && value < 500) {
            return 'color:#7e0023;';
        } else {
            return 'color:#b8b8b8;';
        }
    },
    /**
     * easyui文本框 按enter查询事件
     * @param inputTextId 文本框id
     * @param callback 按enter后执行的事件
     */
    inputText_enterKeyEvent: function (inputTextId, callback) {
        $('#' + inputTextId).textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keyup: function (event) {
                    if (event.keyCode == 13) {
                        callback.call();
                        $('#' + inputTextId).next('span').find('input').focus();//获取焦点
                    }
                }
            })
        });
    },

    /**
     * 普通文本框 按enter查询事件
     * @param inputId 文本框id
     * @param callback 按enter后执行的事件
     */
    input_enterKeyEvent: function (inputTextId, callback) {
        $("#" + inputTextId).keypress(function (e) {
            if (e.which == 13) {
                callback.call();
            }
        });
    },


    /**
     * 判断值是否为空 为空返回 - 不为空返回原本值
     * @param val
     * @returns {string|*}
     */
    formatNUll: function (val) {
        if (Ams.isNoEmpty(val)) {
            return val;
        }
        return '-';
    },

    /**
     * 判断值是否为空 为空返回 0 不为空返回原本值
     * @param val
     * @returns {string|*}
     */
    formatNullForZero: function (val) {
        if (Ams.isNoEmpty(val)) {
            return val;
        }
        return '0';
    },


    /**
     * 短信发送
     * @param mobilePhone 电话号码
     * @param name 姓名
     */
    sendMassageToUser: function (mobilePhone, name) {
        var phs = mobilePhone.split(",");
        for (var i = 0; i < phs.length; i++) {
            if (!Ams.isNoEmpty(phs[i]) || !/^(?:13\d|15\d|17\d|18\d)-?\d{5}(\d{3}|\*{3})$/.test(phs[i])) {
                layer.msg('手机号码为空或手机号码格式不正确，不能发送短信');
                return;
            }
        }
        var title = '发送短信';
        if (Ams.isNoEmpty(name)) {
            title = '给' + name + '发送短信';
        }
        layer.prompt({title: title, formType: 2, value: ''},
            function (pass, index) {
                layer.close(index);
                $.ajax({
                    type: "POST",
                    url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/sendMsg',
                    dataType: 'json',
                    data: {
                        phones: mobilePhone,
                        names: name,
                        message: pass
                    },
                    success: function (data) {
                        layer.msg('短信发送成功');
                    },
                    error: function () {
                        layer.msg('短信发送失败');
                    }

                });
            });
    },

    /**
     * 表格为空时默认显示暂无数据
     */
    easyuiEmptyView: function () {
        var myview = $.extend({}, $.fn.datagrid.defaults.view, {
            onAfterRender: function (target) {
                $.fn.datagrid.defaults.view.onAfterRender.call(this, target);
                var opts = $(target).datagrid('options');
                var vc = $(target).datagrid('getPanel').children('div.datagrid-view');
                vc.children('div.datagrid-empty').remove();
                if (!$(target).datagrid('getRows').length) {
                    var d = $('<div class="datagrid-empty"></div>').html(opts.emptyMsg || 'no records').appendTo(vc);
                    d.css({
                        position: 'absolute',
                        left: 0,
                        top: 50,
                        width: '100%',
                        textAlign: 'center',
                    });
                }
            }
        });
        return myview;
    },
    /**
     * 获取上周几
     * @param n 7：上周一；1：上周日
     * @returns {string}
     */
    getTime: function (n) {
        const now = new Date();
        const year = now.getFullYear();
        let month = now.getMonth() + 1;
        //返回星期几的某一天;
        const day = now.getDay();
        n = day === 0 ? n + 6 : n + (day - 1);
        let lastWeek = new Date();
        lastWeek.setDate(now.getDate() - n);
        date = lastWeek.getDate();
        let lastMonth = lastWeek.getMonth() + 1;
        // 月初的上周一跨月,month-1
        if (lastMonth < month) {
            month = month - 1;
        }
        return year + "-" + (month < 10 ? ('0' + month) : month) + "-" + (date < 10 ? ('0' + date) : date);
    },
    /**
     * 视频播放调用 关闭时候关闭声音
     * @param videoId
     * @param videoDlgId 弹窗id
     */
    playVideo: function (videoId, videoDlgId) {
        var myVideo = document.getElementById(videoId);//获取video对象
        // 关闭视频后关闭声音
        $("#" + videoDlgId).dialog({
            onClose: function () {
                myVideo.pause();
            }
        });
    },
    /**
     * 获取form表单里的参数传到后台； 查询使用
     * @param formId
     */
    searchParam: function (formId) {
        var modelObj = {};
        var modelFieldsArray = $('#' + formId).serializeArray();
        $.each(modelFieldsArray, function () {
            modelObj[this.name] = this.value;
        });
        return modelObj;
    }


};