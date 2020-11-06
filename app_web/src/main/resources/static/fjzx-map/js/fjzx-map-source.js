MACRO_PACKAGE_DEFINE("fjzx.map.source");
fjzx.map.source = {
	//基础矢量图层
	getVecBaseLayer: function(){ 
		return createWMTSLayer({
			caption: "vecBaseLayer",
			url: "http://t{0-6}.tianditu.gov.cn/vec_c/wmts",
			layerName: "vec",
			format: "tiles"	
		});
	},
	getVecMarkerLayer: function(){  
		return createWMTSLayer({
			caption: "vecMarkerLayer",
			url: "http://t{0-6}.tianditu.gov.cn/cva_c/wmts",
			layerName: "cva",
			format: "tiles" 
		});
	},
	//基础影响图层
	getImgBaseLayer: function(){  
		return createWMTSLayer({
			caption: "imgBaseLayer",
			url: "http://t{0-6}.tianditu.gov.cn/img_c/wmts",
			layerName: "img",
			format: "tiles",
            title: "影像图层"
		});
	},
	getImgMarkerLayer: function(){  
		return createWMTSLayer({
			caption: "imgMarkerLayer",
			url: "http://t{0-6}.tianditu.gov.cn/cia_c/wmts",
			layerName: "cia",
			format: "tiles" ,
            title: "标注点图层"
		});
	},
	
	//龙岩矢量图层
	getLyVecBaseLayer: function(){  
		return createWMTSLayer({
			caption: "lyVecBaseLayer",
			url: "http://service.lymap.gov.cn/WMTS/kvp/services/LYVEC/MapServer/WMTSServer",
			layerName: "LYVEC",
			format: "image/png"	
		});
	},
	getLyVecMarkerLayer: function(){  
		return createWMTSLayer({
			caption: "lyVecMarkerLayer",
			url: "http://service.lymap.gov.cn/WMTS/kvp/services/LYCVA/MapServer/WMTSServer",
			layerName: "SMCVA2015",
			format: "image/png"	
		});
	},
	//龙岩影像图层
	getLyImgBaseLayer: function(){  
		return createWMTSLayer({
			caption: "lyImgBaseLayer",
			url: "http://service.lymap.gov.cn/WMTS/kvp/services/LYIMG/MapServer/WMTSServer",
			layerName: "LYIMG",
			format: "image/jpg"
		});
	},
	getLyImgMarkerLayer: function(){  
		return createWMTSLayer({
			caption: "lyImgMarkerLayer",
			url: "http://service.lymap.gov.cn/WMTS/kvp/services/LYCIA/MapServer/WMTSServer",
			layerName: "SMCIA2015",
			format: "image/png"
		});
	},

	//漳州矢量图层
    getZzVecBaseLayer: function(){
        return createWMTSLayerForZZ({
            caption: "zzVecBaseLayer",
            //url: "http://112.5.180.219/WMTS/kvp/services/zzvec/MapServer/WMTSServer",
            url: "http://140.237.73.123:9058/stifs/maps.do?service=WMTS&request=GetTile&version=1.0.0&layer=zzvec&style=default&format=image/png&TileMatrixSet=WholeWorld_CRS_84&TileMatrix={z}&TileRow={y}&TileCol={x}",
            layerName: "zzvec",
            format: "image/png",
            type: "base",
            title: "矢量图层"
        });
    },
    getZzVecMarkerLayer: function(){
        return createWMTSLayerForZZ({
            caption: "z-zVecMarkerLayer",
            //url: "http://112.5.180.219/WMTS/kvp/services/zzcva/MapServer/WMTSServer",
            url: "http://140.237.73.123:9058/stifs/maps.do?service=WMTS&request=GetTile&version=1.0.0&layer=zzcva&style=default&format=image/png&TileMatrixSet=WholeWorld_CRS_84&TileMatrix={z}&TileRow={y}&TileCol={x}",
            layerName: "zzcva",
            format: "image/png",
            type: "base11"
        });
    },
    getZzRiverLayer: function(){
    	var riverLayer = new ol.layer.Tile({
    	    source: new ol.source.TileWMS({
    	        url: 'http://140.237.73.123:9052/zzhb/wms?service=WMS&version=1.1.0&request=GetMap&layers=zzhb%3Azz_river_190401&bbox=116.94244%2C23.5311578%2C118.1708779%2C25.235140455123258&width=553&height=768&srs=EPSG%3A4490&format=application/openlayers'
    	        , projection: "EPSG:4326", tileGrid: _tileGrid
    	    })
    	});
    	return riverLayer;
    },
    //漳州影像图层
    getZzImgBaseLayer: function(){
        return createWMTSLayer({
            caption: "zzImgBaseLayer",
            url: "http://112.5.180.219/WMTS/kvp/services/zzimg/MapServer/WMTSServer",
            layerName: "zzimg",
            format: "image/png",
            type: "base",
            title: "影像图层"
        });
    },
    getZzImgMarkerLayer: function(){
        return createWMTSLayer({
            caption: "zzImgMarkerLayer",
            url: "http://112.5.180.219/WMTS/kvp/services/zzcia/MapServer/WMTSServer",
            layerName: "zzcia",
            format: "image/png",
            title: "标注点图层"
        });
    },

	
	/**
	 *	福建矢量图层资源：http://service.fjmap.net/vec_fj/wmts
	 *	福建矢量标注资源：//service.fjmap.net/cva_fj/wmts
	 *	福建影像图层资源：//service.fjmap.net/img_fj/wmts
	 *	福建影像标注资源：//service.fjmap.net/cia_fj/wmts
	 */
	
	//福建省矢量图层
	getFjVecBaseLayer: function(){  
		return createWMTSLayer({
			caption: "fjImgMarkerLayer",
			url: "http://service.fjmap.net/vec_fj/wmts",
			layerName: "vec_fj",
			format: "image/tile",
			style: "vec_fj",
			matrixSet: 'Matrix_0'
		});
	},
	getFjVecMarkerLayer: function(){  
		return createWMTSLayer({
			caption: "fjImageBaseLayer",
			url: "http://service.fjmap.net/cva_fj/wmts",
			layerName: "cva_fj",
			format: "image/tile",
			style: "cva_fj",
			matrixSet: 'Matrix_0'
		});
	},
	//福建省影响图层
	getFjImgBaseLayer: function(){  
		return createWMTSLayer({
			caption: "fjImgBaseLayer",
			url: "http://service.fjmap.net/img_fj/wmts",
			layerName: "img_fj",
			format: "image/tile",
			style: "img_fj",
			matrixSet: 'Matrix_0',
            type: "base",
            title: "影像图层"
		});
	},
	getFjImgMarkerLayer: function(){  
		return createWMTSLayer({
		caption: "fjImgMarkerLayer",
			url: "http://service.fjmap.net/cia_fj/wmts",
			layerName: "cia_fj",
			format: "image/tile",
			style: "cia_fj",
			matrixSet: 'Matrix_0'
		});
	},
	//全国矢量地图
	getGlobalVecBaseLayer: function(){  
		return createWMTSLayer({
			caption: "vecBaseLayer",
			url: "http://t{0-6}.tianditu.gov.cn/vec_c/wmts",
			layerName: "vec",
			format: "tiles"	
		});
	},
	getGlobalVecMarkerLayer: function(){  
		return createWMTSLayer({
		caption: "fjMarkerLayer",
			url: "http://t{0-6}.tianditu.gov.cn/cva_c/wmts",
			layerName: "cva",
			format: "tiles"
		});
	},
	//全国影像地图
	getGlobalImageBaseLayer: function(){  
		return createWMTSLayer({
			caption: "vecBaseLayer",
			url: "http://t{0-6}.tianditu.gov.cn/img_c/wmts",
			layerName: "img",
			format: "tiles"	
		});
	},
	getGlobalImageMarkerLayer: function(){  
		return createWMTSLayer({
            caption: "fjMarkerLayer",
            url: "http://t{0-6}.tianditu.gov.cn/cia_c/wmts",
            layerName: "cia",
            format: "tiles"
        });
	},
    //漳州水系水脉图层
    getAdminDivisionBaseLayer: function(){
        return createWMSLayer({
            caption: "行政区划",
            url: 'http://140.237.73.123:9052/zzhb/wms?service=WMS&version=1.1.0&request=GetMap&layers=zzhb%3Azzadmin&bbox=116.89096640555478%2C23.531157843988904%2C118.23584088636579%2C25.21527416470987&srs=EPSG%3A4490&format=application/openlayers',
            layerName: "adminDivision",
            format: "tiles"
        });
    },
    getRiverLayerGroup: function(){
        return new ol.layer.Group({
            layers: [this.getAdminDivisionBaseLayer()]
        });
    },

	
	getLyImageLayerGroup: function(){
		return new ol.layer.Group({
			layers: [this.getImgBaseLayer(), this.getLyImgBaseLayer(), this.getLyImgMarkerLayer()]
		});
	},
	getLyVecLayerGroup: function(){
		return new ol.layer.Group({
			layers: [this.getVecBaseLayer(), this.getLyVecBaseLayer(), this.getLyVecMarkerLayer()]
		});
	},
    getZzVecLayerGroup: function(){
        return new ol.layer.Group({
            type: "base",
            title: "矢量图层",
            combine: true,
            type: "base",
            //layers: [this.getVecBaseLayer(), this.getGlobalVecBaseLayer(), this.getZzVecBaseLayer(), this.getZzVecMarkerLayer()]
            layers: [this.getAdminDivisionBaseLayer(), this.getZzVecMarkerLayer()]
        });
    },
    getZzImgLayerGroup: function(){
        return new ol.layer.Group({
            type: "base",
            title: "影像图层",
            combine: true,
            type: "base",
            layers: [this.getZzImgBaseLayer(), this.getZzImgMarkerLayer()]
        });
    },
    getZzVecImgLayerGroup: function(){
        return new ol.layer.Group({
            type: "base",
            title: "影像图层",
            combine: true,
            type: "base",
            layers: [this.getZzVecBaseLayer(),this.getZzImgBaseLayer(), this.getZzImgMarkerLayer()]
        });
    },
	getFjImageLayerGroup: function(){ 
		return new ol.layer.Group({
			layers: [this.getImgBaseLayer(), this.getFjImgBaseLayer(), this.getFjImgMarkerLayer()]
		});
	},
	getFjVecLayerGroup: function(){ 
		return new ol.layer.Group({
			layers: [this.getVecBaseLayer(), this.getFjVecBaseLayer(), this.getFjVecMarkerLayer()]
		});
	},
	getGlobalVecLayerGroup: function(){ 
		return new ol.layer.Group({
			layers: [this.getVecBaseLayer(), this.getGlobalVecBaseLayer(), this.getGlobalVecMarkerLayer()]
		});
	},
	getGlobalImageLayerGroup: function(){ 
		return new ol.layer.Group({
			layers: [this.getVecBaseLayer(), this.getGlobalImageBaseLayer(), this.getGlobalImageMarkerLayer()]
		});
	},
	getLayerGroupByMapType: function(mapType){
		var result = "";
		switch (mapType) {
		case "FJ_VEC_MAP":
			result = this.getFjVecLayerGroup();
			break;
		case "FJ_IMG_MAP":
			result = this.getFjImageLayerGroup();
			break;
		case "LY_VEC_MAP":
			result = this.getLyVecLayerGroup();
			break;
		case "LY_IMG_MAP":
			result = this.getLyImageLayerGroup();
			break;
		case "ZZ_VEC_MAP":
			result = this.getZzVecLayerGroup();
			break;
		case "ZZ_IMG_MAP":
			result = this.getZzImgLayerGroup();
			break;
		case "GLOBAL_VEC_MAP":
			result = this.getGlobalVecLayerGroup();
			break;
		case "GLOBAL_IMG_MAP":
			result = this.getGlobalImageLayerGroup();
			break;
        case "ZZ_RIVER_MAP":
			result = this.getRiverLayerGroup();
			break;
        case "ZZ_VEC_IMG_MAP":
            result = this.getZzVecImgLayerGroup();
            break;
		default:
			result = this.getGlobalVecLayerGroup();
			break;
		}
		return result;
	}
}