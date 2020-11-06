function rankingWasteWater(){
    $('#topEnterpriseTb').datagrid({
        url: Ams.ctxPath+'/enviromonit/wtpt/wastewater/getRanking',
        // onLoadSuccess:function(){
        //     var rows = $("#topEnterpriseTb").datagrid("getRows");
        //     if(rows.length != 0){
        //         $("#topEnterpriseTb .other").html('实时：'+Ams.dateFormat(rows[0].datatime,'yyyy-MM-dd HH:mm'));
        //     }
        //     loopScrollOdj("waterMonitoring",50,40);
        // },
        // onDblClickRow:function(rowIndex,rowData){
        //     window.open("/enviromonit/water/nationalSurfaceWater?pid=d7aa1b75-6893-4091-8452-9c9a1ebf8369&waterPointCode="+rowData.pointCode);
        // }
    });

    $('#topPlantTb').datagrid({
        url: Ams.ctxPath+'/enviromonit/wtpt/wastewater/getPlantRanking'
    });
}

$(function () {
    rankingWasteWater();
});