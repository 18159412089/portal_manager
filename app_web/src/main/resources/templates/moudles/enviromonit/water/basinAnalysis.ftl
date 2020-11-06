<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>

<style>

</style>
<div id="basinDlg" class="easyui-dialog" style="width:900px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="basin_tabs" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:500px;">
			<div title="简介详情" selected="true">
	    		<div class="panel-group-container">
					<div class="panel-group-top">
                        <span class="subtext fr" id="basinMonitorTime"></span>
                        <div class="info_search_title_orange"><span id="basinName" ></span><i></i></div>
					</div>

	       			<#--<div class="panel-group-body">-->
                        <div class="panel-info" id="basinInfo"></div>
                        <div class="panel-group-title">
                            <span id="spanFileId"></span>
								 <a id="fjlbid" class="title-link-tag" target="view_window ">附件列表>></a>
							</span>

                        </div>
					<span class="subtext fr" id="attach_river"  ></span>

					<#--文档列表-->
                        <div class="panel-table">
                        <table class="table-info alone-table" id="dg1" ></table>
						</div>
                        <div class="panel-group-title">
							<span id="spanDetailId" ></span><i></i>
						</div>
						<div class="panel-table">
                        <table class="table-info alone-table" id="tb_otherInfo" >
                        </table>
                        </div>
						<div class="panel-table">
						<table class="table-info alone-table pdfview-table" id="basinTableInfo">
						</table>
						</div>
	       			<#--</div>-->
	       		</div>
	        </div>
	        <div id="basinAnalysis" title="概况与分析">
	    		<div class="data-analysis">
					<div class="panel-info" style='font-size:14px;margin:10px' id="basinText"></div>
				</div>
	        </div>
	        <div title="同比分析">
	        	<div class="data-analysis">
	        		<div id="basin_polluteList_tb" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
						<span id="basin_ph_tb" class="active" value="PH_VALUE" unit="">PH值</span>
						<span value="RJY_VALUE" unit="(mg/L)">溶解氧</span>
						<span value="GMSY_VALUE" unit="(mg/L)">高锰酸盐</span>
						<span value="BOD_VALUE" unit="(mg/L)">五日生化需氧量</span>
						<span value="ZL_VALUE" unit="(mg/L)">总磷</span>
						<span value="ANDAN_VALUE" unit="(mg/L)">氨氮</span>
					</div>
					<div class="oh data-analysis-content">
						<div id="waterBasinBar_tb" style="height: 390px;"></div>
					</div>
	        	</div>
	        </div>
	        <div title="环比分析">
	        	<div class="data-analysis">
	        		<div id="basin_polluteList" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
						<span id="basin_ph" class="active" value="PH_VALUE" unit="">PH值</span>
						<span value="RJY_VALUE" unit="(mg/L)">溶解氧</span>
						<span value="GMSY_VALUE" unit="(mg/L)">高锰酸盐</span>
						<span value="BOD_VALUE" unit="(mg/L)">五日生化需氧量</span>
						<span value="ZL_VALUE" unit="(mg/L)">总磷</span>
						<span value="ANDAN_VALUE" unit="(mg/L)">氨氮</span>
					</div>
					<div class="oh data-analysis-content">
						<div id="waterBasinBar" style="height: 390px;"></div>
					</div>
	        	</div>
	        </div>
	        <div title="年均对比">
	        	<div class="data-analysis">
	        		<div id="basin_polluteList_njdb" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
						<span id="basin_ph_njdb" class="active" value="PH_VALUE" unit="">PH值</span>
						<span value="RJY_VALUE" unit="(mg/L)">溶解氧</span>
						<span value="GMSY_VALUE" unit="(mg/L)">高锰酸盐</span>
						<span value="BOD_VALUE" unit="(mg/L)">五日生化需氧量</span>
						<span value="ZL_VALUE" unit="(mg/L)">总磷</span>
						<span value="ANDAN_VALUE" unit="(mg/L)">氨氮</span>
					</div>
					<div class="oh data-analysis-content">
						<div id="waterBasinBar_njdb" style="height: 390px;"></div>
					</div>
	        	</div>
	        </div>
	    </div>
	</div>
</div>

<script>
    function seeAttach(value, row, index) {
        var mongoid = row.mongoid;
        if (row.type == 3) {
            return "<div>"+Ams.setImageSee()+"<a href='javascript:onClick=play(\"" + row.mongoid + "\")' class='easyui-linkbutton'>查看</a></div>";
        } else {
            return "<div>"+Ams.setImageSee()+"<a href='/environment/waterAttachment/download/" + row.mongoid + "/" + row.type
                    + "' class='easyui-linkbutton' target='_blank'>查看</a></div>";
        }
    }
</script>