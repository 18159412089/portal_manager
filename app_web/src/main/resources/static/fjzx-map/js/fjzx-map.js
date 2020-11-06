//包的预定义函数
function MACRO_PACKAGE_DEFINE(packageName) {
	var names = packageName.split(".");
	var currentPackage = null;
	for (var i = 0; i < names.length; i++) {
		var name = names[i];
		if (i === 0) {
			if (!this[name])
				this[name] = {};
			currentPackage = this[name];
		} else {
			if (!currentPackage[name])
				currentPackage[name] = {};
			currentPackage = currentPackage[name];
		}
	}
};

MACRO_PACKAGE_DEFINE("fjzx.map");
var tk = "7ca2bb2feccc647effa30f35238a1fe3";
var format = "image/png";
var bounds = [ 73.4510046356223, 18.1632471876417, 134.976797646506, 53.5319431522236 ];
var projection = ol.proj.get('EPSG:4326');
var projectionExtent = projection.getExtent();
var size = ol.extent.getWidth(projectionExtent) / 256;
var resolutions = new Array(14);
var matrixIds = new Array(14);
for ( var z = 0; z <= 14; ++z) {
	// resolutions[z] = size / Math.pow(2, z);
	// matrixIds[z] = z;
	resolutions = [ 0.01098632812500001860777113270858666,
			0.005493164062500009303885566354293329,
			0.002746582031250001658728184138270372,
			0.001373291015625000829364092069135186,
			0.0006866455078124989180747465151294470,
			0.0003433227539062494590373732575647235,
			0.0001716613769531250288401465326699910,
			0.00008583068847656251442007326633499548,
			0.00004291534423828140687076658511131235,
			0.00002145767211914064357109131177813033,
			0.00001072883605957030681947266069468370,
			0.000005364418029785168375809325541723313,
			0.000002682209014892578201475464693109072,
			0.000001341104507446289100737732346554536 ];
	matrixIds = [ '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ];
};

var _tileGrid = new ol.tilegrid.WMTS({
    origin: [-180, 90],
    resolutions: [
        0.703125,
        0.3515625,
        0.17578125,
        0.087890625,
        0.0439453125,
        0.02197265625,
        0.010986328125,
        0.0054931640625,
        0.00274658203125,
        0.001373291015625,
        0.0006866455078125,
        0.00034332275390625,
        0.000171661376953125,
        8.58306884765625e-005,
        4.291534423828125e-005,
        2.1457672119140625e-005,
        1.0728836059570313e-005,
        5.3644180297851563e-006,
        2.6822090148925781e-006,
        1.3411045074462891e-006
    ],
    matrixIds: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
});

/**
 * 专用于漳州图层资源加载
 * @param options
 * @returns {ol.layer.Tile}
 */
function createWMTSLayerForZZ(options) {
    //添加天地图tk秘钥
    var style = options.style;
    var matrixSet = options.matrixSet;
    if (!style)
        style = 'default';
    if (!matrixSet)
        matrixSet = 'c';
    var _tileGrid = new ol.tilegrid.WMTS({
        origin: [-180, 90],
        resolutions: [
            0.703125,
            0.3515625,
            0.17578125,
            0.087890625,
            0.0439453125,
            0.02197265625,
            0.010986328125,
            0.0054931640625,
            0.00274658203125,
            0.001373291015625,
            0.0006866455078125,
            0.00034332275390625,
            0.000171661376953125,
            8.58306884765625e-005,
            4.291534423828125e-005,
            2.1457672119140625e-005,
            1.0728836059570313e-005,
            5.3644180297851563e-006,
            2.6822090148925781e-006,
            1.3411045074462891e-006
        ],
        matrixIds: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    });

    var source = new ol.source.XYZ({
        url : options.url,
        layer : options.layerName,
        format : options.format,
        tileGrid : _tileGrid,
        matrixSet :matrixSet,
        style : style,
        projection: "EPSG:4326",

    });

    var layer = new ol.layer.Tile({
        title: options.title ? options.title : options.layerName,
        visible: options.false ? options.false : true,
        type: options.false ? options.false : 'base',
        type: 'base',
        projection: "EPSG:4326",
        source : source
    })
    return layer;
};

/**
 * 创建网络地图切片服务（WMTS）资源图层
 * @param options
 * @returns {ol.layer.Tile}
 */
function createWMTSLayer(options) {
	//添加天地图tk秘钥

	var style = options.style;
	var matrixSet = options.matrixSet;
	if (!style)
		style = 'default';
	if (!matrixSet)
		matrixSet = 'c';
	var source = new ol.source.WMTS({
		url : options.url+"?tk="+tk,
		layer : options.layerName,
		format : options.format,
		tileGrid : new ol.tilegrid.WMTS({
			origin : ol.extent.getTopLeft(projectionExtent),
			resolutions : resolutions,
			matrixIds : matrixIds
		}),
		matrixSet : matrixSet,
		style : style,
        wrapX: true
	});

	var layer = new ol.layer.Tile({
        title: options.title ? options.title : options.layerName,
        visible: options.false ? options.false : true,
        type: options.false ? options.false : 'base',
		name : options.caption,
		source : source
	})
	return layer;
};

/**
 * 创建网络地图服务图层
 * @param options
 * @returns {ol.layer.Tile}
 */
function createWMSLayer(options) {
    //添加天地图tk秘钥

    var source = new ol.source.TileWMS({
        url : options.url+"?tk="+tk,
        projection: 'EPSG:4326'
    });

    var layer = new ol.layer.Tile({
        name : options.caption,
        source : source
    })
    return layer;
};

function createVectorLayer(options) {
    var source = new ol.source.Vector({
        format: new ol.format.GeoJSON({
            geometryName: 'geom'
        }),
        url: options.url,
        projection: 'EPSG:4326'
    });

    var layer = new ol.layer.Vector({
        renderMode: 'image',
        name : options.caption,
        source : source,
        style: options.styleFormat
    })
    return layer;
};

function createZoomSlider() {
	var zoomSlider = new ol.control.ZoomSlider();

	return zoomSlider;
};

function createCustomOverviewMap(layerGroup) {
	var overviewMapControl = new ol.control.OverviewMap({
		className : 'ol-overviewmap ol-custom-overviewmap',
		layers : [ layerGroup ],
		collapseLabel : '\u00BB',
		label : '\u00AB',
		collapsed : false
	});
	return overviewMapControl;
};

/**
 * 测量工具（测距、测面积）
 * 
 * @constructor
 * @extends {ol.control.Control}
 * @param {Object} opt_options Control options, extends olx.control.ControlOptions
 *            adding: **`tipLabel`** `String` - the button tooltip.
 * @param {Function} startDrawCallback	开始测量回调函数
 * @param {Function} endDrawCallback	结束测量回调函数
 */
fjzx.map.MeasureTool = function(opt_options,startDrawCallback,endDrawCallback) {
	var options = opt_options || {};

	//将绘画开始和结束时调用的回调函数保存为全局变量
	this.startDrawCallback = startDrawCallback;
	this.endDrawCallback = endDrawCallback;
	//用于保存已画线条和提示以便删除时使用
	this.measureMap = new fjzx.map.HashMap();	
	this.measureTooltipMap = new fjzx.map.HashMap();

	this.map = options.map;
	this.sphereradius = options.sphereradius ? options.sphereradius : 6378137;
	var measureType = options.measureType === "line" ? length : area;	//测量类型：area为测量面积(area)、line为距离(length)
	
	//测量时显示线条用的图层
	this.source = new ol.source.Vector();
	this.vector = new ol.layer.Vector({
		source : this.source,
		style : new ol.style.Style({
			fill : new ol.style.Fill({
				color : 'rgba(255, 255, 255, 0.2)'
			}),
			stroke : new ol.style.Stroke({
				color : '#ffcc33',
				width : 2
			}),
			image : new ol.style.Circle({
				radius : 7,
				fill : new ol.style.Fill({
					color : '#ffcc33'
				})
			})
		})
	});
	
	this.typeSelect = {
		value: measureType,
		check: true
	};
};

ol.inherits(fjzx.map.MeasureTool, ol.control.Control);

fjzx.map.MeasureTool.prototype.open = function(){
	this.mapmeasure(this.typeSelect);
};

fjzx.map.MeasureTool.prototype.close = function(){
	this.mapmeasure(this.typeSelect);
};

fjzx.map.MeasureTool.prototype.mapmeasure = function(typeSelect) {
	var source = this.source;
	var vector = this.vector;
	var map = this.map;
	var measureMap = this.measureMap;
	var measureTooltipMap = this.measureTooltipMap;
	var wgs84Sphere = new ol.Sphere(this.sphereradius);

	var sketch;
	var helpTooltipElement;
	var measureTooltipElement;
	var measureTooltip;
	var this_ = this;

	map.addLayer(vector);

	map.getViewport().addEventListener('mouseout', function() {
		helpTooltipElement.classList.add('hidden');
	});

	var draw;

	var formatLength = function(line) {
		var length;
		if (typeSelect.check) {
			var coordinates = line.getCoordinates();
			length = 0;
			var sourceProj = map.getView().getProjection();
			for ( var i = 0, ii = coordinates.length - 1; i < ii; ++i) {
				var c1 = ol.proj.transform(coordinates[i], sourceProj,
						'EPSG:4326');
				var c2 = ol.proj.transform(coordinates[i + 1], sourceProj,
						'EPSG:4326');
				length += wgs84Sphere.haversineDistance(c1, c2);
			}
		} else {
			var sourceProj = map.getView().getProjection();
			var geom = /** @type {ol.geom.Polygon} */
			(line.clone().transform(sourceProj, 'EPSG:3857'));
			length = Math.round(geom.getLength() * 100) / 100;
			// length = Math.round(line.getLength() * 100) / 100;
		}
		var output;
		if (length > 100) {
			output = (Math.round(length / 1000 * 100) / 100) + ' ' + 'km';
		} else {
			output = (Math.round(length * 100) / 100) + ' ' + 'm';
		}
		return output;
	};

	var formatArea = function(polygon) {
		if (typeSelect.check) {
			var sourceProj = map.getView().getProjection();
			var geom = /** @type {ol.geom.Polygon} */
			(polygon.clone().transform(sourceProj, 'EPSG:4326'));
			var coordinates = geom.getLinearRing(0).getCoordinates();
			area = Math.abs(wgs84Sphere.geodesicArea(coordinates));
		} else {
			var sourceProj = map.getView().getProjection();
			var geom = /** @type {ol.geom.Polygon} */
			(polygon.clone().transform(sourceProj, 'EPSG:3857'));
			area = geom.getArea();
			// area = polygon.getArea();
		}
		var output;
		if (area > 10000) {
			output = (Math.round(area / 1000000 * 100) / 100) + ' '
					+ 'km<sup>2</sup>';
		} else {
			output = (Math.round(area * 100) / 100) + ' ' + 'm<sup>2</sup>';
		}
		return output;
	};

	var popupcloser = document.createElement('a');
	var measureId = fjzx.map.utils.getUUID();
	popupcloser.id= measureId
	popupcloser.href = 'javascript:void(0);';
	popupcloser.classList.add('fjzx-map-infoWindow-closer');

	
	function addInteraction() {
		var type = (typeSelect.value == 'area' ? 'Polygon' : 'LineString');
		draw = new ol.interaction.Draw({
			source : source,
			type : /** @type {ol.geom.GeometryType} */
			(type),
			style : new ol.style.Style({
				fill : new ol.style.Fill({
					color : 'rgba(255, 255, 255, 0.2)'
				}),
				stroke : new ol.style.Stroke({
					color : 'rgba(0, 0, 0, 0.5)',
					lineDash : [ 10, 10 ],
					width : 2
				}),
				image : new ol.style.Circle({
					radius : 5,
					stroke : new ol.style.Stroke({
						color : 'rgba(0, 0, 0, 0.7)'
					}),
					fill : new ol.style.Fill({
						color : 'rgba(255, 255, 255, 0.2)'
					})
				})
			})
		});
		map.addInteraction(draw);

		createMeasureTooltip(measureId);
		createHelpTooltip(measureId);
		measureMap.put(measureId,draw);
		
		var listener;
		draw.on('drawstart', function(evt) {
			// set sketch
			sketch = evt.feature;

			/** @type {ol.Coordinate|undefined} */
			var tooltipCoord = evt.coordinate;

			listener = sketch.getGeometry().on(
				'change',
				function(evt) {
					try {
						var geom = evt.target;
						var output;
						if (geom instanceof ol.geom.Polygon) {
							output = formatArea(geom);
							tooltipCoord = geom.getInteriorPoint()
									.getCoordinates();
						} else if (geom instanceof ol.geom.LineString) {
							output = formatLength(geom);
							tooltipCoord = geom.getLastCoordinate();
						}
						measureTooltipElement.innerHTML = output;
						measureTooltip.setPosition(tooltipCoord);
					} catch (e) {
						map.removeInteraction(draw);
					} finally {
					}

				});
			if(typeof(this_.startDrawCallback)==="function")
				this_.startDrawCallback();
		}, this);

		draw.on('drawend', function() {
			measureTooltipElement.appendChild(popupcloser);
			measureTooltipElement.className = 'tooltip tooltip-static';
			measureTooltip.setOffset([ 0, -7 ]);
			// unset sketch
			sketch = null;
			// unset tooltip so that a new one can be created
			measureTooltipElement = null;
			createMeasureTooltip(measureId);
			ol.Observable.unByKey(listener);
			// end
			map.removeInteraction(draw);
			// map.getInteractions().item(1).setActive(false);
			if(typeof(this_.endDrawCallback)==="function")
				this_.endDrawCallback();
		}, this);
	}

	function createHelpTooltip(measureId) {
		if (helpTooltipElement) {
			helpTooltipElement.parentNode.removeChild(helpTooltipElement);
		}
		helpTooltipElement = document.createElement('div');
		helpTooltipElement.setAttribute("measure-id",measureId);
		helpTooltipElement.className = 'tooltip hidden';
	}
	function createMeasureTooltip(measureId) {
		if (measureTooltipElement) {
		 
			measureTooltipElement.parentNode.removeChild(measureTooltipElement);
		}
		measureTooltipElement = document.createElement('div');
		measureTooltipElement.setAttribute("measure-id",measureId);
		measureTooltipElement.className = 'tooltip tooltip-measure';
		measureTooltip = new ol.Overlay({
			element : measureTooltipElement,
			offset : [ 0, -15 ],
			positioning : 'bottom-center'
		});
		map.addOverlay(measureTooltip);
		measureTooltipMap.put(measureId,measureTooltip);
	}

	//清楚地图上的测量数据
	popupcloser.onclick = function(e) {
		/*
		var measureInteraction = measureMap.get(measureId);
		var measureTooltipLayer = measureTooltipMap.get(measureId);
		var measureTooltipElement = document.getElementById(measureId);
		var paremtElement = measureTooltipElement.parentNode;
		
		console.log(measureInteraction);
		console.log(measureTooltipLayer);
		map.removeInteraction(measureInteraction);
		map.removeLayer(measureTooltipLayer);
		paremtElement.removeChild(measureTooltipElement);
		*/
		
		map.getOverlays().clear();
		vector.getSource().clear();
		// map.removeLayer(vector);
	};

	addInteraction();
};

/**
 * Show the MeasureTool.
 */
fjzx.map.MeasureTool.prototype.showPanel = function() {
	if (this.element.className != this.shownClassName) {
		this.element.className = this.shownClassName;
	}
};

/**
 * Hide the MeasureTool.
 */
fjzx.map.MeasureTool.prototype.hidePanel = function() {
	if (this.element.className != this.hiddenClassName) {
		this.element.className = this.hiddenClassName;
	}
};

/**
 * 设置该测量工具所对应的Map.
 * 
 * @param {ol.Map}  map The map instance.
 */
fjzx.map.MeasureTool.prototype.setMap = function(map) {
	// 清理与前一个地图Map相关联的监听器
	for ( var i = 0, key; i < this.mapListeners.length; i++) {
		this.getMap().unByKey(this.mapListeners[i]);
	}
	this.mapListeners.length = 0;
	// 连接监听器等，且保存对新地图的引用
	ol.control.Control.prototype.setMap.call(this, map);
	if (map) {
		var this_ = this;
		this.mapListeners.push(map.on('pointerdown', function() {
			this_.hidePanel();
		}));
	}
};

/**
 * 生成UUID
 * 
 * @returns {String} UUID
 */
fjzx.map.MeasureTool.uuid = function() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		return v.toString(16);
	});
};

