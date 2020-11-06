var drawGridlinesjson = null;
var GridlinesJSONArr  = [] ;
var X_axisStartPoint = [116.85,25.247787];
var X_axisEndPoint = [116.85,23.55];
var Y_axisStartPoint = [116.85,23.55];
var Y_axisEndPoint = [118.182216,23.55];
function setGridlines () {
    if(drawGridlinesjson == null){
        drawGridlinesjson = new fjzx.map.DrawGeoJSON({
            map: map,
            zIndex : 10000,
            customType:"line"
        });
    }
    //横线
    var featureLine;
    if (GridlinesJSONArr.length == 0) {
        for (var i=0; i<135; i++) {
            featureLine = {"layout":"XY","coordinates":[[X_axisStartPoint[0] + i*0.009944,X_axisStartPoint[1]],[X_axisEndPoint[0] + i*0.009944,X_axisEndPoint[1]]],"type":"LineString","featureId":"lngid"+i,"pencilColor":"#90d7ec"};
            GridlinesJSONArr.push({"feature":JSON.stringify(featureLine),"name":"","id":"lngLine"+i});
        }
        for (var i=0; i<190; i++) {
            featureLine = {"layout":"XY","coordinates":[[Y_axisStartPoint[0],Y_axisStartPoint[1] + i*0.008983],[Y_axisEndPoint[0],Y_axisEndPoint[1] + i*0.008983]],"type":"LineString","featureId":"latid"+i,"pencilColor":"#90d7ec"};
            GridlinesJSONArr.push({"feature":JSON.stringify(featureLine),"name":"","id":"latLine"+i});
        }
    }
    drawGridlinesjson.load(GridlinesJSONArr);
}

function clearGridlines () {
    if(drawGridlinesjson!=null) {
        drawGridlinesjson.clearGeoJSON();
        drawGridlinesjson.closeModifyFeature();
    }
}
