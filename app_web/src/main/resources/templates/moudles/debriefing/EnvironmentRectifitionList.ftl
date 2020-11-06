<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en" class="min-data">
<head>
    <title>环保督察-整改汇总表</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"/>

<body class="wrap-color" >
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<div class="hzb-content-wrap">
    <div class="details-bar">
    <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
        <a class="link-tag" style="cursor: pointer" data-options="iconCls:'icon-add'" onclick="newOne()">
            新增任务
        </a>
    <a data-options="iconCls:'icon-add'" style="cursor: pointer" onclick="earlyone()">
        预警时间
    </a>
    </@sec.authorize>
    </div>
<input type="hidden" id="authority" value="${authority!}">

    <div class="dc-info-box ">
        <p id="timeid">截至2019年5月6日</p>
        <div class="entry-list seven-box">
            <div class="entry-item">
                <span id="title">我市中央环保督察问题</span>
                <p><i id="zyhb">0</i> 个</p>
            </div>
            <div class="entry-item">
                <span>尚未启动任务</span>
                <p><i id="swqd">0</i> 个</p>
            </div>
            <div class="entry-item">
                <span>未达到序时进度任务</span>
                <p><i id="wdxs">0</i> 个</p>
            </div>
            <div class="entry-item">
                <span>达到序时进度任务</span>
                <p><i id="ddxs">0</i> 个</p>
            </div>
            <div class="entry-item">
                <span>超过序时进度任务</span>
                <p><i id="cgxs">0</i> 个</p>
            </div>
            <div class="entry-item">
                <span>完成整改任务</span>
                <p><i id="wczg">0</i> 个</p>
            </div>
            <div class="entry-item">
                <span>完成交账销号任务</span>
                <p><i id="wcxz">0</i> 个</p>
            </div>

        </div>
    </div>

    <form id="searchForm"  class="searchForm-style">
        <input id="queryProjectName" name="projectId" class="easyui-combobox" style="width:200px;" label="项目:"
               data-options="
            	required:false,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION&num=${num}',
            	valueField:'id',
            	textField:'name'"/>
        <input id="queryAreaCode" label="行政区划:" class="easyui-combobox" name="queryAreaCode"  style="width:250px;" data-options="
                   url:'${request.contextPath}/env/pollution2/getAllPollutionCity',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name'"/>

        <label class="control-label">完成情况:</label>
    <@al.menuCommobox name="queryStatus" id="queryStatus" labelPosition="left" style="width:180px" type="EvnRectifitionEnum" onChange=""/>
        <!-- <select name="queryStatus" id="queryStatus" label="完成情况:" class="easyui-combobox" style="width:200px">
            <option value="" selected="selected">全部状态</option>
            <option value="over">整改完成</option>
            <option value="pass">超过序时进度</option>
            <option value="ontime">达到序时进度</option>
        </select> -->
        <label class="control-label">整改时限:</label>
        <input id="queryLimit" name="queryLimit" class="easyui-datebox yl-easyui-textbox" data-options="editable:false" style="width:160px;">
        <div style="display:none;"><input id="queryDutyDepartment" name="queryDutyDepartment" class="easyui-textbox" data-options="editable:false" style="width:160px;"/></div>
        <div style="display:none;"><input id="queryCityCode" name="queryCityCode" class="easyui-textbox" data-options="editable:false" style="width:160px;"/></div>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-redo'" onclick="exportExl()">导出EXCEL</a>
    </form>

    <div class="details-info-box" id="divTable">
        <ul class="tit-entry-box">
            <li class="alone-tag" onclick="getBtn('all')"> <span>全部</span></li>
            <li onclick="getBtn('over')"><span>整改时间延期</span><a class="radius-tag" id="overTal"></a></li>
        </ul>


    </div>
<#include "/moudles/debriefing/tips-font.ftl"/>
    <!-- 引入底部文字提示 main -->

    <!-- 改变项目完成情况 -->
    <div id="dlg-status" class="easyui-dialog" style="withd:600px; " data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-status-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
            <input name="uuid" hidden="true"/>
            <div style="margin-bottom:10px">
            <@al.menuCommobox name="status" id="status" label="完成情况:" labelPosition="left" style="width:200px" type="EvnRectifitionEnum" onChange=""/>
            </div>
        </form>
    </div>

    <div id="dlg-status-buttons"  >
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveStatus()"
           style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="$('#dlg-status').dialog('close')" style="width:90px">取消</a>
    </div>



