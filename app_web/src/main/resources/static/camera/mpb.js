var myAppkey,mySecret,myOpUserUuid,myNetZoneUuid,seledCameraUuid;
Date.prototype.format = function(fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    var week = {
        "0": "\u65e5",
        "1": "\u4e00",
        "2": "\u4e8c",
        "3": "\u4e09",
        "4": "\u56db",
        "5": "\u4e94",
        "6": "\u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[this.getDay() + ""]);
    }
	
	for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
};

$(function () {
    init();
});

function init() {
	//IP = window.location.host;
	IP = '27.155.33.126';
	//port = window.location.port;
	port = '81';
	myHost = IP;
	setDefaultRecordSearchDate();
	
	$("#PlayType").change(function(){
		var vOpt = parseInt($('#PlayType option:selected').val(), 10);
		if (2 == vOpt){
			var ocxObj = document.getElementById("spb");
			var ret = ocxObj.MPB_GetPlayWndCount();
			var vWndIds = document.getElementById("seledWndIndex");
			$("#seledWndIndex").empty();
			for(var i = 0; i < ret; ++i){
				var opt = document.createElement("option");
				opt.value = i;
				opt.innerText = i;
				vWndIds.appendChild(opt);
				if (i == 0){
					opt.selected = "true";
				}	
			}
		}
		else
		{
			//document.getElementById("seledWndIndex").empty();
		}
	})
		
	$("#SelectUser").on('change', function(){
		var opt = $("#SelectUser option:selected");
		var tUuid = opt.val();
		if (tUuid && tUuid != myOpUserUuid){
			myOpUserUuid = tUuid;
			
			// 停止单路回放
			stopAllPlayback();
			buildDefaultUnit();
		}
	});
	
	$("#SelectNet").on('change', function(){
		var opt = $("#SelectNet option:selected");
		var tUuid = opt.val();
		if (tUuid && tUuid != myNetZoneUuid){
			myNetZoneUuid = tUuid;
			
			// 停止单路回放
			stopAllPlayback();
			buildDefaultUnit();
		}
	});
}

function InitData()
{
	myAppkey = $("#appKey").val();
	mySecret = $("#secret").val();
	if (mySecret && myAppkey){
		GetDefaultUser(myAppkey, mySecret);
	}
	else
	{
		alert("请先填写appKey和secret！");
	}
}

function handleResponse(response){
	console.log(response);
}

function GetDefaultUser(tAppkey, tSecret){
	/*var time = GetMilSeconds();
	uri = "/openapi/service/base/user/getDefaultUserUuid";
    strParam = {"appkey":tAppkey,"time":time};
	token = GenToken(uri, JSON.stringify(strParam), tSecret);*/
	console.log("GetDefaultUser");
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/getDefaultUserUUID",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function(jVal){
			if (jVal.errorCode==0 && jVal.data){
				// 获取到了默认用户
				// 分页获取用户
				myOpUserUuid = jVal.data;
				console.log("myOpUserUuid:"+myOpUserUuid);
				GetUsers(tAppkey, tSecret, jVal.data);
				
				// 获取网域信息
				GetNetZones(tAppkey, tSecret, jVal.data);
			}
			else
			{
				var vDsc = "getDefaultUserUuid失败，描述：" + jVal.errorMessage + ",错误码：" + jVal.errorCode;
				alert(vDsc);
			}
		}
	});
}

function GetUsers(tAppkey, tSecret, defaultUserUuid){
	/*var time = GetMilSeconds();
	uri = "/openapi/service/base/user/getUsers";
    strParam = {"appkey":tAppkey,"time":time,"pageNo":1,"pageSize":400,"opUserUuid":defaultUserUuid};
	token = GenToken(uri, JSON.stringify(strParam), tSecret);*/
	
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/getUsers",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
        data: JSON.stringify({
			opUserUuid: defaultUserUuid
        }),
		success: function(jVal){
			if (jVal.errorCode==0 && jVal.data){
				// 设置用户信息，并显示默认用户
				var userList = document.getElementById("SelectUser");
				if (userList){
					for (i = 0; i < jVal.data.total; ++i){
						var opt = document.createElement("option");
						opt.value = jVal.data.list[i].userUuid;
						opt.innerText = jVal.data.list[i].userName;
						userList.appendChild(opt);
						
						if (defaultUserUuid == jVal.data.list[i].userUuid){
							opt.selected = "true";
						}
					}
					
					// 获取默认控制中心
					buildDefaultUnit();
				}
			}
			else
			{
				var vDsc = "getUsers" + jVal.errorMessage + ",错误码：" + jVal.errorCode;
				alert(vDsc);
			}
		}
	});
}

