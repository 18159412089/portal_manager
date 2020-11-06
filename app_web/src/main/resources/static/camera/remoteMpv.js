var mySecret,myAppkey,myOpUserUuid,myNetZoneUuid,mymyHost,seledCamerUuid;

$(function () {
    init();
});

function init() {
	IP = window.location.host;
	port = window.location.port;
	myHost = IP;
	
	setTimeout(function(){
		GetDefaultUser();
		InitSpvx();
	},1000);

	$("#PlayType").change(function(){
		var vOpt = parseInt($('#PlayType option:selected').val(), 10);
		if (2 == vOpt){
			var ocxObj = document.getElementById("spv");
			var ret = ocxObj.MPV_GetPlayWndCount();
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
		}else{
			//document.getElementById("seledWndIndex").empty();
		}
	})	
	
	$("#SelectUser").on('change', function(){
		// 选择用户事件
		var opt = $("#SelectUser option:selected");
		var tUuid = opt.val();
		if (tUuid && tUuid != myOpUserUuid){
			myOpUserUuid = tUuid;
			
			// 重新获取默认控制中心
			stopAllPreview();
			buildDefaultUnit();
		}
	});

	$("#SelectNet").on('change', function(){
		// 选择网域事件
		var opt = $("#SelectNet option:selected");
		var tUuid = opt.val();
		if (tUuid && tUuid != myNetZoneUuid){
			myNetZoneUuid = tUuid;
			
			// 重新获取默认控制中心
			stopAllPreview();
			buildDefaultUnit();
		}
	});
}

function InitData(){
	GetDefaultUser();
}

function GetPreset(){
	$("#preset").empty();
	var cameraUuid = $("#uuid").val();
	if (null == cameraUuid){
		return ;
	}
	
	
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/remoteCameraController/getPresetInfosByCameraUuid",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
        data: JSON.stringify({
			opUserUuid: myOpUserUuid,
			cameraUuids: cameraUuid
        }),
		success: function(jVal){
			if (jVal.errorCode != 0){
				var vDesc = jVal.errorMessage != null ? jVal.errorMessage : "getPresetInfosByCameraUuid返回失败";
				console.log("获取预置点信息失败：" + vDesc + ",错误码为：" + jVal.errorCode);
				return ;
			}
			
			if (jVal.data && jVal.data.length <= 0){
				console.log("获取预置点信息成功，但无预置点！");
				return ;
			}
			
            if (jVal.errorCode==0 && jVal.data && jVal.data.length > 0){
				// 设置用户信息，并显示默认用户
				$("#preset").empty();
				var presetList = document.getElementById("preset");
				if (presetList){
					var presetArray = new Array(jVal.data.length);
					for (i = 0; i < jVal.data.length; ++i){
						presetArray.push(jVal.data[i]);
					}
					
					var newArray = presetArray.sort(function(a,b){
						return a.presetNo - b.presetNo;
					});
					
					for (i = 0; i < jVal.data.length; ++i){    // 用newArray的长度在IE10上有问题
						var opt = document.createElement("option");
						opt.value = newArray[i].presetNo;
						opt.innerText = newArray[i].presetName;
						presetList.appendChild(opt);
						
						if (i == 0){
							opt.selected = "true";
						}
					}
				}
			}
		}
	});
}

function GetDefaultUser(){
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/remoteCameraController/getDefaultUserUUID",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function(jVal){
			if (jVal.errorCode==0 && jVal.data){
				// 获取到了默认用户
				// 分页获取用户
				myOpUserUuid = jVal.data;
				GetUsers(jVal.data);
				
				// 获取网域信息
				GetNetZones(jVal.data);
				
		        $("#loadingDiv").fadeOut("normal", function () {
		            $(this).remove();
		        });
			}else{
				var vDsc = "getDefaultUserUuid失败，描述：" + jVal.errorMessage + ",错误码：" + jVal.errorCode;
				console.log(vDsc);
			}
		}
	});
}

function GetUsers(defaultUserUuid){
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/remoteCameraController/getUsers",
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
				console.log(vDsc);
			}
		}
	});
}

