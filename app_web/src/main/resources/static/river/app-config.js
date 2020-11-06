window.appConfig = function () {
    // 底图配置。
    var baseMaps = [
        {
            id: 'adminDivision',
            url: 'http://140.237.73.123:9052/zzhb/wms?service=WMS&version=1.1.0&request=GetMap&layers=zzhb%3Azzadmin&bbox=116.89096640555478%2C23.531157843988904%2C118.23584088636579%2C25.21527416470987&srs=EPSG%3A4490&format=application/openlayers',
            icon: 'assets/img/basemap-1.png',
            title: '行政区划',
            simpleTitle: '区划',
            type: 1
        }, {
            id: 'fjTiandituVec',
            url: [
                'http://140.237.73.123:9058/stifs/maps.do?service=WMTS&request=GetTile&version=1.0.0&layer=zzvec&style=default&format=image/png&TileMatrixSet=WholeWorld_CRS_84&TileMatrix={z}&TileRow={y}&TileCol={x}',
                'http://140.237.73.123:9058/stifs/maps.do?service=WMTS&request=GetTile&version=1.0.0&layer=zzcva&style=default&format=image/png&TileMatrixSet=WholeWorld_CRS_84&TileMatrix={z}&TileRow={y}&TileCol={x}'
            ],
            icon: 'assets/img/basemap-2.png',
            title: '福建天地图矢量',
            simpleTitle: '矢量',
            type: 0
        }
    ];
    // 水系专题图配置。
    var river = {
        id: 'zzRiver',
        url: [
            'http://140.237.73.123:9052/zzhb/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=zzhb%3AWT_BASIN_PLANE_L_DATA&outputFormat=application%2Fjson',
            'http://140.237.73.123:9052/zzhb/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=zzhb%3AWT_BASIN_PLANE_P_DATA&outputFormat=application%2Fjson'
        ],
        // 外层数组，0：河流，1：水库。内层数组按照水质等级排列。
        waterQualityConfig: [
            [
                {
                    color: '#2ba4e9',
                    title: 'Ⅰ类水环境'
                },
                {
                    color: '#2ba4e9',
                    title: 'Ⅱ类水环境'
                },
                {
                    color: '#45b97c',
                    title: 'Ⅲ类水环境'
                },
                {
                    color: '#FFFF00',
                    title: 'Ⅳ类水环境'
                },
                {
                    color: '#f47920',
                    title: 'Ⅴ类水环境'
                },
                {
                    color: '#d02032',
                    title: '劣Ⅴ类水环境'
                }
            ],
            [// 数组按照 1~++ 进行排列，如果前面没有，需要用 null 占位。
                {
                    color: '#60e1e9',
                    title: '水库Ⅰ类水环境'
                },
                {
                    color: '#237e2b',
                    title: '水库Ⅱ类水环境'
                },
                {
                    color: '#1d58f9',
                    title: '水库Ⅲ类水环境'
                }
            ]
        ],
        //水系底图默认配置颜色
        //defaultColor: '#747474'
        defaultColor: '#747474'

};

    // 服务接口配置。
    var server = {
        featureNS: 'http://140.237.73.123:9052/zzhb',
        featurePrefix: 'zzhb',
        wfs: 'http://140.237.73.123:9052/wfs'
    };

    return {
        baseMaps: baseMaps,
        river: river,
        server: server
    };
}();