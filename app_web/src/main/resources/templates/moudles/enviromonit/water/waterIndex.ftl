<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en" >
<head>
    <title>总体情况</title>
</head>
<!-- body -->
<body style="overflow: auto;">
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<#include "/secondToolbar.ftl">
<div class="container container-top"  >
    <!-- main -->
 	<div class="column-panel-group col-xs-12">
		<div class="column-panel" >
	         <div class="column-panel-header"> 
	         	<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->       	
				<span class="title">
					河流环境质量状况
				</span>
	         </div>
	         <div class="column-panel-body">
		         <div class="row">
		         	<div id="WatertypeBar"  style="width:100%;height:280px;"></div>
		         	<div id="WatertypeBarItem">
			          <p class="text-item">全市3条主要河流24个水质评价断面，总体水质状况由上年的“优”下降为“良好”。</p>
			         	<p class="text-item">主要流域10个国控断面，1-6月先后有6个断面出现了超标， 分别是<span class="highlight">上坂（5次）、长泰洛宾（4次）、平和洪濑汤坑桥（3次）、南靖靖城桥（2次） 、云霄高塘渡口（3次）和诏安澳仔头（2次） </span>。</p>
			         	<p class="text-item">根据国家委托第三方采样监测结果，6月份，云霄高塘渡口、诏安澳仔头2个断面水质超标。</p>
			         	<p class="text-item">根据1-6月均值，<span class="highlight">西溪上坂、长泰洛宾、平和洪濑汤坑桥 </span>3个断面水质目前暂未达标。</p>  
		         	</div>
		         	
		         </div>
	         </div>
	    </div>
	</div>
 	  		<!--   <div class="column-panel-group  col-xs-12" style="margin-left: 14%;">
		<div class="column-panel">
	         <div class="column-panel-header"> 
	         	<div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>      	
				<span class="title">
					饮用水源及湖库环境质量状况
				</span>				
	         </div>
	         <div class="column-panel-body col-xs-8" style="height: 560px;">
	         	<div id="standardPie" style="width:50%;height:340px;"></div>
	         	<p class="text-item">全市13个集中式生活饮用水水源取水口水质达标率为100%。</p>
	         	<p class="text-item">市区3个饮用水源水质达标率100%，与2017年同期相比持平。</p>
	         	<p class="text-item">各县（市、区）10个水源水质达标率为100%，与2017年同期相比持平。</p>
	         	<p class="text-item">全市2个主要湖库都出现超标，与2017年同期相比，南一水库由Ⅳ类下降为Ⅴ类，峰头水库水质由III类下降为劣Ⅴ类。南一水库总磷出现超标，超标倍数为1.55。
	         		<br/>峰头水库pH、总磷超标，pH为劣Ⅴ类，总磷超标0.02倍。
	         	</p>
	         </div>
	    </div>
	</div>  -->

 	<div class="column-panel-group  col-xs-12">
			<div class="column-panel">
				<div class="column-panel-header col-xs-3">
	         	<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
				<span class="title">
					小流域环境质量状况
				</span>				
	         </div>
	         <div class="column-panel-body" style="height: 560px;">
	         	<div class="row">
	         		<div class="col-xs-6">
						<div id="WatertypePie" style="height:400px;width:100%;"></div>
					</div>
	         		 <div class="col-xs-6">
						<div class="monitor-container">
							<div class="monitor-title fl">龙文区</div>
							<div class="sr-only fr">70</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="70" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">长泰县</div>
							<div class="sr-only fr">30</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="30" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">平和县</div>
							<div class="sr-only fr">85</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="85" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">绍安县</div>
							<div class="sr-only fr">45</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="45" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">南靖县</div>
							<div class="sr-only fr">80</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="80" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">华安县</div>
							<div class="sr-only fr">85</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="85" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">云霄县</div>
							<div class="sr-only fr">65</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="65" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">漳浦县</div>
							<div class="sr-only fr">75</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="75" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">龙海市</div>
							<div class="sr-only fr">55</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="55" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
						<div class="monitor-container">
							<div class="monitor-title fl">芗城区</div>
							<div class="sr-only fr">75</div>
							<div class="progress">
								<div class="progress-bar" data-type="progressbar" aria-valuenow="75" aria-valuemax="100" bar-bgColor="#e4edf7" bar-color="#51a1fa" bar-stroke-width="20" bar-font="auto"></div>
							</div>
						</div>
					</div>
	         	</div>
	         	 <div class="row">
	         		<p class="text-item">按断面评价，60个小流域评价断面，Ⅰ类～Ⅲ类水质比例为55％，Ⅳ类水质比例为18.3％，Ⅴ类及劣Ⅴ类水质比例为26.7％。与2017年同期水质相比，Ⅰ类～Ⅲ类水质比例<span class="highlight">上升5个百分点</span>，Ⅳ类水质比例不变，Ⅴ类及劣Ⅴ类水质比例减少了5个百分点。</p>
	         		<p class="text-item">按行政区统计，10个县（市）区Ⅰ类～Ⅲ类水质比例在0％～100％之间，从高到低排序：<span class="highlight">龙文区、长泰县、平和县、诏安县、南靖县、华安县、云霄县、漳浦县、龙海市、芗城区</span>，其中龙文区和长泰县均为100%，龙海市和芗城区均为0%。</p>
	        	</div>  
	         </div>
	    </div> 
	    </div>
 	<div class="column-panel-group col-xs-12  col-spacing-top">
		<div class="column-panel">
	         <div class="column-panel-header"> 
	         	<div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>     	
				<span class="title">
					小流域环境质量状况
				</span>				
	         </div>
	         <div class="column-panel-body">
		         <div class="row">
		         	<div id="WaterPollutionBar"  style="width:100%;height:280px;"></div>
		        	  <p class="text-item">2017年底，我市仍有10条劣V类小流域（11个劣V类小流域断面），分别是：芗城大水溪、丰山溪，龙海高排渠、程溪溪，华安银塘溪，南靖斗米溪、适中溪、黄井溪南靖段，黄井溪平和段，云霄山美溪，南溪漳浦段（何寮上游断面）。
						<br/>今年1-5月份，共监测了3次。
						<br/>一、有4个劣V类断面3次监测水质都已提升至V类以上，分别是：芗城大水溪、龙海高排渠、华安银塘溪、黄井溪平和段。
						<br/>二、有3个劣V类断面3次监测水质都仍是劣V类，分别是：芗城丰山溪、云霄山美溪、南溪漳浦段（何寮上游断面）。
						<br/>三、其余4个劣V类断面虽个别月份水质有提升至V类以上，但水质存在波动，未稳定消除劣V类水质，分别是：龙海程溪溪，南靖斗米溪、适中溪、黄井溪南靖段。
						<br/>四、有3个断面3月份水质由V类以上降至劣V类，分别是：南溪漳浦段（西岭大桥断面）、漳浦小南溪，南靖高才溪。5月份，以上3个断面水质已恢复至V类以上。</p>
		         	<p class="text-item">与2017年相比，5月监测结果如下：
						<br/>水质变好断面13个，分别是：芗城区大水溪，龙海市高排渠、程溪溪，华安县银塘溪，长泰县湖珠溪、坂里溪，平和县芦溪、黄井溪平和段，南靖县斗米溪、高才溪、黄井溪南靖段，漳浦县龙岭溪，诏安县西溪。
						<br/>水质变差断面2个，分别是：平和县三合溪，南溪漳浦段（西岭大桥断面）。
						<br/>仍有4个断面水质是劣V类，分别是：芗城丰山溪、南靖适中溪、云霄山美溪和南溪漳浦段（何寮上游断面）。</p> 
		         </div>
	         </div>   
	    </div>
	</div>
    <!-- main over -->
