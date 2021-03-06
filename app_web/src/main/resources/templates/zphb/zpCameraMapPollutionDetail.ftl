<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>

<#--水环境、大气环境弹出框-->
<div id="airWaterDialog" class="easyui-dialog" style="width:900px;height:600px;background:white;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 0">
        <div id="tt" class="easyui-tabs" >
            <div title="详情">
                <div class="panel-group-container">

                    <div class="panel-group-top">
                        <span id="mc">南靖上洋</span>
                        <span class="subtext fr" id="" style="font-size: 14px;">
                            <span id="jd" >经度：11111</span>
                            <span id="wd" >纬度：11111</span>
                        </span>
                    </div>
                    <div class="panel-group-container" >
                        <div class="panel-group-body">
                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>企业详情</span>
                                </div>

                            <#--                               <div class="row-item">-->
                            <#--                                   <div class="col-xs-4  copies " >-->
                            <#--                                       <span  class="name-tag">污染源类型：</span>-->
                            <#--                                       <span  class="font-tag" id="wrylx">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                   </div>-->
                            <#--                                   <div class="col-xs-4 copies" >-->
                            <#--                                       <span  class="name-tag">污染源类型：</span>-->
                            <#--                                       <span  class="font-tag" id="wryzl">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                   </div>-->
                            <#--                               </div>-->

                            <#--                                <div class="row-item">-->
                            <#--                                    <div class="col-xs-4  copies " >-->
                            <#--                                        <span  class="name-tag">区县：</span>-->
                            <#--                                        <span  class="font-tag" id="qx">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                    </div>-->
                            <#--                                    <div class="col-xs-4 copies" >-->
                            <#--                                        <span  class="name-tag">乡镇：</span>-->
                            <#--                                        <span  class="font-tag" id="xz">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                    </div>-->
                            <#--                                </div>-->

                            <#--                                <div class="row-item">-->
                            <#--                                    <div class="col-xs-4  copies " >-->
                            <#--                                        <span  class="name-tag">地址：</span>-->
                            <#--                                        <span  class="font-tag" id="dz">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                    </div>-->
                            <#--                                </div>-->

                            <#--                                <div class="row-item">-->
                            <#--                                    <div class="col-xs-4  copies " >-->
                            <#--                                        <span  class="name-tag">经度：</span>-->
                            <#--                                        <span  class="font-tag" id="jd">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                    </div>-->
                            <#--                                    <div class="col-xs-4 copies" >-->
                            <#--                                        <span  class="name-tag">纬度：</span>-->
                            <#--                                        <span  class="font-tag" id="wd">大气交付伙食费水立方空间是开发商</span>-->
                            <#--                                    </div>-->
                            <#--                                </div>-->



                                <div class="row">
                                    <span class="col-xs-4" id="wrylx">污染源类型：大气</span>
                                    <span class="col-xs-4" id="wryzl">污染源种类：散乱污</span>
                                </div>
                                <div class="row">
                                    <span id="qx" class="col-xs-4">区县：南靖县 </span>
                                    <span id="xz" class="col-xs-4">乡镇：龙山镇</span>
                                </div>
                                <div class="row">
                                    <span id="dz" class="col-xs-12">地址：梧营村爱园（门）组26号 </span>
                                </div>
                                <div class="row">
                                    <span id="cameraChannelList" class="col-xs-12"></span>
                                </div>
                            <#-- <div class="row">

                             </div>-->
                            </div>

                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>整改详情</span>
                                </div>
                                <div class="existence-bug-box">
                                    <i class="icon iconcustom icon-fengxian4"></i> <span id="czwt">存在问题：未办理环评手续</span>
                                </div>
                                <div class="row">
                                    <span id="zgcs"  class="col-xs-12">整改措施：明确分类处置措施并完成整治。</span>
                                </div>
                                <div class="row">
                                    <span id="zlxm"  class="col-xs-12">治理项目：“散乱污”工业企业污染专项整治</span>
                                </div>

                                <!--面板主内容-->
                                <div class="speed-info-title">完成目标</div>
                                <div class="speed-info-part" >
                                    <div class="time-axis-container">
                                        <ul>
                                            <li class="item highlight">
                                                <div href="" class="time-axis-box">
                                                    <div class="step">
                                                    <#--<span>今天</span>-->   <span>2020-12</span>   <#--<span>15:20</span>-->
                                                        <span class="button-tag fr red" >未开展</span>
                                                    </div>
                                                    <div id="wcmb202012" class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                        自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                                </div>
                                            </li>
                                            <li class="item highlight">
                                                <div href="" class="time-axis-box">
                                                    <div class="step"><#--<span>今天</span>-->   <span>2020-06</span>   <#--<span>15:20</span>-->
                                                        <span class="button-tag fr red" >未开展</span>
                                                    </div>
                                                    <div id="wcmb202006" class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                        自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                                </div>
                                            </li>
                                            <li class="item highlight">
                                                <div href="" class="time-axis-box">
                                                    <div class="step"><#--<span>今天</span>-->   <span>2019-12</span>   <#--<span>15:20</span>-->
                                                        <span class="button-tag fr " >已开展</span>
                                                    </div>
                                                    <div id="wcmb201912" class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                        自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <!--面板主内容 over-->

                            </div>

                            <div class="sewage-info-table">


                            </div>

                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>负责详情</span>
                                </div>
                            <#--                                <table style="width: 100%">-->
                            <#--                                    <tr>-->
                            <#--                                        <td class="col-xs-4"> <span id="sdzrZrdw" >属地责任单位：龙山镇</span></td>-->
                            <#--                                        <td class="col-xs-4"> <span id="sd_fzr" >责任人：龙山镇</span></td>-->
                            <#--                                        <td class="col-xs-4"> <span id="sd_lxfs" > 联系方式：XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span></td>-->
                            <#--                                    </tr>-->
                            <#--                                    <tr>-->
                            <#--                                        <td class="col-xs-4"> <span id="bmzrZrdw" >属地责任单位：龙山镇</span></td>-->
                            <#--                                        <td class="col-xs-4"> <span id="bm_fzr"   >责任人：龙山镇</span></td>-->
                            <#--                                        <td class="col-xs-4"> <span id="bm_lxfs" > 联系方式：XXXXXXXX <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span></td>-->
                            <#--                                    </tr>-->
                            <#--                                    <tr>-->
                            <#--                                        <td class="col-xs-4"> <span id="bmzrPhzrdw">属地责任单位：龙山镇</span></td>-->
                            <#--                                        <td class="col-xs-4"> <span id="ph_fzr">责任人：龙山镇</span></td>-->
                            <#--                                        <td class="col-xs-4"> <span id="ph_lxfs"> 联系方式：XXXXXXXX <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span></td>-->
                            <#--                                    </tr>-->
                            <#--                                    <tr>-->
                            <#--                                        <td class="col-xs-4">  <span id="bz">属地责任单位：龙山镇</span></td>-->
                            <#--                                    </tr>-->

                            <#--                                </table>-->
                                <div class="row">
                                    <span id="sdzrZrdw" class="col-xs-4">属地责任单位：龙山镇</span>
                                    <span id="sd_fzr"   class="col-xs-4">责任人：龙山镇</span>
                                    <span id="sd_lxfs"  class="col-xs-4"> 联系方式：XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                </div>
                                <div class="row">
                                    <span id="bmzrZrdw" class="col-xs-4">属地责任单位：龙山镇</span>
                                    <span id="bm_fzr"   class="col-xs-4">责任人：龙山镇</span>
                                    <span id="bm_lxfs"  class="col-xs-4"> 联系方式：XXXXXXXX <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                </div>
                                <div class="row">
                                    <span id="bmzrPhzrdw" class="col-xs-4">属地责任单位：龙山镇</span>
                                    <span id="ph_fzr"     class="col-xs-4">责任人：龙山镇</span>
                                    <span id="ph_lxfs"    class="col-xs-4"> 联系方式：XXXXXXXX <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                </div>
                                <div class="row">
                                    <span id="bz" class="col-xs-12">属地责任单位：龙山镇</span>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            <#--            <div title="Tab2" >tab2</div>-->
            <#--            <div title="Tab3" >-->
            <#--                tab3-->
            <#--            </div>-->
            </div>
            <div title="整改时间轴" >
                <div class="panel-group-container" ><a onclick="$('#uploadDlg').dialog('open').dialog('center').dialog('setTitle', '上传附件')" target="_blank" class="fr common-upload-tag" ><i class="icon iconcustom icon-shangchuan2"></i> 上传附件</a>
                <#--                    <div id="zlxm" class="speed-info-title">治理项目 “散乱污”</div>-->
                    <div class="speed-info-part" style="padding: 15px;" id="timeData">
                        <div class="time-axis-container">
                            <ul>
                                <li class="item highlight">
                                    <div class="time-axis-part">
                                        <div class="time-axis-head">
                                            <span>上传时间：2019年9月20日16时10分</span>
                                            <a class="delete-tag"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>
                                            <a class="fr common-upload-tag" >
                                                <i class="icon iconcustom icon-shangchuan2"></i> 上傳附件</a>
                                        </div>
                                        <div class="time-axis-content">
                                            <div class="img-box">

                                            </div>
                                        </div>
                                        <p>描述：</p>
                                        <p>锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批</p>
                                    </div>
                                </li>
                                <li class="item highlight">
                                    <div class="time-axis-part">
                                        <div class="time-axis-head">
                                            <span>上传时间：2019年9月20日16时10分</span>
                                            <a class="delete-tag"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>
                                            <a class="fr common-upload-tag" >
                                                <i class="icon iconcustom icon-shangchuan2"></i> 上傳附件</a>
                                        </div>
                                        <div class="time-axis-content">
                                            <div class="img-box">

                                            </div>
                                        </div>
                                        <p>描述：</p>
                                        <p>锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- 漳浦环保一张图：矿山、养殖场、垃圾场弹出框 -->