/**
 * @private 私有变量
 * @desc 是使溢出的内容在元素内滚动的解决方案 
 */
fjzx.map.MeasureTool.enableTouchScroll_ = function(elm) {
	if (fjzx.map.MeasureTool.isTouchDevice_()) {
		var scrollStartPos = 0;
		elm.addEventListener("touchstart", function(event) {
			scrollStartPos = this.scrollTop + event.touches[0].pageY;
		}, false);
		elm.addEventListener("touchmove", function(event) {
			this.scrollTop = scrollStartPos - event.touches[0].pageY;
		}, false);
	}
};

/**
 * @private
 * @desc Determine if the current browser supports touch events.
 */
fjzx.map.MeasureTool.isTouchDevice_ = function() {
	try {
		document.createEvent("TouchEvent");
		return true;
	} catch (e) {
		return false;
	}
};


//==============================================================================
/*fjzx.map.LayerSwitcher = function(opt_options,callback){
	 this.opt =  opt_options.tipLabel ?opt_options.tipLabel :'切换图层';
	 fjzx.map.LayerSwitcher.call(this,this.opt);
	 
};*/
/**
 * 创建地图实例
 * @param {JSON} opt_options (controls,pixelRatio,interactions,keyboardEventTarget,layers,loadTilesWhilethis_animating,loadTilesWhileInteracting,logo,moveTolerance,overlays,renderer,target,view)
 * @param {Funciton} callback
 * @returns {ol.Map}
 */
fjzx.map.Map = function(opt_options,callback){
	var options = opt_options || {};
    this._clusterInteractions = null ; //地图交互  （_interactions 现用于clusterFeature）
    this._selectClusterMaker = null ; //聚合数据选中features
	var center = options.center ? options.center : [117.01, 25.12];
	if(isNaN(center[0]) || isNaN(center[1])){
		center[0] =117.01;
		center[1] = 25.12;
	}
	
	var projection = options.projection ? options.projection : ol.proj.get('EPSG:4326');
	var zoom = options.zoom ? options.zoom : 3;
	var maxZoom = options.maxZoom ? options.maxZoom : 18;
	var minZoom = options.minZoom ? options.minZoom : 2;
	this._selectInteraction = null;createWMTSLayer
	this.mapTools = [];
	
	this.opt = {
		view: new ol.View({
			center: center,
			projection: projection,	//projection=EPSG:4326,坐标系设为经纬度坐标系（EPSG:4326），默认为xy坐标（EPSG:3857）
			zoom: zoom,
			maxZoom: maxZoom,
			minZoom: minZoom
		}),
		layers: options.layers,
		target: options.target,
		
		controls: options.controls ? options.controls : undefined,
		pixelRatio: options.pixelRatio ? options.pixelRatio : undefined,
		interactions: options.interactions ? options.interactions : undefined,
		keyboardEventTarget: options.keyboardEventTarget ? options.keyboardEventTarget : undefined,
		loadTilesWhileAnimating: options.loadTilesWhileAnimating ? options.loadTilesWhileAnimating : undefined,
		loadTilesWhileInteracting: options.loadTilesWhileInteracting ? options.loadTilesWhileInteracting : undefined,
		logo: options.logo ? options.logo : false,
		moveTolerance: options.moveTolerance ? options.moveTolerance : undefined,
		overlays: options.overlays ? options.overlays : undefined,
		renderer: options.renderer ? options.renderer : undefined
	};
	
	ol.Map.call(this,this.opt);
};

ol.inherits(fjzx.map.Map, ol.Map);

fjzx.map.Map.prototype.setCenterAndZoom = function(point,zoom){
	var center = new fjzx.map.Point(point[0],point[1]);

	if(!isNaN(center[0]) && !isNaN(center[1]))
		this.setCenter(center);
	
	if(!isNaN(zoom) && !(zoom < 0 || zoom > 28))
		this.setZoom(zoom);
};

/**
 * 设置地图事件点击失效 生效
 * @param {String} selectType
 */
fjzx.map.Map.prototype.setInteractionDrawGeo = function(names,flag){
	var interactions = this.getInteractions().getArray();
	
    for(var i = 0 ; i < interactions.length; i++){
    	for(var b = 0 ; b < names.length ; b++){
    		if(interactions[i].get("name") == names[b]){
    		        interactions[i].setActive(flag);
			   }
    	}
	 } 
    map.render(); 
    
}
//设置选中interaction  
fjzx.map.Map.prototype.setSelectInteraction = function(interaction){
	this._selectInteraction = interaction;
};
fjzx.map.Map.prototype.getSelectInteraction = function(){
	return this._selectInteraction;
};
fjzx.map.Map.prototype.removeSelectInteraction = function(){
    if(this._selectInteraction!=null){

    	 var features = this._selectInteraction.getFeatures().getArray()
    	 for(var i = 0 ; i <features.length;i++){
    		var currentLayer =  this._selectInteraction.getLayer(features[i]);
    		currentLayer.getSource().clear()
    	 }
    }
};


/**
 * 设置地图中心点坐标
 * @param {fjzx.map.Point}point	中心点坐标
 * @param {boolean}isAnimate	是否动画显示（默认为动画显示）
 */
fjzx.map.Map.prototype.setCenter = function(point,isAnimate){
	var view = this.getView();
	 // 添加动画效果时  中心点不能定位的轨迹起始点
/*	if(isAnimate){
	     
		   view.animate({
		          center: point,
		          duration: 1000
		        });
	}else{
		view.setCenter(point);
	}*/
	view.setCenter(point);
};

/**
 * 设置地图显示级别
 * @param {integer}zoom 地图级别，0～28
 */
fjzx.map.Map.prototype.setZoom = function(zoom){
	var view = this.getView();
	
	if(!isNaN(zoom) && zoom<0 || zoom > 28)
		return false;

	view.setZoom(zoom);
};

/**
 * 设置地图最小缩放级别
 * @param {integer}zoom 地图级别，0～28
 */
fjzx.map.Map.prototype.setMinZoom = function(minZoom){
	var view = this.getView();
	
	if(!isNaN(minZoom) && (minZoom<0 || minZoom > 28))
		return false;
	
	view.setMinZoom = minZoom;
};

/**
 * 设置地图最大缩放级别
 * @param {integer}zoom 地图级别，0～28
 */
fjzx.map.Map.prototype.setMaxZoom = function(maxZoom){
	var view = this.getView();
	
	if(!isNaN(maxZoom) && (maxZoom<0 || maxZoom > 28))
		return false;
	
	view.setMaxZoom = maxZoom;
};

fjzx.map.Map.prototype.setAnimation = function(animation){
	
};

fjzx.map.Map.prototype.setMapType = function(mapType){
	var layerGroup = fjzx.map.source.getLayerGroupByMapType(mapType);
	map.setLayerGroup(layerGroup);
};

/**
 * 标注点构造函数
 * 海量标记点
 * @param {fjzx.map.Point} point
 * @param {Object} opt_options
 * @param {Function} callback
 * @returns {fjzx.map.Marker}
 */
fjzx.map.ClusterMarker = function(opt_options,callback){
	var options = opt_options || {};
	this._distance = options.distance ? options.distance : 50 ;
	this._hasMoreImage =  options.hasMoreImage ? options.hasMoreImage : false ; //是否有包含多个图片
	this._type = options.type ? options.type : 0 ;
    this._iconSmallPath  = options.iconSmallPath ? options.iconSmallPath :  "./fjzx-map/img/map_markers3.png";
    this._iconBigPath  = options.iconBigPath ? options.iconBigPath :  "./fjzx-map/img/map_markers3.png";
    this._map   = options.map;
    this._clustersLayer = null;

    this._saveObject = null ;
    this._clusterSource = null;
   
    this._datas = null ;
    return this;
}
//聚合  加载数据
fjzx.map.ClusterMarker.prototype.loadData = function(datas,showMoreImage) {
	this._datas = datas;
	var count = datas.length;
	var iconPath = this._iconPath;
	var myfeatures =  new Array(count);
	for (var i = 0; i < count; i++) {
		  var coordinates = [Number(datas[i].longitude),Number(datas[i].latitude)];
		  myfeatures[i] = new ol.Feature(new ol.geom.Point(coordinates));
		  if(typeof(showMoreImage)!='undefined'){
			  myfeatures[i].set("iconSmallPath",showMoreImage(datas[i]));
		  }else{
			  myfeatures[i].set("iconSmallPath",this._iconSmallPath);
		  }
		  myfeatures[i].set("iconBigPath",this._iconBigPath);
		  myfeatures[i].set("object",datas[i]);
		  myfeatures[i].set("type",this._type);
		  
	}
	var source = new ol.source.Vector({
		  features: myfeatures
		});

	this._clusterSource = new ol.source.Cluster({
		  distance: this._distance,
		  source: source
		});

	var styleCache = {};
	var $this = this;
	 
	if(this._clustersLayer != null){
	   map.removeLayer(this._clustersLayer);
	  
	}
	this._clustersLayer = new ol.layer.Vector({
		  source: this._clusterSource,
		  style: function(feature) {
			  	var size = feature.get('features').length;
			    var style = styleCache[size];
			    if (!style) {
			    	
			    	style = $this.styleFunction(feature);
			        styleCache[size] = style;
			    }
			    return style;
		  }
		});
	 this._map.addLayer(this._clustersLayer);
	 this._map.render();
}
/**集群点击事件
 * 将点击事件放置map 中确保点击唯一
 */
fjzx.map.ClusterMarker.prototype.setOnClickListener= function (showPointCallBack){
	   var $this = this;
	   var map = $this._map;
	   if(map._clusterInteractions == null){
		   map._clusterInteractions =   new ol.interaction.Select({
				    condition: function(evt) {
				    return evt.originalEvent.type == 'mouseup' ||
				        evt.type == 'singleclick';
				    },
				    style: this.styleFunction
				  }) ;
	        
		   map._clusterInteractions.on('select', function(e) {
				 
				 if( typeof(e.selected[0])!='undefined'){
					  var feature = e.selected[0].get("features")[0];
					  map._selectClusterMaker = map._clusterInteractions.getFeatures();
				      if(typeof(showPointCallBack)== "function"){
				    	  showPointCallBack(feature.get('type'),feature.get('object'),$this);
				 	  }  
				  }else{
				        $this._map.clearOverlays();
			    	  
			      }
			 });
			
		    map.addInteraction(map._clusterInteractions);
	   }
}
/**
 * 清空选中的feature
 */
fjzx.map.ClusterMarker.prototype.clearSelectClusterMaker = function(){
     var map = this._map;
	if(map._selectClusterMaker!=null)
		map._selectClusterMaker.clear();
}


/**
 * 地图信息框
 * @param opt_options
 * @returns {fjzx.map.InfoWindow}
 */
fjzx.map.ClusterMarkerInfoWindow = function(opt_options,clustermaker){
	var options = opt_options || {};
	
	this._containerElement = document.getElementById('infoWindow');
	this._contentElement = document.getElementById('infoWindow-content');
	this._closerElement = document.getElementById('infoWindow-closer');

 
	 if(this._containerElement==null){
		this._containerElement = document.createElement("div");
		this._containerElement.id="infoWindow";
		this._containerElement.className = "fjzx-map-infoWindow";
		
		this._contentElement = document.createElement("div");
		this._contentElement.innerHTML = options.infoWindow;
		this._contentElement.id="infoWindow-content";
		
		this._closerElement = document.createElement("a");
		this._closerElement.setAttribute("href", "javascript:void(0)");
		this._closerElement.id="infoWindow-closer";
		this._closerElement.className="fjzx-map-infoWindow-closer";
		
		this._containerElement.appendChild(this._closerElement);
		this._containerElement.appendChild(this._contentElement);
	}else{
		this._contentElement.innerHTML = options.infoWindow;
	}
	
	var this_ = this;
	$(this._containerElement).find("a#infoWindow-closer").click(function(){
		this_.setPosition(undefined);
		$(this_.closer).blur();
	 	if(typeof(clustermaker) !="undefined"){
	 		clustermaker.clearSelectClusterMaker(clustermaker);
	 		clustermaker._map.clearOverlays();
			clustermaker._selectClusterMaker = null;
		} 
		return false;
	});
	
	ol.Overlay.call(this,{
		element: this._containerElement,
		autoPan: true,
		autoPanAnimation: {
			duration: 250
		}
	});
};

ol.inherits(fjzx.map.ClusterMarkerInfoWindow, ol.Overlay);

/**
 * 设置地图信息弹出框内容
 * @param {String} content 可以为纯文字字符串，也可以是带HTML元素的字符串 
 */
fjzx.map.ClusterMarkerInfoWindow.prototype.setContent = function(content){
	this._contentElement.innerHtml=content;
};


/**
 * 弹出标注点信息框
 * @param {fjzx.map.InfoWindow} infoWindow
 */
