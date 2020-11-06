Array.prototype.indexOf = function (val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == val)
            return i;
    }
    return -1;
};
Array.prototype.remove = function (val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

// JQuery方法定制
(function ($) {
    /**
     * 获取form表单数据
     */
    $.fn.getFormData = function (isValid) {
        var fieldElem = $(this).find('input,select,textarea'); //获取所有表单域
        var data = {};
        $.each(fieldElem, function (index, item) {
            if (!item.name) return;
            if (/^checkbox|radio$/.test(item.type) && !item.checked) return;
            var value = item.value;
            if (item.type == "checkbox") {//如果多选
                if (data[item.name]) {
                    value = data[item.name] + "," + value;
                }
            }
            if (isValid) {
                //如果为true,只需要处理有数据的值
                if (!$.isEmpty(value)) {
                    data[item.name] = value;
                }
            }
            else {
                data[item.name] = value;
            }
        });
        return data;
    };

    $.fn.serializeJson = function () {
        var serializeObj = {};
        var array = this.serializeArray();
        var str = this.serialize();
        $(array).each(
            function () {
                if (serializeObj[this.name]) {
                    if ($.isArray(serializeObj[this.name])) {
                        serializeObj[this.name].push(this.value);
                    } else {
                        serializeObj[this.name] = [
                            serializeObj[this.name], this.value];
                    }
                } else {
                    serializeObj[this.name] = this.value;
                }
            });
        return serializeObj;
    };


    $.extend({
        //非空判断
        isEmpty: function (value) {
            if (value === null || value == undefined || value === '') {
                return true;
            }
            return false;
        },
        //获取对象指
        result: function (object, path, defaultValue) {
            var value = "";
            if (!$.isEmpty(object) && $.isObject(object) && !$.isEmpty(path)) {
                var paths = path.split('.');
                var length = paths.length;
                $.each(paths, function (i, v) {
                    object = object[v];
                    if (length - 1 == i) {
                        value = object;
                    }
                    if (!$.isObject(object)) {
                        return false;
                    }
                })

            }

            if ($.isEmpty(value) && !$.isEmpty(defaultValue)) {
                value = defaultValue;
            }
            return value;
        },
        //判断是否obj对象
        isObject: function (value) {
            var type = typeof value;
            return value != null && (type == 'object' || type == 'function');
        },
        //是否以某个字符开头
        startsWith: function (value, target) {
            return value.indexOf(target) == 0;
        },
        //设置sessionStorage
        setSessionStorage: function (key, data) {
            sessionStorage.setItem(key, data);
        },
        //获取sessionStorage
        getSessionStorage: function (key) {
            return sessionStorage.getItem(key) == null ? "" : sessionStorage.getItem(key);
        },
        //删除sessionStorage
        removeSessionStorage: function (key) {
            sessionStorage.removeItem(key);
        },
        //清除sessionStorage
        clearSessionStorage: function () {
            sessionStorage.clear();
        },
        uuid: function () {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }
    });
}(jQuery));