</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
		
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    
    var placeHolderStyle = {
	    normal: {
	        color: '#f2f2f2'
	    },
	    emphasis: {
	        color: '#f2f2f2'
	    }
	};
    
    $(function () {
    	 doSearch();
    });
    
    
    $(window).resize(function () {

    });
	
	function doSearch(){
		var date=new Date;
		var year=date.getFullYear(); 
		var month=date.getMonth()+1;
		var startTime = year+"-1";
		var endTime = year+"-"+month;
		getWaterPollutionLevelData(startTime, endTime);
		getWatertypePieData(startTime,endTime);
		getWatertypeBar(startTime,endTime);
		//getStandardPie();注释代码湖库;
		
	}
	
    /*---------------------------------------小流域环境-------------------------------------------*/
    function getWatertypePieData(startTime,endTime){
    	$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/water/wtReportData/getBasinQuality",
			data : {
				startTime:startTime,
				endTime:endTime
			},
			dataType: "json",
			success: function(data){
				setWatertypePieData(data.data)
			},
			error: function(r){console.log(r);}
		});
    }
    /*---------------------------------------小流域环境质量状况 -------------------------------------------*/
    
	function getWaterPollutionLevelData(startTime, endTime) {
		/* 统计每个质量等级的数量 */
		$.ajax({
			type : "post",
			url : Ams.ctxPath+"/enviromonit/water/wtReportData/countWaterQuality",
			async : true,
			data : {
				"startTime" : startTime,
				"endTime" : endTime
			},
			success : function(result) {
				setWaterPollutionData(result.data)
			},
			error : function(result) {
				console.log(result);
			},
			dataType : 'json'
			});
	}
	/*---------------------------------------河流环境质量状况-------------------------------------------*/
	function getWatertypeBar(startTime,endTime){
		
    	$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/water/wtReportData/getWatertypeBar",
			data : {
				startTime:startTime,
				endTime:endTime
			},
			dataType: "json",
			success: function(data){
				var html='<p class="text-item">全市3条主要河流<span class="highlight">'+(data.count-1)+'</span>个水质评价断面。</p>'
	         	+'<p class="text-item">主要流域<span class="highlight">'+data.category1+'</span>个断面，'+startTime.split('-')[0]+'年'+startTime.split('-')[1]+'-'+endTime.split('-')[1];
			    var point=data.point;
			    var times=data.time;
			    var temp=0;
			    var gk="<span style='color:black'>国控断面:</span>"
				var sk="<span style='color:black'>省控断面:</span>"
				var zj="<span style='color:black'>自建断面:</span>"
				var gskCount = 0;
				for(var i=0;i<point.length;i++){
					if(times[i]!=0){
						if(point[i].pointName.indexOf('华安西陂')){
							temp++;
						 }
						 if(point[i].category==1){
							 if(point[i].pointName.indexOf('华安西陂')){
								 gk+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:red' >"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
							 // }else {
								//  gk+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:blue' >"+"（龙岩市）"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
							 }
						 }else if(point[i].category==2){
							 sk+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:red' >"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
						 }else if(point[i].category==3){
							 zj+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:red' >"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
						 }
					}
					if(point[i].category==2||point[i].category==1){
						gskCount++;
					}
				}
				    //判断国控自建和声控是否有数据有的话渠道
			    if(gk.length==38){
			    	gk="";
			    }else{
			    	gk=gk.slice(0,gk.length-1);
			    	gk+=";<br/>"
			    } 
			    if(sk.length==38){
			    	sk="";
			    }else{
			    	sk=sk.slice(0,sk.length-1);
			    	sk+=";<br/>"
			    }
			    if(zj.length==38){
			    	zj="";
			    }else{
			    	zj=zj.slice(0,zj.length-1);
			    	zj+=";<br/>"
			    } 	
				html+='月先后有<span class="highlight">'+temp+'</span>个断面出现了超标， 分别是:<span class="highlight"><br/>'+gk+sk+zj;

				gk = "<span style='color:black'>国控断面:</span>"
				sk = "<span style='color:black'>省控断面:</span>"
				zj = "<span style='color:black'>自建断面:</span>"
				var gskMonth = 0;
				var overproofPoint1 = data.overproofPoint1;
				for (var i = 0; i < overproofPoint1.length; i++) {
					if (overproofPoint1[i].category == 1) {
						gk += "<a href='javascript:void(0)' onclick='clickSkip(" + overproofPoint1[i].category + ",\"" + overproofPoint1[i].pointCode + "\")'  style='color:red' >" + overproofPoint1[i].pointName + "</a>、";
						gskMonth++;
					} else if (overproofPoint1[i].category == 2) {
						sk += "<a href='javascript:void(0)' onclick='clickSkip(" + overproofPoint1[i].category + ",\"" + overproofPoint1[i].pointCode + "\")'  style='color:red' >" + overproofPoint1[i].pointName + "</a>、";
						gskMonth++;
					} else if (overproofPoint1[i].category == 3) {
						zj += "<a href='javascript:void(0)' onclick='clickSkip(" + overproofPoint1[i].category + ",\"" + overproofPoint1[i].pointCode + "\")'  style='color:red' >" + overproofPoint1[i].pointName + "</a>、";
					}
				}
				if (gk.length == 38) {
					gk = "";
				} else {
					gk = gk.slice(0, gk.length - 1);
					gk += ";<br/>"
				}
				if (sk.length == 38) {
					sk = "";
				} else {
					sk = sk.slice(0, sk.length - 1);
					sk += ";<br/>"
				}
				if (zj.length == 38) {
					zj = "";
				} else {
					zj = zj.slice(0, zj.length - 1);
					zj += ";<br/>"
				}

				html += '</span></p><p class="text-item">' + endTime.split('-')[1] + '月份，<span class="highlight">' + zj + ' </span>共' + (data.overproofPoint1.length-gskMonth) + '个断面水质超标。</p>';

				var overproofPoint2 = data.overproofPoint2;
				gk = "<span style='color:black'>国控断面:</span>"
				sk = "<span style='color:black'>省控断面:</span>"
				zj = "<span style='color:black'>自建断面:</span>"
				var skVag =  0;
				for (var i = 0; i < overproofPoint2.length; i++) {
					if (overproofPoint2[i].category == 1) {
						gk += "<a href='javascript:void(0)' onclick='clickSkip(" + overproofPoint2[i].category + ",\"" + overproofPoint2[i].pointCode + "\")'  style='color:red' >" + overproofPoint2[i].pointName + "</a>、";
					} else if (overproofPoint2[i].category == 2) {
						sk += "<a href='javascript:void(0)' onclick='clickSkip(" + overproofPoint2[i].category + ",\"" + overproofPoint2[i].pointCode + "\")'  style='color:red' >" + overproofPoint2[i].pointName + "</a>、";
						skVag++;
					} else if (overproofPoint2[i].category == 3) {
						zj += "<a href='javascript:void(0)' onclick='clickSkip(" + overproofPoint2[i].category + ",\"" + overproofPoint2[i].pointCode + "\")'  style='color:red' >" + overproofPoint2[i].pointName + "</a>、";
					}
				}
				if (gk.length == 38) {
					gk = "";
				} else {
					gk = gk.slice(0, gk.length - 1);
					gk += ";<br/>"
				}
				if (sk.length == 38) {
					sk = "";
				} else {
					sk = sk.slice(0, sk.length - 1);
					sk += ";<br/>"
				}
				if (zj.length == 38) {
					zj = "";
				} else {
					zj = zj.slice(0, zj.length - 1);
					zj += ";<br/>"
				}
				html += '<p class="text-item">根据' + startTime.split('-')[1] + '-' + endTime.split('-')[1] + '月均值，<span class="highlight">' + gk+zj + ' </span>共' + (data.overproofPoint2.length - skVag) + '个断面水质目前暂未达标。</p>';//+gk+sk
			         	
			         	 
				$("#WatertypeBarItem").html(html);
				setWatertypeBar(data);
				//setWatertypePieData(data.data)
			},
			error: function(r){console.log(r);}
		});
	}
	/*---------------------------------------饮用水源及湖库环境质量状况-------------------------------------------*/
	function getStandardPie(){
		setStandardPie();
	}
    
	function setWatertypePieData(WatertypePieData){
        var WatertypePie = echarts.init(document.getElementById('WatertypePie'));
        WatertypePie.clear();
        WatertypePieOption ={    		
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
       	    	orient: 'horizontal',
                top: '10',
                left:'14',
       	        data:['Ⅰ类～Ⅲ类水质','Ⅳ类水质','Ⅴ类及劣Ⅴ类水质']
       	    },
            series : [
                {
                    name: '小流域环境',
                    type: 'pie',
                    radius : [0, '60%'],
                    center: ['50%', '52%'],
                    data:WatertypePieData,
                    label: {
                        formatter: '{b}\n{d}%'
                    }
                    /* roseType : 'radius' */
                    
                }
            ]

        };
        WatertypePie.setOption(WatertypePieOption);
	}
	 /*---------------------------------------小流域环境质量状况 -------------------------------------------*/
	// countWaterLevel统计小河流域每个等级的数量有多少个 
	function setWaterPollutionData(countWaterLevel) {
		var WaterPollutionBar = echarts.init(document.getElementById('WaterPollutionBar'));
		var WaterPollutionBarOption = {
			tooltip : {
				trigger : 'axis',//trigger: 'item'
				axisPointer : { // 坐标轴指示器，坐标轴触发有效
					type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			grid : {
				top : '30',
				left : '10',
				right : '10',
				bottom : '10',
				containLabel : true
			},
			xAxis : {
				type : 'category',
				axisLabel : {
					type : 'category',
					interval : 0
				},
				data : [ '未知', 'I', 'II', 'III', 'IV', 'V', '劣V' ]
			},
			yAxis : {
				type : 'value',
			},
			series : [ {
				name : '断面',
				type : 'bar',
				barWidth : '50%',
				itemStyle : {
					normal : {
						color : '#2ba4e9',
					}
				},
				data : countWaterLevel
			//[ 120, 132, 101, 134, 90, 130, 110 ]
			}

			],
		};
		WaterPollutionBar.setOption(WaterPollutionBarOption);
        window.onresize = function() {
            $('#WaterPollutionBar').width('100%');
            WaterPollutionBar.resize();
        }
	}
	
	
	/*---------------------------------------河流环境质量状况-------------------------------------------*/
	function setWatertypeBar(data){
		var WatertypeBar = echarts.init(document.getElementById('WatertypeBar'));
		WatertypeBar.clear();
	    var WatertypeBarOption ={            
	        tooltip : {
	            trigger: 'axis',//trigger: 'item'
	            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	            }
	        },
	        legend: {
	            orient: 'horizontal',
	            right:'30',
	            data: data.type
	        },
	        grid: {
	            top:'50',
	            left: '10',
	            right: '30',
	            bottom: '10',
	            containLabel: true
	        },
	        xAxis:  {
	            type: 'category',
	            axisLabel:{
	                type:'category',
	                interval:0,
	                formatter:function(value)
                    {
                        return value.split("").join("\n");
                    }
	            },
	            data: data.pointName
	        },
	        yAxis: {
	            type: 'value'
	        },
	        series: [
	            {
	            	name: 'Ⅰ',
	                type: 'bar',
	                stack: 'one',
	                barWidth:'50%',
	                itemStyle:{
	                    normal:{
	                        color:'#2ba4e9'
	                    }
	                },
	                data: data.type2
	            },
	            {
	            	name: 'Ⅱ',
	                type: 'bar',
	                stack: 'one',
	                barWidth:'50%',
	                itemStyle:{
	                    normal:{
	                        color:'#a4e0a7'
	                    }
	                },
	                data: data.type3
	            },
	            {
	                name: 'Ⅲ',
	                type: 'bar',
	                stack: 'one',
	                barWidth:'50%',
	                itemStyle:{
	                    normal:{
	                        color:'#ffff00'
	                    }
	                },
	                data: data.type4
	            },
	            {
	                name: 'Ⅳ',
	                type: 'bar',
	                stack: 'one',
	                barWidth:'50%',
	                itemStyle:{
	                    normal:{
	                        color:'#fe8a57'
	                    }
	                },
	                data: data.type5
	            },
	            {
	                name: 'Ⅴ',
	                type: 'bar',
	                stack: 'one',
	                barWidth:'50%',
	                itemStyle:{
	                    normal:{
	                        color:'#d02032'
	                    }
	                },
	                data: data.type6
	            },
	            {
	                name: '劣Ⅴ',
	                type: 'bar',
	                barWidth:'50%',
	                stack: 'one',
	                itemStyle:{
	                    normal:{
	                        color:'#560337'
	                    }
	                },
	                data: data.type7
	            },
	            {
	                name: '未知',
	                type: 'bar',
	                stack: 'one',
	                barWidth:'50%',
	                itemStyle:{
	                    normal:{
	                        color:'#b8b8b8'
	                    }
	                },
	                data: data.type1
	            }

	        ],
	    };
	    WatertypeBar.off('click');
	    WatertypeBar.on('click', function (params) {
			console.log(params);
        });
	    WatertypeBar.setOption(WatertypeBarOption);
        window.onresize = function() {
            $('#WatertypeBar').width('100%');
            WatertypeBar.resize();
        }
	}
    
	
	/*---------------------------------------饮用水源及湖库环境质量状况-------------------------------------------*/
	function setStandardPie(){
		var standardPie = echarts.init(document.getElementById('standardPie'));
	    var standardPieOption ={
	   	    tooltip: {
	   	        trigger: 'item',
	   	        formatter: "{a} <br/>{b}: {d}%"
	   	    },
	   	    legend: {
	   	    	orient: 'horizontal',
	            top: '10',
	            left:'14',
	   	        data:['全市13个集中式生活饮用水','市区3个饮用水源水质','各县（市、区）10个水源水质']
	   	    },
	   	    series: [       	        
	   	        {
	   	            name:'达标率',
	   	            type:'pie',
	   	            radius: [100, 118],
	   	         	center: ['50%', '54%'],
	   	         	hoverAnimation: false,
	   	            clockWise: false,
	   	            startAngle: 90,
	   	            data:[
	   	                {value:96, name:'全市13个集中式生活饮用水',label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14,}, itemStyle: {normal: {color: '#2ba4e9'	}}},
	   	                {value:4, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
	   	            ]
	   	        },
	   	        {
	   	            name:'达标率',
	   	            type:'pie',
	   	            radius: [68, 86],
	   	         	center: ['50%', '54%'],
	   	         	hoverAnimation: false,
	   	            clockWise: false,
	   	            startAngle: 90,
	   	            data:[
	   	                {value:96, name:'市区3个饮用水源水质',label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14}, itemStyle: {normal: {color: '#ffa800'	}}},
	   	                {value:4, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
	   	            ]
	   	        },
	   	        {
	   	            name:'达标率',
	   	            type:'pie',
	   	            radius: [36, 54],
	   	         	center: ['50%', '54%'],
	   	         	hoverAnimation: false,
	   	            clockWise: false,
	   	            startAngle: 90,
	   	            data:[
	   	                {value:96, name:'各县（市、区）10个水源水质',label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14}, itemStyle: {normal: {color: '#43ab60'	}}},
	   	                {value:4, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
	   	            ]
	   	        }
	   	    ]
	   	};
	    standardPie.setOption(standardPieOption);
	}
	function clickSkip(category,pointCode){ 
		var date=new Date;
		var year=date.getFullYear(); 
		var month=date.getMonth()+1;
		var startTime = year+"-1-1";
		var endTime = year+"-"+month+"-"+date.getDate();
		window.open('/env/mainPage/main.do?type=waterData&pointCode='+pointCode+"&category="+category+"&startTime="+startTime+"&endTime="+endTime+"&pid="+$("#pid").val());
	}
	function getLastDay(year,month) {   
		 var lastDay= new Date(year,month,0);
		 return lastDay.getDate();
   }



</script>

</body>

</html>