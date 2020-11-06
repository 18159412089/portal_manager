//图表数据插入
function setCharts(charts, title, xAxis, series) {
	charts.hideLoading();
	charts.clear();
	var option = {
		title : {
			text : title
		},
		legend : {
			data : [ 'PM2.5', 'PM10', 'CO', 'NO2', 'SO2', 'O3' ]
		},
		toolbox : { // 可视化的工具箱
			show : true,
			feature : {
				saveAsImage : {// 保存图片
					show : true
				}
			}
		},
		tooltip : {
			trigger : 'axis',
			axisPointer : {
				type : 'shadow'
			},
			formatter : function(params) {
				var res = params[0].name + "<br/>";
				for (let i = 0; i < params.length - 1; i++) {
					res += params[i].seriesName + ":" + params[i].value
							+ "<br/>"
				}
				return res;
			}
		},
		grid : {
			left : '3%',
			right : '4%',
			bottom : '3%',
			containLabel : true
		},
		xAxis : [ {
			axisLabel : { // xAxis，yAxis，axis都有axisLabel属性对象
				show : true, // 默认为true，设为false后下面都没有意义了
				interval : 0, // 此处关键， 设置文本标签全部显示
				rotate : 18, // 标签旋转角度，对于长文本标签设置旋转可避免文本重叠
			},
			type : 'category',
			data : xAxis
		} ],
		yAxis : [ {
			type : 'value'
		} ],
		series : [ {
			name : "首要污染物",
			type : "bar",
			data : series,
			itemStyle : {
				normal : {
					label : {
						show : true, // 开启显示
						position : 'top', // 在上方显示
						textStyle : { // 数值样式
							color : 'black',
							fontSize : 16
						}
					}
				}
			},
		} ]
	};
	charts.setOption(option);
}

// 传递图表容器id
function downloadImpByChart(chartId) {
	var myChart = echarts.getInstanceByDom(document.getElementById(chartId));
	if(typeof (myChart.getOption().title)=="undefined") {
		$.messager.alert('警告','暂无数据');
		return ;
	};
	var url = myChart.getConnectedDataURL({
		pixelRatio: 5,　　// 导出的图片分辨率比率,默认是1
		backgroundColor: '#fff',　　// 图表背景色
		excludeComponents:[　　// 保存图表时忽略的工具组件,默认忽略工具栏
		'toolbox'
		],
		type:'png'　　// 图片类型支持png和jpeg
	});
	var $a = document.createElement('a');
	var type = 'png';
	$a.download = myChart.getOption().title[0].text + '.' + type;

	$a.target = '_blank';
	$a.href = url;
	// Chrome and Firefox
	if (typeof MouseEvent === 'function') {
		var evt = new MouseEvent('click', {
			view: window,
			bubbles: true,
			cancelable: false
		});
		$a.dispatchEvent(evt);
	}
	// IE
	else {
		var html = ''
            + '<body style="margin:0;">'
            + '<img src="' + url + '" style="max-width:100%;" title="' +  myChart.getOption().title[0].text + '" />'
            + '</body>';
        var tab = window.open();
        tab.document.write(html);
	}
};