function GetNetZones(tAppkey, tSecret, defaultUserUuid){
	/*var time = GetMilSeconds();
	uri = "/openapi/service/base/netZone/getNetZones";
    strParam = {"appkey":tAppkey,"time":time,"opUserUuid":defaultUserUuid};
	token = GenToken(uri, JSON.stringify(strParam), tSecret);*/
	
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/getNetZones",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
        data: JSON.stringify({
			opUserUuid: defaultUserUuid
        }),
		success: function(jVal){
			if (jVal.errorCode==0 && jVal.data && jVal.data.length > 0){
				// 设置用户信息，并显示默认用户
				var netList = document.getElementById("SelectNet");
				if (netList){
					for (i = 0; i < jVal.data.length; ++i){
						var opt = document.createElement("option");
						opt.value = jVal.data[i].netZoneUuid;
						opt.innerText = jVal.data[i].netZoneName;
						netList.appendChild(opt);
						
						if (i == 0){
							opt.selected = "true";
							myNetZoneUuid = jVal.data[i].netZoneUuid;
						}
					}
					
					// 获取默认控制中心
					buildDefaultUnit();
				}
			}
			else if (jVal.errorCode != 0)
			{
				var vDsc = "getUsers" + jVal.errorMessage + ",错误码：" + jVal.errorCode;
				alert(vDsc);
				return ;
			}
			else if (jVal.data && jVal.data.length <= 0)
			{
				var vDsc = "查询用户信息成功，但无用户信息";
				alert(vDsc);
			}
		}
	});
}

function GenToken(uri, strParam, mySecret) {
    srcStr = uri + strParam + mySecret;
    token = hex_md5(srcStr).toUpperCase();    // 生成token
    return token;
}

function GetDefaultUnit(time) {
    uri = "/openapi/service/base/org/getDefaultUnit";
    strParam ={"appkey":myAppkey,"time":time,"opUserUuid":myOpUserUuid,"subSystemCode":"2097152"}; // 获取直接子中心控制中心
    token = GenToken(uri, JSON.stringify(strParam), mySecret);
    return token;
}

function GetMilSeconds()  // 获取当前时间的毫秒数
{
    return new Date().getTime();
}

function GetCtrlUnitToken(time, pUuid) 
{
    uri = "/openapi/service/base/org/getUnitsByParentUuid";
	strParam = {"appkey":myAppkey,"time":time,"pageNo":1,"pageSize":400,"opUserUuid":myOpUserUuid,"parentUuid":pUuid,"allChildren":0}; // 获取直接子中心控制中心
    token = GenToken(uri, JSON.stringify(strParam), mySecret);
    return token;
}

function GetRegionToken(time, pUuid, type)  //type 1-上级是中心 2-上级是区域
{
    uri = type == 1 ? "/openapi/service/base/org/getRegionsByUnitUuid" : "/openapi/service/base/org/getRegionsByParentUuid";
	strParam = {"appkey":myAppkey,"time":time,"pageNo":1,"pageSize":400,"opUserUuid":myOpUserUuid,"parentUuid":pUuid,"allChildren":0}; // 获取直接子区域
    token = GenToken(uri, JSON.stringify(strParam), mySecret);
    return token;
}

function GetCameraToken(time, pUuid) 
{
    uri = "/openapi/service/vss/res/getCamerasByRegionUuids";
	strParam = {"appkey":myAppkey,"time":time,"pageNo":1,"pageSize":400,"opUserUuid":myOpUserUuid,"regionUuids":pUuid}; // 获取监控点
    token = GenToken(uri, JSON.stringify(strParam), mySecret);
    return token;
}

function GetRecordPlanToken(time, uuid) {  // 单个监控点的录像计划
    uri = "/openapi/service/vss/playback/getRecordPlansByCameraUuids";
	strParam = {"appkey":myAppkey,"time":time,"pageNo":1,"pageSize":15,"opUserUuid":myOpUserUuid,"cameraUuids":uuid,"netZoneUuid":myNetZoneUuid};
	token = GenToken(uri, JSON.stringify(strParam), mySecret);
	return token;
}

