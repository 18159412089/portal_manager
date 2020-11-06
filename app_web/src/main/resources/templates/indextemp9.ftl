<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title></title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<style type="text/css">
    
</style>
	<!-- 内容 -->
	<div class="data-display-container">
		<div class="title">
			<span>漳州市中央环保督察交账销号进展</span>
			<div class="sub-content">
				<!-- 时间控件 -->
				
			</div>			
		</div>
		<div class="describe">
			总体情况 我市中央环保督察问题<span>24</span>个，截至3月25日，我市应完成整改任务<span>13</span>个，<span>11</span>个达到序时进度。已完成整改<span>13</span>个，完成市级验收13个，完成行业审查4个。
		</div>
		
		<div class="data-charts">			
			<div id="dataCharts" style="width:100%;height: 340px;"></div>
			<div id="dataPieCharts" style="width:100%;height: 340px;"></div>
		</div>
	
	</div>
	
	
	<!-- 内容  over-->
	
	
	
	
	
	
	
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
	$.parser.onComplete = function () {
	    $("#loadingDiv").fadeOut("normal", function () {
	        $(this).remove();
	    });
	};    
    $(function () {
    	/*---------------------------------------漳州市周统计-------------------------------------------*/

        var dataCharts = echarts.init(document.getElementById('dataCharts'));

        var dataChartsOption ={
        		title : {
        	        text: '某站点用户访问来源',
        	        subtext: '纯属虚构',
        	        x:'center'
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    legend: {
        	        orient: 'horizontal',
        	        right: '4%',
        	        data: ['县级预验收','完成市级验收','提交行业审查','完成行业审核']
        	    },
        	    xAxis : [
        	        {
        	            type : 'category',
        	            data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        	            axisTick: {
        	                alignWithLabel: true
        	            }
        	        }
        	    ],
        	    yAxis: [
       	            {
       	                type: 'value',
       	                splitNumber: 4,
       	             	max:4, 
       	                axisLabel: {
       	                    formatter: function (value) {
       	                        var text = value;
       	                        switch(value){
       	                            case 0:text=" "; 
       	                            break;
       	                            case 1:text="县级预验收"; 
       	                            break;
       	                            case 2:text="完成市级验收"; 
       	                            break;
       	                            case 3:text="提交行业审查"; 
       	                            break;
       	                         	case 4:text="完成行业审核"; 
    	                            break;
       	                        }
       	                        
       	                        return text;
       	                    }
       	                }
       	            }
       	        ],
        	    series : [
        	        {
        	            name:'县级预验收',
        	            type:'bar',
        	            barWidth: '60%',
        	            barMaxWidth:30,
        	            stack: 'one',
        	            color: ['#91c7ae'],
        	            data:[1, 0, 1, 1, 1, 1, 1]
        	        	
        	        },
        	        {
        	            name:'完成市级验收',
        	            type:'bar',
        	            barWidth: '60%',
        	            barMaxWidth:30,
        	            stack: 'one',
        	            color: ['#61a0a8'],
        	            data:[1, 0, 1, 1, 1, 1, 0]
        	        	
        	        },
        	        {
        	            name:'提交行业审查',
        	            type:'bar',
        	            barWidth: '60%',
        	            barMaxWidth:30,
        	            stack: 'one',
        	            color: ['#d48265'],
        	            data:[1, 0, 1, 0, 1, 1, 0]
        	        	
        	        },
        	        {
        	            name:'完成行业审核',
        	            type:'bar',
        	            barWidth: '60%',
        	            barMaxWidth:30,
        	            stack: 'one',
        	            color: ['#d53a35'],
        	            data:[1, 0, 1, 0, 0, 1, 0]
        	        	
        	        }
        	    ]
        	};

        dataCharts.setOption(dataChartsOption);
        /*---------------------------------------漳州市周统计-------------------------------------------*/

        var dataPieCharts = echarts.init(document.getElementById('dataPieCharts'));

        var dataPieChartsOption= {
        	    title : {
        	        text: '某站点用户访问来源',
        	        subtext: '纯属虚构',
        	        x:'center'
        	    },
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient: 'horizontal',
        	        top:55,
        	        left: 'center',
        	        data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
        	    },
        	    series : [
        	        {
        	            name: '访问来源',
        	            type: 'pie',
        	            radius : '55%',
        	            center: ['50%', '63%'],
        	            data:[
        	                {value:335, name:'直接访问'},
        	                {value:310, name:'邮件营销'},
        	                {value:234, name:'联盟广告'},
        	                {value:135, name:'视频广告'},
        	                {value:1548, name:'搜索引擎'}
        	            ],
        	            itemStyle: {
        	                emphasis: {
        	                    shadowBlur: 10,
        	                    shadowOffsetX: 0,
        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
        	                }
        	            }
        	        }
        	    ]
        	};
        dataPieCharts.setOption(dataPieChartsOption);
    });
    $(window).resize(function () {
		
    });

  

</script>

</body>

</html>