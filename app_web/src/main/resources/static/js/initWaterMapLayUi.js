Date.prototype.format = function(format){
	var o = {
		"M+" : this.getMonth()+1,                 //月份
		"d+" : this.getDate(),                    //日
		"H+" : this.getHours(),                   //小时
		"m+" : this.getMinutes(),                 //分
		"s+" : this.getSeconds(),                 //秒
		"q+" : Math.floor((this.getMonth()+3)/3), //季度
		"S"  : this.getMilliseconds()             //毫秒
	};
	if(/(y+)/.test(format)){
		format=format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	}
	for(var k in o){
		if(new RegExp("("+ k +")").test(format)){
			format = format.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
		}
	}
	return format;
};


var date = new Date();

var initYear = date.getFullYear();
var nowTime=new Date();
/**
 * 初始化日期控件
 * @param id   日期控件id  #id
 * type  日期类型,date week month    year
 * offset  偏移量,周类型值为1-7，其它：0为当天，1为明天，-1昨天，以此类推
 */
function initDateInput(id,type,offset){
	layui.use('laydate', function () {
		var laydate = layui.laydate;
		laydate.render({
			elem: id,
			range: '到',
			format:getDateFormat(type),
			value: getDate(type,offset-1)+' 到 '+getDate(type,offset),
			calendar: true,
			type:type=="week"?"date":(type=="quarter"?"month":type),

			ready:function(date){
				var dateEle = $(id);
				var laydateEle = $("#layui-laydate"+dateEle.attr("lay-key"));

				if(type == "quarter"){
					if(laydateEle.length>0){
						laydateEle.click(function(){
							renderQuarterDateObj($(this));
						});
					}
					renderQuarterDateObj(laydateEle);
				}else if(type == "week"){
					if(laydateEle.length>0){
						laydateEle.click(function(){
							renderWeekDateObj($(this),parseInt(offset));
						});
					}
					renderWeekDateObj(laydateEle,parseInt(offset));
				}
			},
			change: function(value, date, endDate){
			},
			done:function(value,date,endDate){//控件选择完毕
			},
			btns: ['confirm']
		});
	});
};

//获取type对应的日期格式
function getDateFormat(type){
	var dateFormat = "";
	switch(type){
		case "datetime":dateFormat ="yyyy年MM月dd日 HH时";break;
		case "year":dateFormat = "yyyy年";break;
		case "quarter":dateFormat = "yyyy年第M季度";break;
		case "month":dateFormat = "yyyy年MM月";break;
		case "week":
		case "date":
		default:dateFormat = "yyyy年MM月dd日";break;
	}
	return dateFormat;
};
//获取初始化时当前type下的日期格式展现在日期控件上
function getDate(type,offset){
	var o = offset;
	var now = new Date();
	var date;
	if(type=="week"){
		var nowDay = now.getDay();
		if(offset<=nowDay){
			o = -1*(nowDay-offset);
		}else{
			o = -7+(offset-nowDay);
		}
	}
	date = new Date(now.getTime()+o*24*60*60*1000);
	var dateStr = dateFtt(getDateFormat(type),date);//formatDate(date,type);
	return dateStr;
}

