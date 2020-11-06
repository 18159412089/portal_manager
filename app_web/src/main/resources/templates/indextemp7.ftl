<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>汇报页</title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<#include "/toolbar.ftl">
<style type="text/css">
    .monitor-container {
        margin: 16px 0;
    }
    .text-item2:before{
        margin-top: 18px !important;
    }
    .monitor-container .monitor-title {
        width: 48px;
        font-weight: normal;
    }

    .layui-input {
        display: inline;
    }
    #pf-hd .pf-user .pf-user-photo{
        margin: 0px 10px 0 0;
    }

</style>
<div class="container yl-container">
    <div id="toolbar" style="margin-top:80px;position: relative">
        <div id="searchBar" class="temp7-searchBar">
            <label class="control-label">查询时间：</label> <input
                id="queryStartTime" type="text" class="layui-input"
                style="width: 156px; height: 33px;" readonly=""> <span>-</span>
            <input id="queryEndTime" type="text" class="layui-input"
                   style="width: 156px; height: 33px;" readonly="">
            <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>

            <div class="switch-box">
                <a>大屏</a>  <a class="link-a">小屏</a>
            </div>
        </div>

    </div>
    <!-- main -->
    <div class="column-panel-group col-xs-12">
        <div class="column-panel" >
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> 河流环境质量状况 </span>
            </div>
            <div class="column-panel-body">
                <div class="row">
                    <div id="WatertypeBar" style=" height: 280px; "></div>
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
        <div class="column-panel" >
            <div class="column-panel-header col-xs-12">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> 小流域环境质量状况 </span>
                <div class="column-panel-body" >
                    <div class="row">
                        <div class="col-xs-6">
                            <div id="WatertypePie" style="width:100%;"></div>
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
        <div class="column-panel-group col-xs-12">
            <div class="column-panel" >
                <div class="column-panel-header">
                    <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                    <span class="title"> 小流域环境质量状况 </span>
                </div>
                <div class="column-panel-body">
                    <div class="row">
                        <div id="WaterPollutionBar" style=" height: 280px;"></div>
                        <p class="text-item">
                            2017年底，我市仍有10条劣V类小流域（11个劣V类小流域断面），分别是：芗城大水溪、丰山溪，龙海高排渠、程溪溪，华安银塘溪，南靖斗米溪、适中溪、黄井溪南靖段，黄井溪平和段，云霄山美溪，南溪漳浦段（何寮上游断面）。
                            <br />今年1-5月份，共监测了3次。 <br />一、有4个劣V类断面3次监测水质都已提升至V类以上，分别是：芗城大水溪、龙海高排渠、华安银塘溪、黄井溪平和段。
                            <br />二、有3个劣V类断面3次监测水质都仍是劣V类，分别是：芗城丰山溪、云霄山美溪、南溪漳浦段（何寮上游断面）。 <br />三、其余4个劣V类断面虽个别月份水质有提升至V类以上，但水质存在波动，未稳定消除劣V类水质，分别是：龙海程溪溪，南靖斗米溪、适中溪、黄井溪南靖段。
                            <br />四、有3个断面3月份水质由V类以上降至劣V类，分别是：南溪漳浦段（西岭大桥断面）、漳浦小南溪，南靖高才溪。5月份，以上3个断面水质已恢复至V类以上。
                        </p>
                        <p class="text-item">
                            与2017年相比，5月监测结果如下： <br />水质变好断面13个，分别是：芗城区大水溪，龙海市高排渠、程溪溪，华安县银塘溪，长泰县湖珠溪、坂里溪，平和县芦溪、黄井溪平和段，南靖县斗米溪、高才溪、黄井溪南靖段，漳浦县龙岭溪，诏安县西溪。
                            <br />水质变差断面2个，分别是：平和县三合溪，南溪漳浦段（西岭大桥断面）。 <br />仍有4个断面水质是劣V类，分别是：芗城丰山溪、南靖适中溪、云霄山美溪和南溪漳浦段（何寮上游断面）。
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- main over -->




    <!-- 空气 main -->
    <div class="column-panel-group col-xs-12">
        <div class="column-panel">
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> 空气质量统计分析 </span>
            </div>
            <div class="column-panel-body">
                <div class="article-area tc yl-article-area">
                    <div class="title" id="airTitle" ></div>
                    <a class="details-link" href="javascript:void(0)" onclick="clickSkip2('AQI','4')" style="right: 5%;text-decoration:underline;color:blue;">详情</a>
                </div>
                <!-- 本年优良率与上年同期对比 -->
                <div id="airStandardPie" class="oh" style="width: 100%;height: 340px;"></div>
            </div>
        </div>
    </div>
    <div class="column-panel-group col-xs-12">
        <div class="column-panel" >
            <div class="column-panel-body">
                <div class="article-area tc yl-article-area">
                    <div id="information" style="margin-bottom:15px;">
                        <!--<p>截止12月04日，本市市空气质量优良天数<span class="highlight">312</span>，优良率<span class="highlight">95%</span>，与2016年同期相比<span class="highlight">减少10天</span>。</p>-->
                    </div>
                    <a class="details-link" href="javascript:void(0)" onclick="clickSkip2('AQI','5')" style="right: 5%;text-decoration:underline;color:blue;">详情</a>
                </div>
                <!-- 近三十日全市AQI -->
                <div id="airChart" class="oh" style="width: 100%;height: 340px;"></div>
                <div class="box-top">
                    <div class="grade-legend">
                        <div class="legend">
                            <span class="item excellent"></span><span
                                style="color: #000000">优</span> <span class="item good"></span><span
                                style="color: #000000">良</span> <span class="item mild"></span><span
                                style="color: #000000">轻度</span> <span class="item moderate"></span><span
                                style="color: #000000">中度</span> <span class="item severe"></span><span
                                style="color: #000000">重度</span> <span class="item dangerous"></span><span
                                style="color: #000000">严重</span> <span class="item"></span><span
                                style="color: #000000">暂无数据</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="column-panel-group  col-xs-12"><!-- col-lg-6 -->
        <div class="column-panel">
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> <span class="title-time">1-6月份</span>市区大气优良比例排名情况
						</span>
				<a class="details-link" href="javascript:void(0)" onclick="exportExl('0')" style="right: 5%;text-decoration:underline;color:blue;">导出</a>
			</div>
			<div class="column-panel-body column-table">
				<table id="bug" class="easyui-datagrid" style="width: 60%;"
						cellpadding="0" cellspacing="0"></table>
				<table id="airComplianceRateDG" class="easyui-datagrid"
					style="width: 100%; height: 150px;"
					data-options="
									rownumbers:false,
					                striped:false,
									fitColumns:true">
                    <thead>
                    <tr>
                        <th rowspan="2" field="city" width="60">城市</th>
                        <th rowspan="2" field="badDay" width="60">超标天数</th>
                        <th rowspan="2" field="standard" width="60">达标比例</th>
                        <th colspan="4" align="center">超标污染物/天</th>
                        <th rowspan="2" field="exceedingO3" width="60">臭氧超标天数占比</th>
                    </tr>
                    <tr>
                        <th field="PM2Day" width="30">PM2.5</th>
                        <th field="PM10Day" width="30">PM10</th>
                        <th field="NO2Day" width="30">NO2</th>
                        <th field="O3Day" width="30">O3</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <br>
    <div class="column-panel-group col-xs-12"><!-- col-lg-6 -->
        <div class="column-panel">
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> <span class="title-time">1-6月份</span>我市六项指标单项质量指数占比情况
						</span>
						<a class="details-link" href="javascript:void(0)" onclick="exportExl('1')" style="right: 5%;text-decoration:underline;color:blue;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="zb" class="easyui-datagrid"
							style="width: 100%; height: 250px;"
							data-options="
									rownumbers:false,
					                striped:true,
									fitColumns:true">
                    <thead>
                    <tr>
                        <th field="name" width="60"></th>
                        <th field="SO2" width="60">SO2</th>
                        <th field="NO2" width="60">NO2</th>
                        <th field="PM10" width="60">PM10</th>
                        <th field="PM25" width="60">PM2.5</th>
                        <th field="O3" width="60">O3(90%)</th>
                        <th field="CO" width="60">CO(95%)</th>
                        <th field="total" width="60">空气质量综合指数</th>
                    </tr>
                    </thead>
                </table>
                <p class="text-remark">从单项质量指数分析，<span id="zb-factory">O3、PM10</span>两项污染物单项质量分数贡献率总和占比高达<span id="zb-index">47.7%</span>，直接决定我市空气质量综合指数高低。</p>
            </div>
        </div>
    </div>
    <div class="column-panel-group col-xs-12"><!-- col-lg-6 -->
        <div class="column-panel">
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> <span class="title-time">1-6月份</span>我市六项指标同比变化情况
						</span>
						<a class="details-link" href="javascript:void(0)" onclick="exportExl('2')" style="right: 5%;text-decoration:underline;color:blue;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="tb" class="easyui-datagrid"
							style="width: 100%; height: 250px;"
							data-options="
									rownumbers:false,
					                striped:true,
									fitColumns:true">
                    <thead>
                    <tr>
                        <th field="name" width="60"></th>
                        <th field="SO2" width="60">SO2</th>
                        <th field="NO2" width="60">NO2</th>
                        <th field="PM10" width="60">PM10</th>
                        <th field="PM25" width="60">PM2.5</th>
                        <th field="O3" width="60">O3(90%)</th>
                        <th field="CO" width="60">CO(95%)</th>
                        <th field="total" width="60">空气质量综合指数</th>
                    </tr>
                    </thead>
                </table>
                <p class="text-remark">
                <p class="text-remark">环境空气质量综合指数<span id="tb-aqi">4.60</span>，同比<span id="tb-index">上升6.6%</span>；
                    6项主要污染物其中<span id="tb-factory">PM2.5</span> 浓度超过二级浓度限值。</p>
                </p>
            </div>
        </div>
    </div>
    <div class="column-panel-group col-xs-12">
        <div class="column-panel">
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title" id="SameTimeCompare"> <span
                        class="title-time">1-6月份</span>漳州市11个县市区同期对比（综合指数）
						</span>
						<a class="details-link" href="javascript:void(0)" onclick="exportExl('3')" style="right: 5%;text-decoration:underline;color:blue;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="SameTimeCompareDG" class="easyui-datagrid"
							style="width: 100%; height: 725px;"
							data-options="
									rownumbers:true,
					                striped:true,
									fitColumns:true">
                    <thead>
                    <tr>
                        <th rowspan="2" field="name" width="120">县（市/区）</th>
                        <th colspan="3" align="center">综合指数</th>
                        <th colspan="3" align="center">SO2</th>
                        <th colspan="3" align="center">NO2</th>
                        <th colspan="3" align="center">PM10</th>
                        <th colspan="3" align="center">PM2.5</th>
                        <th colspan="3" align="center">CO-95%</th>
                        <th colspan="3" align="center">O3-90%</th>
                    </tr>
                    <tr>
                        <th field="totalIAQI" width="60">综合指数</th>
                        <th field="totalTB" width="60">同比(%)</th>
                        <th field="totalINDEX" width="60" styler="color">全市</th>
                        <th field="SO2C" width="60">浓度</th>
                        <th field="SO2TB" width="60">同比(%)</th>
                        <th field="SO2INDEX" width="60" styler="color">全市</th>
                        <th field="NO2C" width="60">浓度</th>
                        <th field="NO2TB" width="60">同比(%)</th>
                        <th field="NO2INDEX" width="60" styler="color">全市</th>
                        <th field="PM10C" width="60">浓度</th>
                        <th field="PM10TB" width="60">同比(%)</th>
                        <th field="PM10INDEX" width="60" styler="color">全市</th>
                        <th field="PM25C" width="60">浓度</th>
                        <th field="PM25TB" width="60">同比(%)</th>
                        <th field="PM25INDEX" width="60" styler="color">全市</th>
                        <th field="COC" width="60">浓度</th>
                        <th field="COTB" width="60">同比(%)</th>
                        <th field="COINDEX" width="60" styler="color">全市</th>
                        <th field="O3C" width="60">浓度</th>
                        <th field="O3TB" width="60">同比(%)</th>
                        <th field="O3INDEX" width="60" styler="color">全市</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <div class="column-panel-group col-xs-12">
        <div class="column-panel">
            <div class="column-panel-header">
                <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                <span class="title"> <span class="title-time">1-6月份</span>漳州市11个县市区同期对比（大气优良率）
						</span>
						<a class="details-link" href="javascript:void(0)" onclick="exportExl('4')" style="right: 5%;text-decoration:underline;color:blue;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="airQualityByYearDG" class="easyui-datagrid"
							style="width: 100%; height: 800px;"
							data-options="
					       			fitColumns:true,
									rownumbers:false,
					                striped:true,
									fitColumns:true">
                    <thead>
                    <tr>
                        <th rowspan="3" field="pointName" align="center" width="120">县（市/区）</th>
                        <th rowspan="2" colspan="3" align="center" width="120">空气质量达标率%</th>
                        <th rowspan="2" colspan="2" align="center" width="120">轻度污染天数</th>
                        <th colspan="8" align="center" width="120">轻度污染天数分布情况</th>
                    </tr>
                    <tr>
                        <th colspan="2" align="center">PM2.5</th>
                        <th colspan="2" align="center">PM10</th>
                        <th colspan="2" align="center">NO2</th>
                        <th colspan="2" align="center">O3-8h</th>
                    </tr>
                    <tr>
                        <th field="reach" align="center" width="60">达标率</th>
                        <th field="reachYear" align="center" width="60">同比</th>
                        <th field="rank" align="center" width="60">全市排名</th>
                        <th field="polluteDay" align="center" width="60">天数</th>
                        <th field="polluteDayYear" align="center" width="60">同比</th>
                        <th field="PM2Day" align="center" width="60">天数</th>
                        <th field="PM2DayYear" align="center" width="60">同比</th>
                        <th field="PM10Day" align="center" width="60">天数</th>
                        <th field="PM10DayYear" align="center" width="60">同比</th>
                        <th field="NO2Day" align="center" width="60">天数</th>
                        <th field="NO2DayYear" align="center" width="60">同比</th>
                        <th field="O3Day" align="center" width="60">天数</th>
                        <th field="O3DayYear" align="center" width="60">同比</th>

                    </tr>
                    </thead>
                </table>
                <p class="text-remark">备注：2018年2月16日诏安县首要污染物为PM10和PM2.5；2017年3月18日龙文区首要污染物为NO2和PM2.5。</p>
            </div>
        </div>
    </div>
    <!--
			<div class="column-panel-group col-xs-12">
				<div class="column-panel">
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>
						<span class="title"> <span class="title-time">1-6月份</span>气候条件分析
						</span>
					</div>
					<div class="column-panel-body column-table">
						<table class="easyui-datagrid" style="width: 100%; height: 380px;"
							url="${request.contextPath}/sys/role/list"
							data-options="
									rownumbers:false,
					                striped:true,
									fitColumns:true">
							<thead>
								<tr>
									<th field="name" width="120">名称</th>
									<th field="code" width="120">编号</th>
									<th field="num" width="60">排序</th>
									<th field="remark" width="60">备注</th>
									<th field="updateDate" width="100">修改时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			-->





    <!-- 空气 main over -->

