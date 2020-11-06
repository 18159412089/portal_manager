<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="enterpriseWindow" class="easyui-window" title="详细和数据分析" c class="easyui-dialog" style="width:1000px;height:600px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:552px;">
			 <div title="详情">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top">
	       				<span id="enterpriseName"></span><span class="subtext fr" id="monitrorTime"></span>
	       			</div>
	       			<div class="panel-group-body" >
	       				<div class="panel-info" id="enterpriseInfo">
	       				</div>  
	       				<div id="cameraView" style="padding-left: 15px;color: blue;"></div>       				
	       			</div>
	       		</div>
	        </div>
			
			
	        <div title="数据分析">
	        	<div class="data-analysis">
	        		<div id="enterpriseListContainer" class="radio-button-group radio-button-group3 style-list fl" style="width: 100px;height:100%;">
						<div id="enterpriseList">
						</div>
					</div>
					<div class="oh data-analysis-content">
						<div class="radio-button-group  radio-button-group4 " id="optionEnterprise">
							
						</div>
						<div id="enterpriseTypeBar" style="height: 400px;width:850px;"></div>
						<div class="selectBox-container">
							<div class="select-button">
								<span>排口选择</span>
							</div>
							<div class="select-panel">
								<div id="selectEnterpriseGropContainer" style="height:104px;">
									<div id="selectEnterpriseGrop">
									</div>
									<!--复选框 over-->											
								</div>
								<div class="tr">
									<button type="button" class="btnEnterpriseSure btn-blue l-btn">确定</button>
									<button type="button" class="cancel btn-blue l-btn">取消</button>
								</div>										
							</div>
						</div>
					</div>					
	        	</div>
	        </div>
	        
	    </div>	
	</div>
</div>