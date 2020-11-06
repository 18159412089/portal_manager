/*!
 *	ZhangGQ
 */

//包的预定义函数
function MACRO_PACKAGE_DEFINE(packageName) {
	var names = packageName.split(".");
	var currentPackage = null;
	for (var i = 0; i < names.length; i++) {
		var name = names[i];
		if (i === 0) {
			if (!this[name]) {
				this[name] = {};
			}
			currentPackage = this[name];
		} else {
			if (!currentPackage[name]) {
				currentPackage[name] = {};
			}
			currentPackage = currentPackage[name];
		}
	}
}

MACRO_PACKAGE_DEFINE("fjzx.ui")
//fjzx.ui具有的方法一览
fjzx.ui.functionList = {
	//
};

fjzx.ui.ComponentSelect = function($comboboxSelect,opt_options){
	var options = opt_options || {};
	this._mouseOver = false;
	
	this._onChangeCallback = options.onChangeCallback;
	var thisComponent = $comboboxSelect.combobox({
		url: options.url,
		valueField: "id",
		textField: "text",
		editable: true,
		panelHeight:'auto',
		panelMaxHeight:'240',
		method:'get',
		labelPosition:'left',
		multiple:false,
		value: "",
		onLoadSuccess: function(){	//加载完成后选择第一项
			var val = $(this).combobox("getData");
			if(val!=null){
				$(this).combobox("select", val[0].id);
			}
			if(typeof(thisComponent._onLoadSuccessCallback)=="function"){
				this._onLoadSuccessCallback($(this));
			}
		},
		onChange: function(newValue, oldValue){
			if(typeof(thisComponent._onChangeCallback)=="function"){
				this._onChangeCallback(newValue, oldValue);
			}
		}
	});
	
	return thisComponent;
};

fjzx.ui.ComponentSelect.prototype = {
	setOnChange: function(onChangeCallback){
		this._onChangeCallback = onChangeCallback;
	}
};