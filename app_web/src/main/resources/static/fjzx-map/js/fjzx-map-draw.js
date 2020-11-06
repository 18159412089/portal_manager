/**
 * 绘制区域
 * 放在初始化地图 前一个script
 */

//动态加载颜色选择器css ，js
loadjscssfile(Ams.ctxPath+"/static/color-pick/jquery.bigcolorpicker.min.js","js")
loadjscssfile( Ams.ctxPath+"/static/css/jquery.bigcolorpicker.css","css")
loadjscssfile( Ams.ctxPath+"/static/css/tiandi-map/fjzx-map-draw.css","css")
var pencilColor = "#00ACFF" ;
var pencilSize =  3 ;
var draw = null ;
var selectedFeatures = null;
//绘图
setTimeout(function () {
    draw = new fjzx.map.Draw({
        map: map,
		isModify :false,
		startCallback: function(rs){	//开始绘画回调
		},
        endCallback: function(rs){	//结束绘画回调
        	var selectInteraction = map.getSelectInteraction();
        	if(selectInteraction != null){
				selectedFeatures = map.getSelectInteraction().getFeatures();   //  清除bug  选中后地图遗留线段
				selectedFeatures.clear();
			}
        	map.render();
            newFeatureManage(rs);

        }
    });
},500)

	//新增图形后
	function newFeatureManage(rs) {
  			rs.pencilColor = pencilColor;
			rs.pencilSize  = pencilSize;
	    	var data = JSON.stringify(rs);
	    	console.log(data);
	}
	initTools();
	function initTools() {

		 var toolsStr = "  <div id=\"ktd\" class=\"easyui-draggable\"\n" +
			 "         data-options=\"handle:'#mmmm .fjzx-draw-map-panel-header',\n" +
			 "            onBeforeDrag:function(e){\n" +
			 "                e.data.target.style.right='auto';\n" +
			 "\t\t}\"\n" +
			 "         style=\"position:absolute;top:300px;left: 707px;\">\n" +
			 "        <div id=\"mmmm\" class=\"fjzx-draw-map-panel panel-left\">\n" +
			 "            <div class=\"fjzx-draw-map-panel-header\">\n" +
			 "\t\t\t<span class=\"title\">\n" +
			 "\t\t\t\t<span class=\"icon iconcustom icon-zhedie3\"></span>区域绘制\n" +
			 "\t\t\t</span>\n" +
			 "            </div>\n" +
			 "            <div class=\"fjzx-draw-map-panel-body no-bargound\" style=\"width:130px;\">\n" +
			 "                <div class=\"point-group-map-draw\">\n" +
			 "                    <a id=\"btn_draw\" value=\"btn_draw\">绘制</a>\n" +
			 "                    <a id=\"btn_clearAll\" value=\"btn_clearAll\">清空</a>\n" +
			 "                    <a id=\"btn_stop\" value=\"btn_stop\">停止绘制</a>\n" +
			 "                </div>\n" +
			 "            </div>\n" +
			 "        </div>";
		$('body').append(toolsStr);

		var  dialogSettingStr = "\t<div id=\"dlgPencil\" class=\"easyui-dialog\" style=\"width: 400px\"\n" +
			"\t\t data-options=\"closed:true,modal:true,border:'thin',buttons:'#dlgPencil-buttons'\">\n" +
			"\t\t<form id=\"fm_pencil\" method=\"post\" novalidate style=\"margin: 0; padding: 20px 50px\">\n" +
			"\n" +
			"\t\t\t<div  style=\"margin-bottom: 10px\">\n" +
			"\t\t\t\t<label class=\"textbox-label textbox-label-before\" title=\"绘制图形\">绘制图形</label>\n" +
			"\t\t\t\t<select id =\"shape\" width=\"200px\">\n" +
			"\t\t\t\t\t<option value =\"Polygon\">多边形</option>\n" +
			"\t\t\t\t\t<option value =\"LineString\">线条</option>\n" +
			"\t\t\t\t</select>\n" +
			"\t\t\t</div>\n" +
			"\t\t\t<div  style=\"margin-bottom: 10px\">\n" +
			"\t\t\t\t<label class=\"textbox-label textbox-label-before\" title=\"流域名称\">画笔颜色</label>\n" +
			"\n" +
			"\t\t\t\t<input type=\"text\" id=\"pencolor\"   width=\"230px\"  />\n" +
			"\t\t\t</div>\n" +
			"\t\t\t<label class=\"textbox-label textbox-label-before\" title=\"画笔粗细\">画笔粗细:</label>\n" +
			"\t\t\t<div class=\"inline-block\">\n" +
			"\t\t\t\t<input id=\"pencilSize\" class=\"easyui-slider\" value=\"3\" style=\"width:220px\"  max = 10 min =1\n" +
			"\t\t\t\t\t   data-options=\"showTip:true,rule:[1,'|',5,'|',10]\"/>\n" +
			"\t\t\t</div>\n" +
			"\t\t</form>\n" +
			"\t\t<div id=\"dlgPencil-buttons\">\n" +
			"\t\t\t<a href=\"javascript:void(0)\" class=\"easyui-linkbutton c6\" iconCls=\"icon-ok\" onclick=\"savePencilManage()\" style=\"width: 90px\">设置</a>\n" +
			"\t\t\t<a href=\"javascript:void(0)\" class=\"easyui-linkbutton\" iconCls=\"icon-cancel\" onclick=\"$('#dlgPencil').dialog('close')\" style=\"width: 90px\">取消</a>\n" +
			"\t\t</div>\n" +
			"\t</div>\n";
		$('body').append(dialogSettingStr);


		$.parser.parse($("#dlgPencil"));//使用局部渲染



	}

	function savePencilManage(){
		draw.clearDraw();
		var shapeSelect=document.getElementById("shape");
		var shareType = shapeSelect.value;

		pencilColor = $("#pencolor").val();
		pencilSize = $("#pencilSize").slider('getValue');

		$('#dlgPencil').dialog('close');
		if(draw != null){
			map.removeInteraction(draw);
		}

		draw.startDraw(shareType,pencilColor,pencilSize);
	}


	//弹出画笔颜色
	function openSetting(){
		$("#pencolor").bigColorpicker("pencolor");
		$("#img").bigColorpicker(function(el,color){
			$(el).css("background-color",color);
		});
		$('#dlgPencil').dialog('open').dialog('center').dialog('setTitle', '设置画笔');
		if(pencilColor !=""){
			$("#pencolor").val(pencilColor);
		}
		if(pencilSize !=""){
			$("#pencilSize").slider('setValue',pencilSize);
		}
	}
 	$("#drawArea").click(function () {
		if ($('.point-group-map-draw').width() <= 0){
			$("#drawArea").html("<span class=\"icon iconcustom icon-zhedie3\"></span> 区域绘制")
			$('.point-group-map-draw').animate({width: '132',opacity:'1'}, 200);
		}else{
			$("#drawArea").html("<span class=\"icon iconcustom\"></span> 区域绘制")
			$('.point-group-map-draw').animate({width: '0',opacity:'0'}, 200);
		}
	})
	//绘制区域点击事件
	$(".point-group-map-draw") .find("a").click(function () {
		$(".point-group-map-draw").find("a").removeClass("select-point");
		$(this).addClass("select-point");
		var operateType = $(".point-group-map-draw .select-point").attr("value");
	    switch (operateType) {
			case 'btn_draw':
					drawArea();
				break;
			case 'btn_update':
				break;
			case 'btn_stop':
			 	  stopDrawSaveFeature();
				break;
			case  'btn_clearAll':
				  clearDarwLayer();
				break ;
    	}
    })
/**
 * 绘制区域
 */
	function drawArea() {
		openSetting();
	}

/**
 * 清空绘制图
 */
	function clearDarwLayer(){
		console.log("clearDarwLayer");
		draw.clearDrawLayer();
	}

/**
 * 停止绘画保留绘制图形
 */
	function  stopDrawSaveFeature() {
		console.log("stopDrawSaveFeature");

		draw.stopDrawSaveFeature();
	}


//动态加载一个js/css文件

function loadjscssfile(filename, filetype){

	if (filetype=="js"){

		var fileref=document.createElement('script')

		fileref.setAttribute("type","text/javascript")

		fileref.setAttribute("src",filename)

	}

	else if (filetype=="css"){

		var fileref=document.createElement("link")

		fileref.setAttribute("rel","stylesheet")

		fileref.setAttribute("type","text/css")

		fileref.setAttribute("href",filename)

	}

	if (typeof fileref!="undefined")

		document.getElementsByTagName("head")[0].appendChild(fileref)

}