<div id="zpEnterpriseInfoDialog" class="easyui-dialog" style="width:900px;height:600px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 0">
        <div id="tt" class="easyui-tabs" >
            <div title="详情">
                <div class="panel-group-container">

                    <div class="panel-group-top">
                        <span id="name">南靖上洋</span>
                        <span class="subtext fr" id="" style="font-size: 14px;">
                            <span id="longitude" >经度：11111</span>
                            <span id="latitude" >纬度：11111</span>
                        </span>
                    </div>
                    <div class="panel-group-container" >
                        <div class="panel-group-body">
                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>企业详情</span>
                                </div>
                                <div class="row">
                                    <span id="qx" class="col-xs-4">区县：漳浦县 </span>
                                    <span id="township" class="col-xs-4">乡镇：龙山镇</span>
                                </div>
                                <div class="row">
                                    <span id="address" class="col-xs-12">地址：梧营村爱园（门）组26号 </span>
                                </div>
                                <div class="row">
                                    <span id="panorama" class="col-xs-12">全景图：全景图 </span>
                                </div>
                                <div class="row">
                                    <span id="distributedMap" class="col-xs-12">全景图：全景图 </span>
                                </div>
                                <div class="row">
                                    <span id="zpCameraChannelList" class="col-xs-12"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- dialog1 -->