function GetSinglePlaybackToken(time, planType, recordPlanUuid) {
    uri = "/openapi/service/vss/playback/getPlaybackParamByPlanUuid";
	strParam = {"appkey":myAppkey,"time":time,"opUserUuid":myOpUserUuid,"planType":planType,"recordPlanUuid":recordPlanUuid,"netZoneUuid":myNetZoneUuid};
	token = GenToken(uri, JSON.stringify(strParam), mySecret);
	return token;
}
/* =============================================== */

function setDefaultRecordSearchDate()
{
	var now = new Date();
	document.getElementById("endTime").value = now.format("yyyy-MM-dd HH:mm:ss");
	now.setDate(now.getDate() - 2);
	now.setHours(0);
	now.setMinutes(0);
	now.setSeconds(0);
	now.setMilliseconds(0);
	document.getElementById("startTime").value = now.format("yyyy-MM-dd HH:mm:ss");
}

function buildDefaultUnit() {
    myAppkey = $("#appKey").val();
    mySecret = $("#secret").val();
    var setting = {
		data: {
			key: {
				name: "name"
			}
		},
        async: {
            enable: false,
            autoParam: ['uuid', 'NodeType', 'planType']   // 资源编号， 节点类型(1-控制中心 2-区域 3-监控点 4-录像计划)， 录像计划ID
        },
        view: {
            showIcon: true //设置 zTree 是否显示节点的图标。
        },
        callback: {
            onExpand: zTreeOnExpand,
			onDblClick: zTreeDblClick
		},
    };

    // 获取默认控制中心
    time = GetMilSeconds();
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/getDefaultUnit",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		data: JSON.stringify({
            opUserUuid: myOpUserUuid,
            subSystemCode: "2097152"
        }),
		success: function(nodes){
			if (nodes.errorCode != 0){
				alert("获取默认控制中心失败，描述：" + nodes.errorMessage + "，错误码为：" + nodes.errorCode);
			}
			else{
				var arr = {};
				arr.uuid = nodes.data.unitUuid;
				arr.name = nodes.data.name;
				arr.NodeType = 1;   // 1是控制中心
				arr.isParent = true;
				arr.expanded = false;
				arr.iconSkin = 'data-icon-unit';
				childNodes = [];
				childNodes.push(arr);
				
				$.fn.zTree.init($("#planTree"), setting, childNodes);
			}
		}
	});
}
/* =============================================== */

