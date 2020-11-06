<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>地表水水质实时监测</title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<div id="pf-hd" style="position: absolute;width:100%;">
	<span class="pf-logo">
   		<img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
    </span>
    <div class="pf-user">
        <div class="pf-user-photo">
            <img src="${request.contextPath}/static/images/main/user.png" alt="">
        </div>
        <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
        <i class="iconfont xiala">&#xe607;</i>

        <div class="pf-user-panel">
            <ul class="pf-user-opt">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe60d;</i>
                        <span class="pf-opt-name">用户信息</span>
                    </a>
                </li>
                <li class="pf-modify-pwd">
                    <a href="#" id="editpass">
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li class="pf-logout">
                    <a href="#" id="loginOut">
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
    <!-- main -->
    <div class="map-wrapper" style="background: url('${request.contextPath}/static/images/map_bg.png') center;"></div>
    <!-- 地图层(真实添加地图时，删除style) -->


    <!-- 图例  -->
    <div class="map-legend-container" style="position:absolute;bottom:0px;left:0px;">
        <div class="grade-legend">
            <div class="legend">
                <span class="item level-1"></span>Ⅰ
                <span class="item level-2"></span>Ⅱ
                <span class="item level-3"></span>Ⅲ
                <span class="item level-4"></span>Ⅳ <br/>
                <span class="item level-5"></span>Ⅴ
                <span class="item level-6"></span>Ⅵ
                <span class="item level-0"></span>劣Ⅴ
                <span class="item"></span>未知
            </div>
        </div>
    </div>
    <!-- 图例 over -->  


    <div class="map-panel" style="position:absolute;top:86px;right:58px;">
        <div class="map-panel-header">
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				图层控制
			</span>
        </div>
        <div class="map-panel-body" style="height: 540px;width:440px;position: relative;background: none;">
            <div class="body-box" id="filterBox" style="width:320px;height:220px;margin-left:120px; border-bottom: 1px solid #fff;border-color: rgba(255,255,255,0.15);">
				<div class="filter-container" style="margin-bottom: 12px;">
			        <div class="filter-box">
			            <div class="filter-title">按区域</div>
			            <div class="filter-content">
			                    <div class="change-line no-choice" title="全部" id="all">全部</div>
			                    <div class="change-line no-choice">鼓楼区</div>
			                    <div class="change-line no-choice">台江区</div>
			                    <div class="change-line no-choice">仓山区</div>
			                    <div class="change-line no-choice choiced" id="tabs1" title="晋安区" >晋安区</div>
			                    <div class="change-line no-choice">马尾区</div>
			                    <div class="change-line no-choice">长乐区</div>
			                    <div class="change-line no-choice">福清市</div>
			                    <div class="change-line no-choice">闽侯县</div>
			                    <div class="change-line no-choice">连江县</div>
			                    <div class="change-line no-choice">罗源县</div>
			                    <div class="change-line no-choice">闽清县</div>
			                    <div class="change-line no-choice">永泰县</div>
			                    <div class="change-line no-choice">平潭县</div>
			            </div>
			        </div>
			        <div class="filter-box">
			            <div class="filter-title">按控制级别</div>
			            <div class="filter-content">
			                    <div class="change-line no-choice">全部</div>
			                    <div class="change-line no-choice">国控</div>
			                    <div class="change-line no-choice">省控</div>
			                    <div class="change-line no-choice">市控</div>
			            </div>
			        </div>
					<div class="filter-box">
			            <div class="filter-title">按区域</div>
			            <div class="filter-content">
			                    <div class="change-line no-choice">全部</div>
			                    <div class="change-line no-choice">鼓楼区</div>
			                    <div class="change-line no-choice">台江区</div>
			                    <div class="change-line no-choice">仓山区</div>
			                    <div class="change-line no-choice">晋安区</div>
			                    <div class="change-line no-choice">马尾区</div>
			                    <div class="change-line no-choice">长乐区</div>
			                    <div class="change-line no-choice">福清市</div>
			                    <div class="change-line no-choice">闽侯县</div>
			                    <div class="change-line no-choice">连江县</div>
			                    <div class="change-line no-choice">罗源县</div>
			                    <div class="change-line no-choice">闽清县</div>
			                    <div class="change-line no-choice">永泰县</div>
			                    <div class="change-line no-choice">平潭县</div>
			            </div>
			        </div>

			    </div>
			</div>
            
            <div class="tabs-content" style="width:320px;margin-left:120px;">
            	<div class="body-box" id="mapTabs_tabs1">						
					<!--  -->
					<div class="theme-container">
				        <div class="theme-title">筛选</div>
				            <div class="theme-content">
			                    <div class="search-container" id="search">
			                    	<div class="search-box">
			                    		<input class="easyui-textbox" style="width:100%;"/>
			                    		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			                    	</div>
			                    </div>
			                    <div class="easyui-table-light">
				                    <table id="test2" class="easyui-datagrid"
			                           style="width: 100%;height:272px;" toolbar="#search"
			                           url=""
			                           data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
				                        <thead>
				                        <tr>
				                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>
				                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>
				                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>
				                        </tr>
				                        </thead>
				                    </table>
			                    </div>

				            </div>

				    </div>  
					<!--  -->	

				</div>
				<div class="body-box" id="mapTabs_tabs2" style="display: none;">						
					dlfgdflg id="map-tabs2"
				</div>	
            	<div class="body-box" id="mapTabs_all" style="display: none;">						
					全部 id="map-tabs1"
				</div>
            </div>
            <ul class="tabs-panel" style="top:220px;margin-right: -120px;">
				<li class="tabs-item">
					<a class="tabs-inner active" data-target="#mapTabs_tabs1">晋安区</a>
				</li>
				<li class="tabs-item">
					<a class="tabs-inner" data-target="#mapTabs_tabs2">tabs2</a>
				</li>
			</ul>            
        </div>
    </div>
    
    <!--  -->
    <div class="map-panel" style="position:absolute;top:86px;right:558px;">
        <div class="map-panel-header">
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				近岸海域分析监控图
			</span>
        </div>
        <div class="map-panel-body" style="height: 450px;width:400px;position: relative;">
            <div class="theme-container" style="width:400px;">
		        <div class="theme-title">筛选</div>
		            <div class="theme-content">
	                    <div class="search-container" id="search2">
	                    	<div class="search-box">
	                    		<input class="easyui-textbox" style="width:100%;"/>
	                    		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
	                    	</div>
	                    </div>
	                    <div class="easyui-table-light">
		                    <table id="test" class="easyui-datagrid"
	                           style="width: 100%;height:400px;" toolbar="#search2"
	                           url=""
	                           data-options="
					            rownumbers:false,
					            singleSelect:true,
					            striped:false,
					            autoRowHeight:false,
					            pageSize:10,
					            pagination:true,
					            nowrap:false">
		                        <thead>
		                        <tr>
		                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>
		                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>
		                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>
		                        </tr>
		                        </thead>
		                    </table>
	                    </div>
	                    
		            </div>

		    </div>  
                
        </div>
    </div>
    <!--  -->
    
	<!-- 弹出 -->
		<div style="position:absolute;top:96px;left:30px;">
			<!--地图点-弹出-->
				<div class="map-panel">
					<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:670px;height:380px;">
				        <div title="数据分析">
				        	<div class="data-analysis">
				        		<div id="radioList" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
									<span class="active">DO</span>
									<span>TOC</span>
									<span>氢离子浓度指数</span>
									<span>COD</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
									<span>NH3N</span>
								</div>
								<div class="oh data-analysis-content">
									<div class="radio-button-group">
										<span class="active">最近7天</span>
										<span>最近30天</span>
										<span>最近3一年</span>
									</div>
									<div id="WatertypeBar" style="height: 270px;"></div>
									<div class="selectBox-container">
										<div class="select-button">
											<span>对比 </span>
										</div>
										<div class="select-panel">
											<div id="selectGrop" style="height:104px;">
												<!--复选框-->
												<label class="form-checkbox">
													<input name="type" type="checkbox" value="" checked="checked"/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<!--复选框 over-->											
											</div>
											<div class="tr">
												<button type="button" class="btnSure btn-blue l-btn">确定</button>
											</div>										
										</div>
									</div>
								</div>					
				        	</div>
				        </div>
				        <div title="详情">
				    		<div class="panel-group-container">
				       			<div class="panel-group-top">
				       				漳州东溪<span class="subtext fr">2019.1.18  14:43</span>
				       			</div>
				       			<div class="panel-group-body">
				       				<div class="panel-info">
				       					<span>经度：104.62</span>
				        				<span>纬度：28</span>
				        				<span>区县：龙海市</span>
				        				<span>断面情况：入海</span>
				        				<span>水系：浙闽河流</span>
				        				<span>河流名称：东溪</span>
				        				<span>溶解氧：10.17mg/L</span>
				        				<span>氨氮：0.15mg/L</span>
				        				<span>总有机碳：-</span>
				        				<span>高锰酸盐指数：2.29mg/L</span>
				        				<span>氢离子浓度指数：7.79</span>
				        				<span>水质类别：Ⅳ类</span>
				       				</div>         				
				       			</div>
				       		</div>
				        </div>
				        <div title="标签3">
							<div class="panel-group-container">
                                <div class="theme-content">
                                    <div class="search-container alone-search" id="search3">
                                        <div class="search-box">
                                            <input class="easyui-textbox" style="width:100%;"/>
                                            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
                                        </div>
									</div>
                                    <div class="easyui-table-light">
                                        <table id="test3" class="easyui-datagrid"
                                               style="width: 100%;height:330px;" toolbar="#search3"
                                               url=""
                                               data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                            <thead>
                                            <tr>
                                                <th field="qymc" width="317px" formatter="Ams.tooltipFormat">文件</th>
                                                <th field="qymc2" width="317px" formatter="Ams.tooltipFormat">操作</th>
                                            </tr>
                                            </thead>
											<tbody>
											 <tr>
                                                 <td>
													 <div class="table-font">
                                                         <i><img src="${request.contextPath}/static/images/file-ppt.png"></i>漳州市九龙江流域生态环境网格化.ppt
												     </div>
												 </td>
												 <td>
													 <div class="link-box">
                                                         <a class='look-tag'><span class="icon iconcustom look-icon"></span>查看</a>
                                                         <a><span class="icon iconcustom"></span>下载</a>
													 </div>
												 </td>
											 </tr>
                                             <tr>
                                                 <td>
                                                     <div class="table-font">
                                                        <i> <img src="${request.contextPath}/static/images/file-pdf.png"></i>漳州市九龙江流域生态环境网格化.pdf
                                                     </div>
												 </td>
                                                 <td>
                                                     <div class="link-box">
                                                         <a class='look-tag'><span class="icon iconcustom look-icon"></span>查看</a>
                                                         <a><span class="icon iconcustom"></span>下载</a>
                                                     </div>
												 </td>
                                             </tr>
                                             <tr>
                                                 <td>
                                                     <div class="table-font">
                                                        <i> <img src="${request.contextPath}/static/images/file-jpg.png"></i>漳州市九龙江流域生态环境网格化.jpg
                                                     </div>
												 </td>
                                                 <td>
                                                     <div class="link-box">
                                                         <a class='look-tag'><span class="icon iconcustom look-icon"></span>查看</a>
                                                         <a><span class="icon iconcustom"></span>下载</a>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <td>
                                                     <div class="table-font">
                                                       <i>  <img src="${request.contextPath}/static/images/file-xls.png"></i>漳州市九龙江流域生态环境网格化.xls
                                                     </div>
                                                 </td>
                                                 <td>
                                                     <div class="link-box">
                                                         <a class='look-tag'><span class="icon iconcustom look-icon"></span>查看</a>
                                                         <a><span class="icon iconcustom"></span>下载</a>
                                                     </div>
                                                 </td>
                                             </tr>
											</tbody>
                                        </table>
                                    </div>

                                </div>
							</div>

				        </div>
				        <div title="标签4">
				    		tab4
				        </div>
				        <div title="标签5">
				    		tab5
				        </div>
				        <div title="标签6">
				    		tab6
				        </div>
				    </div>	
				</div>
			<!--地图点-弹出 over-->
		</div>
    <!-- 弹出 over -->
    


    

    
    <!-- main over -->

