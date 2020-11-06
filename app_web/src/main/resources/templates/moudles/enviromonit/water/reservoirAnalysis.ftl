<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="reservoirDlg" class="easyui-dialog" style="width:800px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:380px;">
			<div title="详细信息">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top"> <span id="reservoirName"></span><span class="subtext fr" id="outfallMonitorTime"></span>
	       			</div>
	       			<div class="panel-group-body">
	       				<div class="panel-info" id="reservoirInfo">
	       				</div>
	       			</div>
	       		</div>
	        </div>
	        <div title="数据分析">
	        	<div class="data-analysis">
        			
					<div class="oh data-analysis-content">
						<div id="reservoirTimeList" class="radio-button-group">
							<span id="30d" class="active" value="30">30天</span>
							<span value="180">180天</span>
						</div>
						<div id="reservoirChart" style="height: 270px;width:680px;"></div>
						
					</div>
				</div>
        	</div>
	    </div>
	</div>
</div>