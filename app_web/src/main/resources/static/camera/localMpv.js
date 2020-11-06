var mySecret,myAppkey,myOpUserUuid,myNetZoneUuid,mymyHost,seledCamerUuid,initSpvxRes=false;

$(function () {
    init();
});

function init() {
	IP = window.location.host;
	port = window.location.port;
	myHost = IP;
    // 获取网域信息
    GetNetZones();
    //初始化预览窗口
    initSpvxRes = InitSpvx();
    if(!initSpvxRes){
        return;
    }
	//初始化预览抓图、录像参数
    SetLocalParam();
}

function GetMilSeconds()  // 获取当前时间的毫秒数
{
    return new Date().getTime();
}
/* =============================================== */

function zTreeDblClick(event, treeId, treeNode){ 
    if (treeNode && treeNode.id && treeNode.nodeType && treeNode.nodeType == "3"){  // 双击的是监控点
        var time = GetMilSeconds();
		var seledCameraUuid = treeNode.id;
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/getPreviewParamByCameraUuid",
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
			},
			error: function(data){
				console.log(data);
			}
		});
    }
};

/**
 *
 * @param seledCameraUuid
 * @param playType: 0 空闲窗口播放，1 选中窗口播放，2 指定窗口播放
 * @param vWndIndex: 指定播放窗口
 */
function startPreview(seledCameraUuid,playType, vWndIndex){
    var time = GetMilSeconds();
    $.ajax({
        type: "POST",
        url:  Ams.ctxPath + "/camera/localCameraController/getPreviewParamByCameraUuid",
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
                opt = playType;
                switch (opt){
                    case 0:
                        ret = spvxOcx.MPV_StartPreview(xml.data);
                        break;
                    case 1:
                        ret = spvxOcx.MPV_StartPreviewBySelectedWnd(xml.data);
                        break;
                    case 2:
                        //var vWndIndex = $('#seledWndIndex option:selected').val();
                        vWndIndex = vWndIndex ? vWndIndex : 0;
                        ret = spvxOcx.MPV_StartPreviewByWndIndex(xml.data, parseInt(vWndIndex, 10));
                        break;
                    default:
                        console.log("startPreview success-opt:"+opt);
                        return ;
                }
                if (ret != 0) {
                    console.log("预览失败：" + xml.data);
                }
            }else{
                var vDesc = "查询预览参数失败，" + xml.errorMessage + ",错误码为：" + xml.errorCode;
                console.log(vDesc);
            }
        },
        error: function(data){
            console.log(data);
        }
    });
};


function GetNetZones(){
	$.ajax({
		type: "POST",
		url:  Ams.ctxPath + "/camera/localCameraController/getNetZones",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
        data: {},
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
				}
			} else if (jVal.errorCode != 0) {
				var vDsc = "getUsers" + jVal.errorMessage + ",错误码：" + jVal.errorCode;
				console.log(vDsc);
				return ;
			} else if (jVal.data && jVal.data.length <= 0) {
				var vDsc = "查询用户信息成功，但无用户信息";
				console.log(vDsc);
			}


		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		},
        error: function(res){
            console.log(res);
        }
	});
}

function InitSpvx() {
    var ocxObj = document.getElementById("spv");
    var languageType = 1;
    if(typeof(ocxObj.MPV_Init)=="undefined"){
        console.log('初始化失败');
        return false;
    }
    var ret = ocxObj.MPV_Init(languageType);
    if (ret != 0) {
        console.log("初始化失败");
    }
    //隐藏工具栏
    HideMainToolBar();
    return true;
}

function UninitSpvx() {
    var ocxObj = document.getElementById("spv");
    var ret = ocxObj.MPV_Uninit();
    if (ret != 0) {
        console.log("反初始化失败");
    }
}

/**
 * 配置预览参数，包括预览时长
 * @constructor
 */
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
		'<limitPreviewTime>0</limitPreviewTime> ' +
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

/**
 * 获取视频播放窗口数
 * @constructor
 */
function GetWnd(){
	var ocxObj = document.getElementById("spv");
	var ret = ocxObj.MPV_GetPlayWndCount();
	console.log(ret);
}

/**
 * 设置视频播放窗口数
 * @param windowCount
 * @constructor
 */
function SetWnd(windowCount){
    var ocxObj = document.getElementById("spv");
    var opt = windowCount ? windowCount : $("#SetWnd option:selected").val();
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
