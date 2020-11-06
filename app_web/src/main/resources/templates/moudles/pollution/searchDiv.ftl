
<div class="soil-data">
    <div class="soil-title"><span class="icon iconcustom icon-turang"></span>区域划分 <div class="soil-search-tex" id="showSearch">高级搜索</div></div>


    <div class="soil-table-box">
        <!--搜索框-->
        <div class="theme-content searchInfo"  >
            <div class="search-container" id="search">
                <div class="search-box">
                    <input class="easyui-textbox"  data-options="prompt:'请根据企业名称/区县/类别来模糊查询'" style="width:100%;" id="queryMc"/>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()"></a>
                </div>
            </div>
            <div class="easyui-table-light">
                <table id="searchDG" class="easyui-datagrid"
                       style="width: 100%;height:auto;min-height: 300px;" toolbar="#search"
                       data-options="
							            rownumbers:true,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                    <thead>
                    <tr>
                        <th field="name" width="170" formatter="Ams.tooltipFormat">企业名称</th>
                        <th field="qx" width="80" formatter="Ams.tooltipFormat">区县</th>
                        <th field="wryzl" width="120" formatter="Ams.tooltipFormat">类型</th>
                    </tr>
                    </thead>
                </table>
            </div>

        </div>
        <!--搜索框 over-->

        <ul class="soil-table-list" id="areaList">
        </ul>
    </div>
</div>