function zTreeOnExpand(event, treeId, treeNode){
	//expandNode = treeNode;
	if (!treeNode.expanded){
		treeNode.expanded = true;
		var resUuid = treeNode.uuid;
		alert(treeNode.NodeType);
		// 先查中心或区域
		if (treeNode.NodeType == 2){    // 点击的是区域，查区域
			var time3 = GetMilSeconds();
			RegiontokenEx = GetRegionToken(time3, resUuid, 2);
			
			$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:  Ams.ctxPath + "/camera/getRegionsByParentUuid",
				dataType: "json",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					parentUuid: resUuid,
					allChildren: 0
				}),
				success: function(nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getRegionsByParentUuid : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						alert(vDsc);
					}else if (nodes.data.total < 1){
					}else{
						childNodes = [];
						for (var i = 0; i < nodes.data.list.length; i++){
							var arr = {};
							arr.uuid = nodes.data.list[i].regionUuid;
							arr.name = nodes.data.list[i].name;
							arr.NodeType = 2;   // 2表示区域
							arr.isParent = true;
							arr.iconSkin = "data-icon-region";
							childNodes.push(arr);
						}
						var tree = $.fn.zTree.getZTreeObj("planTree");
						console.log("treeNode.NodeType == 2");
						console.log(childNodes);
						tree.addNodes(treeNode, childNodes);
					}
				}
			});
		}else if (treeNode.NodeType == 1){	// 点击的是控制中心，查控制中心
			var time4 = GetMilSeconds();
			var CtrlUnittoken = GetCtrlUnitToken(time4, resUuid);

			$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:  Ams.ctxPath + "/camera/getUnitsByParentUuid",
				dataType: "json",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					parentUuid: resUuid,
					allChildren: 0
				}),
				success: function(nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getUnitsByParentUuid : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						alert(vDsc);
					}else if (nodes.data.total < 1){
						console.log("treeNode.NodeType == 1没有东西");
					}else{
						childNodes = [];
						for (var i = 0; i < nodes.data.list.length; i++){
							var arr = {};
							arr.uuid = nodes.data.list[i].unitUuid;
							arr.name = nodes.data.list[i].name;
							arr.NodeType = 1;   // 1表示中心
							arr.isParent = true;
							arr.iconSkin = 'data-icon-unit';
							childNodes.push(arr);
						}
						var tree = $.fn.zTree.getZTreeObj("planTree");
						console.log("treeNode.NodeType == 1");
						console.log(childNodes);
						tree.addNodes(treeNode, childNodes);
					}
				}
			});
		}
		
		// 再查区域或监控点
		if (treeNode.NodeType == 2)  // 当前点击的是区域，查监控点
		{
			/*var time1 = GetMilSeconds();
			cameraToken = GetCameraToken(time1, resUuid);*/
			
			$.ajax({
				type: "POST",
				url:  Ams.ctxPath + "/camera/getCamerasByRegionUuids",
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					regionUuids: resUuid
				}),
				success: function(nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getCamerasByRegionUuids : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						alert(vDsc);
					}else if (nodes.data.total < 1){
						
					}else{
						childNodes = [];
						for (var i = 0; i < nodes.data.list.length; i++) 
						{
							var arr = {};
							arr.uuid = nodes.data.list[i].cameraUuid;
							arr.name = nodes.data.list[i].cameraName;
							arr.NodeType = 3;   // 3表示监控点
							arr.isParent = true;
							arr.iconSkin = 'data-icon-camera1';
							childNodes.push(arr);
						}
						var tree = $.fn.zTree.getZTreeObj("planTree");
						console.log("再查区treeNode.NodeType == 2");
						console.log(childNodes);
						tree.addNodes(treeNode, childNodes);
					}
				}
			});
		}else if (treeNode.NodeType == 1){  // 当前点击的是中心，查区域
			//console.log("当前点击的是中心，查区域");
			var time2 = GetMilSeconds();
			var Regiontoken = GetRegionToken(time2, resUuid, 1);
			$.ajax({
				//url: "http://" + myHost + "/openapi/service/base/org/getRegionsByUnitUuid?token=" + Regiontoken,
                url:Ams.ctxPath + "/camera/getRegionsByUnitUuid",
				type:"POST",
				contentType: "application/json; charset=utf-8",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					parentUuid: resUuid,
					allChildren: 0
				}),
				success: function (nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getRegionsByUnitUuid : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						alert(vDsc);
					}else if (nodes.data.total < 1){
					}else{
						childNodes = [];
						for (var i = 0; i < nodes.data.list.length; i++){
							var arr = {};
							arr.uuid = nodes.data.list[i].regionUuid;
							arr.name = nodes.data.list[i].name;
							arr.NodeType = 2;   // 2表示区域
							arr.isParent = true;
							arr.iconSkin = "data-icon-region";
							childNodes.push(arr);
						}
						var tree = $.fn.zTree.getZTreeObj("planTree");
						tree.addNodes(treeNode, childNodes);
					}	
				}
			}) // end ajax
		}
		
		if (treeNode.NodeType == 3)  // 当前点击的是监控点，查录像计划
		{
			var time5 = GetMilSeconds();
			cameraUuid = treeNode.uuid;
			recPlanToken = GetRecordPlanToken(time5, cameraUuid);
			$.ajax({
				type: "POST",
				url:  Ams.ctxPath + "/camera/getRecordPlansByCameraUuids",
				dataType: "json",
				contentType: "application/json; charset=utf-8",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					cameraUuids: cameraUuid,
					netZoneUuid: myNetZoneUuid
				}),
				success: function(nodes){
					if (nodes.errorCode != 0)
					{
						var vDsc = "getRecordPlansByCameraUuids : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						alert(vDsc);
					}
					else if (nodes.data.total < 1)
					{
					}
					else
					{
						childNodes = [];
						for (var i = 0; i < nodes.data.list.length; i++) 
						{
							var arr = {};
							arr.planType = nodes.data.list[i].planType;
							if (nodes.data.list[i].enabled != 0)
							{
								continue;
							}
							
							if (arr.planType == 1)
							{
								arr.name = "设备存储";
								arr.iconSkin = 'data-icon-device-store';
							}
							else if (arr.planType == 3)
							{
								arr.name = "CVR存储";
								arr.iconSkin = 'data-icon-cvr-store';
							}
							else if (arr.planType == 4)
							{
								arr.name = "CVM存储";
								arr.iconSkin = 'data-icon-cvm-store';
							}
							else
							{
								continue;
							}
							
							arr.uuid = nodes.data.list[i].recordPlanUuid;
							arr.NodeType = 4;   // 4表示录像计划
							arr.isParent = false;
							childNodes.push(arr);
						}
						
						if (childNodes.length > 0)
						{
							var tree = $.fn.zTree.getZTreeObj("planTree");
							tree.addNodes(treeNode, childNodes);
						}
					}
				}
			});
		}
	}
}

