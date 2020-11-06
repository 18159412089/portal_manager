<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="container" class="easyui-window" title="详细信息" class="easyui-dialog" style="width:950px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:552px;">
			 <div title="详情">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top">
	       				<span id="containerNames"></span><span class="subtext fr" id="monitrorTime"></span>
	       			</div>
	       			<div class="panel-group-body" >
	       				<div class="panel-info" id="containerInfo">
	       					<span>经度：104.62</span>
	       				</div>         				
	       			</div>
					<div class="bnt-part" style="padding-bottom: 5px">
						<a class="l-btn btn-primary" href="" id="pdfBtn" target='_blank'>整改前后对比</a>
						<a class="l-btn btn-primary" href="" id="videoBtn">整改视频</a>
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