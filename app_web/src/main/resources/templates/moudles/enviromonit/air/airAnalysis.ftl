<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="air" class="easyui-window" title="详细和数据分析" c class="easyui-dialog" style="width:1000px;height:600px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:552px;">
			 <div title="详情">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top">
	       				<span id="cityName"></span><span class="subtext fr" id="monitrorTime"></span>
	       			</div>
	       			<div class="panel-group-body" >
	       				<div class="panel-info" id="airInfo">
	       				</div>         				
	       			</div>
	       		</div>
	        </div>
			
	        <div title="数据分析">
	        	<div class="data-analysis">
	        		<div id="radioListContainer" class="radio-button-group radio-button-group1 style-list fl" style="width: 100px;height:100%;">
						<div id="radioList">
						</div>
					</div>
					<div class="oh data-analysis-content">
						<div class="radio-button-group radio-button-group2 " id="option">
							
						</div>
						<div id="AirtypeBar" style="height: 400px;width:850px;"></div>
						<#--<div class="selectBox-container">
							<div class="select-button">
								<span>对比 </span>
							</div>
							<div class="select-panel">
								<div id="selectGropContainer" style="height:104px;">
									<div id="selectGrop">
									</div>
									<!--复选框 over&ndash;&gt;
								</div>
								<div class="tr">
									<button type="button" class="btnSure btn-blue l-btn">确定</button>
									<button type="button" class="cancel btn-blue l-btn">取消</button>
								</div>										
							</div>
						</div>-->
					</div>					
	        	</div>
	        </div>
	    </div>	
	</div>
</div>

<div id="peripheralAnalysis" class="easyui-window" title="周边分析"  class="easyui-dialog" style="width:300px;height:200px;background:#FFFFFF;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
     	<div class="easyui-layout" data-options="fit:true">
			
			<div data-options="region:'center'" style="padding:10px;">
				<input type="hidden" id="pointCode">
			范围：<input class="text" style="width:60%;height:32px;" id="distance"  >&nbsp公里
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
				<div style="margin:0 auto;">
					<input type="button" value="确定" style="width:40%;height:32px;" onclick="selectPeripheral()">
				</div>
			</div>
		</div>
	
</div>

