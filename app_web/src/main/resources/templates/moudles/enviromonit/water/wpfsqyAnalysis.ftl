<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="wpfsqyDlg" class="easyui-dialog" style="width:900px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="wpfsqy_tabs" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:500px;">
			<div title="详情" selected="true">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top"> <span id="wpfsqyName"></span><a class="title-link-tag" href="" id="pdfBtn" target='_blank'>整改前后对比</a>
						<a class="title-link-tag" href="" id="videoBtn">整改视频</a>
						<a id="wastewaterCompanyFileInfoSet"  class="title-link-tag" target="_blank">废水企业信息附件配置>></a>
						<a id="wastewaterCompanyInfoSet"  class="title-link-tag" target="_blank">废水企业信息配置>></a>
	       			</div>
	       			<div class="panel-group-body">
	       				<div class="panel-info" id="wpfsqyInfo">
						</div>
                        <div id="cameraViewBtn" style="padding-left: 15px;color: blue;"></div>
						<div class="panel-table">
                            <table class="table-info alone-table" id="wpfsqyTableInfo" >
                            </table>
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