function GetNetZones(defaultUserUuid){
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/remoteCameraController/getNetZones",
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
						
						if (i == 1){
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
				console.log(vDsc);
				return ;
			}
			else if (jVal.data && jVal.data.length <= 0)
			{
				var vDsc = "查询用户信息成功，但无用户信息";
				console.log(vDsc);
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
/* =============================================== */
function buildDefaultUnit() {
    var asynTree = document.getElementById("planTree"); // 异步树
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
            autoParam: ['uuid', 'NodeType']   // 资源编号，资源名称， 节点类型：1-控制中心 2-区域 3-监控点
        },
        view: {
            showIcon: true //设置 zTree 是否显示节点的图标。
        },
        callback: {
            onExpand: zTreeOnExpand,
			onDblClick: zTreeDblClick
		}
    };

    // 获取默认控制中心
    var time = GetMilSeconds();
    $.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/remoteCameraController/getDefaultUnit",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		data: JSON.stringify({
            opUserUuid: myOpUserUuid,
            subSystemCode: "2097152"
        }),
		success: function(nodes){
			if (nodes.errorCode != 0){
				console.log("获取默认控制中心失败，描述：" + nodes.errorMessage + "，错误码为：" + nodes.errorCode);
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
		// 先查中心或区域
		if (treeNode.NodeType == 2){    // 点击的是区域，查区域
			var time3 = GetMilSeconds();
			
			$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:  Ams.ctxPath + "/camera/remoteCameraController/getRegionsByParentUuid",
				dataType: "json",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					parentUuid: resUuid,
					allChildren: 0
				}),
				success: function(nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getRegionsByParentUuid : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						console.log(vDsc);
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
			});
		}else if (treeNode.NodeType == 1){	// 点击的是控制中心，查控制中心
			var time4 = GetMilSeconds();

			$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:  Ams.ctxPath + "/camera/remoteCameraController/getUnitsByParentUuid",
				dataType: "json",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					parentUuid: resUuid,
					allChildren: 0
				}),
				success: function(nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getUnitsByParentUuid : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						console.log(vDsc);
					}else if (nodes.data.total < 1){
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
						tree.addNodes(treeNode, childNodes);
					}
				}
			});
		}
		
		// 再查区域或监控点
		if (treeNode.NodeType == 2){  // 当前点击的是区域，查监控点
			/*var time1 = GetMilSeconds();
			cameraToken = GetCameraToken(time1, resUuid);*/
			
			$.ajax({
				type: "POST",
				url:  Ams.ctxPath + "/camera/remoteCameraController/getCamerasByRegionUuids",
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				data: JSON.stringify({
					opUserUuid: myOpUserUuid,
					regionUuids: resUuid
				}),
				success: function(nodes){
					if (nodes.errorCode != 0){
						var vDsc = "getCamerasByRegionUuids : " + nodes.errorMessage + ",错误码：" + nodes.errorCode;
						console.log(vDsc);
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
						tree.addNodes(treeNode, childNodes);
					}
				}
			});
		}else if (treeNode.NodeType == 1){  // 当前点击的是中心，查区域
			var time2 = GetMilSeconds();
			$.ajax({
                url:Ams.ctxPath + "/camera/remoteCameraController/getRegionsByUnitUuid",
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
						console.log(vDsc);
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
	}
}

function zTreeDblClick(event, treeId, treeNode){ 
    if (treeNode && treeNode.uuid && treeNode.NodeType && treeNode.NodeType == "3"){  // 双击的是监控点
        var time = GetMilSeconds();
		var seledCameraUuid = treeNode.uuid;
		seledCamerUuid = treeNode.uuid;
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/remoteCameraController/getPreviewParamByCameraUuid",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			data: JSON.stringify({
                opUserUuid: myOpUserUuid,
                cameraUuids: seledCameraUuid,
                netZoneUuid: myNetZoneUuid
            }),
			success: function(xml){
				// 调OCX单路预览接口
				var spvxOcx = document.getElementById("spv");
				if (xml.data){
					var ret = 0;
					var opt = parseInt($("#PlayType option:selected").val(), 10);
					switch (opt){
						case 0:
						ret = spvxOcx.MPV_StartPreview(xml.data);
						break;
						case 1:
						ret = spvxOcx.MPV_StartPreviewBySelectedWnd(xml.data);
						break;
						case 2:
						var vWndIndex = $('#seledWndIndex option:selected').val();
						ret = spvxOcx.MPV_StartPreviewByWndIndex(xml.data, parseInt(vWndIndex, 10));
						break;
						default:
						return ;
					}
					if (ret != 0) {
						console.log("预览失败：" + xml.data);
					}
				}else{
					var vDesc = "查询预览参数失败，" + xml.errorMessage + ",错误码为：" + xml.errorCode; 
					console.log(vDesc);
				}
			}
		});
    }
};


function InitSpvx() {
    var ocxObj = document.getElementById("spv");
    var languageType = 1;
    var ret = ocxObj.MPV_Init(languageType);
    if (ret != 0) {
        console.log("初始化失败");
    }
}

function UninitSpvx() {
    var ocxObj = document.getElementById("spv");
    var ret = ocxObj.MPV_Uninit();
    if (ret != 0) {
        console.log("反初始化失败");
    }
}

function SetLocalParam() {
    var ocxObj = document.getElementById("spv");
    //var devPxRa = window.devicePixelRatio;
    var devPxRa = screen.deviceXDPI / screen.logicalXDPI;
    var height = $('#spv').height() * devPxRa ;
    var width = $('#spv').width() * devPxRa;
    var xml = '<?xml version="1.0" encoding="UTF-8"?> ' +
        '<localParam> ' +
		'<width>' + width + '</width> ' +
		'<height>' + height + '</height> ' +
        '<picType>0</picType> ' +
        '<capturePath>C:\\Hikvision</capturePath> ' +
        '<recordSize>2</recordSize> ' +
        '<recordPath>C:\\Hikvision</recordPath> ' +
		'<limitPreviewTime>1800</limitPreviewTime> ' +
		'<showMsgTip>1</showMsgTip> ' +
        '</localParam>';
    var ret = ocxObj.MPV_SetLocalParam(xml);
    if (ret != 0) {
        console.log("设置本地参数失败");
    }
}