</div>
<script src="${request.contextPath}/static/layui/layui.js"
        charset="utf-8"></script> <script type="text/javascript">
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //年月选择器
        var date=new Date();
        var year = date.getFullYear();
        var initYear = year;
        var endYear = year;

        var startTime = laydate.render({
            elem: '#queryStartTime',
            type: 'month',
            format: 'yyyy-M',
            max: getNowDate(0)+"-1",
            value: year+"-1",
            showBottom: false,
            ready: function(date){
                initYear=date.year;
            },
            change: function(value, date, endDate){
                var selectYear = date.year;
                var differ = selectYear-initYear;
                if (differ == 0) {
                    if($(".layui-laydate").length){
                        $("#queryStartTime").val(value);
                        $(".layui-laydate").remove();
                        $("#queryEndTime").val("");
                    }
                }
                initYear = selectYear;
                if($("#queryStartTime").val()==value){
                    var d2 = new Date();
                    endTime.config.max = {
                        year: date.year,
                        month: date.year<d2.getFullYear()?11:d2.getMonth(),
                        date: date.date
                    };
                    endTime.config.min = {
                        year: date.year,
                        month: date.month-1,
                        date: date.date
                    }
                }
            }
        });
        //年月选择器
        var endTime = laydate.render({
            elem: '#queryEndTime',
            type: 'month',
            format: 'yyyy-M',
            value: date,
            max: getNowDate(0)+"-1",
            min: year+"-1-1",
            showBottom: false,
            ready: function(date){
                endYear=date.year;
            },
            change: function(value, date, endDate){
                var selectYear = date.year;
                var differ = selectYear-endYear;
                if (differ == 0) {
                    if($(".layui-laydate").length){
                        $("#queryEndTime").val(value);
                        $(".layui-laydate").remove();
                    }
                }
                endYear = selectYear;
            }
        });

    });
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            doSearch();
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

    var airStandardPie = echarts.init(document.getElementById('airStandardPie'));
    var airChart = echarts.init(document.getElementById('airChart'));
    $(function () {
        /*---------------------------------------空气-------------------------------------------*/
        setAirChartBaroption();
        setAirStandardPieOption();
    });

    function doSearch(){
        var startTime = $("#queryStartTime").val();
        var endTime = $("#queryEndTime").val();
        if(startTime==""||endTime==""){
            $.messager.alert('提示', '时间区间不允许为空！');
        }else if(startTime.slice(0,4)!=endTime.slice(0,4)){
            $.messager.alert('提示', '时间区间不在同一年份！');
        }else{
            $('.title-time').html(startTime+" ~ "+endTime);
            $('#zb').datagrid({
                url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityZB',
                queryParams:{
                    startTime:startTime,
                    endTime:endTime
                }
            });
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityZBRemark',
                async:true,
                data:{
                    startTime:startTime,
                    endTime:endTime
                },
                success: function (data) {
                    $("#zb-factory").val(data.one+"、"+data.two);
                    $("#zb-index").html(data.value);
                }
            });
            $('#tb').datagrid({
                url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityTB',
                queryParams:{
                    startTime:startTime,
                    endTime:endTime
                }
            });
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityTBRemark',
                async:true,
                data:{
                    startTime:startTime,
                    endTime:endTime
                },
                success: function (data) {
                    $("#tb-aqi").html(data.aqi);
                    $("#tb-index").html(data.value);
                    $("#tb-factory").html(data.factory);
                }
            });
            $('#SameTimeCompareDG').datagrid({
                url: Ams.ctxPath + '/environment/debrief/getCompareCounty',
                queryParams:{
                    startTime:startTime,
                    endTime:endTime
                }
            });
            $('#airQualityByYearDG').datagrid({
                url: Ams.ctxPath + '/environment/AirQualityByYear/getAirYearOnYearAnalysis',
                queryParams:{
                    startTime:startTime,
                    endTime:endTime
                }
            });
            $('#airComplianceRateDG').datagrid({
                url: Ams.ctxPath + '/environment/airComplianceRate/list',
                queryParams:{
                    startTime:startTime,
                    endTime:endTime
                }
            });
            getAirQualityStatistics(startTime,endTime);
            getAirChartBaroption();

            getWaterPollutionLevelData(startTime, endTime);
            getWatertypePieData(startTime,endTime);
            getWatertypeBar(startTime,endTime);
            //getStandardPie();
        }

    }

    /*---------------------------------------空气质量数据-------------------------------------------*/
    function getAirChartBaroption(){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airDayData/airQuantityForLastMonth',
            async:true,
            success: function (data) {
                airChart.hideLoading();
                var xAxis = data.xAxis;
                var now = data.data;
                var value = now[0].data;
                var aqi = [];
                var color = [];
                $.each(value,function(i){

                    if(value[i] == null){
                        color.push('#b8b8b8');
                        aqi.push("-");
                    }else if(value[i] >= 0 && value[i]<=50){
                        color.push('#00E400');
                        aqi.push(value[i]);
                    }else if(value[i] <= 100){
                        color.push('#FFFF00');
                        aqi.push(value[i]);
                    }else if(value[i] <= 150){
                        color.push('#FF7E00');
                        aqi.push(value[i]);
                    }else if(value[i] <= 200){
                        color.push('#FF0000');
                        aqi.push(value[i]);
                    }else if(value[i] <= 300){
                        color.push('#99004C');
                        aqi.push(value[i]);
                    }else if(value[i] <= 500){
                        color.push('#7E0023');
                        aqi.push(value[i]);
                    }
                });
                airChart.setOption({        //加载数据图表
                    xAxis:xAxis,
                    yAxis : [{
                        type : 'value'
                    }],
                    series: [{
                        data: aqi,
                        type: 'bar',
                        tooltip : {
                            textStyle: {
                                fontSize:'16',
                            }
                        },
                        itemStyle: {
                            normal: {
                                // 定制显示（按顺序）
                                color: function(params) {
                                    var colorList = color;
                                    return colorList[params.dataIndex]
                                }
                            },
                        },
                    }]
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                airChart.hideLoading();
            },
            dataType: 'json'
        });
    }


    function getAirQualityStatistics(startTime,endTime){

        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/AirQualityStatistics/list',
            data:{startTime:startTime,endTime:endTime},
            async:true,
            success: function (result) {
                airStandardPie.hideLoading();
                var last = result.lastArray;
                var now = result.now;
                var info = result.info;
                airStandardPie.setOption({        //加载数据图表
                    color:["#FF4040","#33ff33"],
                    legend: {
                        orient: 'vertical',
                        top: '40',
                        left:'14',
                        data:[{name:last[0].name},{name:now[0].name}]
                    },
                    series: [{
                        name:last[0].name,
                        type:'pie',
                        radius: [100, 118],
                        center: ['50%', '56%'],
                        hoverAnimation: false,
                        clockWise: false,
                        startAngle: 90,
                        data:[
                            {value:last[0].maxValue, name:last[0].name,label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14,}, itemStyle: {normal: {color:'#FF4040'}}},
                            {value:last[0].minValue, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
                        ]},{
                        name:now[0].name,
                        type:'pie',
                        radius: [60, 86],
                        center: ['50%', '56%'],
                        hoverAnimation: false,
                        clockWise: false,
                        startAngle: 90,
                        data:[
                            {value:now[0].maxValue, name:now[0].name,label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14}, itemStyle: {normal: {color:'#33ff33'}}},
                            {value:now[0].minValue, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
                        ]}
                    ]});
                var html ="<p>截止"+info[0].time+"，本市市空气质量优良天数<span class='highlight'>"+info[0].day
                        +"</span>，优良率<span class='highlight'>"+info[0].rate+"</span>，与"+info[0].lastYear
                        +"年同期相比<span class='highlight'>"+info[0].info+"</span>。</p>"

                $("#information").html(html);
                $("#airTitle").html(info[0].nowYear+"年空气质量现状")
            },
            error: function (jqXHR, textStatus, errorThrown) {
                airStandardPie.clear();
                $.messager.alert('提示', '本年优良率与去年同期对比，暂无数据！');

            },
            dataType: 'json'
        });
    }
    /*---------------------------------------小流域环境-------------------------------------------*/
    function getWatertypePieData(startTime,endTime){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/enviromonit/water/wtReportData/getBasinQuality",
            async : true,
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
                var html='<p class="text-item">全市3条主要河流<span class="highlight">'+data.count+'</span>个水质评价断面。</p>'
                        +'<p class="text-item">主要流域<span class="highlight">'+data.category1+'</span>个断面，'+startTime.split('-')[0]+'年'+startTime.split('-')[1]+'-'+endTime.split('-')[1];
                var point=data.point;
                var times=data.time;
                var temp=0;
                var gk="<span style='color:black'>国控断面:</span>"
                var sk="<span style='color:black'>省控断面:</span>"
                var zj="<span style='color:black'>自建断面:</span>"
                for(var i=0;i<point.length;i++){
                    if(times[i]!=0){
                        if(point[i].pointName.indexOf('华安西陂')){
                            temp++;
                        }
                        if(point[i].category==1){
                            if(point[i].pointName.indexOf('华安西陂')){
                                gk+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:red' >"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
                            }else {
                                gk+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:blue' >"+"（龙岩市）"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
                            }
                        }else if(point[i].category==2){
                            sk+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:red' >"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
                        }else if(point[i].category==3){
                            zj+="<a href='javascript:void(0)' onclick='clickSkip("+point[i].category+",\""+point[i].pointCode+"\")'  style='color:red' >"+point[i].pointName+'（'+times[i]+'）次'+"</a>、";
                        }
                    }
                }
                console.info(temp)
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
                gk="<span style='color:black'>国控断面:</span>"
                sk="<span style='color:black'>省控断面:</span>"
                zj="<span style='color:black'>自建断面:</span>"
                var overproofPoint1=data.overproofPoint1;
                for(var i=0;i<overproofPoint1.length;i++){
                    if(point[i].category==1){
                        gk+="<a href='javascript:void(0)' onclick='clickSkip("+overproofPoint1[i].category+",\""+overproofPoint1[i].pointCode+"\")'  style='color:red' >"+overproofPoint1[i].pointName+"</a>、";
                    }else if(point[i].category==2){
                        sk+="<a href='javascript:void(0)' onclick='clickSkip("+overproofPoint1[i].category+",\""+overproofPoint1[i].pointCode+"\")'  style='color:red' >"+overproofPoint1[i].pointName+"</a>、";
                    }else if(point[i].category==3){
                        zj+="<a href='javascript:void(0)' onclick='clickSkip("+overproofPoint1[i].category+",\""+overproofPoint1[i].pointCode+"\")'  style='color:red' >"+overproofPoint1[i].pointName+"</a>、";
                    }
                }
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

                html+= '</span></p>'
                        +'<p class="text-item">根据国家委托第三方采样监测结果，'+endTime.split('-')[1]+'月份，<span class="highlight">'+gk+sk+zj+' </span>共'+data.overproofPoint1.length+'个断面水质超标。</p>';

                var overproofPoint2=data.overproofPoint2;
                gk="<span style='color:black'>国控断面:</span>"
                sk="<span style='color:black'>省控断面:</span>"
                zj="<span style='color:black'>自建断面:</span>"
                for(var i=0;i<overproofPoint2.length;i++){
                    if(point[i].category==1){
                        gk+="<a href='javascript:void(0)' onclick='clickSkip("+overproofPoint2[i].category+",\""+overproofPoint2[i].pointCode+"\")'  style='color:red' >"+overproofPoint2[i].pointName+"</a>、";
                    }else if(point[i].category==2){
                        sk+="<a href='javascript:void(0)' onclick='clickSkip("+overproofPoint2[i].category+",\""+overproofPoint2[i].pointCode+"\")'  style='color:red' >"+overproofPoint2[i].pointName+"</a>、";
                    }else if(point[i].category==3){
                        zj+="<a href='javascript:void(0)' onclick='clickSkip("+overproofPoint2[i].category+",\""+overproofPoint2[i].pointCode+"\")'  style='color:red' >"+overproofPoint2[i].pointName+"</a>、";
                    }
                }
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
                html+='<p class="text-item">根据'+startTime.split('-')[1]+'-'+endTime.split('-')[1]+'月均值，<span class="highlight">'+gk+sk+zj+' </span>共'+data.overproofPoint2.length+'个断面水质目前暂未达标。</p>';


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
                formatter: "{a} <br/>{b} : {c} ({d}%)",
                textStyle: {
                    fontSize:'16',
                }
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
                    radius : [0, '70%'],
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


        window.onresize = function() {
            WatertypePie.resize();
        }


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
                right : '30',
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

    /*---------------------------------------空气质量数据-------------------------------------------*/
    function setAirChartBaroption(){
        airChartBaroption = {
            title: {
                text: '过去30天AQI情况',
                left:'center',
                textStyle: {
                    color: '#000000',
                    fontSize:'16',
                    fontWeight:'normal'
                }
            },
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                },
                formatter:function(params) {
                    var result = '';
                    params.forEach(function (item) {
                        result += item.axisValue + "</br>" +item.marker + " " + "AQI指数" + " : " + item.value +"</br>";
                    });
                    return result;
                }
            },
            legend: {
                show:false,
            },
            toolbox: {
                show: true,
                feature: {
                    magicType: {type: [ 'bar']},
                    restore: {}
                },
                right: '5%',
                iconStyle: {
                    borderColor: '#000000'
                }
            },
            grid: {
                top:'35',
                left: '3%',
                right: '5%',
                bottom: '35',
                containLabel: true
            },
            xAxis : {
                type : 'category',
                axisLine:{
                    lineStyle:{
                        color: '#000000'
                    }
                }

            },
            yAxis :{
                type : 'value',
                axisLine:{
                    lineStyle:{
                        color: '#000000'
                    }
                },
                splitLine:{
                    lineStyle:{
                        opacity:0.5
                    }
                }
            },
            textStyle:{
                color: '#000000',

            },
            series : [
                {
                    name:'AQI指数',
                    type:'bar',
                    barWidth: '60%',
                    data:[],
                }
            ]

        };
        airChart.setOption(airChartBaroption);
        airChart.showLoading();
    }
    function setAirStandardPieOption(){
        var airStandardPieOption ={
            title: {
                text: '本年优良率与上年同期对比',
                top: '10',
                left:'center',
                textStyle: {
                    fontSize:'16',
                    fontWeight:'normal'
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {d}%"
            }
        };
        airStandardPie.setOption(airStandardPieOption);
        //airStandardPie.showLoading();
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

    function color(value, row, index) {
        return 'background-color:#FFFF00;color:#ffffff'
    }

    function clickSkip(category,pointCode){
        var startTime = $("#queryStartTime").val();
        var endTime = $("#queryEndTime").val();
        var month;
        var year=endTime.slice(0,4)
        if(endTime.length==7){
            month=endTime.slice(5,7)
        }else{
            month=endTime.slice(5,6)
        }

        var lastDate=getLastDay(year,month);
        startTime+="-01";

        var d=new Date();
        var now_month = d.getMonth()+1;
        var currentDate=d.getFullYear()+"-"+now_month+"-"+d.getDate()
        endTime+="-"+lastDate;
        if(year==d.getFullYear()&&month==now_month){
            endTime=currentDate;
        }
        window.open('/env/mainPage/main.do?type=waterData&pointCode='+pointCode+"&category="+category+"&startTime="+startTime+"&endTime="+endTime);
    }
    function clickSkip2(type,category){
        window.open('/env/mainPage/main2.do?type='+type+'&category='+category);
    }
    function getLastDay(year,month) {
        var lastDay= new Date(year,month,0);
        return lastDay.getDate();
    }
    //    大小屏按钮切换
    $(".switch-box a").click(function () {
        $(".switch-box a").removeClass("link-a")
        if ($(this).index()!=1){
            $("body").css("font-size","18px");
            $(".column-panel-header .title").css("font-size","26px");
            $(".text-item").css("font-size","26px");
            $(".text-remark").css("font-size","18px");
            $(".column-table .datagrid-cell").css("font-size","18px");
            $(".datagrid-cell-group").css("font-size","18px");
            $(".grade-legend .legend").css("font-size","18px");
            $(".text-item").addClass("text-item2")
        }else {
            $("body").css("font-size","14px");
            $(".column-panel-header .title").css("font-size","16px");
            $(".text-item").css("font-size","16px");
            $(".text-remark").css("font-size","14px");
            $(".column-table .datagrid-cell").css("font-size","14px");
            $(".datagrid-cell-group").css("font-size","12px");
            $(".text-item:before").css("margin-top","8px");
            $(".text-item").removeClass("text-item2")
        }
        $(this).addClass("link-a")
    })
	function exportExl(type){
		var date=new Date;
		var year=date.getFullYear(); 
		var month=date.getMonth()+1;
		var startTime = year+"-01";
		var endTime = year+"-"+month;
		if(type == "0"){
			window.location.href = "${request.contextPath}/environment/airComplianceRate/list?export=yes&startTime="+startTime+"&endTime="+endTime;
		} else if(type == "1"){
			window.location.href = "${request.contextPath}/environment/debrief/getSixFactoryQualityZB?export=yes&startTime="+startTime+"&endTime="+endTime;
		}else if(type == "2"){
			window.location.href = "${request.contextPath}/environment/debrief/getSixFactoryQualityTB?export=yes&startTime="+startTime+"&endTime="+endTime;
		}else if(type == "3"){
			window.location.href = "${request.contextPath}/environment/debrief/getCompareCounty?export=yes&startTime="+startTime+"&endTime="+endTime;
		}else if(type == "4"){
			window.location.href = "${request.contextPath}/environment/AirQualityByYear/getAirYearOnYearAnalysis?export=yes&startTime="+startTime+"&endTime="+endTime;
		}
	}
</script>
</body>

</html>