<div id="uploadDlg" class="easyui-dialog" style="height:230px;width:500px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#uploadDlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="mcid" name="mc" hidden="true"/>
        <input id="jdid" name="jd" hidden="true"/>
        <input id="wdid" name="wd" hidden="true"/>
        <input id="source" name="source" value="pollutionMapInfo" hidden/>
        <div style="margin-bottom:10px">
            <input class="easyui-filebox" label="图片:"
                   data-options="buttonText:'选择文件',accept:'image/gif,image/jp2,image/jpeg,application/pdf,image/png',required:true"
                   style="width:100%;" required
                   onchange="onchange(newVal,oldVal)" id="picFile" name="picFile"/>
        </div>
        <#--<div style="margin-bottom:10px">
            <input name="picname" id="picnameid" data-options="validType:'maxLength[255]'" class="easyui-textbox" label="图片名称:"
                   style="width:100%">
        </div>-->
        <div style="margin-bottom:10px">
            <input name="describe" id="describe" data-options="validType:'maxLength[255]'" class="easyui-textbox" label="描述:"
                   style="width:100%">
        </div>
    </form>
</div>
<div id="uploadDlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveActach()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#uploadDlg').dialog('close');" style="width:90px">取消</a>
</div>
<#--图片放大图层-->
<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);width:100%;height:100%;display:none;z-index: 999999999">
    <div id="innerdiv" style="position:absolute;">
        <img id="bigimg" style="border:5px solid #fff;" src="" />
    </div>
</div>
<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:900px;height:700px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload >您的浏览器不支持 video 标签。</video>
</div>

<#--漳浦视频监控弹窗-->
<div id="zpCameraDlg" class="easyui-dialog" style="width:900px;height:700px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <div id='fjzx-camera-dialog' class="map-videolist"></div>
    <div style="position: absolute;top: 0;left:auto;right: 0px;bottom:0;width: 380px;padding: 28px 10px;">
        <#--云台控制器-->
        <div id="camera-control-dialog"></div>
    </div>
</div>
