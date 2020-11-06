<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<head>
    <title>环保督察-销号汇总表</title>
    <style type="text/css">

    	/*.window-shadow{*/
    		/*display: none !important;*/
    	/*}*/

        html{
            min-width: auto!important;
        }
        .textbox{
            border: 1px solid #45b97c !important;
        }
        #toolbar .textbox-text{
            background-color: #f3f8f6;
        }

    </style>
</head>
<body style=" background-color: #f3f8f6;">
    <#include "/common/loadingDiv.ftl"/>
    <#include "/decorators/header.ftl"/>
    <#include "/passwordModify.ftl">
<#--    <#if authority??>-->
<#--        <#include "/supervisionMenu.ftl">-->
<#--    <#else>-->
<#--        <#include "/inputSupervisionMenu.ftl">-->
<#--    </#if>-->
    <#include "/secondToolbar.ftl">
<!-- datagrid -->
<input type="hidden" id="authority" value="${authority!}">
<div class="easyui-layout"  style="padding-bottom:50px;margin-left:0px;" id="myPrint">

    <div class="dc-content-box">
        <input type="hidden" id="authority" value="${authority!}"  />
        <div class="data-display-container" style="padding: 0px;padding-top: 15px;padding-bottom: 10px;">
            <div class="title">
                <span id="title">漳州市环保督察销号汇总表</span>
                <a id="printImg" onclick="Ams.doPrint('myPrint','环保督察销号汇总表')" class="printing-button"  >
                    <span style="font-size: 28px; vertical-align: middle" class="icon iconcustom" /></span> 打印
                </a>
                <a id="exportImg" onclick="Ams.exportPdfById('myPrint','环保督察销号汇总表')" class="printing-button" >
                    <span class="icon iconcustom icon-PDFwenjian yl_print"></span> 导出PDF
                </a>
            </div>
            <div class="dc-info-box">
                <p id="timeId">截至2019年5月6日</p>
                <div class="entry-list five-box">
                    <div class="entry-item">
                        <span>已完成整改销号问题</span>
                        <p><i id="zgxh">0</i> 个</p>
                    </div>
                    <div class="entry-item">
                        <span>已完成县级验收</span>
                        <p><i id="xjys">0</i> 个</p>
                    </div>
                    <div class="entry-item">
                        <span>已完成市级验收</span>
                        <p><i id="sjys">0</i> 个</p>
                    </div>
                    <div class="entry-item">
                        <span>已提交行业验收</span>
                        <p><i id="tjys">0</i> 个</p>
                    </div>
                    <div class="entry-item">
                        <span>已完成行业审查</span>
                        <p><i id="wcsc">0</i> 个</p>
                    </div>
                </div>
            </div>
        <#--<div id="message" style="padding:10px; width: 100%;text-align: center;font-size: 120%;font-weight: bold;color:white;background-color:#676767;"></div>-->
        </div>
        <div id="toolbar">
            <div style="padding:3px;background-color: #f3f8f6;padding: 3px; border-bottom: none" id="searchBar" >
                <form id="searchForm">
                    <label class="control-label">项目名称:</label>
                    <input id="queryProjectName" name="queryProjectName" class="easyui-textbox"  style="width:200px;">
                    <label class="control-label">问题描述:</label>
                    <input id="queryDescribleName" name="queryDescribleName" class="easyui-textbox" style="width:200px;">
                <#--
                <label class="control-label">监测时间：</label>
                <input id="startTime" name="startTime" class="easyui-datebox" required="true" data-options="editable:false" style="width:156px;">
                <span>-</span>
                <input id="endTime" name="endTime" class="easyui-datebox" required="true" data-options="editable:false" style="width:156px;">
                -->
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-redo'" onclick="exportExl()">导出EXCEL</a>
            </form>
        </div>
    </div>
    <div class="easyui-layout"  style="padding-bottom:70px;margin-left:0px;">
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/environment/envCancellationAccount/list" data-options="
            queryParams : '',
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:false,
            pagination:true,
            pageSize:10,
            pageList:[10,20,30]">
                <thead>
                <tr>
                    <th field="projectName" width="220px" formatter="Ams.tooltipFormat">项目名称</th>
                    <th field="describleName" width="220px" formatter="Ams.tooltipFormat">问题简述</th>
                    <th field="timeLimit" width="220px" formatter="timeEdit">问题整改完成时限</th>
                    <th field="schedule" width="220px" formatter="Ams.tooltipFormat">整改进度</th>
                <#--<th field="countyEstimateTime" width="220px" formatter="timeEdit">拟县级验收时间</th>-->
                    <th field="countyActualTime" width="220px" formatter="timeEdit">实际县级验收时间</th>
                <#--<th field="cityEstimateTime" width="220px" formatter="timeEdit">拟市级验收时间</th>-->
                    <th field="cityActualTime" width="220px" formatter="timeEdit">实际市级验收时间</th>
                <#--<th field="professionEstimateTime" width="220px" formatter="timeEdit">拟提交行业验收时间</th>-->
                    <th field="professionActualTime" width="220px" formatter="timeEdit">实际提交行业验收时间</th>
                    <th field="professionExamineTime" width="220px" formatter="timeEdit">完成行业审查时间</th>
                    <th field="operate" width="220px" Resizable=false formatter="formatOperate">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <#include "/moudles/debriefing/tips-font.ftl"/>
    <!-- 引入底部文字提示 main -->
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="dlg_uuid" name="dlg_uuid" hidden="true"/>
        <input id="dlg_field" name="dlg_field" type="hidden">
        <div style="margin-bottom:10px">
            <label class="control-label">请确认时间： </label>
             <input id="modifyTime" name="modifyTime" class="easyui-datebox" required="false" data-options="editable:false" style="width:200px;">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveTime()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<script>
	function formatOperate(value,row,index){
		var uuid = row.rectifitionUuid;
		return "<div>"+Ams.setImageDelete()+"<a href='#' class='easyui-linkbutton' onClick=\"del('"+uuid+"')\">删除</a></div>";
	}

	//删除 
    function del(uuid){  
         if (uuid) {
             $.messager.confirm("提示信息", "确认删除？", function (r) {
                 if (r) {
                     $.ajax({
                         type: 'POST',
                         url: Ams.ctxPath + '/environment/envCancellationAccount/delete',
                         data: {
                             'uuid': uuid
                         },
                         success: function (result) {
                             var result = eval(result);
                             if (result.type == 'E') {
                                 Ams.error(result.message);
                             } else {
                                 $('#dg').datagrid('load');
                                 info();
                                 Ams.success(result.message);
                             }
                         },
                         dataType: 'json'
                     });
                 }
             });
         } else {
             $.messager.alert('提示', '请选择要删除的人员信息！');
         }
    }  
	
	var authority = $("#authority").val()
	$(function(){
		getDescript();
		if(authority == 1){
			$('#dg').datagrid('hideColumn','operate');
		}
	});
	

    
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch() {
        $('#dg').datagrid('load', {
            projectName : $("#queryProjectName").val(),
            describleName : $("#queryDescribleName").val()
        });
        getDescript();
    }
    function exportExl(){
        window.location.href = "${request.contextPath}/environment/envCancellationAccount/list?export=yes&projectName="+$("#queryProjectName").val()+"&describleName="+$("#queryDescribleName").val();
    }
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
    var num = 0;
    function timeEdit(value,row,index){
    	// 标记value是否有值 默认没值 为false。
        var flag = false;
        var title = this.title;
        var uuid = row.uuid;
        var field = this.field;
        var columnId;
        if(field == "countyActualTime") {
            columnId = "COUNTY_ACTUAL_TIME";
            num = 0; 
        } else if(field == "cityActualTime"){
            columnId = "CITY_ACTUAL_TIME";
        } else if(field == "professionActualTime"){
            columnId = "PROFESSION_ACTUAL_TIME";
        } else if(field == "professionExamineTime"){
            columnId = "PROFESSION_EXAMINE_TIME";
        } else if(field == "timeLimit"){
            columnId = "TIME_LIMIT";
        }
        var temp = Ams.dateFormat(value, 'yyyy-MM-dd');
        if(authority == 1){
            if(value==null){
                return "暂未设置时间";
            }else{
                return temp;  
            }
        }
        if(value != null){
            num++;
		}else {
            flag = true;
		}
		if(columnId=="TIME_LIMIT" ){
	        if(value==""){            
	            return "<a href='javascript:void(0)' class='easyui-linkbutton' onClick='show(\""+uuid+"\",\""+columnId+"\",\""+temp+"\",\""+title+"\")'>设置时间</a>";
	        } else {
	            return temp+"<br><a href='javascript:void(0)' class='easyui-linkbutton' onClick='show(\""+uuid+"\",\""+columnId+"\",\""+temp+"\",\""+title+"\")'>修改时间</a>";
	        }
		}
            
        if(flag && num == 0){
            num--;
            return "<a href='javascript:void(0)' class='easyui-linkbutton' onClick='show(\""+uuid+"\",\""+columnId+"\",\""+temp+"\",\""+title+"\")'>设置时间</a>";
        }else if(!flag){
            num--;
            return temp+"<br><a href='javascript:void(0)' class='easyui-linkbutton' onClick='show(\""+uuid+"\",\""+columnId+"\",\""+temp+"\",\""+title+"\")'>修改时间</a>";
        }
    }
    
    function show(uuid,columnName,value,title){
        $('#dlg_uuid').text(uuid);
        $('#dlg_field').text(columnName);
        $('#modifyTime').datebox('setValue',value);
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', title);
    }

	function getDescript(){
		$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/environment/envCancellationAccount/getDescript",
			async : true,
			data: {
				projectName : $("#queryProjectName").val(),
	            describleName : $("#queryDescribleName").val()
			},
			dataType: "json",
			success: function(data){
				var date=new Date();
                $('#title').text((Ams.isNoEmpty(data.qx)==true?data.qx:'漳州市')+'环保督察销号汇总表')
				$("#timeId").text("截至"+date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日 ");
				$("#zgxh").text(data.num);
                $("#xjys").text(data.num1);
                $("#sjys").text(data.num2);
				$("#tjys").text(data.num3);
				$("#wcsc").text(data.num4);

			},
			error: function(r){console.log(r);}
		});
		
	}
    
    function saveTime() {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/envCancellationAccount/saveTime',
            data: {'uuid': $('#dlg_uuid').text(),
                'columnId': $('#dlg_field').text(),
                'modifyTime': $('#modifyTime').datebox('getValue')
            },
            success: function (result) {
                $('#dlg').dialog('close');
                $('#dg').datagrid('load');
                getDescript();
            },
            error: function () {
                $.messager.progress('close');
                $.messager.show({
                    title: '错误',
                    msg: '修改失败！'
                });
            },
            dataType: 'json'
        });
    }
</script>
</body>
</html>