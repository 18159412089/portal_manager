<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="outfallDlg" class="easyui-dialog" style="width:800px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:380px;">
			<div title="详细信息">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top"> <span id="outfallName"></span><span class="subtext fr" id="outfallMonitorTime"></span>
						<a id="wastewaterPlantFileInfoSet"  class="title-link-tag" target="_blank">污水处理厂信息附件配置>></a>
						<a class="title-link-tag" href="" id="out_pdfBtn" target='_blank'>整改前后对比</a>
						<a class="title-link-tag" href="" id="out_videoBtn">整改视频</a>
	       			</div>
	       			<div class="panel-group-body">
	       				<div class="panel-info" id="outfallInfo">
	       				</div>
	       				<div id="cameraView" style="padding-left: 15px;color: blue;"></div>
	       				<div id="pdfView" style="padding-left: 15px;color: blue;"></div>
	       			</div>
	       		</div>
	        </div>
	        <div title="数据分析">
	        	<div class="data-analysis">
        			<div id="outfallPltCodeListScroll" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
        				<div id="outfallPltCodeList"></div>
					</div>
					<div class="oh data-analysis-content">
						<div id="outfallTimeList" class="radio-button-group">
							<span id="24hof" class="active" value="24">最近24小时</span>
							<span value="72">最近72小时</span>
						</div>
						<div id="outfallChart" style="height: 270px;width:680px;"></div>
						<div class="selectBox-container">
							<div class="select-button">
								<span>排口选择 </span>
							</div>
							<div class="select-panel">
								<div id="outfallListScroll" style="height:104px;">
									<div id="outfallList"></div>
								</div>
								<div class="tr">
									<button type="button" class="btnSure2 btn-blue l-btn">确定</button>
									<button type="button" class="btnCancel btn-blue l-btn">取消</button>
								</div>
							</div>
						</div>
					</div>
				</div>
        	</div>
	    </div>
	</div>
</div>


<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width: 800px; height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd: auto; height: 99%;"
           controls="controls" preload>您的浏览器不支持 video 标签。
    </video>
</div>