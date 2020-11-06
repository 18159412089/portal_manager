<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html>
<head>
<title>空气质量日报查询</title> <#include "/header.ftl"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/progressbar.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/base.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/testing.css" />
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">

<script type="text/javascript" src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<style type="text/css">
	input[readonly]{
		background-color: #fff;
	}
	.map-legend-container{
		padding: 0px 0px 0px 0px;
	}
	.map-legend-container .item{
		width:14.28%
	}
	.air-AQI-container .air-AQI-box {
		height: 100%;
		padding-top: 35px;
	}
	.air-AQI-container{
		height: 130px;
		padding-left: 5px;
	}
	.num .item{
		text-align: left;
	}
	.map-legend-container .num{
		margin-left:0px;
	}
</style>
</head>
<body ondragstart="return false" style="background:#ffffff;">

<div class="easyui-layout" fit=true>
	
<div class="map-panel panel-top" style="margin:0px auto;top:0px;width:60%;background:#ffffff;border:1px solid #d8cece;">
     <div class="map-panel-body">	            
     	<div class="panel-calendar-containe;background:#ededed;">
			<div id="toolbar" style="padding-top:10px;">
				<div class="form-group" id="area"style="color:#000000">
					<label class="control-label" id="lb_name">区/县：</label>
					<div class="control-div">
						<input id="county" class="easyui-combobox" name="county" style="height: 32px; width: 140px;" data-options="
							url:'/enviromonit/airMonitorPoint/getCity',
							method:'post',
							editable:false,
							valueField:'uuid',
							textField:'name',
							multiple:false,
							panelHeight:'auto'">
					</div>
				</div>
         		<div class="form-group">
					<label class="control-label"style="color:#000000">月份：</label>
					<div class="control-div">
						<input id="monthText" type="text"  class="easyui"style="height: 32px; width: 140px;" readonly="">
					</div>
				</div>
			</div>
         		<div class="calendar-wrapper" id="calendar">
         		
         		</div>
         		
         		<div class="calendar-wrapper">
         			<table style="color:black">
         				<thead>
         					<tr>
         						<th>日</th>
         						<th>一</th>
         						<th>二</th>
         						<th>三</th>
         						<th>四</th>
         						<th>五</th>
         						<th>六</th>
         					</tr>
         				</thead>
         				<tbody >
         					
         				</tbody>
         			</table>
         		</div>
         		<div class="air-AQI-container">
         			<div class="air-AQI-box" id="color" style="color:#000000">
         				<div id="quality"></div>
         				<div><span id="AQI"></span></div>
         			</div>
         			<div class="air-AQI-details" >         				
         				<div class="air-AQI-top">
         					<div class="time fr" id="time"></div>
         					<div class="title" id="city"></div>
         				</div>
         				<div class="AQI-info">
	         				<span id="PM2"></span>
	         				<span id="PM10"></span>
	         				<span id="CO"></span>
	         				<span id="No2"></span>
	         				<span id="O3"></span>
	         				<span id="So2"></span>
         				</div>
     				</div>
					
     			</div>
     		<div class="map-legend-container" style="width:100%;background:#ffffff; color:black">
						<div class="title">
							<div class="item" >优</div>
							<div class="item">良</div>
							<div class="item">轻度</div>
							<div class="item">中度</div>
							<div class="item">重度</div>
							<div class="item">严重</div>
							<div class="item">暂无数据</div>
						</div>
						<div class="grade-legend">
							<div class="item excellent"></div>
							<div class="item good"></div>
							<div class="item mild"></div>
							<div class="item moderate"></div>
							<div class="item severe"></div>
							<div class="item dangerous"></div>
							<div class="item not_data"></div>
						</div>
						<div class="num">
							<div class="item">0</div>
							<div class="item">50</div>
							<div class="item">100</div>
							<div class="item">150</div>
							<div class="item">200</div>
							<div class="item">300</div>
							<div class="item">500</div>
						</div>
					</div>  	
		</div>
     </div>