fjzx.map.ClusterMarker.prototype.openInfoWindow = function(infoWindow,record){
	var map = this._map;
	if(typeof(map)=="undefined" || map==null){
	     
	     return null ;
	}
	var point =new fjzx.map.Point( Number(record.longitude),Number(record.latitude));
	this._infoWindow = infoWindow;
	this._infoWindow.setPosition(point);
	map.addOverlay(this._infoWindow);
	
	 /**
	   * 显示的信息框被遮挡时自动重新设置地图中心点（通过计算出偏移量来实现）
	 */
	//标记点屏幕像素坐标
	var positionPixel = map.getPixelFromCoordinate(point);
	var bounds = map.getBounds();
	var mapLeftTopPoint = bounds.getLeftTopPoint();
	var mapRightButtonPoint = bounds.getRightButtonPoint();
	
	 if(!bounds.containsPoint(point)){
	 
		map.setCenter(point);
		return;
	} 
	
	//信息框宽高
	var element = this._infoWindow.getElement();
	var width = element.clientWidth;
	var height = element.clientHeight;
	
	//地图中心点经纬度坐标和屏幕像素坐标
	var center = map.getCenter();
	var centerPixel = map.getPixelFromCoordinate(center);
	
	//上边被挡住时
	if(height>(positionPixel[1] - mapLeftTopPoint[1])){
		//由于地图显示区上方可能有工具栏，所以偏移量多100px
		var offset = height - Math.abs(mapLeftTopPoint[1] - positionPixel[1]) + 100;
		centerPixel = [centerPixel[0], centerPixel[1]-offset];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	//下边被挡住时，由于统一显示在标注点上方，所以此种情况一般不会出现
	if((positionPixel[1])>mapRightButtonPoint[1]){
		var offset = positionPixel[1] - mapRightButtonPoint[1];
		centerPixel = [centerPixel[0]+offset, centerPixel[1]];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	//左边被挡住时
	if(width/5>(positionPixel[0] - mapLeftTopPoint[0])){
		//由于信息框统一显示在标注点上方偏右位置，所以正常情况下只有信息框部分被遮挡
		var offset = width/5 - Math.abs(positionPixel[0] - mapLeftTopPoint[0]);
		centerPixel = [centerPixel[0]-offset, centerPixel[1]];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	//右边被挡住时
	if(width>(mapRightButtonPoint[0]-positionPixel[0])){
		var offset = width - Math.abs(mapRightButtonPoint[0]-positionPixel[0]); 
		centerPixel = [centerPixel[0]+offset, centerPixel[1]];
		center = map.getCoordinateFromPixel(centerPixel);
	}
 
	map.setCenter(center);
};
fjzx.map.ClusterMarker.prototype.styleFunction = function(feature){
 
	 var style = null ;
	 var imagePath = null;
	 var size = feature.get('features').length;
	 if(size > 1){
  		imagePath = feature.get('features')[0].get('iconBigPath');
  		style = new ol.style.Style({
           image: new ol.style.Icon(({
                anchor: [0.5, 0.5],
                anchorXUnits: 'fraction',   //fraction 根据百分比控制锚点x y
                anchorYUnits: 'fraction',
                opacity: 1,
                scale :1,
                src: imagePath
          })),
          text: new ol.style.Text({
              text: size.toString(),
              fill: new ol.style.Fill({
                color: '#000000'
              })
            })
        });
      }else{
        imagePath = feature.get('features')[0].get('iconSmallPath');
        style = new ol.style.Style({
           image: new ol.style.Icon(({
                anchor: [0.5, 0.5],
                anchorXUnits: 'fraction',   //fraction 根据百分比控制锚点x y
                anchorYUnits: 'fraction',
                opacity: 1,
                scale :1,
                src: imagePath
              }))
        });
      }
  
	 return style;
}
 

/**
 * 清空地图覆盖物
 * @returns {Boolean}
 */
fjzx.map.Map.prototype.clearOverlays = function(){
	var overlays = this.getOverlays().getArray();
	var overlayArray = [];
	//需要先把地图上的覆盖物对象保存在数组中，然后再遍历该数组进行移除操作
	for(var i=0;i<overlays.length;i++){
		overlayArray.push(overlays[i]);
	}
	for(var i=0;i<overlayArray.length;i++){
		var result = this.removeOverlay(overlayArray[i]);
	}

	return true;
};

fjzx.map.Map.prototype.getDistance = function(startPoint, endPoint){
	var result = 0;
	var sourceProj = map.getView().getProjection();
	
	var c1 = ol.proj.transform(startPoint, sourceProj, 'EPSG:4326');
	var c2 = ol.proj.transform(endPoint, sourceProj, 'EPSG:4326');
	result = ol.sphere.getDistance(c1,c2);
	
	return result;
};

fjzx.map.Map.prototype.pointToPixel = function(point){
	var planePoint = ol.proj.fromLonLat(point);
	var view = this.getView();
	var zoom = view.getZoom();
	
	var pixel_X = planePoint[0] * Math.pow(2, zoom-18);
	var pixel_Y = planePoint[1] * Math.pow(2, zoom-18)
	var pixelPoint = {x: pixel_X, y: pixel_Y};
	return pixelPoint;
};

fjzx.map.Map.prototype.getProjection = function(){
	var view = this.getView();
	var proj = view.getProjection();
	var options = {
		code: proj.getCode() ? proj.getCode() : 'EPSG:4326',
		units: proj.getUnits() ? proj.getUnits() : undefined,
		extent: proj.getExtent() ? proj.getExtent() : undefined,
		axisOrientation: undefined,
		global: proj.isGlobal() ? proj.isGlobal() : undefined,
		metersPerUnit:	proj.getMetersPerUnit() ? proj.getMetersPerUnit() : undefined,
		worldExtent: proj.getWorldExtent() ? proj.getWorldExtent() : undefined
	};
	
	var projection = new fjzx.map.Projection(options);
	
	return projection;
};

/**
 * 获取地图边界值
 * @returns {fjzx.map.Bounds}
 */
fjzx.map.Map.prototype.getBounds = function(){
	var bounds = new fjzx.map.Bounds(this);
	
	return bounds;
};

/**
 * 获取地图中心坐标点（经纬度）
 * @returns {fjzx.map.Bounds}
 */
fjzx.map.Map.prototype.getCenter = function(){
	var view = this.getView();
	
	return view.getCenter();
};

/**
 * 地图边界类
 * @param {fjzx.map.Map} map
 * @returns {fjzx.map.Bounds}
 */
fjzx.map.Bounds = function(map){
	this._map = map;
	var size = this._map.getSize();
	var id = this._map.getTarget();
	var element = document.getElementById(id);
	
	//左上角的XY轴坐标值
	var element_X = element.offsetLeft;
	var element_Y = element.offsetTop;
	//右下角的XY轴坐标值
	var element_max_X = element_X + size[0];
	var element_max_Y = element_Y + size[1];
	
	this.leftTopPoint = [element.offsetLeft, element.offsetTop];
	this.rightButtonPoint = [element_max_X, element_max_Y];
}

fjzx.map.Bounds.prototype.getSize = function(){
	return this._map.getSize();
}

fjzx.map.Bounds.prototype.getLeftTopPoint = function(){
	return this.leftTopPoint;
}

fjzx.map.Bounds.prototype.getRightButtonPoint = function(){
	return this.rightButtonPoint;
}

fjzx.map.Bounds.prototype.containsPoint = function(point){
	//根据经纬度坐标获取对应的屏幕坐标
	var pixelPoint = this._map.getPixelFromCoordinate(point);
	var pixel_X = pixelPoint[0];
	var pixel_Y = pixelPoint[1];
	if(pixel_X > this.leftTopPoint[0] && pixel_X < this.rightButtonPoint[0]){
		if(pixel_Y > this.leftTopPoint[1] && pixel_Y < this.rightButtonPoint[1]){
			return true;
		}
	}
	return false;
}

fjzx.map.Bounds.prototype.containsPixelPoint = function(pixelPoint){
	//根据经纬度坐标获取对应的屏幕坐标
	var pixel_X = pixelPoint[0];
	var pixel_Y = pixelPoint[1];
	if(pixel_X > this.leftTopPoint[0] && pixel_X < this.rightButtonPoint[0]){
		if(pixel_Y > this.leftTopPoint[1] && pixel_Y < this.rightButtonPoint[1]){
			return true;
		}
	}
	return false;
}

/**
 * 标注点构造函数
 * @param {fjzx.map.Point} point
 * @param {Object} opt_options
 * @param {Function} callback
 * @returns {fjzx.map.Marker}
 */
fjzx.map.Marker = function(point,opt_options,callback){
	var options = opt_options || {};
	
	var title = options.title ? options.title : "Marker";
	var icon = options.icon ? options.icon : new fjzx.map.Icon( Ams.ctxPath+"/static/fjzx-map/img/map_markers3.png", new fjzx.map.Size(30, 30));
	var iconSize = icon.opt.size ? icon.opt.size :new fjzx.map.Size(30, 30);
	
	var offIndex = options.offIndex ? options.offIndex : [-10,-8];
	this._map = options.map;
	this._markerId = options.markerId ? options.markerId : fjzx.map.utils.getUUID();
	this._isShowIcon = typeof(options.isShowIcon)=="boolean" ? options.isShowIcon : true;
	this._markerHtml = options.markerHtml ? options.markerHtml :"";
	this._markerElement = document.createElement("div");
	this._markerPoint = point;
	
	if(this._isShowIcon){
		this._markerElement = document.createElement("div");
		this._markerElement.title = title;
		this._markerElement.id = this._markerId;
		this._markerElement.className = "fjzx-map-marker";
		var markerImg = document.createElement("img");
		markerImg.src = icon.getSrc();
		markerImg.width = iconSize[0];
        markerImg.height = iconSize[1];
       this._markerElement.appendChild(markerImg);
	}else{
		if(this._markerHtml!=null || this._markerHtml!="")
			this._markerElement.innerHTML= this._markerHtml;
	} 
	 
 
	this.opt = {
		element: this._markerElement,
		position: point,

		offset: offIndex,
		stopEvent: false,
		autoPan: false,
		autoPanAnimation: undefined
	};
	
	ol.Overlay.call(this, this.opt);
}

ol.inherits(fjzx.map.Marker, ol.Overlay);


/**
 * 标记物圆形波纹效果
 * setCycleTime 设置动画循环时间
 * stopAnimal  结束动画
 * pauseAnimal 暂停动画
 * startAnimal 开始动画
 * setDurationTime 设置动画频率、
 * flagAniaml 标志动画
 *
 *   var	 cycleObject  =  myMarker.cycleAnimal();
			 cycleObject.startAnimal();
			 cycleObject.setCycleTime(5);
 *
 */

fjzx.map.Marker.prototype.cycleAnimal = function(offsetX,offsetY) {
	var listenerKey;
	var sourceAnimal;
	var vectorAnimal;

	if( typeof offset != 'number' && isNaN(offsetX)){
		offsetX = 0;
	}
	if( typeof offset != 'number' && isNaN(offsetY)){
		offsetY = -0.0001;
	}

	var cycleObject  ={
			duration:2000,
			zIndex :1000,
			flagAniaml : true ,
			cListenerKey :null,
			stopAnimal : function(){
			   ol.Observable.unByKey(cycleObject.cListenerKey);
			},
	        pauseAnimal :function(){
	        	this.flagAniaml =false;
	        },
			startAnimal :function(){
				this.flagAniaml = true ;
				cListenerKey = map.on('postcompose',animate);	
			},
	        setDurationTime : function(time){
				this.duration= time;
	        },
	        setCycleTime : function(time){
	        	setTimeout(function(){
					 this.flagAniaml = false ;
	        		 cycleObject.stopAnimal(); 
	   
	        	},time*1000);
	        }
	};
    var start = new Date().getTime();
	var elapsed =0;
    var map = this.getMap();
	if(typeof(map)=="undefined" || map==null)
		map = this._map;
	
    sourceAnimal = new ol.source.Vector({
    	 wrapX: false
	});

	vectorAnimal = new ol.layer.Vector({
		source :sourceAnimal
	});
	//设置偏移量
	var ly = ol.proj.fromLonLat([this.opt.position[0]+offsetX,this.opt.position[1]+offsetY]);
    var lyln = ol.proj.toLonLat(ly);
    var iconFeature = new ol.Feature({
       geometry: new ol.geom.Point(lyln)
    });
    var feature =iconFeature;
	sourceAnimal.addFeature(feature);
  //  map.addLayer(vectorAnimal);
    vectorAnimal.setZIndex(cycleObject.zIndex);

	function animate(event) {
		var vectorContext = event.vectorContext;
		var frameState = event.frameState;
		var flashGeom =  feature.getGeometry();
		elapsed = frameState.time - start;
		var elapsedRatio = elapsed / cycleObject.duration;
		// radius will be 5 at start and 30 at end.
		var radius = ol.easing.easeOut(elapsedRatio) * 25 + 5;
		var opacity = ol.easing.easeOut(1 - elapsedRatio);

		var style = new ol.style.Style({
		  image: new ol.style.Circle({
			radius: radius,
			snapToPixel: false,
			stroke: new ol.style.Stroke({
			  color: 'rgba(255, 0, 0, ' + opacity + ')',
			  width: 1 + opacity
			}),

		  })
		})

	   vectorContext.setStyle(style);
	   vectorContext.drawGeometry(flashGeom);
	 if(parseFloat(opacity)<=0){
	   opacity =1;
	   start = new Date().getTime();
	   if(cycleObject.flagAniaml){
		 elapsed = frameState.time - start;
		 animate(event);
	   }
	 }

	if (elapsed > cycleObject.duration) {
	  return;
	 }
	 map.render();
  }
	
	  listenerKey = map.on('postcompose',animate);	 
	  cycleObject.cListenerKey = listenerKey ;
	  map.render();
      return cycleObject ;
}


/**
 * 设置标注点
 * @param {fjzx.map.Label} label
 */
fjzx.map.Marker.prototype.setLabel = function(label){
	var map = this.getMap();
	this._markerLabel = label;
	if(typeof(map)=="undefined" || map==null)
		map = this._map;
	this._markerLabel.setPosition(this.opt.position);
	map.addOverlay(this._markerLabel);
};

fjzx.map.Marker.prototype.getMarkerPoint = function(){
    return this._markerPoint;
}

fjzx.map.Marker.prototype.setTitle = function(title){
	this._markerElement.title = title;
	this.setElement(this._markerElement);
};

fjzx.map.Marker.prototype.setMarkerId = function(markerId){
	this._markerElement.id = markerId;
	this.setElement(this._markerElement);
};

fjzx.map.Marker.prototype.getMarkerId = function(){
    return this._markerId;
};

fjzx.map.Marker.prototype.setIcon = function(icon){
	if(this._isShowIcon){
		$(this._markerElement).find("img").attr("src",icon.getSrc());
		this.setElement(this._markerElement);
	}
};

fjzx.map.Marker.prototype.setAnimation = function(animation){
	//console.log("animation");
};

fjzx.map.Marker.prototype.setRotation = function(rotation){
	//console.log("rotation");
};

/**
 * 显示隐藏的标注点
 * @param title
 */
fjzx.map.Marker.prototype.show = function(){
	var className = "fjzx-map-marker-hide";
	//显示标注点
	fjzx.map.utils.removeClass(this._markerElement, className);
	this.setElement(this._markerElement);
	
	//显示标注点label
	var labelElement = this._markerLabel.getElement();
	fjzx.map.utils.removeClass(labelElement, className);
	this._markerLabel.setElement(labelElement);
};

/**
 * 隐藏标注点（没有从地图上移除）
 * @param title
 */
fjzx.map.Marker.prototype.hide = function(){
	var className = "fjzx-map-marker-hide";
	//隐藏标注点
	fjzx.map.utils.addClass(this._markerElement, className);
	this.setElement(this._markerElement);
	
	//隐藏标注点label
	var labelElement = this._markerLabel.getElement();
	fjzx.map.utils.addClass(labelElement, className);
	this._markerLabel.setElement(labelElement);
};

/**
 * 监听标注点点击事件
 * @param callback
 */
fjzx.map.Marker.prototype.addClick = function(callback){
	var this_ = this;

	$("div#"+this._markerId).click(function(){
		if(typeof(callback)=="function")
			callback(this_);
	});
};

/**
 * 弹出标注点信息框
 * @param {fjzx.map.InfoWindow} infoWindow
 */
fjzx.map.Marker.prototype.openInfoWindow = function(infoWindow){
	var map = this.getMap();
	if(typeof(map)=="undefined" || map==null)
		map = this._map;
	
	this._infoWindow = infoWindow;
	this._infoWindow.setPosition(this.opt.position);
	map.addOverlay(this._infoWindow);
	
	/**
	 * 显示的信息框被遮挡时自动重新设置地图中心点（通过计算出偏移量来实现）
	 */
	//标记点屏幕像素坐标
	var positionPixel = map.getPixelFromCoordinate(this.opt.position);
	var bounds = map.getBounds();
	var mapLeftTopPoint = bounds.getLeftTopPoint();
	var mapRightButtonPoint = bounds.getRightButtonPoint();
	
	if(!bounds.containsPoint(this.opt.position)){
		map.setCenter(this.opt.position);
		return;
	}
	
	//信息框宽高
	var element = this._infoWindow.getElement();
	var width = element.clientWidth;
	var height = element.clientHeight;
	
	//地图中心点经纬度坐标和屏幕像素坐标
	var center = map.getCenter();
	var centerPixel = map.getPixelFromCoordinate(center);
	
	//上边被挡住时
	if(height>(positionPixel[1] - mapLeftTopPoint[1])){
		//由于地图显示区上方可能有工具栏，所以偏移量多100px
		var offset = height - Math.abs(mapLeftTopPoint[1] - positionPixel[1]) + 100;
		centerPixel = [centerPixel[0], centerPixel[1]-offset];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	//下边被挡住时，由于统一显示在标注点上方，所以此种情况一般不会出现
	if((positionPixel[1])>mapRightButtonPoint[1]){
		var offset = positionPixel[1] - mapRightButtonPoint[1];
		centerPixel = [centerPixel[0]+offset, centerPixel[1]];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	//左边被挡住时
	if(width/5>(positionPixel[0] - mapLeftTopPoint[0])){
		//由于信息框统一显示在标注点上方偏右位置，所以正常情况下只有信息框部分被遮挡
		var offset = width/5 - Math.abs(positionPixel[0] - mapLeftTopPoint[0]);
		centerPixel = [centerPixel[0]-offset, centerPixel[1]];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	//右边被挡住时
	if(width>(mapRightButtonPoint[0]-positionPixel[0])){
		var offset = width - Math.abs(mapRightButtonPoint[0]-positionPixel[0]); 
		centerPixel = [centerPixel[0]+offset, centerPixel[1]];
		center = map.getCoordinateFromPixel(centerPixel);
	}
	map.setCenter(center);
};

/**
 * 弹出中心标注点信息框
 * @param {fjzx.map.InfoWindow} infoWindow
 */
fjzx.map.Marker.prototype.openInfoWindowWithPoint = function(infoWindow,point,offset){
	var map = this.getMap();
	if(typeof(map)=="undefined" || map==null)
		map = this._map;
	
	this._infoWindow = infoWindow;
	this._infoWindow.setPosition(point);

	var centerPixel = map.getPixelFromCoordinate(point);
	centerPixel = [centerPixel[0]+offset[0],centerPixel[1]+offset[1]];
	center = map.getCoordinateFromPixel(centerPixel);
	map.addOverlay(this._infoWindow);

	map.setCenter(center,false);
};

/**
 * 关闭标注点信息显示框
 */
fjzx.map.Marker.prototype.closeInfoWindow = function(){
	var map = this.getMap();
	if(typeof(map)=="undefined" || map==null)
		map = this._map;
	
	//this._infoWindow.setPosition(undefined);
	map.removeOverlay(this._infoWindow);
};

/**
 * 文字标注
 */
fjzx.map.Label = function(opt_options){
	var options = opt_options || {};
	
	this._labelId = options.labelId ? options.labelId : fjzx.map.utils.getUUID();
	this._markerId = options.markerId ? options.markerId : '';
	var content = options.content ? options.content : "文字标注";
	
	this._labelElement = document.createElement("div");
	this._labelElement.className = "fjzx-map-marker-label";
	this._labelElement.id=this._labelId;
	this._labelElement.setAttribute("markerId", this._markerId);
	this._labelElement.innerHTML=content;
	
	this.opt = {
		element: this._labelElement,
		position: options.position,
		offset: options.offset ? options.offset : [0,0],
		stopEvent: false
	};
	ol.Overlay.call(this, this.opt);
}

ol.inherits(fjzx.map.Label, ol.Overlay);

/**
 * 设置标注文字
 * @param {String}content 字符串或HTML字符串
 */
fjzx.map.Label.prototype.setContent = function(content){
	this._labelElement.innerText = content;
}

/**
 * 设置文字标注相对于标注点的偏移量
 * @param {Array}offset
 */
fjzx.map.Label.prototype.setOffset = function(offset){
	this.setOffset(offset);
}

/**
 * 设置文字标注点样式
 * @param {Object}opt_options
 */
fjzx.map.Label.prototype.setStyle = function(opt_options){
	var options = opt_options || {};
	var style = "";
	$.each(options,function(key,value){
		style += key + ": " + value + ";";
	});
	this._labelElement.setAttribute("style",style);
	
	this.setElement(this._labelElement);
};

/**
 * 地图信息框
 * @param opt_options
 * @returns {fjzx.map.InfoWindow}
 */
fjzx.map.InfoWindow = function(opt_options){
	var options = opt_options || {};
	
	this._containerElement = document.getElementById('infoWindow');
	this._contentElement = document.getElementById('infoWindow-content');
	this._closerElement = document.getElementById('infoWindow-closer');

	if(this._containerElement==null){
		this._containerElement = document.createElement("div");
		this._containerElement.id="infoWindow";
		this._containerElement.className = "fjzx-map-infoWindow";
		
		this._contentElement = document.createElement("div");
		this._contentElement.innerHTML = options.infoWindow;
		this._contentElement.id="infoWindow-content";
		
		this._closerElement = document.createElement("a");
		this._closerElement.setAttribute("href", "javascript:void(0)");
		this._closerElement.id="infoWindow-closer";
		this._closerElement.className="fjzx-map-infoWindow-closer";
		
		this._containerElement.appendChild(this._closerElement);
		this._containerElement.appendChild(this._contentElement);
	}else{
		this._contentElement.innerHTML = options.infoWindow;
	}
	
	var this_ = this;
	$(this._containerElement).find("a#infoWindow-closer").click(function(){
		this_.setPosition(undefined);
		$(this_.closer).blur();
		return false;
	});
	
	ol.Overlay.call(this,{
		element: this._containerElement,
		autoPan: true,
		autoPanAnimation: {
			duration: 250
		}
	});
};

ol.inherits(fjzx.map.InfoWindow, ol.Overlay);



fjzx.map.InfoWindowBlack = function(opt_options){
	var options = opt_options || {};
	
	this._containerElement = document.getElementById('infoWindow');
	this._contentElement = document.getElementById('infoWindow-content');
	this._closerElement = document.getElementById('infoWindow-closer');

	if(this._containerElement==null){
		this._containerElement = document.createElement("div");
		this._containerElement.id="infoWindow";
		this._containerElement.className = "fjzx-map-infoWindow baclk";
		
		this._contentElement = document.createElement("div");
		this._contentElement.innerHTML = options.infoWindow;
		this._contentElement.id="infoWindow-content";
		
		this._closerElement = document.createElement("a");
		this._closerElement.setAttribute("href", "javascript:void(0)");
		this._closerElement.id="infoWindow-closer";
		this._closerElement.className="fjzx-map-infoWindow-closer";
		
		this._containerElement.appendChild(this._closerElement);
		this._containerElement.appendChild(this._contentElement);
	}else{
		this._contentElement.innerHTML = options.infoWindow;
	}
	
	var this_ = this;
	$(this._containerElement).find("a#infoWindow-closer").click(function(){
		this_.setPosition(undefined);
		$(this_.closer).blur();
		return false;
	});
	
	ol.Overlay.call(this,{
		element: this._containerElement,
		autoPan: true,
		autoPanAnimation: {
			duration: 250
		}
	});
};

ol.inherits(fjzx.map.InfoWindowBlack, ol.Overlay);


/**
 * 设置地图信息弹出框内容
 * @param {String} content 可以为纯文字字符串，也可以是带HTML元素的字符串 
 */
fjzx.map.InfoWindow.prototype.setContent = function(content){
	this._contentElement.innerHtml=content;
};

/**
 * 地图信息框
 * @param opt_options
 * @returns {fjzx.map.InfoWindow}
 */
fjzx.map.AqiInfoWindow = function(opt_options){
	var options = opt_options || {};
	
	this._containerElement = document.getElementById('infoWindow');
	this._contentElement = document.getElementById('infoWindow-content');
	this._closerElement = document.getElementById('infoWindow-closer');
	if(this._containerElement==null){
		this._containerElement = document.createElement("div");
		this._containerElement.id="infoWindow";
		this._containerElement.className = "fjzx-map-infoWindow";
		
		this._contentElement = document.createElement("div");
		this._contentElement.innerHTML = options.infoWindow;
		this._contentElement.id="infoWindow-content";
		
		this._closerElement = document.createElement("a");
		this._closerElement.setAttribute("href", "javascript:void(0)");
		this._closerElement.id="infoWindow-closer";
		this._closerElement.className="fjzx-map-infoWindow-closer";
		
		this._containerElement.appendChild(this._closerElement);
		this._containerElement.appendChild(this._contentElement);
	}else{
		this._contentElement.innerHTML = options.infoWindow;
	}
	
	var this_ = this;
	$(this._containerElement).find("a#infoWindow-closer").click(function(){
		this_.setPosition(undefined);
		$(this_.closer).blur();
		return false;
	});
	
	ol.Overlay.call(this,{
		element: this._containerElement,
		autoPan: true,
		autoPanAnimation: {
			duration: 250
		}
	});
};

ol.inherits(fjzx.map.AqiInfoWindow, ol.Overlay);



/**
 * 地图绘制
 * @param opt_options
 * @returns {fjzx.map.Draw}
 */
fjzx.map.Draw = function(opt_options){
	var options = opt_options || {};
	this._map = options.map;
	this._pencilSize  =  options.pencilSize ? options.pencilSize : 3;
    this._pencilColor =  options.pencilColor ? options.pencilColor :'#00ACFF';
	this.isModify = options.interactionModify ? options.interactionModify : true;
	this._startCallback = options.startCallback ? options.startCallback : '';
	this._endCallback = options.endCallback ? options.endCallback : '';
	this._currentDrawType = '';
	this._featureData = {
		type:"",
		coordinates: [],
		layout: ""
	};
	//设置绘制所需的图层
	this.features = null;
    this._featureLayer = null;
    this.initFeatureLayer();
 
    var drawStyleDefaul = new ol.style.Style({
	    fill: new ol.style.Fill({
	      color: 'rgba(255, 255, 255, 0.2)'
	    }),
	    stroke: new ol.style.Stroke({
	      color:  this._pencilColor,
	      width:  this._pencilSize
	    }),
	    image: new ol.style.Circle({
	      radius: 7,
	      fill: new ol.style.Fill({
	        color:  this._pencilColor
	      })
	  }) });
	this.opt = {
		//clickTolerance: options.clickTolerance ? options.clickTolerance : undefined,	//鼠标单击时误差,默认为6px
		features: this.features,
		//source: options.source ? options.source : undefined,
		snapTolerance: options.snapTolerance ? options.snapTolerance : undefined,
		type: options.type ? options.type : 'Point',		//Point、LineString、Polygon、Circle/** @type {ol.geom.GeometryType} */ 
		maxPoints: options.maxPoints ? options.maxPoints : undefined,
		minPoints: options.minPoints ? options.minPoints : undefined,
		finishCondition: options.finishCondition ? options.finishCondition : undefined,	//用于绘制结束时的判断，返回false不结束绘制，返回true结束绘制
		//style: options.style ? options.style : '',
		geometryFunction: options.geometryFunction ? options.geometryFunction : undefined,	//当几何上的点有更新（修改）时调用的函数
		geometryName: options.geometryName ? options.geometryName : undefined,
		condition: options.condition ? options.condition : undefined,
		freehand: options.freehand ? options.freehand : undefined,
		freehandCondition: options.freehandCondition ? options.freehandCondition : undefined,
		wrapX: options.wrapX ? options.wrapX : undefined ,
		style :drawStyleDefaul 
				
	};
	//全局变量,使得后面能够移除
    this.draw;

	//鼠标经过所绘制的线条或点时会在其上出现相应的原点,此时按照鼠标左键便可更改所绘制的图像
    this._modifyInteraction;
}

/**
 * 设置所绘制画笔颜色画笔大小
 */
fjzx.map.Draw.prototype.setDrawStyle = function(pencilColor,pencilSize){
	 if(pencilColor == "undefined" || pencilColor == null || pencilColor ==""){
		 pencilColor = "#00ACFF";
	 }
	 if(pencilSize == "undefined" || pencilSize == null || pencilSize ==""){
		 pencilSize = 3;
	 } 
	  var drawStyleDefaul = new ol.style.Style({
		    fill: new ol.style.Fill({
		      color: 'rgba(255, 255, 255, 0.2)'
		    }),
		    stroke: new ol.style.Stroke({
		      color:  pencilColor,
		      width:  pencilSize
		    }),
		    image: new ol.style.Circle({
		      radius: 7,
		      fill: new ol.style.Fill({
		        color: pencilColor
		      })
		  }) });
    this._pencilSize = pencilSize;
	this._pencilColor = pencilColor;
	this.opt.style = drawStyleDefaul;
	this.initFeatureLayer();
}



/**
 * 设置所绘制图像是否可更改
 */
fjzx.map.Draw.prototype.setInteractonModify = function(){
	var map = this._map;
	this._modifyInteraction = new ol.interaction.Modify({
      features: this.features,
      //按住SHIF键+鼠标左键:取消更改绘制的图像
      deleteCondition: function(event) {
        return ol.events.condition.shiftKeyOnly(event) && ol.events.condition.singleClick(event);
      }
    });
	
    this._map.addInteraction(this._modifyInteraction);
}

/**
 * 开始绘图
 */

fjzx.map.Draw.prototype.startDraw = function(type,pencialColor,pencialSize){
	var type = type ? type : 'Point';
	var flag = fjzx.map.utils.hasDrawType(type); //判断是会否包含（  Point  LineString  Polygon  Circle ）
	if(flag){
		//当再次点击相同的绘图类型时相当于取消绘图操作
		if(this._currentDrawType === type){
			this.stopDraw();
			this._currentDrawType = '';
			return;
		}
		this._currentDrawType = type;
		
		if(this.isModify)
			this.setInteractonModify();
		
		this.opt.type = type;
	    this.setDrawStyle(pencialColor,pencialSize);

		this.draw = new ol.interaction.Draw(this.opt);
	
		this._map.addLayer(this._featureLayer);
	    this._map.addInteraction(this.draw);
	    this.setOnStartListener(this._startCallback);
	    this.setOnEndListener(this._endCallback);
	}else{
		console.log("请正确选择所画图形!");
	}
}

/**
 * 停止绘图并清空图形
 */
fjzx.map.Draw.prototype.stopDraw = function(callback){
    var this_ = this;
	if(typeof (this.draw) == 'undefined') return ;
    this.draw.on('drawend',function(evt){
    	if(typeof(callback)=='function'){
    		callback(evt);
    	}else if(typeof(this_._endCallback)=='function'){
    		this_._endCallback(evt);
    	}
    });
	this.clearDraw();
}

/**
 * 停止绘图并 保存  图形
 */
fjzx.map.Draw.prototype.stopDrawSaveFeature = function(callback){
	var this_ = this;

	if(typeof(this.draw) == 'undefined') return ;
	this.draw.on('drawend',function(evt){
		if(typeof(callback)=='function'){
			callback(evt);
		}else if(typeof(this_._endCallback)=='function'){
			this_._endCallback(evt);
		}
	});

	if(this._modifyInteraction!=null){
		this._map.removeInteraction(this._modifyInteraction);
	}
	if(this.draw!=null){
		this._map.removeInteraction(this.draw);
	}

}



/**
 * 绑定开始绘制事件
 */
var drawState = null ;
fjzx.map.Draw.prototype.setOnStartListener = function(callback){
	this.draw.un('drawstart');
	drawState = "drawing";
	var this_ = this;
	this.draw.on('drawstart',function(evt){
    	if(typeof(this_._startCallback)=='function'){
    		this_._startCallback(evt);
    	}
    });
}

/**
 * 绑定结束绘制事件
 */
fjzx.map.Draw.prototype.setOnEndListener = function(callback){
	var type = this._currentDrawType;	//POINT、LINESTRING、POLYGON、CIRCLE
	this._endCallback = callback;
	
	this.draw.un('drawend');
	var this_ = this;
	this.draw.on('drawend',function(evt){
    	var feature = evt.feature;
    	var geometry = feature.getGeometry();

    	//将圆形转换为多边形
    	var geometryData = {};
    	if(type.toUpperCase()=='CIRCLE'){
			var sides = 100;
			var angle = 0;
			type='Polygon';
			geometry = new ol.geom.Polygon.fromCircle(geometry,sides,angle);
    	}
    	
    	var coors = geometry.getCoordinates();
    	/*
    	 * 当绘制的图形为线段（LineString）时，数组coors中的元素就是所绘制图形的坐标点集
    	 * 当绘制的图形为非线段（Polygon、Circle等）时，数组coors中的元素是所绘图形集合，而非所绘图形的坐标点集
    	*/
     
    	var coordinates = 'LineString'===type || 'Point'===type  ? coors : coors[0];
    	
    	this_._featureData.type=type;
    	this_._featureData.coordinates.push(coordinates);
    	this_._featureData.layout=geometry.getLayout();
    	
    	if(typeof(this_._endCallback)=='function'){
    		this_._endCallback(this_._featureData);
    	}
    	drawState = "reading";
    });
	this._currentDrawType = '';
}

/**
 * 清空绘图
 */
fjzx.map.Draw.prototype.clearDraw = function(callback){
	if(this._featureLayer!=null){
		this._map.removeLayer(this._featureLayer);
	}
	if(this._modifyInteraction!=null){
	    this._map.removeInteraction(this._modifyInteraction);
	}
    if(this.draw!=null){
    	this._map.removeInteraction(this.draw);
    }
    this.initFeatureLayer();

    this._currentDrawType = '';
    this._featureData = {
		type:"",
		coordinates: [],
		layout: ""
    };
    
    
    if(typeof(callback)=='function'){
    	callback(this);
    }
    this._map.render();
  
}

/**
 *  清空绘画图形 重新初始化
 */
var touchFlag = true ;
fjzx.map.Draw.prototype.clearDrawLayer = function(){

	this._featureData = {
			type:"",
			coordinates: [],
			layout: ""
	    };
   if(touchFlag){
		   touchFlag= false;
	var source = this._featureLayer.getSource();
    source.clear();
 
    this._map.render();
    touchFlag= true;
	   }
}


fjzx.map.Draw.prototype.clearDrawFeature = function(callback){
	 
	   this._map.render();
}

/**
 * 初始化绘制用图层
 */
fjzx.map.Draw.prototype.initFeatureLayer = function(){
	if(this._featureLayer==null){	//this._featureLayer为null时需实例化一个Layer对象
		this.features = new ol.Collection();
		this._featureLayer = new ol.layer.Vector({
	      source: new ol.source.Vector({features: this.features}),
	      style: new ol.style.Style({
	        fill: new ol.style.Fill({
	          color: 'rgba(0, 255, 0, 0.2)'
	        }),
	        stroke: new ol.style.Stroke({
        	  color: this._pencilColor,
	          width: this._pencilSize
	        }),
	        image: new ol.style.Circle({
	          radius: 7,
	          fill: new ol.style.Fill({
        	  color: '#1A1364',
	          })
	        })
	      }),
	      zIndex: 100
	    });
    }else{	//当this._featureLayer对象存在时，需要清空对应的ol.source.Vector对象
       
    	source = this._featureLayer.getSource();
    	source.clear();
    	this._featureLayer.setStyle(new ol.style.Style({
	        fill: new ol.style.Fill({
		          color: 'rgba(0, 255, 0, 0.2)'
		        }),
		        stroke: new ol.style.Stroke({
	        	  color: this._pencilColor,
		          width:  this._pencilSize
		        }),
		        image: new ol.style.Circle({
		          radius: 7,
		          fill: new ol.style.Fill({
	        	  color: this._pencilColor,
		          })
		        })
		      }));
    	this._featureLayer.setSource(source);
    }
}

/**
 * 获取当前所绘制网格的数据(经纬度、形状等)
 */
fjzx.map.Draw.prototype.getFeatureData = function(){
	return this._featureData;
}

/**
 * 地图图层切换控件
 * @param opt_options
 * @constructor
 */
fjzx.map.LayerSwitcher = function(opt_options){
    var options = opt_options || {};
    var tipLabel = options.tipLabel ?
        options.tipLabel : 'Legend';
    this.mapListeners = [];
    this.hiddenClassName = 'ol-unselectable ol-control layer-switcher';
    if (fjzx.map.LayerSwitcher.isTouchDevice_()) {
        this.hiddenClassName += ' touch';
    }
    this.shownClassName = 'shown';
    var element = document.createElement('div');
    element.className = this.hiddenClassName;
    var button = document.createElement('button');
    button.setAttribute('title', tipLabel);
    element.appendChild(button);
    this.panel = document.createElement('div');
    this.panel.className = 'panel';
    element.appendChild(this.panel);
    fjzx.map.LayerSwitcher.enableTouchScroll_(this.panel);
    var this_ = this;
    button.onmouseover = function(e) {
        this_.showPanel();
    };
    button.onclick = function(e) {
        e = e || window.event;
        this_.showPanel();
        e.preventDefault();
    };
    this_.panel.onmouseout = function(e) {
        e = e || window.event;
        if (!this_.panel.contains(e.toElement || e.relatedTarget)) {
            this_.hidePanel();
        }
    };
    ol.control.Control.call(this, {
        element: element,
        target: options.target
    });
}
ol.inherits(fjzx.map.LayerSwitcher, ol.control.Control)

/**
 * 地图形状特征对象（如地图上绘制的各种几何图形等）
 * @param {object}opt_options
 * @returns {fjzx.map.Feature}
 */
fjzx.map.Feature = function(opt_options){
	var options = opt_options || {};
	
	this.opt = {
		"type": "Feature",
		"id": options.id ? options.id : '',
		"name": options.name ? options.name : '',
		"geometry": options.geometry ? options.geometry : {},
		"labelPoint": options.labelPoint ? options.labelPoint : new fjzx.map.Point(),
		"properties": options.properties ? options.properties : {}
	};

	ol.Feature.call(this,this.opt);
}

ol.inherits(fjzx.map.Feature, ol.Feature);


/**
 * 根据GeoJSON格式数据在地图上绘制图形（地图网格化）
 * @param opt_options
 * @returns {fjzx.map.DrawGeoJSON}
 */
fjzx.map.DrawGeoJSON = function(opt_options) {
	var options = opt_options || {};
	this._translateInteraction = null;
 
	this.modifyInteraction = null;
	this._markerList = [];
	this._markerLabelList = [];

	this._currentSelectedFeatureData = {};
	this._selectedFeatureData = new fjzx.map.HashMap();
	this._layerGroup = opt_options.layerGroup;
	this._zIndex = options.zIndex ? options.zIndex : 9999 ;
	this._pencilColor= options.pencilColor ? options.pencilColor : "#00ACFF" ;
	this._pencilSize=  options.pencilSize ?  options.pencilSize :3 ;
	this._map = options.map;
	this.geoJSON = options.geoJSON ? options.geoJSON : {};
	this._selectType = options.selectType ? options.selectType : 'click';
	this._customType = options.customType ? options.customType :'';   // 自定义类型标识
	this._title = options.title ? options.title :'图层';   // 添加图层名称
	this._selectCallback = options.selectCallback;
	
	//图块交互
	if(options.selectType!=null && options.selectType != '' && typeof(options.selectType)!='undefined'){
	    this.setSelectType(this._selectType);

	}
};

fjzx.map.DrawGeoJSON.prototype.setGeoJSON = function(geoJSON){
	this.geoJSON = geoJSON;
};
fjzx.map.DrawGeoJSON.prototype.getGeoJSON = function(){
	return this.geoJSON;
};

 
fjzx.map.DrawGeoJSON.prototype.clearGeoJSON = function(){
	var map = this._map;
	var selectLayer = this._selectLayer;
	var markerList = this._markerList;
	var markerLabelList = this._markerLabelList;
 
	map.removeLayer(selectLayer);
	markerList.forEach(function(value,index){
		map.removeOverlay(value);
	});
	markerLabelList.forEach(function(value,index){
		map.removeOverlay(value);
	});
 
    
	this._selectLayer = null;
	this._markerList = [];
	this._markerLabelList = [];
};

/**
 * 设置图块选中时的回调函数
 * @param {function} callback
 */
fjzx.map.DrawGeoJSON.prototype.setSelectAction = function(callback){
	var map = this._map;
	var selectLayer = this._selectLayer;
	var selectInteraction = map.getSelectInteraction();
	if(selectInteraction)
		selectInteraction.un('select');
	selectInteraction.on('select',function(e){
		if(typeof(callback)=='function'){
			callback(e,selectInteraction);
		}
	});
		
};

/**
 * 设置图块鼠标单击监听事件
 * @param {function} callback
 */
fjzx.map.DrawGeoJSON.prototype.setFeatureClick = function(callback){
	var map = this._map;
	var selectLayer = this._selectLayer;
	var selectInteraction = map.getSelectInteraction();
	selectInteraction.un('click');
	selectInteraction.on('click',function(e){
		if(typeof(callback)=='function'){
			callback(e);
		}
	});
};

/**
 * 设置图块选中时的回调函数
 * @param {function} callback
 */
fjzx.map.DrawGeoJSON.prototype.setUnSelectAction = function(callback){
	var map = this._map;
	var selectLayer = this._selectLayer;
	var selectInteraction = map.getSelectInteraction();
	if(selectInteraction)
		selectInteraction.un('select');		
};


/**
 * 设置图块鼠标单击监听事件
 * @param {function} callback
 */
fjzx.map.DrawGeoJSON.prototype.setUnFeatureClick = function(callback){
	var map = this._map;
	var selectLayer = this._selectLayer;
	var selectInteraction = map.getSelectInteraction();
	if(selectInteraction)
		selectInteraction.un('click');
	 
};


/**
 * 设置地图图块选择方式(鼠标单击选中、鼠标经过选中等)
 * @param {String} selectType
 */
fjzx.map.DrawGeoJSON.prototype.setSelectType = function(selectType){
	var map = this._map;
	var selectInteraction=null;
	if (map.getSelectInteraction() !== null) {
			map.removeInteraction(map.getSelectInteraction());
	 }
	switch (selectType.toUpperCase()) {
	case 'CLICK':	// 普通单击（双击时选中图块且放大地图）
		 selectInteraction = new ol.interaction.Select({
			   condition: ol.events.condition.click
		    }); 
		break;
	case 'SINGLECLICK':	// 单击选中（双击时只放大地图而不选中图块）
		selectInteraction = new ol.interaction.Select({
			condition: ol.events.condition.singleClick
		}) 
		break;	
	case 'HOVER':	//鼠标经过选中
		selectInteraction = new ol.interaction.Select({
			condition: ol.events.condition.pointerMove
		});
		break;
	case 'ALTCLICK':	//Alt+鼠标单击选中
		selectInteraction = new ol.interaction.Select({
			condition: function(mapBrowserEvent) {
				return ol.events.condition.click(mapBrowserEvent) &&
				ol.events.condition.altKeyOnly(mapBrowserEvent);
			}
		});
		break;
	default:
		selectInteraction = new ol.interaction.Select({
			 condition: ol.events.condition.click
		});
		break;
	}
	
	this._selectType = selectType;
	if(selectInteraction!=null){
        selectInteraction.set("name",this._customType);
        map.setSelectInteraction(selectInteraction);
	    map.addInteraction(selectInteraction);
	}
 
}

 

/**
 * 根据传入的GeoJSON参数重新加载图层
 * @param {Object}list
 */
 function styleFunction(feature) {
	var myStyle = null ;
	var image = new ol.style.Circle({
        radius: 7,
        fill:  new ol.style.Fill({
            color :'rgba(0,0,255,1)'
        }),
        stroke: new ol.style.Stroke({color: 'blue', width: 1})
    });

    var name = feature.get('name');
    var pColor = feature.get('color');
    var strokeColor = feature.get('strokeColor');
    var strokeWidth = feature.get('strokeWidth');
    //var pColor = 'rgba(45,183,245, 1)';
    var pcolorRgba = fjzx.map.utils.colorRgb(pColor,0.6);
    var pSize = feature.get('psize');
    var textFill = new ol.style.Fill({
      color: '#EEB422'
    });
    var textStroke = new ol.style.Stroke({
      color: 'rgba(0, 0, 0, 0.6)',
      width: 3
    });
    var earthquakeStroke = new ol.style.Stroke({
        color: 'rgba(255, 111, 222, 0.2)',
        width: 1
    });
    myStyle = new ol.style.Style({
        fill: new ol.style.Fill({
          color: pcolorRgba
        }),
        stroke: new ol.style.Stroke({
          color: strokeColor,
          width: strokeWidth
        }),
        text: new ol.style.Text({
            text: name.toString(),    //必须传字符串
            fill: textFill,
            stroke: textStroke,
        }),
        opacity: 1,
        image: image
    });
  return myStyle;
}
fjzx.map.DrawGeoJSON.prototype.load = function(list){
	this.clearGeoJSON();
	var map = this._map;
	var selectLayer = this._selectLayer;
	var markerList = this._markerList;
	var markerLabelList = this._markerLabelList;
	this.list = list;
	var geoJSON = {
		type: 'FeatureCollection',
		features:[],
		resultFeature:[]
	};
 
	var source = new ol.source.Vector();
	var this_ = this;
	var opacity = 1;

    if(list!="" && list!=null && typeof(list)!= "undefined"){
        list.forEach(function(value, index,array){	
            opacity = JSON.parse(value.feature).opacity?JSON.parse(value.feature).opacity :"1";
            if(opacity == "undefined"){
                opacity = 1;
            }
            
			var name = value.name;
			var id = value.id;
			if(value.feature =="" || typeof(value.feature) == 'undefined'){
				return;
			}
			var geometryData = JSON.parse(value.feature);
 
			var geometry = fjzx.map.utils.transformGeometry(geometryData);
			
			if(geometry==null)
				return;
			var feature = new ol.Feature({
				name  : name,
				geometry: geometry
			});
			
			feature.setId(id)
 
			var pColor = JSON.parse(value.feature).pencilColor?JSON.parse(value.feature).pencilColor :"#0000FF";
			 
			if(pColor == "undefined"){
				pColor ="#00ACFF";
			}
			var strokeColor = JSON.parse(value.feature).strokeColor;
            if(strokeColor == undefined){
                strokeColor = pColor;
            }
            var strokeWidth = JSON.parse(value.feature).strokeWidth;
            if(strokeWidth == undefined){
                strokeWidth = 2;
            }
			var pSize = JSON.parse(value.feature).pencilSize?JSON.parse(value.feature).pencilSize :3;
			if(pSize == "undefined"){
				pSize = 3;
			}
			var typeString = JSON.parse(value.feature).typeString?JSON.parse(value.feature).typeString :"";
			if(typeString == "undefined"){
				typeString = "";
			}
			feature.set("psize",pSize);
			feature.set("color",pColor);
			feature.set("strokeColor",strokeColor);
			feature.set("strokeWidth",strokeWidth);
			feature.set("typeString",typeString);
			geoJSON.resultFeature[index] = feature;
			source.addFeature(feature);
			 
			var obj = fjzx.map.utils.formatGeoJSON(value);
			geoJSON.features[index] = obj;
	        
			var geometry = obj.geometry;
			var coordinates = geometry.coordinates;
			var type = geometry.type;
			var geom ;
			var result;
			var centerPoint ;
			 
			geom = fjzx.map.utils.transformGeometry({type:type,coordinates:coordinates,layout: 'xy'});
		 
			if(type != "LineString" && type != "MultiLineString"  && type != "Point"){
			      centerPoint = geom.getInteriorPoint().getCoordinates();
			}
			else if(type == "Point"){
				  centerPoint= geom.getCoordinates();
			}
			else{
				 var point = new fjzx.map.Point(coordinates[0][0][0],coordinates[0][0][1]);
			     centerPoint =point;
			}
		});
	}
    this.geoJSON = geoJSON;
	this._selectLayer = new ol.layer.Vector({
		title: this._title,
		customType : this._customType,
		source: source ,
		style :styleFunction,
		opacity:opacity,
		transparent: false
	});
	this.geoJSON = geoJSON;
 
	this._selectLayer.setZIndex(this._zIndex);
   
   /**
	 * 如果外界传入图层集合 则以该图层集合 进行显示方便分层管理 或者自动加入地图进行显示
	 */
	 if(this._layerGroup != null && this._layerGroup!='' && typeof(this._layerGroup)!='undefined'){
		  var layers = this._layerGroup.getLayers().getArray(); 
		  var flag = false ;
		  var tempLayer = null ;
		  for(var i = 0 ; i <layers.length;i++){
		    if( layers[i].get("customType") == this._customType){
				 flag = true ;
				 tempLayer = layers[i];
			 }
		  }  
		  if(flag && tempLayer!=null){
			  tempLayer.setSource(source);
		  }else{ 
			  this._layerGroup.getLayers().push(this._selectLayer);
		  }
	}else{
		this._map.addLayer(this._selectLayer)
	} 
	this._map.render();
	
};

/**
 * 重新加载图层
 */
fjzx.map.DrawGeoJSON.prototype.reload = function(){
	this.clearGeoJSON();
	
	var map = this._map;
	var selectLayer = this._selectLayer;
	var geoJSON = this.geoJSON;
	var list = this.list;

    var source = new ol.source.Vector();
    var this_ = this;
    var opacity = 1;
    if(list!="" && list!=null && typeof(list)!= "undefined"){
        list.forEach(function(value, index,array){
            opacity = JSON.parse(value.feature).opacity?JSON.parse(value.feature).opacity :"1";
            if(opacity == "undefined"){
                opacity = 1;
            }

            var name = value.name;
            var id = value.id;
            if(value.feature =="" || typeof(value.feature) == 'undefined'){
                return;
            }
            var geometryData = JSON.parse(value.feature);

            var geometry = fjzx.map.utils.transformGeometry(geometryData);

            if(geometry==null)
                return;
            var feature = new ol.Feature({
                name  : name,
                geometry: geometry
            });

            feature.setId(id)

            var pColor = JSON.parse(value.feature).pencilColor?JSON.parse(value.feature).pencilColor :"#0000FF";

            if(pColor == "undefined"){
                pColor ="#00ACFF";
            }
            var strokeColor = JSON.parse(value.feature).strokeColor;
            if(strokeColor == undefined){
                strokeColor = pColor;
            }
            var strokeWidth = JSON.parse(value.feature).strokeWidth;
            if(strokeWidth == undefined){
                strokeWidth = 2;
            }
            var pSize = JSON.parse(value.feature).pencilSize?JSON.parse(value.feature).pencilSize :3;
            if(pSize == "undefined"){
                pSize = 3;
            }
            var typeString = JSON.parse(value.feature).typeString?JSON.parse(value.feature).typeString :"";
            if(typeString == "undefined"){
                typeString = "";
            }
            feature.set("psize",pSize);
            feature.set("color",pColor);
            feature.set("strokeColor",strokeColor);
            feature.set("strokeWidth",strokeWidth);
            feature.set("typeString",typeString);
            geoJSON.resultFeature[index] = feature;
            source.addFeature(feature);

            var obj = fjzx.map.utils.formatGeoJSON(value);
            geoJSON.features[index] = obj;

            var geometry = obj.geometry;
            var coordinates = geometry.coordinates;
            var type = geometry.type;
            var geom ;
            var result;
            var centerPoint ;

            geom = fjzx.map.utils.transformGeometry({type:type,coordinates:coordinates,layout: 'xy'});

            if(type != "LineString" && type != "MultiLineString"  && type != "Point"){
                centerPoint = geom.getInteriorPoint().getCoordinates();
            }
            else if(type == "Point"){
                centerPoint= geom.getCoordinates();
            }
            else{
                var point = new fjzx.map.Point(coordinates[0][0][0],coordinates[0][0][1]);
                centerPoint =point;
            }
        });
    }
    this._selectLayer = new ol.layer.Vector({
        title: this._title,
        customType : this._customType,
        source: source ,
        style :styleFunction,
        opacity:opacity,
        transparent: false
    });

	this._map.addLayer(this._selectLayer);
}

/**
 * 设置区域颜色为空白
 */
fjzx.map.DrawGeoJSON.prototype.setAreaNoColor = function(){
    this.clearGeoJSON();
    
    var map = this._map;
    var selectLayer = this._selectLayer;
    var geoJSON = this.geoJSON;
    var list = this.list;

    var source = new ol.source.Vector();
    var this_ = this;
    var opacity = 1;
    if(list!="" && list!=null && typeof(list)!= "undefined"){
        list.forEach(function(value, index,array){
            opacity = JSON.parse(value.feature).opacity?JSON.parse(value.feature).opacity :"1";
            if(opacity == "undefined"){
                opacity = 1;
            }

            var name = value.name;
            var id = value.id;
            if(value.feature =="" || typeof(value.feature) == 'undefined'){
                return;
            }
            var geometryData = JSON.parse(value.feature);

            var geometry = fjzx.map.utils.transformGeometry(geometryData);

            if(geometry==null)
                return;
            var feature = new ol.Feature({
                name  : name,
                geometry: geometry
            });

            feature.setId(id)

            var pColor = JSON.parse(value.feature).pencilColor?JSON.parse(value.feature).pencilColor :"#0000FF";

            if(pColor == "undefined"){
                pColor ="#00ACFF";
            }
            var strokeColor = JSON.parse(value.feature).strokeColor;
            if(strokeColor == undefined){
                strokeColor = pColor;
            }
            var strokeWidth = JSON.parse(value.feature).strokeWidth;
            if(strokeWidth == undefined){
                strokeWidth = 2;
            }
            var pSize = JSON.parse(value.feature).pencilSize?JSON.parse(value.feature).pencilSize :3;
            if(pSize == "undefined"){
                pSize = 3;
            }
            var typeString = JSON.parse(value.feature).typeString?JSON.parse(value.feature).typeString :"";
            if(typeString == "undefined"){
                typeString = "";
            }
            feature.set("psize",pSize);
            feature.set("color","#f7f7f5");
            feature.set("strokeColor",strokeColor);
            feature.set("strokeWidth",strokeWidth);
            feature.set("typeString",typeString);
            geoJSON.resultFeature[index] = feature;
            source.addFeature(feature);

            var obj = fjzx.map.utils.formatGeoJSON(value);
            geoJSON.features[index] = obj;

            var geometry = obj.geometry;
            var coordinates = geometry.coordinates;
            var type = geometry.type;
            var geom ;
            var result;
            var centerPoint ;

            geom = fjzx.map.utils.transformGeometry({type:type,coordinates:coordinates,layout: 'xy'});

            if(type != "LineString" && type != "MultiLineString"  && type != "Point"){
                centerPoint = geom.getInteriorPoint().getCoordinates();
            }
            else if(type == "Point"){
                centerPoint= geom.getCoordinates();
            }
            else{
                var point = new fjzx.map.Point(coordinates[0][0][0],coordinates[0][0][1]);
                centerPoint =point;
            }
        });
    }
    this._selectLayer = new ol.layer.Vector({
        title: this._title,
        customType : this._customType,
        source: source ,
        style :styleFunction,
        opacity:opacity,
        transparent: false
    });
    
    this._map.addLayer(this._selectLayer);
}

/**
 * 打开修改地图网格功能
 */
fjzx.map.DrawGeoJSON.prototype.openModifyFeature = function(opt_options){
	var options = opt_options || {};
	
	var map = this._map;
	var modifyStartCallback = options.modifyStartCallback;
	var modifyEndCallback = options.modifyEndCallback;
	
 	this.setSelectType('click');//必须在重新实例化ol.interaction.Modify前调用
	this.modifyInteraction = new ol.interaction.Modify({
		features: map.getSelectInteraction().getFeatures(),
		condition: undefined,
		deleteCondition: undefined,
		insertVertexCondition: undefined,
		pixelTolerance: undefined,
		style: undefined,
		wrapX: false
    });
	//监听修改开始事件
	this._selectedFeatureData = new fjzx.map.HashMap();
	var this_ = this;
	this.modifyInteraction.on('modifystart',function(evt){
		var features = evt.features;
		var featureArray = features.getArray();
		var feature = featureArray[0];
		var featureId = feature.getId();
		var geometry = feature.getGeometry();
    	var geometryData = {};
    	geometryData = {
			featureId: featureId,
			type: geometry.getType(),
			coordinates: geometry.getCoordinates(),
			layout: geometry.getLayout(),
			typeString:feature.get('typeString')
		}
     
    	if(typeof(featureId)!="undefined"){
    		this_._selectedFeatureData.put(featureId, geometryData);
    	}
    		
    	
		if(typeof(modifyStartCallback)=='function')
			modifyStartCallback(this_._selectedFeatureData);
	});
	//监听修改结束事件
	this.modifyInteraction.on('modifyend',function(evt){
		var features = evt.features;
		var featureArray = features.getArray();
		var feature = featureArray[0];
		var featureId = feature.getId();
		var geometry = feature.getGeometry();
		
    	var geometryData = {};
    	geometryData = {
			featureId: featureId,
			type: geometry.getType(),
			coordinates: geometry.getCoordinates(),
			layout: geometry.getLayout(),
			typeString:feature.get('typeString')
		}
    	
    	if(typeof(featureId)!="undefined"){
    		this_._selectedFeatureData.put(featureId, geometryData);
    	}

		if(typeof(modifyEndCallback)=='function'){
			modifyEndCallback(this_._selectedFeatureData);
		}
	});
	
	map.removeInteraction(this.modifyInteraction);
	map.addInteraction(this.modifyInteraction);
}

/**
 * 关闭修改地图网格功能
 */
fjzx.map.DrawGeoJSON.prototype.closeModifyFeature = function(){
	var map = this._map;
	
	var modifyInteraction = this.modifyInteraction;
	map.removeInteraction(modifyInteraction);
   //清除选中图形
	var selectedFeatures = map.getSelectInteraction().getFeatures(); 
	selectedFeatures.clear();
	 
	this._selectedFeatureData = null;
	return modifyInteraction;
}

/**
 * 打开图块移动功能
 */
fjzx.map.DrawGeoJSON.prototype.openTranslateFeature = function(opt_options){
	var options = opt_options ||{};
	
	var map = this._map;
	var translateStartCallback = options.translateStartCallback;
	var translateEndCallback = options.translateEndCallback;
	var translatingCallback = options.translatingCallback;
	
	//重新实例化一个对象
	this._translateInteraction = new ol.interaction.Translate({
        features: map.getSelectInteraction().getFeatures(),
        hitTolerance:0
    });
	
	//添加监听事件
	//开始
	this._translateInteraction.on('translatestart',function(evt){
		if(typeof(translateStartCallback)=='function'){
			translateStartCallback(evt);
		}
	});
	//结束
	var this_ = this;
	this._translateInteraction.on('translateend',function(evt){
		var features = evt.features;
		var featureArray = features.getArray();
		var feature = featureArray[0];
		var featureId = feature.getId();
		var geometry = feature.getGeometry();
		
    	var geometryData = {};
    	geometryData = {
			featureId: featureId,
			type: geometry.getType(),
			coordinates: geometry.getCoordinates(),
			layout: geometry.getLayout()
		}
    	 
    	if(typeof(featureId)!="undefined"){
    		this_._selectedFeatureData.put(featureId, geometryData);
    	}
    	
		if(typeof(translateEndCallback)=='function'){
			translateEndCallback(evt);
		}
	});
	//进行中
	this._translateInteraction.on('translating',function(evt){
		if(typeof(translatingCallback)=='function'){
			translatingCallback(evt);
		}
	});

	map.removeInteraction(this._translateInteraction);
	map.addInteraction(this._translateInteraction);
}

/**
 * 关闭图块移动功能
 */
fjzx.map.DrawGeoJSON.prototype.closeTranslateFeature = function(){
	var map = this._map;
	var translateInteraction = this._translateInteraction
	
	map.removeInteraction(translateInteraction);
	return translateInteraction;
}

fjzx.map.DrawGeoJSON.prototype.getSelectedFeatureData = function(){
	return this._selectedFeatureData;
}

/**
 * 标注点动画（类似路书）
 * @param map
 * @param points
 * @param opt_options
 * @returns {fjzx.map.MarkerAnimate}
 */
fjzx.map.MarkerAnimate = function(map,points,opt_options){
	var options = opt_options || {};
	
	this._map = map;
	
	this._speed = options.speed;
	this._animating = false;

	this._routeLayer = null;	//路书图层
	this._markerStart = null;	//路书起点
	this._markerEnd = null;		//路书终点
	
	//根据传入的点生成路线
	var polylineGeometry = new ol.geom.LineString(points);
	this._routeCoords = polylineGeometry.getCoordinates();
	this._routeLength = this._routeCoords.length;

	if(this._marker){
		map.removeOverlay(this._marker);
	}
	this._marker = new fjzx.map.Marker(this._routeCoords[0], {
		icon: options.icon 
	});
	map.addOverlay(this._marker);
	
	var routeFeature = new ol.Feature({
	  type: 'route',
	  geometry: polylineGeometry
	});
	this._routeLayer = new ol.layer.Vector({
	  source: new ol.source.Vector({
	    features: [routeFeature]
	  }),
	  style: new ol.style.Style({
		  stroke: new ol.style.Stroke({
			  width: options.width ? options.width : 6, 
			  color: options.color ? options.color : [237, 212, 0, 0.8]
		  })
	  })
	});
	this._map.addLayer(this._routeLayer);
}

/**
 * 设置移动标注点
 * @param {fjzx.map.Point}point
 * @param {fjzx.map.Icon}icon
 */
fjzx.map.MarkerAnimate.prototype.setMarker = function(point,icon){
	var map = this._map;
	if(this._marker){
		map.removeOverlay(this._marker); 
	}
	this._marker = new fjzx.map.Marker(point, {
		icon: icon 
     });
	
	map.addOverlay(this._marker); 
}

/**
 * 设置路书起点
 * @param {fjzx.map.Point}point
 * @param {fjzx.map.Icon}icon
 */
fjzx.map.MarkerAnimate.prototype.setMarkerStart = function(point,icon){
	var map = this._map;
	if(this._markerStart){
		map.removeOverlay(this._markerStart); 
	}
	this._markerStart = new fjzx.map.Marker(point, {
		icon: icon 
     });
	
	map.addOverlay(this._markerStart); 
}

/**
 * 设置路书终点
 * @param {fjzx.map.Point}point
 * @param {fjzx.map.Icon}icon
 */
fjzx.map.MarkerAnimate.prototype.setMarkerEnd = function(point,icon){
	var map = this._map;
	if(this._markerEnd){
		map.removeOverlay(this._markerEnd); 
	}
	this._markerEnd = new fjzx.map.Marker(point, {
		icon: icon 
     });
	
	map.addOverlay(this._markerEnd); // 将标注添加到地图中
}

/**
 * 设置路书路线
 * @param{Array<fjzx.map.Point>}points
 * @param {Object}opt_options
 */
fjzx.map.MarkerAnimate.prototype.setPolyline = function(points,opt_options){
	var options = opt_options || {};
	
	var map = this._map;
	
	var lineStringGeometry = new ol.geom.LineString(points);
	var routeFeature = new ol.Feature({
	  type: 'route',
	  geometry: lineStringGeometry
	});
	
	this._routeLayer = new ol.layer.Vector({
	  source: new ol.source.Vector({
	    features: [routeFeature]
	  }),
	  style: new ol.style.Style({
		  stroke: new ol.style.Stroke({
			  width: options.width ? options.width : 6,
			  color: options.color ? options.color : [237, 212, 0, 0.8]
		  })
	  })
	});
	
	if(this._routeLayer){
		this._map.removeLayer(this._routeLayer);
	}
	this._map.addLayer(this._routeLayer);
}

fjzx.map.MarkerAnimate.prototype.stopAnimation = function(ended){
	var map = this._map;
	this._animating = false;

    // 若动画被取消，则将标注点充值为起点位置
    var coord = ended ? this._routeCoords[this._routeLength - 1] : this._routeCoords[0];
    this._marker.setPosition(coord);
    //移除监听事件
    map.un('postcompose', this.moveFeature);
}

/**
 * 释放路书动画资源
 */
fjzx.map.MarkerAnimate.prototype.freeResource = function() {
    this.removeMarker();
    this.removeMarkerStart();
    this.removeMarkerEnd();
    this.removeRoute();
};

/**
 * 移除动画标注点
 */
fjzx.map.MarkerAnimate.prototype.removeMarker = function() {
	if (this._marker){
    	this._map.removeOverlay(this._marker);
    	this._marker = null;
    }
}

/**
 * 移除起点标注点
 */
fjzx.map.MarkerAnimate.prototype.removeMarkerStart = function() {
	if (this._markerStart){
        this._map.removeOverlay(this._markerStart);
    	this._markerStart = null;
    }
}

/**
 * 移除终点标注点
 */
fjzx.map.MarkerAnimate.prototype.removeMarkerEnd = function() {
	if (this._markerEnd){
        this._map.removeOverlay(this._markerEnd);
    	this._markerEnd = null;
	}
}

/**
 * 移除路书
 */
fjzx.map.MarkerAnimate.prototype.removeRoute = function() {
	if (this._routeLayer){
        this._map.removeLayer(this._routeLayer);
    	this._routeLayer = null;
    }
}

fjzx.map.MarkerAnimate.prototype.moveFeature = function(event) {
	var map = event.target;
	var vectorContext = event.vectorContext;
	var frameState = event.frameState;
	if (this._animating) {
		var elapsedTime = frameState.time - now;
		// here the trick to increase speed is to jump some indexes on lineString coordinates
		var index = Math.round(speed * elapsedTime / 1000);

		if (index >= this._routeLength) {
			this.stopAnimation(true);
			return;
		}

		var currentPoint = new ol.geom.Point(this._routeCoords[index]);
		this._marker.setPosition(this._routeCoords[index]);
	}
	// tell OpenLayers to continue the postcompose animation
	map.render();
};

/**
 * 增加路书路线（在原有路书基础上增加，不会覆盖）
 * @param {Array<fjzx.map.Point>}points
 */
fjzx.map.MarkerAnimate.prototype.addPolyline = function(points,callback) {
	var map = this._map;
	var routeLayer = this._routeLayer;

	var polylineGeometry = new ol.geom.LineString(points);
	var routeFeature = new ol.Feature({
	  type: 'route',
	  geometry: polylineGeometry
	});

	var source = routeLayer.getSource();
	source.addFeature(routeFeature);
	routeLayer.setSource(source);
	
	map.removeLayer(routeLayer);
	map.addLayer(routeLayer);
	
	// tell OpenLayers to continue the postcompose animation
	map.render();
	
	if(typeof(callback)=="function")
		callback();
};

/**
 * 设置路书样式（路线颜色、路线宽度）
 * @param {Object} opt_options
 */
fjzx.map.MarkerAnimate.prototype.setRouteStyle = function(opt_options) {
	var options = opt_optioins || {};
	var map = this._map;
	var routeLayer = this._routeLayer;
	
	var style = new ol.style.Style({
		stroke: new ol.style.Stroke({
			width: options.width,
			color: options.color
		})
	});
	routeLayer.setStyle(style);
	
	map.removeLayer(routeLayer);
	map.addLayer(routeLayer);
	
	// tell OpenLayers to continue the postcompose animation
	map.render();
};

/**
 * 将动画标注点移动到指定位置
 * @param {fjzx.map.Point} point
 * @param {function} callback
 */
fjzx.map.MarkerAnimate.prototype.moveTo = function(point,callback) {
	var map = this._map;

	this._marker.setPosition(point);
	// tell OpenLayers to continue the postcompose animation
	map.render();
	if(typeof(callback)=="function")
		callback();
};

/**
 * 开始动画
 */
fjzx.map.MarkerAnimate.prototype.start=function() {
	var map = this._map;
	if (this._animating) {
		this.stopAnimation(false);
		this.freeResource();
	}
	
	this._animating = true;
	now = new Date().getTime();
	var this_ = this;
	map.on('postcompose', this.moveFeature);
	map.render();
}


/**
 * 停止动画
 * @param {boolean} isEnd.
 */
fjzx.map.MarkerAnimate.prototype.stop=function(isEnd) {
	var map = this._map;
	var routeCoords = this._routeCoords;
	var routeLength = this._routeLength;
	
	// 如果动画被取消或停止，则将动画标注点重置到起点位置
	var coord = isEnd ? routeCoords[routeLength - 1] : routeCoords[0];
    this._marker.setPosition(coord);
	//移除监听事件
	map.un('postcompose', this.moveFeature);
}


/**
 * 投影
 * @param opt_options
 * @param callback
 * @returns {fjzx.map.Map}
 */
fjzx.map.Projection = function(opt_options){
	var options = opt_options || {};
	
	this.opt = {
		code: options.code ? options.code : 'EPSG:4326',
		units: options.units ? options.units : undefined,
		extent: options.extent ? options.extent : undefined,
		axisOrientation: options.axisOrientation ? options.axisOrientation : undefined,
		global: options.global ? options.global : undefined,
		metersPerUnit:	options.metersPerUnit ? options.metersPerUnit : undefined,
		worldExtent: options.worldExtent ? options.worldExtent : undefined,
		getPointResolution: options.getPointResolution ? options.getPointResolution : undefined
	};
	
	ol.proj.Projection.call(this,this.opt);
};

ol.inherits(fjzx.map.Projection, ol.proj.Projection);

fjzx.map.Projection.prototype.lngLatToPoint = function(coordinate){
	var coor = ol.proj.fromLonLat(coordinate);
	
	return {x: coor[0], y: coor[1]};
}

fjzx.map.Projection.prototype.pointToLngLat = function(coordinate){
	var lonLat = ol.proj.toLonLat(coordinate);
	
	return lonLat;
}

/**
 * 地图坐标点构造函数
 */
fjzx.map.Point = function(longitude,latitude){
	this.lng = parseFloat(longitude);
	this.lat = parseFloat(latitude);
	//将经纬度数组转换为ol.Coordinate对象
	var coordinate = ol.coordinate.add([this.lng,this.lat], [0,0]);
	//将坐标系转换为EPSG:3857
	var position = ol.proj.fromLonLat(ol.proj.transform(coordinate, 'EPSG:3857', 'EPSG:4326'));
	return position;
}

/**
 * 像素坐标
 */
fjzx.map.Pixel = function(x,y){
	
	return {x: x, y: y};
}

/**
 * 经纬度构造函数（用于根据经纬度从天地图获取地址信息）
 * @param longitude
 * @param latitude
 * @returns {fjzx.map.LngLat}
 */
fjzx.map.LngLat = function(longitude,latitude){
	this.lng = longitude;
	this.lat = latitude;
	//将经纬度数组转换为ol.Coordinate对象
	var coordinate = ol.coordinate.add([longitude,latitude], [0,0]);
	//将坐标系转换为EPSG:3857
	this.position = ol.proj.fromLonLat(ol.proj.transform(coordinate, 'EPSG:3857', 'EPSG:4326'));
}

fjzx.map.LngLat.prototype = {
	getLng: function(){
		return this.lng;
	},
	getLat: function(){
		return this.lat;
	},
	getMercatorLng: function(){	//获取WEB墨卡托坐标点的经度
		
	},
	getMercatorLat: function(){	//获取WEB墨卡托坐标点的纬度
		
	},
	equals: function(point){	//判断当前地理坐标点与给定坐标点是否为同一点
		var result = false;
		
		return result;
	},
	distanceFrom: function(point,radius){	//计算当前地理坐标点与给定坐标点之间的距离,point:经纬度坐标,radius:也可以传递可选的 radius参数计算不同于地球半径的球体的TLngLat坐标之间的距离
		
	}
};

/**
 * Icon构造函数
 * @param {String} src	图片资源地址
 * @param {Object} opt_options	参数设置
 * 
 */
fjzx.map.Icon = function(src,opt_options){
	var options = opt_options || {};
	
	this.opt = {
		anchor: options.anchor,
		anchorOrigin: options.anchorOrigin,//bottom-left, bottom-right, top-left or top-right. Default is top-left
		anchorXUnits: options.anchorXUnits,
		anchorYUnits: options.anchorYUnits,
		color: options.color,
		crossOrigin: options.crossOrigin,
		offset: options.offset ? options.offset : [0, 0],
		offsetOrigin: options.offsetOrigin ? options.offsetOrigin : "top-left",	//bottom-left, bottom-right, top-left or top-right
		opacity: options.opacity ? options.opacity : 1,
		scale: options.scale ? options.scale : 1,
		snapToPixel: true,
		rotateWithView: false,
		rotation: options.rotation ? options.rotation : 0,
		size: options.size,	//ol.Size
		src: src,
		img: options.img,
		imgSize: options.imgSize //ol.Size
	};
	ol.style.Icon.call(this,this.opt);
}

ol.inherits(fjzx.map.Icon, ol.style.Icon);

/**
 * 设置图片偏移量
 * @param {Array} offset,如[0,0]、[10,20]等
 * 
 */
fjzx.map.Icon.prototype.setImageOffset = function(offset){
	this.opt.offset = offset;
}

/**
 * 设置图片偏移量
 * @param {Array} offset,如[0,0]、[10,20]等
 * 
 */
fjzx.map.Icon.prototype.setSize = function(size){
	this.opt.size = size;
}

/**
 * 地图尺寸构造函数
 * @param {number} width 
 * @param {number} height 
 */
fjzx.map.Size = function(width,height){
	return [width,height];
}

fjzx.map.Polyline = function(points,opt_options){
    var options = opt_options || {};

    var map = this._map;

    var lineStringGeometry = new ol.geom.LineString(points);
    var routeFeature = new ol.Feature({
        type: 'route',
        geometry: lineStringGeometry
    });

    var routeLayer= new ol.layer.Vector({
        source: new ol.source.Vector({
            features: [routeFeature]
        }),
        style: new ol.style.Style({
            stroke: new ol.style.Stroke({
                width: options.strokeWeight,
                color: options.strokeColor
            })
        })
    });
	
	return routeLayer;
}

 


/**
 * 地图覆盖物
 * 
 */
fjzx.map.Overlay = function(opt_options){
	var options = opt_options || {};
	
	ol.Overlay.call(options);
}

ol.inherits(fjzx.map.Overlay, ol.Overlay);

/**
 * 逆地理编码构造函数
 * @constructor
 * @desc 继承于天地图的Geocoder对象，用于根据天地图获取地址信息
 * 
 */
fjzx.map.Geocoder = function(){
	
}
fjzx.map.Geocoder.prototype.getLocation= function(TLngLat,successCallback ,errorCallback){
	var lon = TLngLat.lng;
	var lat = TLngLat.lat;
	$.ajax({
		type: 'POST',
		url: "http://api.tianditu.gov.cn/geocoder?postStr={'lon':"+lon+",'lat':"+lat+",'ver':1}&type=geocode&tk="+tk,
        success: function (result) {
        	if(typeof(successCallback) =="function"){        		
        		result.address = result.result.addressComponent.address;
        		result.getAddress = function(){
        			return  result.address ;
        		};
        		successCallback(result);
        	}
		},
		error :function(result){
			if(typeof(errorCallback) =="function"){
				errorCallback();
        	}
		},
	dataType: 'json'
	});
}

/**
 * 地图框选功能
 * @param opt_options
 * @returns {fjzx.map.Selection}
 */
fjzx.map.Selection = function(opt_options){
	var options = opt_options || {};
	this._map = options.map;
    //当前是否开启拉框搜索状态；默认为false，表示没有开启
    this._isOpen = false;
	/*
	//要搜索的类型 用 逗号隔开 比如 USER , SIGN 等 
    //this._selectWords = selectWords ;
    //各种状态的默认参数
    this._opts = {
        map: map,      //搜索结果显示设置          
        followText : "",	// 开启拉框搜索状态后，鼠标跟随的文字
        strokeWeight : 2,	// 遮盖层外框的线宽
        strokeColor : "#111",	// 遮盖层外框的颜色
        style : "solid",	// 遮盖层外框的样式
        fillColor : "#ccc",	// 遮盖层的填充色
        opacity : 0.4,	// 遮盖层的透明度
        cursor : "crosshair",	// 鼠标样式
        autoClose : true,	// 是否在每次操作后，自动关闭拉框搜索状态, 私有属性
        autoViewport : false,	//是否自动调整视野
        alwaysShowOverlay: true,	//是否一直显示拉框后的覆盖物
        panel:"",	 //显示面板
        selectFirstResult: "false",	//是否显示第一个搜索结果
        _zoomType : 12	// 拉框后放大
    };
    // 通过使用者输入的opts，修改这些默认参数
    this._setOptions(opts);
    // 验证参数正确性
    this._opts.strokeWeight = this._opts.strokeWeight <= 0 ? 1 : this._opts.strokeWeight;
    this._opts.opacity = this._opts.opacity < 0 ? 0 : (this._opts.opacity > 1 ? 1 : this._opts.opacity);
    //拉框时显示的矩形遮盖层
    this._fDiv = null;
    //鼠标跟随的文字提示框
    this._followTitle = null;
    //当前overlay对象
    this._overlay = null;
	*/
	this.opt = {
		fillColor: options.fillColor ? options.fillColor : 'rgba(255, 255, 255, 0.2)',
		strokeColor: options.strokeColor ? options.strokeColor : '#ffcc33',
		strokeWidth: options.strokeWidth ? options.strokeWidth : 2,
		beforeCallback: options.beforeCallback,
		afterCallback: options.afterCallback
	};

	var this_ = this;
	this.vectorSource = new ol.source.Vector();
	this.vector = new ol.layer.Vector({
		source : this.vectorSource,
		style : new ol.style.Style({
			fill : new ol.style.Fill({
				color : this_.opt.fillColor
			}),
			stroke : new ol.style.Stroke({
				color : this_.opt.strokeColor,
				width : this_.opt.strokeWidth
			}),
			image : new ol.style.Circle({
				radius : 7,
				fill : new ol.style.Fill({
					color : '#ffcc33'
				})
			})
		})
	});
};

fjzx.map.Selection.prototype.open = function(){
	if(this._isOpen)
		return true;

	var beforeCallback = this.opt.beforeCallback;
	var afterCallback = this.opt.afterCallback;
	this._isOpen = true;
	this._map.addLayer(this.vector);
	
	//创建拉选框实例
	this.dragBox = new ol.interaction.DragBox({
		condition: ol.events.condition.platformModifierkeyOnly
	});
	this._map.addInteraction(this.dragBox);
	
	//监听开始拉选框事件
	this.dragBox.on('boxstart', function(){
		var extent = this.getGeometry().getExtent();
		var obj = {
			startPoint: fjzx.map.Point(extent[0], extent[1]),
			endPoint: fjzx.map.Point(extent[2], extent[3]),
		};
		if(typeof(beforeCallback)==="function") beforeCallback(obj);
	});
	
	//监听结束拉选框事件
	var this_ = this;
	this.dragBox.on('boxend', function(){
		var extent = this.getGeometry().getExtent();
		var obj = {
			startPoint: fjzx.map.Point(extent[0], extent[1]),
			endPoint: fjzx.map.Point(extent[2], extent[3]),
		};
		//拉选框事件结束后立刻把对应的图层和拉选框实例移除，避免能够重复框选
		this_._map.removeLayer(this_.vector);
		this_._map.removeInteraction(this_.dragBox);
		this_._isOpen = false;
		if(typeof(afterCallback)==="function") afterCallback(obj);
	});
};

fjzx.map.Selection.prototype.close = function(){
	this._map.removeLayer(this.vector);
	this._map.removeInteraction(this.dragBox);
	this._isOpen = false;
};

/**
 * 工具类
 */
fjzx.map.utils = {
	getUUID: function() {
		var s = [];
		var hexDigits = "0123456789ABCDEF";
		for (var i = 0; i < 32; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[12] = "4";
		s[16] = hexDigits.substr((s[16] & 0x3) | 0x8, 1);
		var uuid = s.join("");
		return uuid;
	},
	//十六进制 转rgb
	colorRgb : function(str,opacity){
         var opa = opacity ? opacity : 0.2;
		 var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;  
	     var sColor = str.toLowerCase();  
	     if(sColor && reg.test(sColor)){  
	         if(sColor.length === 4){  
	             var sColorNew = "#";  
	             for(var i=1; i<4; i+=1){  
	                 sColorNew += sColor.slice(i,i+1).concat(sColor.slice(i,i+1));     
	             }  
	             sColor = sColorNew;  
	         }  
	         //处理六位的颜色值  
	         var sColorChange = [];  
	         for(var i=1; i<7; i+=2){  
	             sColorChange.push(parseInt("0x"+sColor.slice(i,i+2)));    
	         }  
	         return  "rgba(" + sColorChange.join(",") + ","+opa+")";
	  
	     }else{  
	         return sColor;    
	     }  
	 },
	transformPointFromBd: function(point){
		//百度经纬度坐标转国测局坐标
	    var bd09togcj02 = coordtransform.bd09togcj02(point[0],point[1]);
	    //国测局坐标转wgs84坐标
	    var gcj02towgs84 = coordtransform.gcj02towgs84(bd09togcj02[0], bd09togcj02[1]);
	    
	    return gcj02towgs84;
	},
	formatDrawType: function(type){
		var result = type.toLowerCase();
		var reg = /\b(\w)|\s(\w)/g; //  \b判断边界\s判断空格
		return result.replace(reg,function(m){ 
			return m.toUpperCase()
		});
	},
	hasDrawType: function(type){
		var result = false;
		switch (type) {
		case "Point":
			result = true;
			break;
		case "LineString":
			result = true;
			break;
		case "Circle":
			result = true;
			break;
		case "Polygon":
			result = true;
			break;
		default:
			break;
		}
		return result;
	 
	},
	formatGeoJSON: function(data){
		var geometry = null;
		var geometryData = JSON.parse(data.feature);
		
		var type = geometryData.type;
		switch (type.toUpperCase()) {
		case "POINT":
			geometry ={
				type: type,
				coordinates: geometryData.coordinates
			};
			break;
		case "LINESTRING":
			geometry = {
				type: type,
				coordinates: geometryData.coordinates
			};
			break;
			   
		case "MULTILINESTRING":
			geometry = {
				type: type,
				coordinates: geometryData.coordinates
			};
		 
			break;	
	    
		case "POLYGON":
			geometry = {
				type: type,
				coordinates: geometryData.coordinates
			};
			break;
		case "CIRCLE":
			geometry = {
				type: type,
				center: geometryData.center,
				radius: geometryData.radius
			};
			break;
		default:
			break;
		}

		var result = {
			type: "Feature",
			id: data.id,
			properties: {
				name: data.name
			},
			geometry: geometry
		};
		return result;
	},
	transformGeometry: function(geometryData){
		var result = null;
		var type = geometryData.type;
	 
		switch (type.toUpperCase()) {
		case "POINT":
			var coordinates = geometryData.coordinates;
			var layout = geometryData.layout ? geometryData.layout : 'xy';
			result =  new ol.geom.Point(coordinates[0]);
			break;
		case "LINESTRING":
			var coordinates = geometryData.coordinates;
			
			var layout = geometryData.layout ? geometryData.layout : 'xy';
			result = new ol.geom.LineString(coordinates,layout);
			break;
		case "MULTILINESTRING":
			var coordinates = geometryData.coordinates;
			var layout = geometryData.layout ? geometryData.layout : 'xy';
			result = new ol.geom.MultiLineString(coordinates,layout);
			break;
		case "POLYGON":
			var coordinates = geometryData.coordinates;
			var layout = geometryData.layout ? geometryData.layout : 'xy';
			result = new ol.geom.Polygon(coordinates);
			break;
		case "CIRCLE":
			var center = geometryData.center;
			var radius = geometryData.radius;
			var layout = geometryData.layout ? geometryData.layout : 'xy';
			
			var circleGeom = new ol.geom.Circle(center,radius,layout);
			
			var sides = 32;
			var angle = 0;
			result = new ol.geom.Polygon.fromCircle(circleGeom,sides,angle);
			break;
		default:
			break;
		}
		return result;
	},
	transformFromMapEvent: function(mapEvent){
		var options = mapEvent || {};
		
		var result = {
			point: {lon: options.coordinate[0], lat: options.coordinate[1]},
			dragging: options.dragging,
			frameState: options.frameState,
			map: options.map,
			originalEvent: options.originalEvent,
			pixel: options.pixel,
			target: options.target,
			type: options.type
		};
		result.prototype = options.prototype;
		
		return result;
	},
	getPolygonCenter: function(type,coordinates){
		var result = new Array();
		var minX,minY,maxX,maxY;
		for(var i=0;i<coordinates.length;i++){
			var coor = coordinates[i];
			if(coor[0] instanceof Array){
				var array = fjzx.map.utils.getPolygonCenter(type,coor);
				result.push(array);
				continue;
			}
			
			if(i==0){
				minX = coor[0];
				maxX = coor[0];
				minY = coor[1];
				maxY = coor[1];
				continue;
			}
			if(coor[0]<minX){
				minX = coor[0];
			}
			if(coor[0]>maxX){
				maxX = coor[0];
			}
			if(coor[1]<minY){
				minY = coor[1]; 
			}
			if(coor[1]<maxY){
				maxY = coor[1];
			}
		}
		if(!(isNaN(minX) || isNaN(minX) || isNaN(maxY) || isNaN(maxY))){
			var center = new fjzx.map.Point((minX+minX)/2, (maxY+maxY)/2);
			result.push(center);
		}
		
		return result;
	},
	getPolygonVertex: function(opt_options){
		var options = opt_options || {};
		
		var result = new Array();
		var coordinates = options.coordinates;
		for(var i=0;i<coordinates.length;i++){
			var coor = coordinates[i];
			if(coor[0] instanceof Array){
				options.coordinates = coor;
				var array = fjzx.map.utils.getPolygonVertex(options);
				continue;
			}
			
			if(options.start){
				options.minX = coor[0];
				options.maxX = coor[0];
				options.minY = coor[1];
				options.maxY = coor[1];
				options.start = false;
				continue;
			}
			
			if(coor[0]<options.minX){
				options.minX = coor[0];
			}
			if(coor[0]>options.maxX){
				options.maxX = coor[0];
			}
			if(coor[1]<options.minY){
				options.minY = coor[1]; 
			}
			if(coor[1]<options.maxY){
				options.maxY = coor[1];
			}
		}
		
		return options;
	},
	inherits: function(subObj,superObj){
		function beget(obj){
			var f = function(){};
			f.prototype = obj;
			return new f();
		}
		var proto = beget(superObj.prototype);
		proto.constructor = subObj;
		subObj.prototype = proto;
	},
	hasClass: function(element,className){
		return element.className.match(new RegExp('(\\s|^)' + className + '(\\s|$)'));
	},
	addClass: function(element,className){
		if(!this.hasClass(element, className))
			element.className += ' ' + className;
	},
	removeClass: function(element, className){
		if(this.hasClass(element,className)){
			var reg = new RegExp('(\\s|^)'+className+'(\\s|$)');
			element.className = element.className.replace(reg, ' ');
		}			
	},
	toggleClass: function(element,className){
		if(this.hasClass(element,className)){
			this.removeClass(element,className);
		}else{
			this.ddClass(element,className);
		}
	},
	showPointByPloy:function(coordinates,point,distance){   //coordinates (多边形)流域集合 ，站点目标     distance 单位米
	    var flag = false ;
	    if(typeof (coordinates) == "undefined" || coordinates[0].length <= 0 ){
	    	return  flag ;
		}
	    for (var i = 0; i < coordinates[0].length; i++) {
			coordinates[0][i][0] = parseFloat(coordinates[0][i][0]);
			coordinates[0][i][1] = parseFloat(coordinates[0][i][1]);
        }

	    var extent = ol.extent.boundingExtent(coordinates[0]); //获取一个坐标数组的边界，格式为[minx,miny,maxx,maxy]

		var center = ol.extent.getCenter(extent);   //获取边界区域的中心位置
		// 获取最大值 最小值 点信息
		var pointMinX = extent[0];
		var pointMinY = extent[1];
		var pointMaxX = extent[2];
		var pointMaxY = extent[3];

		var minPoint =   fjzx.map.Point(pointMinX, pointMinY);
		var maxPoint =   fjzx.map.Point(pointMaxX, pointMaxY);

        var centerxyPoint =  fjzx.map.Point(center[0], center[1]);
		var centerXPointY =  fjzx.map.Point(center[0], point[1]);
		var centerYPointX =  fjzx.map.Point(point[0], center[1]);
		var centerXYtoPointDistance = ol.sphere.getDistance(centerxyPoint,point);
		var centerXtoPointYDistance = ol.sphere.getDistance(centerXPointY,point);
		var centerYtoPointXDistance = ol.sphere.getDistance(centerYPointX,point);

		var mintocenterPointDistance = ol.sphere.getDistance(minPoint,center);
		var maxtocenterPointDistance = ol.sphere.getDistance(maxPoint,center);


		if(centerXYtoPointDistance > (mintocenterPointDistance+distance) ||  centerXYtoPointDistance > (maxtocenterPointDistance+distance) ){
			return  false ;
		}else{
			return true ;
		}
     /* if(  (centerXYtoPointDistance >0 && centerXYtoPointDistance <= distance) ||  (centerXtoPointYDistance >0 && centerXtoPointYDistance <= distance)||(centerYtoPointXDistance >0 && centerYtoPointXDistance <= distance) ){
              flag = true ;
       }*/
       return  flag ;
	}

};






/**
 * 动态加载JS
 * @function
 */
function loadScript(url, callback){
	var script = document.createElement("script");
	script.type = "text/javascript";
	if(typeof(callback)!="undefined"){
		if(script.readyState){
			script.onreadystatechange = function(){
				if(script.readyState == "loaded" || script.readyState == "complete"){
					script.onreadystatechange = null;
					callback();
				}
			};
		}else{
			script.onload = function(){
				callback();
			};
		}
	}
	script.src = url;
	document.body.appendChild(script);
}

/**
 * 构造HashMap类型数据
 * @returns {fjzx.map.HashMap}
 */
fjzx.map.HashMap= function() {
	this.map = {};
}

fjzx.map.HashMap.prototype = {
	put : function(key, value) {
		this.map[key] = value;
	},
	get : function(key) {
		if (this.map.hasOwnProperty(key)) {
			return this.map[key];
		}
		return null;
	},
	remove : function(key) {
		if (this.map.hasOwnProperty(key)) {
			return delete this.map[key];
		}
		return false;
	},
	removeAll : function() {
		this.map = {};
	},
	keySet : function() {
		var _keys = [];
		for ( var i in this.map) {
			_keys.push(i);
		}
		return _keys;
	},
	length : function(){
		var  length=0;
		for ( var i in this.map) {
			length++;
		}
		return length;
	}
};