//将日期转为相应日期格式
function dateFtt(fmt,date) {
	if(fmt.indexOf("季度")>-1){
		fmt = fmt.replace(/(第)[\s\S]+(季度)/g,"$1q$2");
	}
	var o = {
		"q+": Math.floor((date.getMonth()+3)/3), //季度//
		"M+" : date.getMonth()+1, //月份
		"d+" : date.getDate(), //日
		"H+" : date.getHours(), //小时
		"m+" : date.getMinutes(), //分
		"s+" : date.getSeconds(), //秒
		"S" : date.getMilliseconds() //毫秒
	};
	if(/(y+)/.test(fmt))
		fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));
	for(var k in o)
		if(new RegExp("("+ k +")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	return fmt;
};
//处理日期为当前type下的对应的准确fmt格式日期
function handleDate(fmt,date,type,endFlag){

	var dateTmp = "";
	switch(type){
		case "year":
			if(endFlag == true){
				dateTmp = date.substr(0,4)+"-"+"12-31 23:59:59";
			}else{
				dateTmp = date.substr(0,4)+"-"+"01-01 00:00:00";
			}
			break;
		case "quarter":
			var month = parseInt(date.substr(4,2))*3-3;
			dateTmp = endFlag?(dateFtt(fmt,new Date(date.substr(0,4), month+3,0))):(dateFtt("yyyyMMdd",new Date(date.substr(0,4), month,1)));break;
		case "month":
			if(endFlag == true){
				var temp = new Date(date.substr(0,4), date.substr(5,2), 0);
				dateTmp = date.substr(0,4)+"-"+date.substr(5,2)+"-"+date.substr(8,2)+date.substr(12,2)+temp.getDate()+" 23:59:59";
			}else{
				dateTmp = date.substr(0,4)+"-"+date.substr(5,2)+"-"+date.substr(8,2)+date.substr(12,2)+"01 00:00:00";
			}
			break;
		case "date":
			if(endFlag == true){
				dateTmp = date.substr(0,4)+"-"+date.substr(5,2)+"-"+date.substr(8,2)+" "+date.substr(12,2)+"23:59:59";
			}else{
				dateTmp = date.substr(0,4)+"-"+date.substr(5,2)+"-"+date.substr(8,2)+" "+date.substr(12,2)+"00:00:00";
			}
			 break;
		case "week":dateTmp = dateFtt(fmt,new Date(date.substr(0,4), parseInt(date.substr(4,2))-1,date.substr(6,2)));break;
		case "datetime":
				dateTmp = date.substr(0,4)+"-"+date.substr(5,2)+"-"+date.substr(8,2)+" "+date.substr(12,2)+":00:00";
			break;
	}
	return dateTmp;
};
//生成季度的时间控件选择器
function renderQuarterDateObj(that){
	$(that).addClass('layui-quarter');
	var unvalidMonth = -1;//0-11
	var isQuarter = [];//判断当前日期控件是否是季度
	var qDateObj = that.find(".laydate-month-list");
	qDateObj.each(function(i,e){
		var length = $(this).find("li:visible").length;
		$(this).find("li:visible").each(function(index,ele){
			var isDisabled = $(ele).hasClass("laydate-disabled");
			if(isDisabled&&unvalidMonth===-1){
				unvalidMonth = index;
			}
			if((length!==4&&index%3===0)||length===4){
				isQuarter.push(isDisabled?"laydate-disabled":"");
			}
			if(index<4){
				var curVal = ele.innerHTML;
				ele.innerHTML = curVal.replace(/([\s\S]+)月/g,"第$1季度");//"第" + q + "季度";
			}else{
				ele.style.display = "none";
			}
		});
	});
	if(isQuarter&&unvalidMonth<10){
		qDateObj.each(function(i,e){
			$(this).find("li:visible").each(function(index,ele){
				// if(unvalidMonth/3<=index){
				$(ele).addClass(isQuarter[i?index+4:index]);
				// }
			});
		});
	}
}
//生成周度的时间控件选择器
function renderWeekDateObj(that,offset){
	offset = (offset == 7?0:offset);
	var qDateObj = that.find(".layui-laydate-content");
	var start = false;
	var selElem;
	qDateObj.each(function(contentIndex,contentElem){
		layui.each($(contentElem).find('tr'),function(trIndex,trElem){
			layui.each($(trElem).find('td'),function(tdIndex,tdElem){
				var tdTmp = $(tdElem);
				if(tdTmp.hasClass('laydate-day-next')||tdTmp.hasClass('laydate-day-prev')){
					return;
				}
				if(tdTmp.hasClass('layui-this')){
					selElem = tdTmp;
				}
				if(tdIndex != offset){
					tdTmp.addClass('laydate-disabled');
					if((++tdIndex>7?1:tdIndex)==offset){
						tdTmp.addClass('laydate-end');
					}
				}
			});
		});
		if($(contentElem).find('.layui-this').hasClass('laydate-disabled')){
			$(contentElem).find('.layui-this.laydate-disabled').removeClass('layui-this');
		}
	});
};
//获取日期控件当前日期,fmt为返回日期格式，默认为yyyyMMdd格式
var getHandleDate = function(id,type,offset,fmt){
	var fmt = fmt?fmt:"yyyyMMdd";
	var date=$(id).val();
	if(date!=""){
		sdate = date.split(' 到 ')[0];
		edate = date.split(' 到 ')[1];
	}else{
		sdate = getDate(type,offset);
		edate = getDate(type,offset);
	}
	var reg = /^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s((([0-1][0-9])|(2?[0-3]))\:([0-5]?[0-9])((\s)|(\:([0-5]?[0-9])))))?$/;


	sdate = sdate.replace(reg,"$1");
	edate = edate.replace(reg,"$1");


	sdate = handleDate(fmt,sdate,type);
	edate = handleDate(fmt,edate,type,true);
	return {"sdate":sdate,"edate":edate};
};