<#--预警弹窗开始-->
    <div class="early-warning-show" style="display:none;">
        <div class="early-center-box">
        <#--<div class="early-head">-->
        <#--<span class="icon iconcustom"></span>-->
        <#--</div>-->
            <div class="early-info" >
                <div class="row-item">
                    <label>预警时间：</label>
                    <input id="warnTime" type="text" placeholder="请输入预警时间" oninput="this.value=this.value.replace(/[^\d]/g,'');if(value.length>3) value=value.slice(0,3)" oninput="" />
                    <span class="day-tex">天</span>
                </div>
                <div class="row-item">
                    <a onclick="warnTimeComfirm()"  style="cursor: pointer">确认 </a>
                    <a class="close-early" style="cursor: pointer">取消 </a>
                </div>
            </div>
        </div>
    </div>


    <!-- 新增任务弹窗 -->
    <div id="dlg" class="easyui-dialog" style="width:600px;height:500px;display: none" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
            <input name="uuid" hidden="true"/>
            <input name="wornTime" value="0" hidden="true"/>
            <input id="debriefing" name="debriefing" value="" type="hidden">
            <div style="margin-bottom:10px">
                <input label="创建时间:" name="createtime" required="required" class="easyui-datebox" data-options="editable:false" style="width:100%;">
            </div>
            <input id="numOfRoundNameAdd" name="numOfRoundName" hidden>
            <div style="margin-bottom:10px">
                <input name="numOfRoundValue" id="numOfRoundValueAdd" class="easyui-combobox"
                       data-options="
                                editable:true,
                                required:true,
                                url:'${request.contextPath}/environment/rectifition/getNumOfRound',
                                valueField:'id',
                                textField:'name',
                                " label="期数：" style="width:250px;">
                </input>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="openNumOfRound('add')" data-options="toggle:true,group:'g1'">新增</a>
            </div>
            <div style="margin-bottom:10px">
                <input id="projectId" name="projectId" class="easyui-combobox" style="width:100%" label="项目:"
                       data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION&num=${num}',
            	valueField:'id',
            	textField:'name'">
                </input>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="openRelation01('relation01')" data-options="toggle:true,group:'g1'">新增</a>
            </div>
            <div style="margin-bottom:10px">
                <input id="describleId" name="describleId" class="easyui-combobox" style="width:100%" label="问题描述:" data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_02&relation=ENVIRONMEENT_RECTIFITION&num=${num}',
            	valueField:'id',
            	textField:'name'"></input>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="openRelation01('relation02')" data-options="toggle:true,group:'g1'">新增</a>
            </div>
            <div style="margin-bottom:10px">
            <@al.menuCommobox name="status" id="status" label="完成情况:" labelPosition="left" required="true" style="width:200px" type="EvnRectifitionEnum" onChange=""/>
            </div>
            <div style="margin-bottom:10px">
            <@al.menuCommobox name="category" id="category" label="归类:" labelPosition="left" required="true" style="width:200px" type="EvnRectfCatogoryEnum" onChange=""/>
            </div>
            <div style="margin-bottom:10px">
                <input  name="limit" class="easyui-datebox" data-options="required:true,label:'整改时限:'" data-options="editable:false" style="width:200px;">
            </div>
            <div style="margin-bottom:10px">
                <input name="require" class="easyui-textbox" data-options="required:true,label:'整改要求:',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
            </div>
            <div style="margin-bottom:10px">
                <input name="question" class="easyui-textbox" data-options="required:true,label:'进展问题:',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-combobox" id="areaCode"  name="areaCode" style="height: 32px; width: 140px;"
                       data-options="
									url:'${request.contextPath}/env/pollution2/getAllPollutionCity',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'auto',label:'行政区划:'"
                       style="width:200px;"/>
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-combobox" id="cityCode"  name="cityCode" style="height: 32px; width: 140px;"
                       data-options="
									url:'${request.contextPath}/env/pollution2/getAllPollutionCity',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'auto',label:'所属城市:'"
                       style="width:200px;"/>
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyPerson" class="easyui-textbox" data-options="label:'责任人:',validType:'maxLength[65]'" style="width: 200px;">
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyPersonPhone" class="easyui-textbox" data-options="label:'责任人电话:',validType:'mobileAndTel'" style="width: 200px;">
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyDepartment" class="easyui-textbox" data-options="label:'责任部门:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyUnit" class="easyui-textbox" data-options="label:'责任单位:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="involveDepartment" class="easyui-textbox" data-options="label:'涉及部门:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="involvePerson" class="easyui-textbox" data-options="label:'涉及人员:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="leadPerson" class="easyui-textbox" data-options="label:'牵头人:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="leadUnit" class="easyui-textbox" data-options="label:'牵头单位:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="matchUnit" class="easyui-textbox" data-options="label:'配合单位:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>

        </form>
    </div>
    <div id="dlg-buttons" >
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveOne()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>

    <!-- 项目问题描述新增弹窗关闭 -->
    <div id="dlg-closeBtn"  >
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-cancel" onclick="$('#dlg-relation01').dialog('close')" style="width:90px">关闭</a>
    </div>

    <!-- 期数新增弹窗关闭 -->
    <div id="dlg-closeRoundBtn"  >
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-cancel" onclick="$('#dlg-numOfRound').dialog('close')" style="width:90px">关闭</a>
    </div>


    <!-- 项目问题描述新增弹窗 -->
    <div id="dlg-relation01" class="easyui-dialog" style="width:600px;height:500px;display: none"  data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-closeBtn'">
        <div id="toolbar1">
            <form id="fm" method="post" novalidate enctype="multipart/form-data" style="display:inline;padding:10px;">
                <input name="uuid" id="uuid" hidden="true"/>
                <label class="control-label" id="projQuesTitle">项目：&emsp;</label>
                <input name="name" id="name" class="easyui-textbox" required="true" style="width: 80%;" data-options="validType:'maxLength[65]'">
                <input name="code" id="code" hidden="true"/>
                <input name="num" id="num" value="${num}" hidden="true"/>
                <input name="relation" id="relation" hidden="true"/>
            </form>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-add'" onclick="saveRelation01()">新增</a>
        </div>
        <table id="relation-dg" class="easyui-datagrid" toolbar="#toolbar1" style="width: 100%;"
               data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fit:true,
            pagination:true,
            pageSize:5,
            pageList:[5,10,15]">
            <thead>
            <tr>
                <th field="name" id="tblName" width="350px" Resizable=false>名称</th>
                <th field="createDate" width="200px" Resizable=false formatter="formatOpr">操作</th>
            </tr>
            </thead>
        </table>
    </div>
    <!-- 期数新增弹窗 -->
    <div id="dlg-numOfRound" class="easyui-dialog" style="width:600px;height:500px;display: none"  data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-closeRoundBtn'">
        <div style="padding-bottom: 10px;padding-top: 10px">
            <form id="numOfRounFm" method="post" novalidate enctype="multipart/form-data" style="display:inline;padding:10px;">
                <table style="padding-bottom: 5px" class="roundid" fit=true></table>
                <input name="uuid" hidden="true"/>
                <input name="code" id="AddNumOfRoundValue" class="easyui-combobox"
                       data-options="
                                editable:true,
                                required:true,
                                valueField:'id',
                                textField:'name',
                                " label="期数：" style="width:250px;">
                </input>
                <input name="num" id="roundNum" hidden="true"/>
                <input name="relation" value="NUM_OF_ROUND_ZZ" hidden="true"/>
            </form>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-add'" onclick="saveNumOfRound()">提交</a>
        </div>
        <table id="numOfRoundTbl" class="easyui-datagrid"  style="width: 100%;"
                url="${request.contextPath}/environment/rectifition/getNumOfRound"
               data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fit:true,
            pagination:false,
            pageSize:5,
            pageList:[5,10,15]">
            <thead>
            <tr>
                <th field="uuid"  hidden></th>
                <th field="relation"  hidden></th>
                <th field="name"  width="350px" Resizable=false>期数</th>
                <th field="createDate" width="200px" Resizable=false formatter="formatNumOfRound">操作</th>
            </tr>
            </thead>
        </table>
    </div>

    <!-- 关联表修改弹窗 -->
    <div id="dlg-update" class="easyui-dialog" style="width:600px;display: none" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-update-buttons'">
        <div class="easyui-panel" style="width:100%;height:100px;" style="padding:5px">
            <form id="fm" method="post" novalidate enctype="multipart/form-data" style="display:inline;padding:10px;">
                <div style="padding:10px">
                    <input name="uuid" id="uuid" hidden="true"/>
                    <label class="control-label" id="edidTitle">项目：</label>
                    <input name="name" class="easyui-textbox" data-options="validType:'maxLength[65]'" style="width: 100%;">
                    <input name="code" id="code" hidden="true"/>
                    <input name="relation" id="relation" hidden="true"/>
                </div>
            </form>
        </div>
    </div>
    <div id="dlg-update-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="updateRelation()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg-update').dialog('close')" style="width:90px">取消</a>
    </div>

    <!-- 期数修改弹窗 -->
    <div id="dlg-update-round" class="easyui-dialog" style="width:600px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-update-round-buttons'">
        <div class="easyui-panel" style="width:100%;height:110px;" style="padding:5px">
            <form id="roundFm" method="post" novalidate enctype="multipart/form-data" style="display:inline;padding:10px;">
                <div style="padding:10px">
                    <input name="uuid" id="uuid" hidden="true"/>
                    <input name="code" id="editNumOfRoundValue" class="easyui-combobox"
                           data-options="
                                editable:false,
                                required:true,
                                valueField:'id',
                                textField:'name',
                                " label="期数：" style="width:250px;">
                    </input>
                    <input name="num"  hidden="true"/>
                    <#--<input name="name"  hidden="true"/>-->
                    <input name="relation" value="NUM_OF_ROUND_ZZ" hidden="true"/>
                </div>
            </form>
        </div>
    </div>
    <div id="dlg-update-round-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="updateRound()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg-update-round').dialog('close')" style="width:90px">取消</a>
    </div>



    <#--编辑任务-->
    <div id="dlg_one" class="easyui-dialog" style="width:600px;height:75% ;display: none"
         data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons_one'">
        <form id="fm_one" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
            <input type="hidden" name="uuid" id="uuid">
            <input name="wornTime"  hidden="true"/>
            <div style="margin-bottom:10px">
                <input label="创建时间:" id="createtime" name="createtime" required="required" class="easyui-datebox" data-options="editable:false" style="width:100%;">
            </div>
            <input id="numOfRoundNameEidt" name="numOfRoundName" hidden>
            <div style="margin-bottom:10px">
                <input name="numOfRoundValue" id="numOfRoundValueEdit" class="easyui-combobox"
                       data-options="
                                editable:true,
                                required:true,
                                url:'${request.contextPath}/environment/rectifition/getNumOfRound',
                                valueField:'id',
                                textField:'name',
                                " label="期数：" style="width:250px;">
                </input>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="openNumOfRound('edit')" data-options="toggle:true,group:'g1'">新增</a>
            </div>
            <div style="margin-bottom:10px">
            <@al.menuCommobox name="category" id="category" label="归类:" labelPosition="left" required="true" style="width:200px" type="EvnRectfCatogoryEnum" onChange=""/>
            </div>
            <div style="margin-bottom:10px">
                <input id="project" name="projectId" required="true" class="easyui-combobox" style="width:100%" label="项目：" data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION&num=${num}',
            	valueField:'id',
            	textField:'name'"></input>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="openRelation01('relation01')" data-options="toggle:true,group:'g1'">新增</a>
            </div>
            <div style="margin-bottom:10px">
                <input id="describle" name="describleId" required="true" class="easyui-combobox" style="width:100%" label="问题描述:" data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_02&relation=ENVIRONMEENT_RECTIFITION&num=${num}',
            	valueField:'id',
            	textField:'name'"></input>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="openRelation01('relation02')" data-options="toggle:true,group:'g1'">新增</a>
            </div>
            <div style="margin-bottom:10px">
                <input id="limit" name="limit" class="easyui-datebox" data-options="required:true,label:'整改时限:'" data-options="editable:false" style="width:200px;">
            </div>
            <div style="margin-bottom:10px">
                <input name="require" class="easyui-textbox" data-options="required:true,label:'整改要求：',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
            </div>
            <div style="margin-bottom:10px">
                <input name="question" class="easyui-textbox" data-options="required:true,label:'进展问题:',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
            </div>
            <div style="margin-bottom:10px">
            <@al.menuCommobox name="status" id="status" label="完成情况:" labelPosition="left" required="true" style="width:200px" type="EvnRectifitionEnum" onChange=""/>
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-combobox" id="areaCode"  name="areaCode" style="height: 32px; width: 140px;"
                       data-options="
									url:'${request.contextPath}/env/pollution2/getAllPollutionCity',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'auto',label:'行政区划:'"
                       style="width:200px;"/>
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-combobox" id="cityCode"  name="cityCode" style="height: 32px; width: 140px;"
                       data-options="
									url:'${request.contextPath}/env/pollution2/getAllPollutionCity',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'auto',label:'所属城市:'"
                       style="width:200px;"/>
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyPerson" class="easyui-textbox" data-options="label:'责任人:',validType:'maxLength[65]'" style="width: 200px;">
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyPersonPhone" class="easyui-textbox" data-options="label:'责任人电话:',validType:'mobileAndTel'" style="width: 200px;">
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyDepartment" class="easyui-textbox" data-options="label:'责任部门:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="dutyUnit" class="easyui-textbox" data-options="label:'责任单位:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="involveDepartment" class="easyui-textbox" data-options="label:'涉及部门:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="involvePerson" class="easyui-textbox" data-options="label:'涉及人员:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="leadPerson" class="easyui-textbox" data-options="label:'牵头人:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="leadUnit" class="easyui-textbox" data-options="label:'牵头单位:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
            <div style="margin-bottom:10px">
                <input name="matchUnit" class="easyui-textbox" data-options="label:'配合单位:',validType:'maxLength[65]'"  style="width: 200px; ">
            </div>
        </form>
    </div>

    <div id="dlg-buttons_one" >
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="save()"
           style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="$('#dlg_one').dialog('close')" style="width:90px">取消</a>
    </div>

    <script>
        var divpage=1;
        var divRowsCount=0;
        var divRowsCountSecond=0;
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
            setRoundData();//初始化选择年度的时候如果有已经被选过的则不出现
            getNextRound('');//获取下一轮以及被删掉的轮数
        };

        function setRoundData(){
            var d = new Date();
            var year = d.getFullYear();
            var yearArr = new Array();
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/rectifition/getNumOfRound',
                data: {},
                success: function (result) {
                    var limit = '';
                    var flag = true;
                    for (var i = year - 9; i <= year + 11; i++) {
                        for (var a = 0; a < result.length; a++) {
                            if (result[a].id == i) {
                                flag = false;
                                break;
                            }
                        }
                        if (flag) {
                            yearArr.push({
                                "id": i,
                                "name": i + "年"
                            });
                        }
                        flag = true;
                    }
                    $('#AddNumOfRoundValue').combobox('loadData', yearArr);
                    $('#editNumOfRoundValue').combobox('loadData', yearArr);
                },
                dataType: 'json'
            });
        }

        function getNextRound(editData){
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/rectifition/getNextRound',
                data: {num: editData},
                success: function (result) {
                    if (result == null || result.length == 0 || result == undefined) {
                        $(".roundid").empty("");
                    }
                    var newTable = "";
                    for (var i = 0; i < result.length; i++) {
                        if (i % 4 == 0) {
                            newTable += "<tr><td>"
                        }
                        if (Ams.isNoEmpty(editData)) {
                            if (editData == i) {
                                newTable += " <label><input type='radio' name='name' class='check' checked style='position: relative;top: 10px;' value=" + result[i] + ">第" + result[i] + "轮</label>";
                            } else {
                                newTable += " <label><input type='radio' name='name' class='check' style='position: relative;top: 10px;' value=" + result[i] + ">第" + result[i] + "轮</label>";
                            }

                        }else{
                            if (result.length - 1 == i) {
                                newTable += " <label><input type='radio' name='name' class='check' checked style='position: relative;top: 10px;' value=" + result[i] + ">第" + result[i] + "轮</label>";
                            } else {
                                newTable += " <label><input type='radio' name='name' class='check' style='position: relative;top: 10px;' value=" + result[i] + ">第" + result[i] + "轮</label>";
                            }
                        }
                        if ((i % 4 == 1 || i == result.length - 1)
                            && i != 1) {
                            newTable += "</td></tr>"
                        }
                    }
                    $(".roundid").empty("");
                    $(".roundid").append(newTable);
                },
                dataType: 'json'
            });
        }

        /**
         * 主界面拼接表格
         */
        function rowTable(data) {
            var newRow = "";
            var dataVal='';
            var colorTime='';
            var colorClass='';
            var nowTime=new Date().getTime();
            divRowsCount=data.total;
            var  overTal = 0 ;
            for (var i = 0; i<data.rows.length;i++) {
                dataVal=data.rows[i];
                var warningTime=dataVal.wornTime;
                if (i==0) $('#warnTime').val(warningTime);
                if(Ams.isNoEmpty(warningTime)){
                    warningTime=warningTime*86400000;//一天的时间戳;
                }
                if(Ams.isNoEmpty(dataVal.timelimit)&&dataVal.timelimit-nowTime<warningTime&&dataVal.status!='SENDACCOUNT'){
                    colorClass = "details-text orange-tag";
                }else{
                    colorClass="details-text";
                }
                var rowData=JSON.stringify(dataVal);
                newRow += '<div class="'+colorClass+'">';
                newRow += '<h5 >'+dataVal.projectName;
                if($("#authority").val()=='1'){
                    newRow += "<div class='operation-box '></div>";
                }else{
                    newRow += "<div class='operation-box '><a href='javascript:void(0)' onclick=\"ChangeStatus('"+dataVal.uuid+"')\">设置状态</a> <a href='javascript:void(0)' onclick='edit("+rowData+")'> 编辑</a> <a href='javascript:void(0)' onclick=\"del('"+dataVal.uuid+"')\"> 删除</a></div>";
                }
                newRow+='</h5>';newRow += '<div class="part-font">';
                newRow += '<div class="item-row">';
                newRow += '<span>问题描述</span>';
                newRow += ' <p>'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName) +'</p>';
                newRow += '</div>';
                newRow += '<div class="item-row">';
                newRow += '<span>整改任务具体要求</span>';
                newRow += '<p>'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require) +'</p>';
                newRow += '</div>';
                newRow += '<div class="item-row">';
                newRow += '<span>目前进展情况及存在问题</span>';

                newRow += '<p>'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question) +'</p>';
                newRow += '</div>';
                newRow += '</div>';
                newRow += '<div class="part-date">';
                newRow += '<div class="item">';
                newRow += '<p> <span>行政区划</span>'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName) +'</p>';
                newRow += '<p> <span>所属城市</span>'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName) +'</p>';
                newRow += '</div>'
                newRow += '<div class="item">';
                newRow += '<p> <span>责任人</span>'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson) +'</p>';
               // newRow += '<p> <span>牵头人</span>'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit) +'</p>';
                newRow += ' <p> <span>涉及人员</span>'+ (Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson) +'</p>';
                newRow += '</div>';
                newRow += '<div class="item">';
                newRow += '<p> <span>责任人电话</span>'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone) +'</p>';
                newRow += '<p><span>牵头单位</span>'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</p>';
                newRow += '</div>';
                newRow += '<div class="item">';
                //newRow += '<p> <span>责任单位</span>'+(Ams.isNoEmpty(dataVal.dutyUnit)==false?"":dataVal.dutyUnit) +'</p>';
                newRow += '<p> <span>配合单位</span>'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit) +'</p>';
                newRow += '<p> <span >销号时间</span>'+Ams.stdDateFormat(dataVal.timelimit)+'</p>';
                newRow += '</div>';
                newRow += '<div class="item">';
               // newRow += '<p> <span>责任部门</span><a href="javascript:void(0)" class="easyui-linkbutton" onClick="show(\''+dataVal.dutyDepartment+'\')">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment) +'</a></p>';
                newRow += '<p><span>更新时间</span>'+ Ams.stdDateFormat(dataVal.createTime)+' </p>';
                newRow += '<p > <span>整改时限</span>'+Ams.stdDateFormat(dataVal.timelimit)+'</p>';
                newRow += '</div>';
               //  newRow += '<div class="item">';
               //  newRow += ' <p> <span>涉及人员</span>'+ (Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson) +'</p>';
               // // newRow += '<p class="color-tag1"> <span class="color-tag1">整改时限</span>'+Ams.stdDateFormat(dataVal.timelimit)+'</p>';
               //  newRow += '</div>';
                // newRow += '<div class="item">';
                // newRow += '<p> <span>涉及部门</span>'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment)+'</p>';
                // newRow += '<p> </p>';
                // newRow += '</div>';
                // newRow += '<div class="item">';
                // newRow += '<p class="color-tag1"> <span class="color-tag1">消耗时间</span>'+Ams.stdDateFormat(dataVal.timelimit)+'</p>';
                // newRow += '<p> </p>';
                //  newRow += '</div>';
                newRow += '</div>';
                newRow += '<div class="footer-font color-tag1">';
                newRow += '<span>'+formatStatus(dataVal.status)+'</span>';
                newRow += '</div>';
                newRow += '</div>';
            }
            $("#divTable div").remove();
            $("#divTable").append(newRow);
            if(divRowsCount!=divRowsCountSecond){
                getLayTable(divRowsCount);
            }

        }






        /**
         *  全部跟超时按钮点击
         */
        var showAllFlag ='1';
        function getBtn(flag){
            if ('all' == flag) {
                showAllFlag = '1';
            }else {
                showAllFlag = '0';
            }
            doSearch();
        }

        /**
         * 预警时间设置  确定按钮
         */
        function warnTimeComfirm(){
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/rectifition/setWarnTime',
                data: {
                    'warnTime': $('#warnTime').val().trim()
                },
                success: function (result) {
                    var result = eval(result);
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        doSearch();
                        layer.msg(result.message, {icon: 1});

                    }
                    $(".early-warning-show").hide();
                },
                dataType: 'json'
            });
        }
        /**
         * 主窗口编辑弹窗
         */
        function edit(row){
            if (row){
                $('#dlg_one').dialog('open').dialog('center').dialog('setTitle', '修改信息');
                $('#fm_one').form('clear');
                $('#fm_one').form('load', row);
                var date = Ams.dateFormat(row.createTime, 'yyyy-MM-dd');
                var timelimit = Ams.dateFormat(row.timelimit, 'yyyy-MM-dd');
                $("#createtime").datebox("setValue",date);
                $("#numOfRoundValueEdit").combobox("setValue",row.numOfRoundValue);
                $("#limit").datebox("setValue",timelimit);
            }

        }

        /**
         * 主窗口编辑弹窗保存
         */
        function save(){
            $('#numOfRoundNameEidt').val($('#numOfRoundValueEdit').combobox('getText'));
            $('#dlg_one #fm_one').form('submit', {
                iframe: false,
                url:  Ams.ctxPath + '/environment/rectifition/saveRectifition',
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        doSearch();
                        $('#dlg_one').dialog('close');
                        layer.msg(result.message, {icon: 1});
                    }
                }
            });
        }

        /**
         * 删除
         */
        function del(uuid){
            if (uuid) {
                $.messager.confirm("提示信息", "确认删除？", function (r) {
                    if (r) {
                        $.ajax({
                            type: 'POST',
                            url: Ams.ctxPath + '/environment/rectifition/delete',
                            data: {
                                'uuid': uuid
                            },
                            success: function (result) {
                                var result = eval(result);
                                if (result.type == 'E') {
                                    layer.msg(result.message, {icon: 2});
                                } else {
                                    doSearch();
                                    layer.msg(result.message, {icon: 1});
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
        /**
         * 字段格式化
         */
        function formatStatus(status){
            if(status=="OVER"){
                return "完成整改";
            }else if(status=="ONTIME"){
                return "达到序时进度";
            }else if(status=="PASS"){
                return "超过序时进度";
            }else if(status=="NOTSTART"){
                return "尚未启动";
            }else if(status=="NOTREACH"){
                return "未达到序时进度";
            }else if(status=="SENDACCOUNT"){
                return "完成交账销号";
            }else{
                return "";
            }
        }

        function formatCategory(value,row,index){
            var category = row.category;
            if(category=="WATER"){
                return "水污染防治";
            }else if(category=="AIR"){
                return "空气污染防治";
            }else if(category=="SOIL"){
                return "土壤污染防治";
            }else if(category=="VOICE"){
                return "噪声污染防治";
            }else{
                return "";
            }
        }

        /**
         * 新增项目操作格式化
         */
        function formatOpr(value,row,index){
            var uuid = row.uuid;
            return "<div>"+Ams.setImageEdit()+"<a href='javascript:void(0)' class='easyui-linkbutton' onClick=\"editRelation('"+uuid+"')\">编辑</a>" +
                "&nbsp;&nbsp;&nbsp;"+Ams.setImageDelete()+"<a href='javascript:void(0)' class='easyui-linkbutton' onClick=\"delRelation('"+uuid+"')\">删除</a></div>";
        }

        /**
         * 新增期数操作格式化
         */
        function formatNumOfRound(value,row,index){
            var uuid = row.uuid;
            return "<div>"+Ams.setImageEdit()+"<a href='javascript:void(0)' class='easyui-linkbutton' onClick=\"editNumOfRound('"+index+"')\">编辑</a>" +
                "&nbsp;&nbsp;&nbsp;"+Ams.setImageDelete()+"<a href='javascript:void(0)' class='easyui-linkbutton' onClick=\"delNumOfRound('"+uuid+"','"+row.name+"')\">删除</a></div>";
        }



        /**
         * 设置状态
         */
        function ChangeStatus(rowId) {
            $('#dlg-status #fm').form('clear');
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/rectifition/get',
                data: {'uuid': rowId},
                success: function (result) {
                    $('#dlg-status').dialog('open').dialog('center').dialog('setTitle', '设置状态');
                    $('#dlg-status #fm').form('load', result.result);
                    url = Ams.ctxPath + '/environment/rectifition/save';
                },
                dataType: 'json'
            });
        }

        /**
         * 设置状态保存
         */
        function saveStatus() {
            $('#dlg-status #fm').form('submit', {
                url: url,
                iframe: false,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        doSearch();
                        $('#dlg-status').dialog('close');
                        layer.msg('保存成功！', {icon: 1});
                    }
                }
            });
        }

        /**
         * 项目、问题描述新增
         */
        function openRelation01(relation){
            projSelUpd = $('#project').combobox("getValue");
            probSelUpd = $('#describle').combobox("getValue");
            ProbSelAdd = $('#describleId').combobox("getValue");
            projSelAdd = $('#projectId').combobox("getValue");
            var type="";
            if(relation == 'relation01'){
                $('#code').val("ENVIRONMEENT_RECTIFITION_01");
                $('#relation').val("ENVIRONMEENT_RECTIFITION");
                $('#relation-dg').datagrid({
                    url: Ams.ctxPath + '/environment/commonRelationTable/list',
                    queryParams:{
                        code:'ENVIRONMEENT_RECTIFITION_01',
                        relation:'ENVIRONMEENT_RECTIFITION',
                        num:${num}
                    }
                });
                $('#dlg-relation01').dialog('open').dialog('center').dialog('setTitle', '项目列表');
                $('#projQuesTitle').text('项目 ：');
                $('#edidTitle').text('项目 ：');
            }else{
                $('#code').val("ENVIRONMEENT_RECTIFITION_02");
                $('#relation').val("ENVIRONMEENT_RECTIFITION");
                $('#relation-dg').datagrid({
                    url: Ams.ctxPath + '/environment/commonRelationTable/list',
                    queryParams:{
                        code:'ENVIRONMEENT_RECTIFITION_02',
                        relation:'ENVIRONMEENT_RECTIFITION',
                        num:${num}
                    }
                });
                $('#dlg-relation01').dialog('open').dialog('center').dialog('setTitle', '问题描述列表');
                $('#projQuesTitle').text('问题描述 ：');
                $('#edidTitle').text('问题描述 ：');
            }
        }

        /**
         * 期数新增
         */
        var numOfRoundValueEdit=''
        var numOfRoundValueEditName=''
        var addOrEdit;
        function openNumOfRound(flag) {
            addOrEdit = flag;
            if (addOrEdit == 'edit') {
                var val = $('#numOfRoundValueEdit').combobox('getValue');
                numOfRoundValueEdit = val.length > 4 ? val.substring(val.length - 5, val.length - 1) : val;
                numOfRoundValueEditName = $('#numOfRoundValueEdit').combobox('getText');
            } else {
                numOfRoundValueEdit = $('#numOfRoundValueAdd').combobox('getValue');
                numOfRoundValueEditName = $('#numOfRoundValueAdd').combobox('getText');
            }
            $('#dlg-numOfRound').dialog('open').dialog('center').dialog('setTitle', '期数列表');
        }



        /**
         * 项目修改 保存
         */
        var projSelUpd,probSelUpd,projSelAdd,probSelAdd;
        function updateRelation(){
            $('#dlg-update #fm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    $('#dlg-update').dialog('close');
                    $('#relation-dg').datagrid('load');
                    resetSel();
                    setSelectForProjAndProb('');
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        layer.msg(result.message, {icon: 1});
                    }
                }
            });
        }

        /**
         * 期数修改 保存
         */
        var afterUpd = ''
        function updateRound() {
            $.messager.confirm("提示信息", "如果此前有项目用到此轮数时间，则此次修改将会同步之前项目设置的轮数时间，确认修改？", function (r) {
                if (r) {
                    $('#dlg-update-round #roundFm').form('submit', {
                        url: Ams.ctxPath + '/environment/commonRelationTable/save',
                        iframe: false,
                        onSubmit: function () {
                            return $(this).form('validate');
                        },
                        success: function (result) {
                            var result = JSON.parse(result);
                            $('#numOfRoundTbl').datagrid('load');
                            getNextRound('');
                            afterUpd = $('#editNumOfRoundValue').combobox('getValue');

                            if (result.type == 'E') {
                                layer.msg(result.message, {icon: 2});
                            } else {
                                getDataShow();
                                layer.msg(result.message, {icon: 1});
                                $('#dlg-update-round').dialog('close');
                            }
                            if (addOrEdit == 'edit') {
                                numOfRoundValueEdit = $('#numOfRoundValueEdit').combobox('getValue');
                                numOfRoundValueEditName = $('#numOfRoundValueEdit').combobox('getText');
                                // setRound($('#editNumOfRoundValue').combobox('getValue'), numOfRoundValueEditName, 'edit', 'edit');
                                resetRound();
                                setRound(numOfRoundValueEdit, numOfRoundValueEditName, 'edit', 'edit');
                            } else {
                                numOfRoundValueEdit = $('#numOfRoundValueAdd').combobox('getValue');
                                numOfRoundValueEditName = $('#numOfRoundValueAdd').combobox('getText');
                                // setRound($('#AddNumOfRoundValue').combobox('getValue'), numOfRoundValueEditName, 'edit', 'add');
                                resetRound();
                                setRound(numOfRoundValueEdit, numOfRoundValueEditName, 'edit', 'add');
                            }
                            $('#editNumOfRoundValue').combobox('setValue', '');
                            setRoundData();
                        }
                    });
                }
            });
        }




        /**
         * 新增任务弹窗
         */
        function newOne() {
            $('#dlg #fm').form('clear');
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增任务');
            url = Ams.ctxPath + '/environment/rectifition/save';
        }

        /**
         * 预警时间弹窗
         */
        function earlyone() {
            $(".early-warning-show").show();
        }

        /**
         * 新增任务保存
         */
        function saveOne() {
            $('#numOfRoundNameAdd').val($('#numOfRoundValueAdd').combobox('getText'));
            $('#dlg #fm').form('submit', {
                url: url,
                iframe: false,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        doSearch();
                        $('#dlg').dialog('close');
                        layer.msg('保存成功！', {icon: 1});
                    }
                }
            });
        }


        /**
         * 文本框字符长度验证
         */
        $.extend($.fn.validatebox.defaults.rules, {
            maxLength: {
                validator: function (value, param) {
                    return value.length <= param[0]&&value.trim().length > 0;
                },
                message: '请输入有效字符串，长度不能超过{0}个字符.'
            }
        });


        /**
         * 新增项目
         */
        function saveRelation01() {
            $('#dlg-relation01 #fm').form('submit', {
                url: Ams.ctxPath + '/environment/commonRelationTable/save',
                iframe: false,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    resetSel();
                    $('#relation-dg').datagrid('load');
                    $('#dlg-relation01 #name').textbox('setValue','');
                    setSelectForProjAndProb('');
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        layer.msg(result.message, {icon: 1});
                    }
                }
            });
        }

        /**
         * 新增期数
         */
        function saveNumOfRound() {
            $('#dlg-numOfRound #numOfRounFm').form('submit', {
                url: Ams.ctxPath + '/environment/commonRelationTable/save',
                iframe: false,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    $('#numOfRoundTbl').datagrid('load');
                    getNextRound('');

                    $('#dlg-numOfRound #AddNumOfRoundValue').combobox('setValue', '');
                    if (result.type == 'E') {
                        layer.msg(result.message, {icon: 2});
                    } else {
                        resetRound();
                        layer.msg(result.message, {icon: 1});
                    }
                    if (addOrEdit == 'edit') {
                        setRound(numOfRoundValueEdit, numOfRoundValueEditName, '', 'edit');
                    } else {
                        setRound(numOfRoundValueEdit, numOfRoundValueEditName, '', 'add');
                    }
                    setRoundData();
                }
            });
        }


        function resetRound(){
            $('#numOfRoundValueAdd').combobox().combobox('clear');
            $('#numOfRoundValueEdit').combobox().combobox('clear');
        }

        /**
         * 新增项目
         * 编辑
         */
        function editRelation(uuid){
            $('#dlg-update #fm').form('clear');
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/commonRelationTable/get',
                data: {'uuid': uuid},
                success: function (result) {
                    $('#dlg-update').dialog('open').dialog('center').dialog('setTitle', '编辑');
                    $('#dlg-update #fm').form('load', result.result);
                    url = Ams.ctxPath + '/environment/commonRelationTable/save';

                },
                dataType: 'json'
            });
        }

        /**
         * 新增期数
         * 编辑
         */
        var editNum =''
        function editNumOfRound(idx){
            $('#dlg-update-round #roundFm').form('clear');
            $('#numOfRoundTbl').datagrid('selectRow',idx);// 关键在这里
            var row = $('#numOfRoundTbl').datagrid('getSelected');
            editNum = row.num;
            $('#dlg-update-round').dialog('open').dialog('center').dialog('setTitle', '第'+editNum+'轮编辑');
            $('#dlg-update-round #roundFm').form('load', row);
            $('#editNumOfRoundValue').combobox('setValue', row.id + '年');
        }




        /**
         * 新增项目
         *   删除
         */
        function delRelation(uuid){
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/environment/commonRelationTable/del',
                        data: {'uuid': uuid},
                        success: function (data) {
                            layer.msg(data.message, {icon: 1});
                            $('#relation-dg').datagrid('load');
                            if ('该值被引用，无法删除' != data.message) {
                                resetSel();
                                setSelectForProjAndProb('del');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        }

        /**
         * 新增期数
         *   删除
         */
        function delNumOfRound(uuid,name) {
            $.messager.confirm("提示信息", "确认删除"+name+"吗？", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/environment/commonRelationTable/del',
                        data: {'uuid': uuid},
                        success: function (data) {
                            layer.msg(data.message, {icon: 1});
                            $('#numOfRoundTbl').datagrid('load');
                            resetRound();
                            getNextRound('');
                            if (addOrEdit == 'edit') {
                                if (data.message.indexOf('才能删除') > -1) {
                                    setRound(numOfRoundValueEdit, numOfRoundValueEditName, '', 'edit');
                                }else{
                                    setRound(numOfRoundValueEdit, numOfRoundValueEditName, 'del', 'edit');
                                }
                            } else {
                                if (data.message.indexOf('才能删除') > -1) {
                                    setRound(numOfRoundValueEdit, numOfRoundValueEditName, '', 'add');
                                }else{
                                    setRound(numOfRoundValueEdit, numOfRoundValueEditName, 'del', 'add');
                                }

                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        }

        /**
         * 重新为id为numOfRoundValueAdd，numOfRoundValueEdit赋值
         */
        function setRound(val,nameVla,flag,addOrEdit){
            if (check('numOfRoundTbl','numOfRoundValueAdd',val,flag)) {
                var s = afterUpd.length > 4 ? afterUpd.substring(afterUpd.length - 5, afterUpd.length - 1) : afterUpd;
                if (addOrEdit == 'add') {
                    $('#numOfRoundValueAdd').combobox("setValue", val);
                } else {
                    var round = nameVla.split('轮')[0];
                    var roundNum = round.substring(1, round.length);
                    var s = afterUpd.length > 4 ? afterUpd.substring(afterUpd.length - 5, afterUpd.length - 1) : afterUpd;
                    $('#numOfRoundValueEdit').combobox("setValue", editNum != roundNum || afterUpd == '' ? val : s);
                }
            }else{
                if (addOrEdit == 'add') {
                    $('#numOfRoundValueAdd').combobox("setValue", '');
                } else {
                    $('#numOfRoundValueEdit').combobox("setValue", '');
                }
            }
        }

        /**
         * 解决修改信息界面新增“项目”和“问题描述”成功时，返回该界面，两个字段内容被清空
         */
        function setSelectForProjAndProb(flag){
            if($('#edidTitle').text() == '问题描述 ：') {
                if (check('relation-dg','describle', probSelUpd, flag)) {
                    $('#describle').combobox("setValue", probSelUpd);
                } else {
                    $('#describle').combobox("setValue", '');
                }
                if (check('relation-dg','describleId', probSelAdd, flag)) {
                    $('#describleId').combobox("setValue", probSelAdd);
                } else {
                    $('#describleId').combobox("setValue", '');
                }
            }else{
                if (check('relation-dg','project',projSelUpd,flag)) {
                    $('#project').combobox("setValue", projSelUpd);
                }else{
                    $('#project').combobox("setValue", '');
                }
                if (check('relation-dg','projectId',projSelAdd,flag)) {
                    $('#projectId').combobox("setValue", projSelAdd);
                }else{
                    $('#projectId').combobox("setValue", '');
                }
            }
        }
       /**
        * 检查下拉框当前选中的值是否存在
        */
        function check(tblId,id,value,flag) {
            var valueField = $("#"+id).combobox("options").valueField;
            var allData = $("#"+id).combobox("getData");
            if (flag == 'del') {
                var row = $('#'+tblId).datagrid('getSelected');
                var cid = '';
                if (id == 'numOfRoundValueAdd') {
                    cid = row.id;
                } else {
                    cid = row.uuid;
                }
                for (var i = 0; i < allData.length; i++) {
                    if (cid == allData[i][valueField]) {
                        allData.splice(i, 1);
                        break;
                    }
                }
            }
            var result = false;
            for (var i = 0; i < allData.length; i++) {
                if (value == allData[i][valueField]) {
                    result = true;
                    break;
                }
            }
            if (flag == 'edit') result = true;
            return result;
        }

        /**
         * 重置下拉框的值
         */
        function resetSel(){
            if ($('#edidTitle').text() == '问题描述 ：') {
                $('#describleId').combobox().combobox('clear');
                $('#describle').combobox().combobox('clear');
            } else {
                $('#projectId').combobox().combobox('clear');
                $('#project').combobox().combobox('clear');
            }
        }
        /**
         * 查询所有
         */
        function doSearch() {
            info();
            getOverTal();
            getDataShow();
        }

        /**
         * 获取超时总条数
         */
        function getOverTal() {
            var url = Ams.ctxPath + '/environment/rectifition/wornList'
            var param = {
                "page": 1,
                "rows": 9999,
                'num':${num}
            }
            $.ajax({
                type: 'POST',
                url: url,
                data: param,
                success: function (data) {
                    $('#overTal').text(data.total);
                },
                dataType: 'json'
            });

        }

        /**
         * 导出excel
         */
        function exportExl(){
            var name = $("#queryProjectName").val();
            var querylimt = $("#queryLimit").val();
            var queryStatus = $("#queryStatus").val();
            if ("1" == showAllFlag) {
                window.location.href = "${request.contextPath}/environment/rectifition/listNew?export=yes&name=" + name + "&limit=" + querylimt + "&status=" + queryStatus+ "&num=${num}";
            } else {
                window.location.href = "${request.contextPath}/environment/rectifition/wornList?export=yes&name=" + name + "&limit=" + querylimt + "&status=" + queryStatus+ "&num=${num}";
            }
        }

        /**
         * 重置按钮
         */
        function doReset() {
            $("#searchForm").form('clear');
            doSearch();
        }

        /**
         * 统计
         */
        function info() {
            var time = $("#queryLimit").val();
            $.ajax({
                type : 'POST',
                url : Ams.ctxPath + '/environment/rectifition/getCount',
                data: {
                    'name': '',//$("#queryProjectName").val(),
                    'status': '',//$("#queryStatus").val(),
                    'timelimitStr': '',//time
                    'num': ${num}
                },
                success : function(result) {
                    var date = new Date();
                    $('#title').text((Ams.isNoEmpty(result.qx) == true ? result.qx : '漳州市')+'中央环保督察问题');
                    if (Ams.isNoEmpty(time)) {
                        $('#timeid').text("截至"+time.split('-')[0]+"年"+time.split('-')[1]+"月"+time.split('-')[2]+"日");
                    } else {
                        $('#timeid').text("截至"+date.getFullYear()+"年"+(date.getMonth() + 1)+"月"+date.getDate()+"日");
                    }
                    $('#zyhb').text(result.size);
                    if (result.NOTSTART != null) {
                        $('#swqd').text(result.NOTSTART);
                    }

                    if (result.NOTREACH != null) {
                        $('#wdxs').text(result.NOTREACH);
                    }
                    if (result.ONTIME != null) {
                        $('#ddxs').text(result.ONTIME);
                    }
                    if (result.PASS != null) {
                        $('#cgxs').text(result.PASS);
                    }
                    if (result.OVER != null) {
                        $('#wczg').text(result.OVER);
                    }
                    if (result.SENDACCOUNT != null) {
                        $('#wcxz').text(result.SENDACCOUNT);
                    }
                },
                dataType : 'json'
            });
        }

        /**
         * 新增跟预警时间切换
         */
        $(".details-bar a").click(function() {
            $(".details-bar a").removeClass("link-tag");
            $(this).addClass("link-tag")
        })

        /**
         * 全部跟整改时间延期
         */
        function getDataShow() {
            //$.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
            var url;
            if ('1' == showAllFlag) {
                url = Ams.ctxPath + '/environment/rectifition/listNew'
            }else{
                url = Ams.ctxPath + '/environment/rectifition/wornList'
            }
            var param={
                "page":divpage,
                "rows":10,
                "name" : $("#queryProjectName").val(),
                "limit" : $("#queryLimit").val(),
                "status" : $("#queryStatus").val(),
                "dutyDepartment" : $("#queryDutyDepartment").val(),
                "areaCode" : $("#queryAreaCode").val(),
                "cityCode" : $("#queryCityCode").val(),
                'num':${num}
            }
            $.ajax({
                type : 'POST',
                url : url,
                data : param,
                success : function(data) {
                    //$.messager.progress('close');
                    rowTable(data);
                },
                dataType : 'json'
            });

        }



        /**
         * 预警时间取消
         */
        $(".close-early").click(function () {
            $(".early-warning-show").hide()
        })

        /**
         * 全部跟整改时间延期切换
         */
        $(".tit-entry-box li").click(function () {
            $(".tit-entry-box li").removeClass("alone-tag")
            $(this).addClass("alone-tag")
        })

        /**
         * 分页栏
         */
        function getLayTable(count){
            layui.use('laypage', function(){
                var laypage = layui.laypage;
                //执行一个laypage实例
                laypage.render({
                    elem: 'page-container', //注意，这里的 test1 是 ID，不用加 # 号
                    count: count,//数据总数，从服务端得到
                    theme:'#45b97c',
                    jump:function(object,first){
                        divpage=object.curr;
                        divRowsCountSecond=count;

                        if(!first){
                            window.location.href='#';
                            getDataShow();

                        }

                    }
                });
            });
        }
        /**
         * 页面初始化
         */
        $(function(){
            doSearch();
            var authority=$("#authority").val();
            if(authority=='1'){
                $("#toolbar").children("a").hide();
                $('#dg').datagrid('hideColumn','operate');
                $('#dg').datagrid('hideColumn','category');
                //$(".details-bar").show();
                $(".details-bar").hide();
            }
        });


        function show(dutyDepartment) {
            $("#queryDutyDepartment").val(dutyDepartment);
            doSearch();
        }
    </script>
    <script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>

<#--分页容器-->
    <div id="page-container" class="page-container"></div>

</body>
</html>
