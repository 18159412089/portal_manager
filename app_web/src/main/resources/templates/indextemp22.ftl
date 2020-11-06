<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>断面水质详情</title>
</head>
<!-- body -->
<body>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>

<#--<  头部>-->
<#--<  头部>-->
<div id="pf-hd"  class="pf-head">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
    </span>
	<div class="pf-user">
		<div class="pf-user-photo">
			<img src="${request.contextPath}/static/images/main/user.png" alt="">
		</div>
		<h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
		<i class="iconfont xiala">&#xe607;</i>

		<div class="pf-user-panel">
			<ul class="pf-user-opt">
				<li>
					<a href="javascript:;">
						<i class="iconfont">&#xe60d;</i>
						<span class="pf-opt-name">用户信息</span>
					</a>
				</li>
				<li class="pf-modify-pwd" id="editpass">
					<a href="#" >
						<i class="iconfont">&#xe634;</i>
						<span class="pf-opt-name">修改密码</span>
					</a>
				</li>
				<li id="omDownload">
					<a href="#" >
						<i class="iconfont">&#xe670;</i>
						<span class="pf-opt-name">下载操作手册</span>
					</a>
				</li>
				<li class="pf-logout" id="loginOut">
					<a href="#" >
						<i class="iconfont">&#xe60e;</i>
						<span class="pf-opt-name">退出</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<#--  当导航只有一级开始-->
    <div  class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag">
                <li class="select-link">
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li >
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-gongzuoguanli1"></i>
                        <span class="title">水环境服务</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon iconcustom icon-fenzhi"></i>
                        <span class="title"> 污染溯源</span>
                    </a>
                </li>
                <li>
                    <a href="#" target="_blank">
                        <i class="icon iconcustom icon-shuju2""></i>
                        <span class="title"> 数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon iconcustom icon-jianguan1"></i>
                        <span class="title"> 总体情况</span>
                    </a>
                </li>
                <li>
                    <a  href="#"  target="_blank">
                        <i class="icon iconcustom icon-jibenxinxi1"></i>
                        <span class="title">一河一策</span>
                    </a>
                </li>


            </ul>
        </div>
        <div class="nav-menu-tag">
            <a class="nav-prev invalid-menu">
                <span class="icon iconcustom "></span>
            </a>
            <a class="nav-next">
                <span class="icon iconcustom"></span>
            </a>
        </div>
    </div>

</div>

<div class="region-content">

    <div class="map-left border-style">
        <div class="map-title">
            <h3> <a><i class="icon iconcustom icon-fanhui5"></i> 九龙江流域</a>  </h3>

            <img style="width: 100%;max-width: 900px;" src="${request.contextPath}/static/images/pollute/map_img.png">
        </div>
        <div class="tagging-item">
            <p><img src="${request.contextPath}/static/images/pollute/icon-img1.png"></i></a></p>
            <h5>西区污水处理厂</h5>
            <div class="row">
                <span>吨数：5万吨</span>
            </div>
            <div class="row">
                <span> 农业:</span>
                <div class="speed-box min-speed">
                    <div class="speed-row"><span class="tag violet" style="width: 20%"></span></div>
                </div>
            </div>

            <div class="row">
                <span> 农业:</span>
                <div class="speed-box min-speed">
                    <div class="speed-row"><span class="tag pink" style="width: 50%"></span></div>
                </div>
            </div>

            <div class="row">
                <span> 农业:</span>
                <div class="speed-box min-speed">
                    <div class="speed-row"><span class="tag yellow" style="width: 30%"></span></div>
                </div>
            </div>
        </div>
    </div>

	<div class="region-right border-style table-info">
        <h3> <a>国控断面</a> <i> <img src="${request.contextPath}/static/images/pollute/icon-img3.png"></i></a> </h3>
		<table class="layui-hide" id="water-table" ></table>

		<div  class="page-footer">
            <div id="demo0"></div>
		</div>
    </div>

</div>

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<script type="text/javascript">
	$.parser.onComplete = function () {
		$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
		});
	};


	layui.use(['layer','element','table','laypage'], function(){
		var layer = layui.layer
				,element = layui.element
				,table = layui.table
				,laypage = layui.laypage;
		//数据表格
		table.render({
			elem: '#water-table'
			,theme: '#0f61b5'
			,cols: [[
				{field:'id', width:'10%', title: '监测时间',style:'background:rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username', title: '监测站点',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username',  title: 'AQI',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username',  title: 'PM2.5(μg/m3)',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username', title: 'PM10(μg/m3)',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username', title: 'SO2(μg/m3)',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username',  title: 'NO2(μg/m3)',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username',  title: 'O3(μg/m3)',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username',  title: 'CO(mg/m3)',style:'background: rgba(0, 0, 0, 0); color: #c4ecff;'}
				,{field:'username', title: 'CO(mg/m3)',style:'background:rgba(0, 0, 0, 0); color: #c4ecff;'}

			]],
			done: function (res, curr, count) {
				$('tr').css({'background-color': 'transparent', 'rgba(7, 21, 64, 0.9)': '#c4ecff'});
			}

			,data: [{
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"

			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}, {
				"id": "2019-3-29"
				,"username": "杜甫"
				,"username": "杜甫"
				,"username": "22"
				,"username": "3"
				,"username": "5"
				,"username": "8"
				,"username": "23"
				,"username": "4"
				,"username": "6"
			}]
		});
		//详情弹窗
		table.resize("water-table")


        //---------------分页-----------
        //自定义首页、尾页、上一页、下一页文本
        laypage.render({
            elem: 'demo0'
            ,count: 100
            ,theme: '#085cb2'
            ,prev: '<em>←</em>'
            ,next: '<em>→</em>'
        });




    });







</script>
</html>