function zTreeDblClick(event, treeId, treeNode){
    if (treeNode && treeNode.uuid && treeNode.NodeType && treeNode.NodeType == "4")  // 双击的是录像计划
    {
        var time = GetMilSeconds();
		var recPlanUuid = treeNode.uuid;  
		var planType = treeNode.planType;
		
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/getPlaybackParamByPlanUuid",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			data: JSON.stringify({
                opUserUuid: myOpUserUuid,
                planType: planType,
				recordPlanUuid: recPlanUuid,
                netZoneUuid: myNetZoneUuid
            }),
			success: function(xml){
				// 调OCX单路预览接口
				if (xml.data)
				{
					var startTime = document.getElementById("startTime").value;
					var endTime = document.getElementById("endTime").value;
					var spbOcx = document.getElementById("spb");
					
					var ret = 0;
					var opt = parseInt($("#PlayType option:selected").val(), 10);
					switch (opt)
					{
						case 0:
						ret = spbOcx.MPB_StartPlayBack(xml.data, startTime, endTime);
						break;
						case 1:
						ret = spbOcx.MPB_StartPlayBackBySelectedWnd(xml.data, startTime, endTime);
						break;
						case 2:
						var vWndIndex = $('#seledWndIndex option:selected').val();
						ret = spbOcx.MPB_StartPlayBackByWndIndex(xml.data, startTime, endTime, parseInt(vWndIndex, 10));
						break;
						default:
						return ;
					}
					
					if (ret != 0) {
						alert("回放失败：" + xml.data);
					}
				}
				else
				{
					alert("查询回放参数失败");
				}
			}
		});
    }
};


function InitSpb() {
    var ocxObj = document.getElementById("spb");
    var languageType = 1;
    var ret = ocxObj.MPB_Init(languageType);
    if (ret != 0) {
        alert("初始化失败");
    }
}

function UninitSpb() {
    var ocxObj = document.getElementById("spb");
    var ret = ocxObj.MPB_Uninit();
    if (ret != 0) {
        alert("反初始化失败");
    }
}

function SetLocalParam() {
    var ocxObj = document.getElementById("spb");
    var xml = '<?xml version="1.0" encoding="UTF-8"?> ' +
        '<localParam> ' +
        '<picType>1</picType> ' +
        '<capturePath>C:\\Hikvision</capturePath> ' +
        '<recordSize>2</recordSize> ' +
        '<recordPath>C:\\Hikvision</recordPath> ' +
		'<showMsgTip>1</showMsgTip> ' +
        '</localParam>';
    var ret = ocxObj.MPB_SetLocalParam(xml);
    if (ret != 0) {
        alert("设置本地参数失败");
    }
}

function stopAllPlayback() {
    var ocxObj = document.getElementById("spb");
    var ret = ocxObj.MPB_StopAllPlayback();
    if (ret != 0) {
        alert("停止所有回放失败");
    }
}

function SetToolBar(){
	var ocxObj = document.getElementById("spb");
	var ids = $('#tbar').val();
	if (null == ids){
		alert("参数为空！");
		return ;
	}
	
	var ret = ocxObj.MPB_SetToolBar(ids);
	if (ret != 0){
		alert("设置工具条失败！");
	}
}

function GetWnd(){
	var ocxObj = document.getElementById("spb");
	var ret = ocxObj.MPB_GetPlayWndCount();
	alert(ret);
}

function SetWnd(){
	var ocxObj = document.getElementById("spb");
	var opt = $('#SetWnd option:selected').val();
	var ret = ocxObj.MPB_SetPlayWndCount(parseInt(opt, 10));
	if (ret != 0){
		alert("设置分屏失败！");
	}
}

function SnapPic(){
	var ocxObj = document.getElementById("spb");
	var ret = ocxObj.MPB_SnapShot(-1);
	if(ret != 0 ){
		alert("选中窗口抓图失败");
	}
}

