<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="monitorDlg" class="easyui-dialog" style="width:900px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:500px;">
            <div title="详情" selected="true">
                <div class="panel-group-container">
                    <div class="panel-group-top"><span id="pointName"></span>
                        <span class="subtext fr" id="moreData">&emsp;<a class="title-link-tag" target="view_window">更多数据<span class="icon iconcustom"></span></a></span>
                        <span class="subtext fr" id="monitorTime"></span>
                    </div>
                    <div class="panel-group-body">
                        <div class="panel-info" id="pointInfo">
                        </div>
                        <div class="panel-table">
                            <table class="table-info alone-table pdfview-table" id="pointTableInfo">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div title="数据分析">
                <div class="data-analysis">
                    <div id="polluteCodeList" class="radio-button-group style-list fl"
                         style="width: 100px;height:100%;">
                        <span id="ph" class="active" value="W01009" unit="(mg/L)">溶解氧</span>
                        <span value="W01019" unit="(mg/L)">高锰酸盐</span>
                        <span value="W21003" unit="(mg/L)">氨氮</span>
                        <span value="W21011" unit="(mg/L)">总磷</span>
                        <span value="W01001" unit="">PH值</span>
                        <span value="W21001" unit="(mg/L)">总氮</span>
                        <span value="W01003" unit="(NTU)">浑浊度</span>
                        <span value="W01010" unit="(℃)">水温</span>
                        <span value="W01014" unit="(μs/cm)">电导率</span>
                    </div>
                    <div class="oh data-analysis-content">
                        <div id="timeList" class="radio-button-group">
                            <span id="24h" class="active" value="24">最近24小时</span>
                            <span value="72">最近72小时</span>
                        </div>
                        <div id="waterPointBar" style="height: 390px;"></div>
                        <div class="selectBox-container">
                            <div class="select-button">
                                <span>对比 </span>
                            </div>
                            <div class="select-panel">
                                <div id="monitorListScroll" style="height:104px;">
                                    <div id="monitorList" style="padding: 10px;"></div>
                                </div>
                                <div class="tr">
                                    <button type="button" class="btnSure btn-blue l-btn">确定</button>
                                    <button type="button" class="btnCancel btn-blue l-btn">取消</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div title="附件">
                <div class="panel-group-container">
                    <div class="theme-content">

                        <div class="search-container alone-search" id="search3">
                            <div class="search-box">

                                <input class="easyui-textbox" style="width:100%;" id="attachementName"/>
                                <a href="javascript:void(0)" onclick=findAttachmentByName() class="easyui-linkbutton"
                                   data-options="iconCls:'icon-search'"></a>
                                <span class="subtext fr" id="attach" style="position: absolute; left: 600px; bottom: 5px; width: 100px;">
                                    <a class="title-link-tag" target="view_window">附件列表>></a>
                                </span>
                            </div>

                        </div>
                    </div>
                        <div class="easyui-table-light  alone-easyui-table" id="datagridTable" >
                            <table id="attachmentIdDg" class="easyui-datagrid"
                                   style="width: 100%;height:440px;" toolbar="#search3"
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
                                    <th field="qymc1" width="431px" formatter="getPointAttachentName">文件</th>
                                    <th field="qymc2" width="431px" formatter="operation">操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>