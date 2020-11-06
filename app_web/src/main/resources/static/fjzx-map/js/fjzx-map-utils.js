/**
 * 构造HashMap类
 * @returns
 */
function HashMap() {
	this.map = {};
}

HashMap.prototype = {
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

HashMap.prototype.constructor = HashMap;

(function($) {
	$.getUUID = function() {
		var s = [];
		var hexDigits = "0123456789ABCDEF";
		for (var i = 0; i < 32; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[12] = "4";
		s[16] = hexDigits.substr((s[16] & 0x3) | 0x8, 1);
		var uuid = s.join("");
		return uuid;
	};
    $.formatStr = function(str, obj) {
        function replaceWithPattern(str, obj, isText) {
            str = str.toString();
            var pattern = /(\{text:(.*?)\})/;
            if (!isText)
                pattern = /(\{html:(.*?)\})/;
            var tmpStr = str;
            var match = pattern.exec(tmpStr);
            while (match) {
                if (obj[match[2]]) {
                    var s = String(obj[match[2]]);
                    if (isText) {
                        s = s.replace(/</g, "&lt;");
                        s = s.replace(/>/g, "&gt;");
                    }
                    str = str.replace(match[1], s);
                } else if (String(obj[match[2]]) == "0") {
                    str = str.replace(match[1], "0");
                } else {
                    str = str.replace(match[1], "");
                }
                tmpStr = tmpStr.replace(pattern, "");
                match = pattern.exec(tmpStr);
            }
            return str;
        }
        str = replaceWithPattern(str, obj, true);
        str = replaceWithPattern(str, obj, false);
        return str;
    };
})(jQuery);