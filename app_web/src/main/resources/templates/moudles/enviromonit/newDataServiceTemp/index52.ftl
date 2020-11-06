<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>监测因子同比</title>
</head>
<!-- body -->
<body >
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout p10" >
    <!-- 搜索栏 -->
    <div id="searchBar1" class="searchBar">
        <form id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">监测站点:</label>
                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointId" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=0',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
             </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)"  onclick="exportImage()" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
            <div class="inline-block fr">
                <!-- 单选按钮组 -->
                <div id="timegroup" class="radio-button-group style-btn-group">
                            <span  name="DAY" class="active">日</span>
							<span  name="MONTH">月</span>
							<span  name="YEAR">年</span>
                </div>
                <!-- 单选按钮组 over-->
            </div>
        </form>

    </div>
    <!-- 搜索栏 over-->
    <div id = "chartDiv"></div>
    
     

</div>
</body>
<script>
    var pollutantCode = ['W01001','W01009','W01019','W21003','W21011','W01017'] ;
    var pollutantName=  ['PH','溶解氧','高锰酸盐','氨氮','总磷','五日生化需氧量'] ;
//初始化头部三大模块 div

    //导出图片
    function exportImage(){
        var pointIds = $("#pointId").combobox('getValues');
        var pointNames = $("#pointId").combobox('getText');
        pointIds   =  changeString(pointIds);
        var pointArr = pointIds.split(",");
        var pointNameArr = pointNames.split(",");
         for (var i = 0; i <pointArr.length ; i++) {
              if(document.getElementById(("airPrimaryPollutant-"+pointArr[i].replace("'","").replace("'","")))!=null) {
                        Ams.exportPdfById(("airPrimaryPollutant-"+pointArr[i].replace("'","").replace("'","")),pointNameArr[i]+'监测因子同比')
              }
        }
    }

    function initTreeModleDiv(pointCode){
         var titleModelName = ["currentItem-","lastItem-","allItem-"];    	
         var type =  $("#timegroup").find("span[class = 'active' ]").attr("name"); 
         $.ajax({
 			type : 'POST',
 			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/wtYearOnYearCompareResult",
 			data : {
 				"pointCodes"   :pointCode,
 		        "currentTime"  :currentTime,
 				"lastTime"     :lastTime,
 				 "type"        : type  		  
 			},
 			dataType: "json",
 			success : function(result) {
 			 	var id = "";
 				var timeType = "";
 				 if(JSON.stringify(result) != '{}'){
 					  for(var k in titleModelName){
 						   var htmlstr = "";
 						   var emclass = "em";
 						   if(k == 0){
 							  timeType= "currentItem";
 							}else if(k == 1){
 							  timeType= "lastItem";
 							}else{
 							  timeType= "currentItem";
 							} 
 						 
 					 	     for(var i = 0 ; i<pollutantCode.length;i++){
 					 	    	    var val = ""
 					 	    	    
 					 	    	    if(typeof(result[pointCode][pollutantCode[i]])=="undefined"){
 					 	    	 	 	val = "-";
 					 	    	 	    emclass = "em";
 					 	    	 	}else{
 					 	    	 		if(k >=2){
 	 					 	    	      //计算同比
 	 					 	    	      var rateOfRise = (result[pointCode][pollutantCode[i]].currentItem -result[pointCode][pollutantCode[i]].lastItem)/result[pointCode][pollutantCode[i]].lastItem;
 	 					 	    	      if(rateOfRise > 0 ){
 	 					 	    	    	emclass = "em up";
 	 					 	    	      }else if (rateOfRise < 0){
 	 					 	    	    	emclass = "em down";
 	 					 	    	      }else{
 	 					 	    	    	 emclass = "em";
 	 					 	    	      }
 	 					 	    	    }else{
 	 					 	    	    	emclass = "em";
 	 					 	    	    }
 					 	    	 		if(typeof(result[pointCode][pollutantCode[i]][timeType]) == "undefined"){
	  					 	    	    	val = "-";
	  					 	    	    }else{
 					 	    	 			val = result[pointCode][pollutantCode[i]][timeType] ;
	  					 	    	   }
 					 	    	 	}
 					 	    	 
 					                htmlstr="<div class='inline-block'>"
				                            +"<span>"+pollutantName[i]+"：</span>"
				                            +"<span class='"+emclass+"'>"+val+"</span>"
	                  	 			   +"</div>";
 						    		if(i>=3){
 						    			   id = "#"+titleModelName[k]+pointCode+"-2" ;
 						    			
 						    		}else{
 						    			   id = "#"+titleModelName[k]+pointCode+"-1" ;
 						    		 }
 						    		$(id).append(htmlstr);
				 		     }  
 						      
 					   }  
 					
 				}
 			  },
 			error: function(){
 			}
 		}); 
         
    }
     //初始化图表div	
	function initChartDiv(pointCode , pointName,dateTime,pollutantgroup,airPrimaryPollutant){
		var htmlStr = "<div class='chart-group'>"
			          +"<div class= 'data-info-layout'>"
					          +"<div class='other'>"
						           +"<div class='inline-block'>"
							          +"<span class='control-label'>监测时间：</span>"
							          +"<span class='control-content'>"+dateTime+" </span>"
					                +"</div>"
					               +"<div class='inline-block'>"
						               +  "<span class='control-label'>监测站点：</span>"
						               + " <span class='control-content'>"+pointName+"</span>"
					               + "</div>"
				               + "</div>"
				               +"<div class='row'>"
					              	 +"<div  class='item col-xs-4'>"
					              	 	+"<div  class='cell-title'>"+dateTime+"</div>"
					              	 	+"<div  id='currentItem-"+pointCode+"-1' class='cell-content'>"
					              	 	+"</div>"
					              	 	+"<div  id='currentItem-"+pointCode+"-2' class='cell-content'>"
					              	 	+"</div>"
					              	 +"</div>"
					              	 +"<div  class='item col-xs-4'>"
					              	     +"<div  class='cell-title'>"+lastTime+"</div>"
						             	 +"<div id='lastItem-"+pointCode+"-1' class='cell-content'>"
					              	 	 +"</div>"
					              	 	 +"<div id='lastItem-"+pointCode+"-2' class='cell-content'>"
					              	 	 +"</div>"
					              	 +"</div>"
					              	 +"<div id='allItem-"+pointCode+"' class='item col-xs-4'>"
					                     +"<div  class='cell-title'>"+dateTime+"与"+lastTime+"同比</div>"
						              	 +"<div id='allItem-"+pointCode+"-1' class='cell-content'>"
					              	 	 +"</div>"
					              	 	+"<div id='allItem-"+pointCode+"-2' class='cell-content'>"
					              	 	 +"</div>"
					              	 +"</div>"
				                +"<div>"
		               +"</div>"
		               +"<div class='chartBar'>"
				               		+"<div class='chart-box'>"
				               			+"<div class='optionBar tc'>"  	
					               				+"<div id='"+pollutantgroup+"' class='radio-button-group style-btn-group'>"
							               				+"<span class='active' name ='W01001'>PH</span>"
							               				+"<span name ='W01009'>溶解氧</span>"
							               				+"<span name ='W01019'>高锰酸盐</span>"
							               				+"<span name ='W21003'>氨氮</span>"
							               				+"<span name ='W21011'>总磷</span>"
							               				+"<span name ='W01017'>五日生化需氧量</span>"
					   							+"</div>"
				   						 +"</div>"
				                  			 +"<div id='"+airPrimaryPollutant+"' style='width: 100%;height: 420px;'></div>"
				              		 +"</div>"
		           		+"</div>"
		             +"</div>"
		            
		             $("#chartDiv").append(htmlStr);
		          
		             initTreeModleDiv(pointCode);
		             initRadioButtonEvent();
	}

    $.parser.onComplete = function () {
    	
    	   $('#pointId').combobox('setValue','A350600_0001');
           $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    function initRadioButtonEvent(){
    	 /*单选按钮组*/
    	$(".radio-button-group").unbind("click");
	    $(".radio-button-group").on("click", "span", function () {
	    	 $(this).siblings("span").removeClass("active");
	         $(this).addClass("active");
	         var type = $(this).parent().attr("id").split("-")[0];
	         
	         var id = $(this).parent().attr("id").split("-")[1];
	         switch (type) {
	        		 case "timegroup" :
	        		      doSearch();
	        		    break;
	        		case "pollutantgroup" :
	        			  doSearch(id);
	       			 break;
	         }
	      });
      }
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
    
    function doSearch(pointCode){
    	initTime();
		initDatas(pointCode);
	}
    
    var currentTime = null ;
    var lastTime = null ;
    $("#startTime").val(new Date().format("yyyy-MM-dd"));
    initTime();
    // 初始化时间
    function initTime(){
    	  lastTime =   $("#startTime").val().split("-");
          lastTime = lastTime[0]-1+"-"+lastTime[1]+"-"+lastTime[2];
          currentTime =$("#startTime").val();
    }
    //拼站点字符串
    function changeString(strobj){
    	var s = "";
        for(var i = 0 ;i <strobj.length;i++){
    		s ="'"+strobj[i]+"'"+','+s;
    	}  
    	return  s.substring(0,s.length-1);
    }

     
    //初始化数据资源
    function  initDatas(pointCode){

      var colors = ['#2ba4e9','#ffbf26'];	
  	  var pointIds = $("#pointId").combobox('getValues');
  	  var currentTime = $("#startTime").val();
  	  var type =  $("#timegroup").find("span[class = 'active' ]").attr("name"); 
  	  var selectPollutant = null ;
  	  if(typeof(pointCode) =="string"){
  			selectPollutant =$("#pollutantgroup-"+pointCode).find("span[class = 'active' ]").attr("name");
  	  }else{
  			 selectPollutant = "W01001";
  	  }
  	  
  	  $.ajax({
			type : 'POST',
			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/wtYearOnYearCompare",
			data : {
				"pointCodes"   :changeString(pointIds),
		        "currentTime"  :currentTime,
				"lastTime"     :lastTime,
				 "type"        : type ,
				"pollutantCode":selectPollutant				  
			},
			dataType: "json",
			success : function(result) {
			 
				if(JSON.stringify(result) != '{}'){
					if(typeof(pointCode) == "undefined"){
			    		 $("#chartDiv").empty();
					}
					 for (var key in  result) {
						    var obj = result[key];
				    	    var timeArr = obj.monitorTimeArr;
				    	    var pointName = obj.pointName;
				    	    var pollutantArr = new Array();
				    	    for(var i = 0 ; i<2 ; i++){
				    	    	var timemonitorValArr = null ;
				    	    	var tipName = null ;
				    	    	if(i == 0 ){
				    	    	    tipName = currentTime+" "+obj.polluteName;
				    	    		timemonitorValArr = obj.currentTimemonitorValArr;
				    	    	}else{
				    	    		tipName = lastTime+" "+obj.polluteName;
				    	    		timemonitorValArr = obj.lastTimemonitorValArr;
				    	    	}
				    	        var currentPollutantObj =  {
					                     name:tipName,
					                     type:'line',
					                     symbol: 'circle',
					                     symbolSize:6,
					                     smooth:false,
					                     itemStyle:{
					                         normal: {
					  							 color: colors[i]
					                         }
					                     },
					                     data:timemonitorValArr
					            };
				    	    	pollutantArr.push(currentPollutantObj);
				    	    }
				    	    if(typeof(pointCode) == "string"){
				    	          if(key == pointCode ){
				    	        	    initEcharts(pointName,timeArr,pollutantArr,"airPrimaryPollutant-"+key); 
							       }
						   }
				    	   if(typeof(pointCode) == "undefined"){
				    		    initChartDiv(key,pointName,$("#startTime").val(),"pollutantgroup-"+key ,"airPrimaryPollutant-"+key);
					    	    initEcharts(pointName,timeArr,pollutantArr,"airPrimaryPollutant-"+key); 
						    }
				    	   
				    	    
				      }  
				} 
			  },
			error: function(){
			}
		}); 
    }
     
    
    
    var airPrimaryPollutantChart = null ;
    // 基于准备好的dom，初始化echarts实例
    function initEcharts(pointName,timeArr,pollutantObjs,echartId){
    	  
    		 var airPrimaryPollutantOption= {
    	             tooltip : {
    	                 trigger: 'axis',
    	                 axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    	                     type : ''        // 默认为直线，可选为：'line' | 'shadow'
    	                 }
    	             },
    	             title: {
    	                 text: pointName,
    	                 top:5,
    	                 textStyle:{ //设置主标题风格
    	                     fontSize: 14,
    	                     color:'#404040',
    	                     fontWeight:100,
    	                 },
    	             },
    	            grid: {
    	                 top:'50',
    	                 left: '10',
    	                 right: '10',
    	                 bottom: '10',
    	                 containLabel: true
    	             },
    	             xAxis:  {
    	                 type: 'category',
    	                 data: timeArr
    	             },
    	             yAxis: {
    	                 type: 'value',
    	                 splitNumber:12 
    	                 
    	             },
    	             series: pollutantObjs
    	 			};
             // 使用刚指定的配置项和数据显示图表。
         	 airPrimaryPollutantChart = echarts.init(document.getElementById(echartId));
         	 airPrimaryPollutantChart.setOption(airPrimaryPollutantOption, true);
      }
    
    
    $(function () {
    	airPrimaryPollutantChart= null ;
        initChartDiv($('#pointId').combobox('getValue'),$('#pointId').combobox('getText'),$("#startTime").val(),"pollutantgroup-"+$('#pointId').combobox('getValue'),"airPrimaryPollutant-"+$('#pointId').combobox('getValue'));
    	 //初始化数据
         initDatas();
         window.onresize = function() {
        	 /* var pointIds = $("#pointId").combobox('getValues');
        	 console.log(pointIds);
        	 for(var i = 0 ; i < pointIds.length ;i++){
        		    var id = "#airPrimaryPollutant-"+pointIds[i];
        		    $(id).width('100%');
               	    echarts.init(document.getElementById(id)).resize();
        	 } */
         }


    })


</script>
</html>