function stopAllPreview() {
    var ocxObj = document.getElementById("spv");
    var ret = ocxObj.MPV_StopAllPreview();
    if (ret != 0) {
        console.log("停止所有预览失败");
    }
}

function SetOSD(){
	if (!seledCamerUuid){
		console.log("未选中监控点！");
		return ;
	}
	var ocxObj = document.getElementById("spv");
	var tx = $('#tx').text();
	var tcolor = $('#fontColor').val();
	var optSize = $("#fontSize option:selected").val();
	var optPos = $('#selectPosition option:selected').val();
	var vv = tx.replace(/\\n/g, '\n');
	var xml = '<?xml version="1.0" encoding="UTF-8"?> ' +
        '<textInfo> ' +
		'<text>' + vv + '</text> ' +
		'<cameraUuid>' + seledCamerUuid + '</cameraUuid> ' +
        '<location>' + optPos + '</location> ' +
        '<fontSize>' + optSize + '</fontSize> ' +
        '<RGB>' + tcolor + '</RGB> ' +
        '</textInfo>';
	var ret = ocxObj.MPV_SetOSDText(xml);
	if (ret != 0)
	{
		console.log("字符叠加失败！");
	}
}

function GetWnd(){
	var ocxObj = document.getElementById("spv");
	var ret = ocxObj.MPV_GetPlayWndCount();
	console.log(ret);
}

function SetWnd(){
	var ocxObj = document.getElementById("spv");
	var opt = $("#SetWnd option:selected").val();
	var ret = ocxObj.MPV_SetPlayWndCount(parseInt(opt, 10));
	if (ret != 0){
		console.log("设置分屏失败！");
	}
}

function SetToolBar(){
	var ocxObj = document.getElementById("spv");
	var ids = $('#tbar').val();
	if (null == ids){
		console.log("参数为空！");
		return ;
	}
	
	var ret = ocxObj.MPV_SetToolBar(ids);
	if (ret != 0){
		console.log("自定义播放工具条按钮失败！");
	}
}

function GotoPreset(){
	var ocxObj = document.getElementById("spv");
	var opt = $("#preset option:selected").val();
	var ret = ocxObj.MPV_GotoPreset(parseInt(opt, 10));
	if (ret != 0){
		console.log("调用预置点失败");
	}
}

function SetMainToolBar(){
	var ocxObj = document.getElementById("spv");
	var ids = $('#Maintbar').val();
	if (null == ids){
		console.log("参数为空！");
		return ;
	}
	
	var ret = ocxObj.MPV_SetMainToolBar(ids);
	if (ret != 0){
		console.log("自定义主工具栏按钮失败！");
	}
}

function SetFullScreen(){
	var ocxObj = document.getElementById("spv");
	var ret = ocxObj.MPV_SetFullScreen();
	if (ret != 0){
		console.log("设置全屏失败");
	}
}

function ShowMainToolBar(){
	var ocxObj = document.getElementById("spv");
	var ret = ocxObj.MPV_ShowMainToolBar(1);
	if (ret != 0){
		console.log("显示主工具栏失败");
	}
}

function HideMainToolBar(){
	var ocxObj = document.getElementById("spv");
	var ret = ocxObj.MPV_ShowMainToolBar(0);
	if (ret != 0){
		console.log("隐藏主工具栏失败");
	}
}

function SnapPic(){
	var ocxObj = document.getElementById("spv");
	var ret = ocxObj.MPV_SnapShot(-1);
	if (ret != 0){
		console.log("选中窗口预览抓图失败");
	}
}

function StartPtzCtrl(){
	var ocxObj = document.getElementById("spv");
	var vCommand = $('#PtzCommand option:selected').val();
	var vSpeed = $('#PtzSpeed option:selected').val();
	var ret = ocxObj.MPV_PTZCtrl(-1, 0, parseInt(vCommand, 10), parseInt(vSpeed, 10));
	if (ret != 0){
		console.log("选中窗口开始云台控制失败");
	}
}
//MPV_PTZCtrl(LONG lWndIndex, LONG lAction, LONG lCommond, LONG lSpeed)
function StopPtzCtrl(){
	$('#selectPosition option:selected').val()
	var ocxObj = document.getElementById("spv");
	var vCommand = $('#PtzCommand option:selected').val();
	var vSpeed = $('#PtzSpeed option:selected').val();
	var ret = ocxObj.MPV_PTZCtrl(-1, 1, parseInt(vCommand, 10), parseInt(vSpeed, 10));
	if (ret != 0){
		console.log("选中窗口停止云台控制失败");
	}
}
