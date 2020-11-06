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
/**
 * 主程序。
 *
 * @param win 全局 window 对象。
 * @param $   jQuery 核心对象。
 * @param ol  OpenLayers 对象。
 * @param lay layer 弹出层 UI 对象。
 * @param map map对象。
 */
MACRO_PACKAGE_DEFINE("fjzx.map.river");
fjzx.map.river.app = function(win, $, ol, lay, map){
    if (!win.appConfig) {
        throw new Error('配置文件不存在。');
    }
    // 初始化模块结构。
    var app = {
        map: {
            control: {}
        },
        layer: {}
    };
    //var map = null;

    app.util = function () {
        var _chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split("");

        function uuid(len, radix) {
            var chars = _chars, uuid = [], i;
            radix = radix || chars.length;

            if (len) {
                for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random() * radix];
            } else {
                // rfc4122
                var r;
                uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
                uuid[14] = "4";
                for (i = 0; i < 36; i++) {
                    if (!uuid[i]) {
                        r = 0 | Math.random() * 16;
                        uuid[i] = chars[(i === 19) ? (r & 0x3) | 0x8 : r];
                    }
                }
            }

            return uuid.join("");
        }

        return {
            getUUID: uuid
        };
    }();

    // 图层管理器。
    app.map.layerManager = function () {
        // 底图数据。
        var baseMaps = {};
        // 专题图数据。
        var specialLayers = {};
        // 绘图图层。
        var drawLayers = {};

        var addLayer = function (opts) {
            switch (opts.type) {
                case 1:
                    baseMaps[opts.id] = {
                        id: opts.id,
                        layer: opts.layer,
                        domNode: opts.domNode
                    };
                    break;
                case 2:
                    specialLayers[opts.id] = {
                        id: opts.id,
                        layer: opts.layer
                    };
                    break;
                case 3:
                    drawLayers[opts.id] = {
                        id: opts.id,
                        layer: opts.layer
                    };
                    break;
                default:
                    throw new Error('未知的图层类型。')
            }
            map.addLayer(opts.layer);
        };
        var removeSpecialById = function(layerId){

            var riverLayerObj = app.map.layerManager.getSpecialById(window.appConfig.river.id);
            var riverLayer = riverLayerObj.layer;
            map.removeLayer(riverLayer);
        }

        return {
            getBaseMaps: function () {
                return baseMaps;
            },
            getBaseMapById: function (layerId) {
                return baseMaps[layerId];
            },
            getSpecialById: function (layerId) {
                return specialLayers[layerId];
            },
            addLayer: addLayer,
            removeSpecialById: removeSpecialById
        };
    }();

    // 底图控制器模块。
    app.map.control.BaseMapToggle = function () {
        var domNodeTemplateString = "" +
            "<div class='basemap-toggle' style='width: ${size}px; height: ${size}px; top: ${top}px; right: ${right}px;'>" +
            "</div>";
        var itemDomNodeTemplateString = "" +
            "<div class='basemap' style='width: ${size}px; height: ${size}px;' data-app-layer-id='${id}' title='${title}'>" +
            "   <img style='width: ${imgSize}px; height: ${imgSize}px; margin: ${imgMargin};' src='${icon}' alt=''>" +
            "</div>";

        /**
         * 创建底图项。
         *
         * @param opts 传入底图配置。
         */
        var createBaseMapItem = function (opts) {
            if (!opts || (Object.prototype.toString.call(opts.url) !== '[object Array]' && Object.prototype.toString.call(opts.url) !== '[object String]')) {
                throw new Error('底图配置配置不正确。');
            }
            var urls = [], size, imgSize, imgMargin, olLayers = [], domNode;
            if (Object.prototype.toString.call(opts.url) === '[object String]') {
                urls.push(opts.url);
            } else {
                urls = opts.url;
            }
            size = opts.size || 60;
            imgSize = 48;
            imgMargin = (size - imgSize) / 2 + "px 0 0 " + (size - imgSize) / 2 + "px";

            // 0：使用 WMTS，1：使用 WMS，默认：0。
            if (opts.type === 1) {
                for (var i = 0; i < urls.length; i++) {
                    olLayers.push(new ol.layer.Tile({
                        source: new ol.source.TileWMS({
                            url: urls[i],
                            projection: 'EPSG:4326'
                        })
                    }));
                }
            } else {
                for (var j = 0; j < urls.length; j++) {
                    olLayers.push(new ol.layer.Tile({
                        source: new ol.source.XYZ({
                            url: urls[j],
                            projection: 'EPSG:4326',
                            tileGrid: new ol.tilegrid.WMTS({
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
                            })
                        })
                    }));
                }
            }

            // 初始化节点。
            domNode = $(
                itemDomNodeTemplateString
                    .replace(/\${size}/g, '' + size)
                    .replace(/\${id}/g, opts.id)
                    .replace(/\${title}/g, opts.title || '')
                    .replace(/\${imgSize}/g, '' + imgSize)
                    .replace(/\${imgMargin}/g, '' + imgMargin)
                    .replace(/\${icon}/g, opts.icon)
            )[0];

            return {
                layerId: opts.id,
                domNode: domNode,
                layer: new ol.layer.Group({
                    layers: new ol.Collection(olLayers),
                    visible: false
                })
            }
        };

        /**
         * 创建底图项页面节点和相应的 ol.control.Control 对象。
         *
         * @param size
         * @param top
         * @param right
         * @returns {{olObj, domNode: *}}
         */
        var createDomNodeAndOpenLayersControlObj = function (size, top, right) {
            // 创建节点。
            var domNode = $(
                domNodeTemplateString
                    .replace(/\${size}/g, '' + size)
                    .replace(/\${top}/g, '' + top)
                    .replace(/\${right}/g, '' + right)
            )[0];
            var separation = 8;// 子组件展开时的间距。
            // 创建 ol 的控制器实例。
            var olObj = new ol.control.Control({element: domNode});

            // 事件绑定。
            // 注册底图控制菜单
            $(domNode).on("click", ".basemap", function () {
                var layerId = $(this).attr("data-app-layer-id");// 取出图层 id。
                select(layerId);
            });
            // 注册鼠标移入移出事件。
            $(domNode).on({
                mouseenter: function (e) {
                    expand(e);
                },
                mouseleave: function (e) {
                    collapse(e);
                }
            });

            /**
             * 底图控制器展开。
             */
            function expand() {
                var $domNode = $(domNode);
                var baseMaps = $domNode.children(".basemap");
                var count = 0;
                // 如果已经展开，则返回。
                if (!!$domNode.attr("expand")) {
                    return;
                }
                // 标记展开状态。
                $domNode.attr("expand", "expand");
                // 将控制器的高度拉伸到可以覆盖所有展开项的位置，避免越界触发鼠标移出事件。
                $domNode.css("height", (size + separation) * baseMaps.length + "px");
                for (var i = 0; i < baseMaps.length; i++) {
                    // 如果不是选中项则执行展开并显示。
                    if (!$(baseMaps[i]).attr("selected")) {
                        count++;
                        $(baseMaps[i]).css("display", "block");
                        $(baseMaps[i]).animate({
                            top: "+=" + (size + separation) * count
                        }, 300, function (count) {
                            $(this).css("display", "block");
                            $(this).css("top", (size + separation) * count + "px");
                        });
                    }
                }
            }

            /**
             * 底图控制器收起。
             *
             * @param time 动画时间。
             */
            function collapse(time) {
                var $domNode = $(domNode);
                var baseMaps = $domNode.children(".basemap");
                var count = 0;
                if (Object.prototype.toString.call(time) !== "[object Number]") {
                    time = 200;
                }
                // 如果没有展开，则返回。
                if (!$domNode.attr("expand")) {
                    return false;
                }
                // 移出展开状态标记。
                $domNode.removeAttr("expand");
                $domNode.css("height", size + "px");
                for (var i = 0; i < baseMaps.length; i++) {
                    // 如果不是选中项则执行收起并隐藏。
                    if (!$(baseMaps[i]).attr("selected")) {
                        count++;
                        $(baseMaps[i]).animate({
                            top: "-=0"
                        }, time, function () {
                            $(this).css("display", "none");
                            $(this).css("top", 0);
                        });
                    }
                }
            }

            /**
             * 选中指定图层 id 的底图。
             *
             * @param layerId 图层 id。
             */
            function select(layerId) {
                var currentItem = app.map.layerManager.getBaseMapById(layerId);
                // 已经选中则返回。
                if (!!$(currentItem.domNode).attr("selected")) {
                    return;
                }
                clear();
                // 标记选中状态。
                $(currentItem.domNode).attr("selected", "selected");
                $(currentItem.domNode).css("z-index", 10000);
                $(currentItem.domNode).animate({
                    top: 0
                }, 200);
                collapse(0);
                // 显示当前底图。
                currentItem.layer.setVisible(true);
            }

            /**
             * 清空选中的底图。
             */
            function clear() {
                var domNode;
                var basemaps = app.map.layerManager.getBaseMaps();
                for (var id in basemaps) {
                    if (basemaps.hasOwnProperty(id)) {
                        domNode = basemaps[id].domNode;
                        // 移除 dom 组件的选中标记。
                        $(domNode).removeAttr("selected");
                        $(domNode).css("z-index", 0);
                        // 隐藏对应的图层组。
                        basemaps[id].layer.setVisible(false);
                    }
                }
            }

            return {
                domNode: domNode,
                olObj: olObj,
                clearBaseMap: clear
            };
        };

        return function (map, opts) {
            if (!win.appConfig.baseMaps ||
                Object.prototype.toString.call(win.appConfig.baseMaps) !== '[object Array]' ||
                win.appConfig.baseMaps.length === 0) {
                throw new Error('配置文件中底图配置不存在或配置不正确。');
            }
            opts = opts || {};
            // 创建控制器页面节点。
            var node = createDomNodeAndOpenLayersControlObj(60, opts.top || 8, opts.right || 16);

            for (var i = 0; i < win.appConfig.baseMaps.length; i++) {
                var item = createBaseMapItem(win.appConfig.baseMaps[i]);
                $(node.domNode).append(item.domNode);
                app.map.layerManager.addLayer({
                    type: 1,// 1：为底图类型。
                    id: item.layerId,
                    layer: item.layer,
                    domNode: item.domNode
                });
            }

            // 选中第一项。触发其单击事件。
            $(node.domNode).children(".basemap:first").trigger("click");

            return {
                appendToMap: function () {
                    // 添加控制器到地图实例。
                    map.addControl(node.olObj);
                    return this;
                },
                clearBaseMapLayer: function(){
                    node.clearBaseMap();
                }
            }
        };
    }();

    app.map.control.RiverLayerControl = function () {
        var domNodeTemplateString = "" +
            "<div class='legend' id='aloneLegend' style='bottom: ${bottom}px; right: ${right}px;display:none'>" +
            "   <div class='title'>图例</div>" +
            "   <ul class='list'></ul>" +
            "</div>";
        var legendItemNodeTemplateString = "" +
            "<li class='legend-item' data-status='${status}' data-grade='${grade}' selected='selected'>" +
            "   <span class='bg-status-${status}' style='background-color: ${color};'><span></span></span>" +
            "   <span class='title'>${title}</span>" +
            "</li>";
        var features;
        var styleConfig = [];
        var defaultStyleConfig = {
            color:  win.appConfig.river.defaultColor,
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color:  win.appConfig.river.defaultColor,
                    width: 3
                }),
                fill: new ol.style.Fill({
                    color:  win.appConfig.river.defaultColor
                })
            })
        };

        /**
         * 创建水系图例节点和相应的 ol.control.Control 对象。
         *
         * @param bottom
         * @param right
         * @returns {{olObj, domNode: *}}
         */
        var createDomNodeAndOpenLayersControlObj = function (bottom, right) {
            // 创建控制器的 dom 组件。
            var domNode = $(
                domNodeTemplateString
                    .replace(/\${bottom}/g, '' + bottom)
                    .replace(/\${right}/g, '' + right)
            )[0];
            // 创建 ol 的控制器实例。
            var olObj = new ol.control.Control({element: domNode});

            return {
                domNode: domNode,
                olObj: olObj
            };
        };

        /**
         * 添加图例项。
         *
         * @param legendNode
         * @param status
         * @param grade
         * @param opts
         */
        var addLegendItem = function (legendNode, status, grade, opts) {
            var $listNode = $(legendNode).find('ul.list');
            var itemNode = $(
                legendItemNodeTemplateString
                    .replace(/\${status}/g, status || 0)
                    .replace(/\${grade}/g, grade || 0)
                    .replace(/\${color}/g, opts.color)
                    .replace(/\${title}/g, opts.title)
            )[0];
            $listNode.append(itemNode);
            $(itemNode).on('click', function () {
                if ($(itemNode).attr('selected')) {
                    $(itemNode).removeAttr('selected');
                    if (!!features[status][grade] && features[status][grade].length > 0) {
                        for (var i = 0; i < features[status][grade].length; i++) {
                            features[status][grade][i].setStyle(getStyle(status, -1, features[status][grade][i].get('NAME') || ''));
                        }
                    }
                } else {
                    $(itemNode).attr('selected', 'selected');
                    if (!!features[status][grade] && features[status][grade].length > 0) {
                        for (var j = 0; j < features[status][grade].length; j++) {
                            features[status][grade][j].setStyle(getStyle(status, grade, features[status][grade][j].get('NAME') || ''));
                        }
                    }
                }
            })
        };

        /**
         * 根据配置，初始化样式。
         */
        var initStyleConfig = function (legendNode) {
            if (!win.appConfig.river ||
                Object.prototype.toString.call(win.appConfig.river.waterQualityConfig) !== '[object Array]' ||
                win.appConfig.river.waterQualityConfig.length !== 2) {
                throw new Error('配置文件中水系专题图水质种类配置不存在或配置不正确。');
            }
            for (var i = 0; i < win.appConfig.river.waterQualityConfig.length; i++) {
                styleConfig[i] = styleConfig[i] || [];
                for (var j = 0; j < win.appConfig.river.waterQualityConfig[i].length; j++) {
                    if (!win.appConfig.river.waterQualityConfig[i][j] || !win.appConfig.river.waterQualityConfig[i][j].color) {
                        styleConfig[i].push(null);
                        continue;
                    }
                    addLegendItem(legendNode, i, j, win.appConfig.river.waterQualityConfig[i][j]);
                    styleConfig[i].push(
                        {
                            color: win.appConfig.river.waterQualityConfig[i][j].color,
                            style: new ol.style.Style({
                                stroke: new ol.style.Stroke({
                                    color: win.appConfig.river.waterQualityConfig[i][j].color,
                                    width: 3
                                }),
                                fill: new ol.style.Fill({
                                    color: win.appConfig.river.waterQualityConfig[i][j].color
                                })
                            })
                        }
                    );
                }
            }
        };

        var getStyle = function (status, grade, text) {
            var styleConfigData;
            if (grade < 0) {
                styleConfigData = defaultStyleConfig;
            } else {
                styleConfigData = styleConfig[status][grade] || defaultStyleConfig;
            }
            styleConfigData.style.text_ = new ol.style.Text({
                maxAngle: 15,
                font: 'bold 14px serif',
                text: text,
                fill: new ol.style.Fill({
                    color: styleConfigData.color
                }),
                stroke: new ol.style.Stroke({
                    color: '#ffffff',
                    width: 2
                }),
                textBaseline: 'bottom',
                placement: 'line',
                offsetY: -8
            });

            return styleConfigData.style;
        };

        return function (map, opts) {
            if (!win.appConfig.river ||
                Object.prototype.toString.call(win.appConfig.river.url) !== '[object Array]' ||
                win.appConfig.river.url.length === 0) {
                throw new Error('配置文件中水系专题图配置不存在或配置不正确。');
            }
            opts = opts || {};
            // 创建控制器页面节点。
            var node = createDomNodeAndOpenLayersControlObj(opts.bottom || 16, opts.right || 16);
            // 初始化样式配置。
            initStyleConfig(node.domNode);

            var olLayers = [];
            for (var i = 0; i < win.appConfig.river.url.length; i++) {
                olLayers.push(
                    new ol.layer.Vector({
                        renderMode: 'image',
                        source: new ol.source.Vector({
                            format: new ol.format.GeoJSON({
                                geometryName: 'geom'
                            }),
                            url: win.appConfig.river.url[i],
                            projection: 'EPSG:4326'
                        }),
                        style: function (feature) {
                            var status = feature.get('STATUS') || 0;
                            var grade = feature.get('GRADE') || -1;
                            var name = feature.get('NAME') || '';
                            try {
                                status = parseInt(status);
                                status = status === 1 ? 1 : 0;
                            } catch (e) {
                                status = 0;
                            }
                            try {
                                grade = parseInt(grade);
                            } catch (e) {
                                grade = -1;
                            }
                            // 分组保存要素对象。
                            if (grade > -1) {
                                features = features || [];
                                features[status] = features[status] || [];
                                features[status][grade] = features[status][grade] || [];
                                features[status][grade].push(feature);
                            }

                            return getStyle(status, grade, name);
                        }
                    })
                );
            }

            var olLayerGroup = new ol.layer.Group({
                layers: new ol.Collection(olLayers)
            });

            // 添加水系图层。
            app.map.layerManager.addLayer({
                type: 2,// 2：为水系专题图类型。
                id: win.appConfig.river.id,
                layer: olLayerGroup
            });

            return {
                appendToMap: function () {
                    map.addControl(node.olObj);
                    return this;
                }
            };
        }
    }();

    app.map.control.DrawRiverControl = function () {
        var drawObj, snapObj, modifyObj, drawSource, drawVector, drawFeatures = {}, domNode;
        var wfsFormat = new ol.format.WFS();
        var drawFeatureStyleDefault = new ol.style.Style({
            fill: new ol.style.Fill({
                color: 'rgba(233, 179, 72, 0.8)'
            }),
            stroke: new ol.style.Stroke({
                color: '#e99225',
                width: 3
            }),
            image: new ol.style.Circle({
                radius: 7,
                fill: new ol.style.Fill({
                    color: '#e9b348'
                })
            })
        });
        var drawFeatureStyleHighlight = new ol.style.Style({
            fill: new ol.style.Fill({
                color: 'rgba(233, 138, 70, 0.8)'
            }),
            stroke: new ol.style.Stroke({
                color: '#e95313',
                width: 4
            }),
            image: new ol.style.Circle({
                radius: 7,
                fill: new ol.style.Fill({
                    color: '#e98a46'
                })
            })
        });
        var domNodeTemplateString = "" +
            "<div class='toolbox-draw-river' style='width: ${size}px; height: ${size}px; top: ${top}px; right:" +
            " ${right}px;' title='绘制河流工具'>" +
            "   <img style='width: ${imgSize}px; height: ${imgSize}px; margin: ${imgMargin};' src='${icon}' alt=''>" +
            "</div>";
        var drawToolbarLayerIdx, drawFeatureLayerIdx;
        var $drawToolbarLayerContent = $(
            '<ul class="draw-toolbar-content-list" style="display: none;">' +
            '   <li class="draw-line"><img src="/static/river/assets/img/tool-draw-line.png" alt="绘制河流（线）"><br><span>绘制线</span></li>' +
            '   <li class="draw-polygon"><img src="/static/river/assets/img/tool-draw-polygon.png" alt="绘制河流（面）"><span>绘制面</span></li>' +
            '   <li class="draw-back"><img src="/static/river/assets/img/tool-draw-back.png" alt="撤销"><span>撤销</span></li>' +
            '   <li class="draw-save"><img src="/static/river/assets/img/tool-draw-save.png" alt="保存"><span>保存</span></li>' +
            '   <li class="draw-cancel"><img src="/static/river/assets/img/tool-draw-cancel.png" alt="取消"><span>取消</span></li>' +
            '</ul>'
        );
        var $drawFeatureLayerContent = $(
            '<ul class="draw-feature-content-list" style="display: none;">' +
            '</ul>'
        );
        var $emptyDrawFeatureRow = $('<li class="empty-item">暂无绘制的图形数据。</li>');
        $drawFeatureLayerContent.append($emptyDrawFeatureRow);
        var $body = $('body');
        $body.append($drawToolbarLayerContent);
        $body.append($drawFeatureLayerContent);
        $drawToolbarLayerContent.find('li.draw-line').on('click', {drawType: 'LineString'}, onDrawHandler);
        $drawToolbarLayerContent.find('li.draw-polygon').on('click', {drawType: 'Polygon'}, onDrawHandler);
        $drawToolbarLayerContent.find('li.draw-back').on('click', function () {
            if (drawObj && drawObj.removeLastPoint) {
                drawObj.removeLastPoint();
            }
        });
        $drawToolbarLayerContent.find('li.draw-cancel').on('click', function () {
            if ($drawFeatureLayerContent.children('li.empty-item').length > 0) {
                close();
            } else {
                var currentLayerIdx = lay.confirm('退出后，所有未保存的绘图信息都将丢失，是否确定退出绘图工具？', {
                    btn: ['确认', '取消'] //按钮
                }, function () {
                    close();
                    lay.close(currentLayerIdx);
                });
            }
        });
        $drawToolbarLayerContent.find('li.draw-save').on('click', onSaveHandler);
        var drawFeatureTemplateString = '' +
            '<li>' +
            '   <img src="${icon}" alt="">' +
            '   <input type="text" value="${name}">' +
            '   <a data-id="${id}" class="btn btn-draw-delete">' +
            '       <img src="/static/river/assets/img/tool-draw-delete.png" alt="删除">' +
            '   </a>' +
            '   <a data-id="${id}" class="btn btn-draw-location">' +
            '       <img src="/static/river/assets/img/tool-draw-location.png" alt="定位">' +
            '   </a>' +
            '</li>';
        $drawFeatureLayerContent.on('click', 'li > a.btn-draw-delete', deleteDrawFeatureHandler);
        $drawFeatureLayerContent.on('click', 'li > a.btn-draw-location', locationDrawFeatureHandler);
        $drawFeatureLayerContent.on('mouseenter', 'li', onDrawFeatureMouseEnterHandler);
        $drawFeatureLayerContent.on('mouseleave', 'li', onDrawFeatureMouseLeaveHandler);

        function onDrawFeatureMouseEnterHandler(e) {
            var id = $(e.target).find('a.btn').attr('data-id');
            if (!id || !drawFeatures[id]) {
                return;
            }
            drawFeatures[id].feature.setStyle(drawFeatureStyleHighlight);
        }

        function onDrawFeatureMouseLeaveHandler(e) {
            var id = $(e.target).find('a.btn').attr('data-id');
            if (!id || !drawFeatures[id]) {
                return;
            }
            drawFeatures[id].feature.setStyle(drawFeatureStyleDefault);
        }

        function deleteDrawFeatureHandler(e) {
            var currentLayerIdx = lay.confirm('是否删除选择的图形？', {
                btn: ['确认', '取消'] //按钮
            }, function () {
                var node = e.target;
                if (Object.prototype.toString.call(e.target) !== '[object HTMLAnchorElement]') {
                    node = $(e.target).parents('a.btn.btn-draw-delete')[0];
                }
                var id = $(node).attr('data-id');
                if (!id || !drawFeatures[id]) {
                    throw new Error('要操作的图形对象不存在。');
                }
                drawSource.removeFeature(drawFeatures[id].feature);
                $(drawFeatures[id].node).remove();
                delete drawFeatures[id];
                if ($drawFeatureLayerContent.children().length === 0) {
                    $drawFeatureLayerContent.append($emptyDrawFeatureRow);
                }
                lay.close(currentLayerIdx);
            });
        }

        function locationDrawFeatureHandler(e) {
            var node = e.target;
            if (Object.prototype.toString.call(e.target) !== '[object HTMLAnchorElement]') {
                node = $(e.target).parents('a.btn.btn-draw-location')[0];
            }
            var id = $(node).attr('data-id');
            if (!id || !drawFeatures[id]) {
                throw new Error('要操作的图形对象不存在。');
            }
            map.getView().fit(drawFeatures[id].feature.getGeometry(), {duration: 1000});
        }

        function close() {
            drawFeatures = {};
            $drawFeatureLayerContent.empty();
            $drawFeatureLayerContent.append($emptyDrawFeatureRow);
            removeDrawInteraction();
            if (modifyObj) {
                map.removeInteraction(modifyObj);
                modifyObj = null;
            }
            if (drawSource) {
                drawSource.clear();
            }
            if (drawVector) {
                drawVector.setVisible(false);
            }
            if (drawToolbarLayerIdx) {
                lay.close(drawToolbarLayerIdx);
                drawToolbarLayerIdx = null;
            }
            if (drawFeatureLayerIdx) {
                lay.close(drawFeatureLayerIdx);
                drawFeatureLayerIdx = null;
            }
            if ($(domNode).attr('selected')) {
                $(domNode).removeAttr('selected');
            }
        }

        function addFeatureItemToList(featureId, feature) {
            if ($drawFeatureLayerContent.find('li.empty-item').length > 0) {
                $drawFeatureLayerContent.find('li.empty-item').remove();
            }
            var idx = $drawFeatureLayerContent.children().length;
            var icon = feature.getProperties().drawType === 'Polygon' ? '/static/river/assets/img/tool-draw-polygon.png' : '/static/river/assets/img/tool-draw-line.png';
            var featureNode = $(
                drawFeatureTemplateString
                    .replace(/\${id}/g, featureId)
                    .replace(/\${icon}/g, icon)
                    .replace(/\${name}/g, '图形' + ++idx)
            );
            drawFeatures[featureId]['node'] = featureNode;
            $drawFeatureLayerContent.append(featureNode);
        }

        function drawEndHandler(e, opts) {
            drawFeatures = drawFeatures || {};
            var featureId = app.util.getUUID();
            // 设置属性。
            e.feature.setProperties({
                drawType: opts.drawType,
                id: featureId,
                status: 0
            }, true);
            drawFeatures[featureId] = {
                feature: e.feature
            };
            addFeatureItemToList(featureId, e.feature);
        }

        function refresh(features) {
            var layers = app.map.layerManager.getSpecialById(win.appConfig.river.id).layer.getLayers();
            layers.forEach(function (layer) {
                layer.getSource().clear();
                layer.getSource().refresh();
            });
        }

        function request(features, drawType) {
            var wfsTransaction = wfsFormat.writeTransaction(features, null, null, {
                featureNS: appConfig.server.featureNS,
                featurePrefix: appConfig.server.featurePrefix,
                featureType: drawType === 'Polygon' ? 'WT_BASIN_PLANE_P_DATA' : 'WT_BASIN_PLANE_L_DATA'
            });
            var serializer = new XMLSerializer();
            var wfsXmlString = serializer.serializeToString(wfsTransaction);
            $.ajax({
                url: appConfig.server.wfs,
                type: 'POST',
                data: wfsXmlString,
                contentType: 'text/xml',
                success: function (req) {
                    refresh(features);
                }
            });
        }

        function onSaveHandler() {
            var lineStringFeatures = [];
            var polygonFeatures = [];
            if (drawFeatures) {
                for (var featureId in drawFeatures) {
                    if (!drawFeatures.hasOwnProperty(featureId)) {
                        continue;
                    }
                    // 河流名称属性处理。
                    var name = $(drawFeatures[featureId].node).children('input').val().trim();
                    switch (drawFeatures[featureId].feature.getProperties().drawType) {
                        case "LineString":
                            lineStringFeatures.push(
                                new ol.Feature({
                                    GEOM: new ol.geom.MultiLineString([drawFeatures[featureId].feature.getGeometry().getCoordinates()]),
                                    NAME: name,
                                    STATUS: 0
                                })
                            );
                            break;
                        case "Polygon":
                            polygonFeatures.push(
                                new ol.Feature({
                                    GEOM: new ol.geom.MultiPolygon([drawFeatures[featureId].feature.getGeometry().getCoordinates()]),
                                    NAME: name,
                                    STATUS: 0
                                })
                            );
                            break;
                        default:
                    }
                }
            }
            if (lineStringFeatures.length > 0) {
                request(lineStringFeatures, 'LineString');
            }
            if (polygonFeatures.length > 0) {
                request(polygonFeatures, 'Polygon');
            }
            close();
        }

        function onDrawHandler(e) {
            removeDrawInteraction();
            var drawType = e.data.drawType;
            modifyObj = new ol.interaction.Modify({source: drawSource});
            map.addInteraction(modifyObj);
            drawObj = new ol.interaction.Draw({
                source: drawSource,
                type: e.data.drawType
            });
            drawObj.on('drawend', function (e) {
                drawEndHandler(e, {drawType: drawType});
            });
            drawVector.setVisible(true);
            map.addInteraction(drawObj);
            snapObj = new ol.interaction.Snap({source: drawSource});
            map.addInteraction(snapObj);
        }

        function openDrawFeatureList() {
            if (!drawFeatureLayerIdx) {
                drawFeatureLayerIdx = lay.open({
                    type: 1,
                    title: '已绘制图形列表',
                    skin: 'draw-feature',
                    closeBtn: 0,
                    anim: 3,
                    shade: 0,
                    offset: ['180px', '16px'],
                    content: $drawFeatureLayerContent
                });
            }
        }

        function openDrawToolbar() {
            if (!drawToolbarLayerIdx) {
                drawToolbarLayerIdx = lay.open({
                    type: 1,
                    title: '绘制工具栏',
                    skin: 'draw-toolbar',
                    closeBtn: 0,
                    anim: 1,
                    shade: 0,
                    offset: '16px',
                    resize: false,
                    content: $drawToolbarLayerContent
                });
            }
        }

        function onClickHandler(e) {
            if ($(e.data.domNode).attr('selected') !== 'selected') {
                $(e.data.domNode).attr('selected', 'selected');
                openDrawToolbar();
                openDrawFeatureList();
            }
        }

        function removeDrawInteraction() {
            if (drawObj) {
                map.removeInteraction(drawObj);
                drawObj = null;
            }
            if (snapObj) {
                map.removeInteraction(snapObj);
                snapObj = null;
            }
        }

        /**
         * 创建底图项页面节点和相应的 ol.control.Control 对象。
         *
         * @param size
         * @param top
         * @param right
         * @returns {{olObj, domNode: *}}
         */
        var createDomNodeAndOpenLayersControlObj = function (size, top, right) {
            var imgSize = 48;
            var imgMargin = (size - imgSize) / 2 + "px 0 0 " + (size - imgSize) / 2 + "px";
            // 创建节点。
            domNode = $(
                domNodeTemplateString
                    .replace(/\${size}/g, '' + size)
                    .replace(/\${top}/g, '' + top)
                    .replace(/\${right}/g, '' + right)
                    .replace(/\${imgSize}/g, '' + imgSize)
                    .replace(/\${imgMargin}/g, '' + imgMargin)
                    .replace(/\${icon}/g, '/static/river/assets/img/tool-draw.png')
            )[0];
            // 创建 ol 的控制器实例。
            var olObj = new ol.control.Control({element: domNode});

            $(domNode).on('click', {domNode: domNode}, onClickHandler);

            return {
                domNode: domNode,
                olObj: olObj
            };
        };

        return function (map, opts) {
            opts = opts || {};
            // 创建控制器页面节点。
            var node = createDomNodeAndOpenLayersControlObj(60, opts.top || 8, opts.right || 16);
            drawSource = new ol.source.Vector();
            drawVector = new ol.layer.Vector({
                source: drawSource,
                style: drawFeatureStyleDefault
            });
            app.map.layerManager.addLayer({
                type: 3,
                id: 'drawRiver',
                layer: drawVector
            });

            return {
                appendToMap: function () {
                    map.addControl(node.olObj);
                    return this;
                }
            }
        }
    }();

    // 创建底图实例。
    /*map = new ol.Map({
        controls: [],
        target: 'app-root',
        view: new ol.View({
            projection: "EPSG:4326",
            center: [117.486211679, 24.4170647798],
            zoom: 11,
            maxZoom: 16,
            minZoom: 9
        })
    });*/
    // 创建底图控制器。
    app.map.control.baseMap = new app.map.control.BaseMapToggle(map, {
        top: 16,
        right: 16
    }).appendToMap();
    // 创建河流专题图控制器。
    new app.map.control.RiverLayerControl(map, {
        bottom: 16,
        right: 200
    }).appendToMap();
    // 创建河流绘制工具控制器。
   /* new app.map.control.DrawRiverControl(map, {
        top: 16,
        right: 86
    }).appendToMap();*/

   return app;
}