</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function () {
    	$("#test").datagrid('getPager').pagination({
          showPageList:false,
          showRefresh:false,
          layout:['first','prev','links','next','last'],
          links:3
        });
    	$("#test").datagrid('resize');
    	$("#test2").datagrid('getPager').pagination({
            showPageList:false,
            showRefresh:false,
            layout:['first','prev','links','next','last'],
            links:3
          });
      	$("#test2").datagrid('resize');
        $("#test3").datagrid('getPager').pagination({
            showPageList:false,
            showRefresh:false,
            layout:['first','prev','links','next','last'],
            links:3
        });
        $("#test3").datagrid('resize');
    	
    	
    	
    	
        $(".map-panel-header").on("click", function () {
            var $target = $(this).parent();
            if ($target.hasClass("collapsed")) {
                $target.removeClass("collapsed");
                WaterPollutionBar.resize();
                WatertypeBar.resize();
                WaterIndexBar.resize();
            } else {
                $target.addClass("collapsed");
            }
        });

        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");

        });
        
        $("#filterBox").mCustomScrollbar({
    		theme:"dark-3",
    		scrollButtons:{
    			enable:true
			}
    	});
        $("#selectGrop").mCustomScrollbar({
    		theme:"dark-3",
    		scrollButtons:{
    			enable:true
			}
    	});
        $("#radioList").mCustomScrollbar({
    		theme:"dark-3",
    		scrollButtons:{
    			enable:true
			},
			autoHideScrollbar: true
    	});
        /*对比*/
        $('body').on('click','.btnSure',function () {
	        $(this).parents(".select-panel").removeClass('show');
        });
        $('body').on('click','.select-button',function () {
	        $(this).next().addClass('show');
        });
		/*tabs*/
        $('.tabs-panel').on('click','.tabs-inner',function () {
	        $(this).parents(".tabs-panel").find(".tabs-inner").removeClass('active');
	        $(this).addClass('active');
	        var target=$(this).attr("data-target");
	        $(target).show();
	        $(target).siblings(".body-box").hide();
        });
        /*筛选与tabs的联动*/
        $('.filter-content').on('click','.no-choice',function () {
            var cl_n=$(this);
            var subtitle=$(this).attr("title");
            var tid=$(this).attr("id");
            if(cl_n.hasClass('choiced')){
                cl_n.removeClass('choiced');
                tabClose(tid);
            }else{
                cl_n.addClass('choiced');
                addTab(subtitle,tid);
            }
        });
        
        /*-----------------------------*/
        var WatertypeBar = echarts.init(document.getElementById('WatertypeBar'));

        var WatertypeBarOption ={
            title: {
                text: '磷酸二铵装置',
                subtext: '2019.1.18 9:43:18',
                textStyle:{
                    fontSize: 16,
                    color:'#ffffff'
				},
                left:'10',
				top:'10'
            },
            textStyle: {
                color:'#ffffff'
            },
            tooltip : {
                trigger: 'axis',//trigger: 'item'
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            toolbox: {
                show: true,
                right: '30',
                top: '8%',
                iconStyle: {
                	borderColor: '#ffffff'
                },
                feature: {
                    magicType: {show: true, type: ['line', 'bar']},
                    saveAsImage: {show: true}
                }
            },
            grid: {
                top:'80',
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
                    rotate:30,
                },
                data: ['地点1','地点2','地点3','地点4','地点5','地点6','地点7','地点8','地点9','地点10','地点11']
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                	name: 'I',
                    type: 'bar',
                    barMaxWidth:'50%',
                    itemStyle:{
                        normal:{
                            color:'#ef8018'
                        }
                    },
                    data: [220, 202, 201, 234, 290, 230, 220,200, 101, 134, 90]
                }

            ],
        };

        WatertypeBar.setOption(WatertypeBarOption);
        
        
        
    });
    /*tabs*/
	function addTab(subtitle,id) {
		var $targetTabs=$(".tabs-panel");
		var $targetContent=$targetTabs.siblings(".tabs-content");
		
	    if (!hasTabs(subtitle)) {
	    	var tabsId='#mapTabs_'+id;
			var tabsHTML='<li class="tabs-item">\
					<a class="tabs-inner active" data-target="#mapTabs_'+id+'">'+subtitle+'</a>\
				</li>';		
			
			if(!id){
				id="un";
				var tabsContentHTML='<div class="body-box" id="mapTabs_undefined"></div>';
				
			}
				
	        $targetTabs.find(".tabs-inner").removeClass('active');		        
	        $targetContent.find(".body-box").hide();
	        $targetTabs.append(tabsHTML);
	        $targetContent.append(tabsContentHTML);
	        $(tabsId).show();
	        console.log(id);
	    }
	}
	function tabClose(id) {			
		var $targetTabs=$(".tabs-panel");
		var $targetContent=$targetTabs.siblings(".map-panel-body");
		var tabsId='#mapTabs_'+id;
		$("[data-target='"+tabsId+"']").remove();
		$(tabsId).hide();
	    selectTab($targetTabs.find(".tabs-inner").length-1);
	}

	function selectTab(index) {			
		var $targetTabs=$(".tabs-panel");
		$targetTabs.find(".tabs-inner").eq(index).trigger("click");
	}

	function hasTabs(title){
		$(".tabs-panel").find(".tabs-inner").each(function(){
			if($(this).text()===title){
				return true;
			}
		});
	}
	/*tabs over*/
    
    $(window).resize(function () {

    });

</script>

</body>

</html>