</div>
		


	</div>
 <script>
 		$('#county').val('350600');
 		
 		layui.use('laydate', function(){
			var laydate = layui.laydate;
			//年月选择器
			laydate.render({
				elem: '#monthText',
				type: 'month',
				value: new Date(),
				max: getNowDate(0),
				btns: ['confirm'],
				done: function(text,date){
					search($('#county').val(),text);
				}
			});
		});
		
		$('#county').combobox({
			onChange: function(){
	   	    	var county = $("#county").val();
	       		search(county,$('#monthText').val());
	   	    }
	   	});
		
 		
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
        };      
        
       
        $(window).resize(function() {
        	
        });
   
    	/*--------------------------加载日历-------------------------*/
    	$(function (){
			var today = new Date();
			var _year = today.getFullYear();
			var _month = today.getMonth() + 1;
			var _day = today.getDate();
			var firstDay = getFirstDay(_year,_month);
	    	var code ='350600';
	    	var day;
	    	var month ;
	    	if(_day<10){
	    		day="0"+_day;
	    	}
	    	if(_month<10){
	    		month="0"+_month;
	    	}
	    	var time = _year+"-"+month;
			cityMonth(code,time,firstDay);
			getCity(code,time+"-"+day);
		
		});
    	
		
		/*----------------------获取城市某天的空气信息----------------*/
		function getCity(pointCode,time){
			$.ajax({
		    url:"/enviromonit/airDayData/getCityAirInfo",
		    type:"post",
		    dataType : 'json', 
		    data:{
		         pointCode:pointCode,
		         time:time
		    },
		    datatype:'json',
		    success:function(data){
		    		if(data[0].AQI == '-' ){
		    			$("#AQI").html("AQI：-");
		    		}else{
						$("#AQI").html("AQI："+data[0].AQI);
					}
					$("#PM2").html("PM2.5："+data[0].PM2);
					$("#PM10").html("PM10："+data[0].PM10);
					$("#CO").html("CO："+data[0].CO);
					$("#No2").html("No2："+data[0].No2);
					$("#O3").html("O3："+data[0].O38);
					$("#So2").html("So2："+data[0].So2);
					$("#city").html(data[0].city);
					$("#time").html(data[0].time);
					if(data[0].AQI < 0 ||  data[0].AQI == '-' ){
					$("#quality").html("-");
						$("#color").attr("class","air-AQI-box not_data");
						$("#quality").html("空气质量：-");
					}else if( data[0].AQI <= 50){
						$("#quality").html("空气质量：优");
						$("#color").attr("class","air-AQI-box excellent");
					}else if(data[0].AQI <= 100){
						$("#quality").html("空气质量：良");
						$("#color").attr("class","air-AQI-box good");
					}else if(data[0].AQI <= 150){
						$("#quality").html("空气质量：轻度污染");
						$("#color").attr("class","air-AQI-box mild");
					}else if(data[0].AQI <= 200){
						$("#quality").html("空气质量：中度污染");
						$("#color").attr("class","air-AQI-box moderate");
					}else if(data[0].AQI <= 300){
						$("#quality").html("空气质量：重度污染");
						$("#color").attr("class","air-AQI-box severe");
					}else if(data[0].AQI <= 500){
						$("#quality").html("空气质量：严重污染");
						$("#color").attr("class","air-AQI-box dangerous");
					}
				}
			})
		}
   
    	/*查询某月的某个城市一个月的时间*/
    	function search(code,time){
    		var arr = time.split("-");
			var firstDay = getFirstDay(arr[0],arr[1]);
    		$('table tbody').html('');
			cityMonth(code,time,firstDay);
			
			
			var today = new Date();
			var year = today.getFullYear();
			var _month = today.getMonth() + 1;
			var _day = today.getDate();
	    	var day;
	    	var month ;
	    	if(_day<10){
	    		day="0"+_day;
	    	}
	    	if(_month<10){
	    		month="0"+_month;
	    	}
	    	var nowTime=year+"-"+month
	    	/*判断是否是当前月 如果是就查询今天 如果不是就查询这个月的第一天*/
	    	if(time==nowTime){
				getCity(code,time+"-"+day);
				return;
			}else{
				getCity(code,time+"-01");
				return;
			}
    	}
    	/*----------------------------------日历显示----------------------*/
    	function cityMonth(code,time,firstDay){
    		$('table tbody').html('');
			$.ajax({
			    url:"/enviromonit/airDayData/getCityByMonth",
			    type:"post",
			    dataType : 'json', 
			    data:{
			         pointCode:code,
				         date:time,
				         firstDay:firstDay
			    },
			    datatype:'json',
			    success:function(data){
			    	var html="<tr>";
			    	//满7换一行
			    	var j = 1;
					$.each(data,function(i){
						
						html += "<td > <div style='height:60px;' class='item pre-m "+
						data[i].color+"' onclick='getCity("+data[i].pointCode+",\""+data[i].time+"\");'> <div class='date' style='color:black'>"+
						data[i].day+"</div><div class='other' style='color:black '>"+
						data[i].polluteName+"</div></div></td>";
						if(j == 7){
							html +="</tr>"
							var $tr = $(html);
							var $table = $('table tbody');
							$table.append($tr);
							j = 1;
							html = "<tr>";
							return ;
						}
						j++;
					 	firstDay = (firstDay+1)%7;	
					});
					if(firstDay!==0) {
				        for (i=firstDay; i<7; i++) {
				            html += "<td></td>";
				        }
					}
					html +="</tr>"
					var $tr = $(html);
					var $table = $('table tbody');
					$table.append($tr);
				
				}
				
			});
    	}
    	/*判断是否是闰年*/
		function runNian(year) {
		    if(year%400 === 0 || (year%4 === 0 && year%100 !== 0) ) {
		        return true;
		    }
		    else { return false; }
		}
		/*判断某年某月的第一天是星期几*/
		function getFirstDay(year,month) {
		    var allDay = 0, y = year-1, i = 1;
		    allDay = y + Math.floor(y/4) - Math.floor(y/100) + Math.floor(y/400) + 1;
		    for ( ; i<month; i++) {
		        switch (i) {
		            case 1: allDay += 31; break;
		            case 2: 
		                if(runNian(year)) { allDay += 29; }
		                else { allDay += 28; }
		                break;
		            case 3: allDay += 31; break;
		            case 4: allDay += 30; break;
		            case 5: allDay += 31; break;
		            case 6: allDay += 30; break;
		            case 7: allDay += 31; break;
		            case 8: allDay += 31; break;
		            case 9: allDay += 30; break;
		            case 10: allDay += 31; break;
		            case 11: allDay += 30; break;
		            case 12: allDay += 31; break;
		        }
		    }
		    return allDay%7;
		}
		
		
    	 //获取时间格式化(cutDay为往前几天，0为当天)
		function getNowDate(cutDay) {
			var d = new Date();
			var nowDateTime = d.getTime() - cutDay*60000*60*24;
			d.setTime(nowDateTime);
			var year = d.getFullYear();
			var month = d.getMonth()+1;
			var date = d.getDate();
			var currentdate = year+"-"+month;
		    return currentdate;
		}
</script>
</body>
</html>