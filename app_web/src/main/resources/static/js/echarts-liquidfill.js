!function (t, e) {
    "object" == typeof exports && "object" == typeof module ? module.exports = e(require("echarts")) : "function" == typeof define && define.amd ? define(["echarts"], e) : "object" == typeof exports ? exports["echarts-liquidfill"] = e(require("echarts")) : t["echarts-liquidfill"] = e(t.echarts)
}(window, function (t) {
    return function (t) {
        var e = {};

        function n(r) {
            if (e[r]) return e[r].exports;
            var i = e[r] = {i: r, l: !1, exports: {}};
            return t[r].call(i.exports, i, i.exports, n), i.l = !0, i.exports
        }

        return n.m = t, n.c = e, n.d = function (t, e, r) {
            n.o(t, e) || Object.defineProperty(t, e, {enumerable: !0, get: r})
        }, n.r = function (t) {
            "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(t, Symbol.toStringTag, {value: "Module"}), Object.defineProperty(t, "__esModule", {value: !0})
        }, n.t = function (t, e) {
            if (1 & e && (t = n(t)), 8 & e) return t;
            if (4 & e && "object" == typeof t && t && t.__esModule) return t;
            var r = Object.create(null);
            if (n.r(r), Object.defineProperty(r, "default", {
                enumerable: !0,
                value: t
            }), 2 & e && "string" != typeof t) for (var i in t) n.d(r, i, function (e) {
                return t[e]
            }.bind(null, i));
            return r
        }, n.n = function (t) {
            var e = t && t.__esModule ? function () {
                return t.default
            } : function () {
                return t
            };
            return n.d(e, "a", e), e
        }, n.o = function (t, e) {
            return Object.prototype.hasOwnProperty.call(t, e)
        }, n.p = "", n(n.s = 26)
    }([function (t, e) {
        var n = {
                "[object Function]": 1,
                "[object RegExp]": 1,
                "[object Date]": 1,
                "[object Error]": 1,
                "[object CanvasGradient]": 1,
                "[object CanvasPattern]": 1,
                "[object Image]": 1,
                "[object Canvas]": 1
            }, r = {
                "[object Int8Array]": 1,
                "[object Uint8Array]": 1,
                "[object Uint8ClampedArray]": 1,
                "[object Int16Array]": 1,
                "[object Uint16Array]": 1,
                "[object Int32Array]": 1,
                "[object Uint32Array]": 1,
                "[object Float32Array]": 1,
                "[object Float64Array]": 1
            }, i = Object.prototype.toString, a = Array.prototype, o = a.forEach, s = a.filter, l = a.slice, h = a.map,
            u = a.reduce, c = {};

        function f(t) {
            if (null == t || "object" != typeof t) return t;
            var e = t, a = i.call(t);
            if ("[object Array]" === a) {
                if (!T(t)) {
                    e = [];
                    for (var o = 0, s = t.length; o < s; o++) e[o] = f(t[o])
                }
            } else if (r[a]) {
                if (!T(t)) {
                    var l = t.constructor;
                    if (t.constructor.from) e = l.from(t); else {
                        e = new l(t.length);
                        for (o = 0, s = t.length; o < s; o++) e[o] = f(t[o])
                    }
                }
            } else if (!n[a] && !T(t) && !b(t)) for (var h in e = {}, t) t.hasOwnProperty(h) && (e[h] = f(t[h]));
            return e
        }

        function d(t, e, n) {
            if (!_(e) || !_(t)) return n ? f(e) : t;
            for (var r in e) if (e.hasOwnProperty(r)) {
                var i = t[r], a = e[r];
                !_(a) || !_(i) || x(a) || x(i) || b(a) || b(i) || w(a) || w(i) || T(a) || T(i) ? !n && r in t || (t[r] = f(e[r])) : d(i, a, n)
            }
            return t
        }

        function p(t, e, n) {
            for (var r in e) e.hasOwnProperty(r) && (n ? null != e[r] : null == t[r]) && (t[r] = e[r]);
            return t
        }

        var v, g = function () {
            return c.createCanvas()
        };

        function y(t, e, n) {
            if (t && e) if (t.forEach && t.forEach === o) t.forEach(e, n); else if (t.length === +t.length) for (var r = 0, i = t.length; r < i; r++) e.call(n, t[r], r, t); else for (var a in t) t.hasOwnProperty(a) && e.call(n, t[a], a, t)
        }

        function m(t, e) {
            var n = l.call(arguments, 2);
            return function () {
                return t.apply(e, n.concat(l.call(arguments)))
            }
        }

        function x(t) {
            return "[object Array]" === i.call(t)
        }

        function _(t) {
            var e = typeof t;
            return "function" === e || !!t && "object" == e
        }

        function w(t) {
            return !!n[i.call(t)]
        }

        function b(t) {
            return "object" == typeof t && "number" == typeof t.nodeType && "object" == typeof t.ownerDocument
        }

        c.createCanvas = function () {
            return document.createElement("canvas")
        };
        var S = "__ec_primitive__";

        function T(t) {
            return t[S]
        }

        function M(t) {
            var e = x(t), n = this;

            function r(t, r) {
                e ? n.set(t, r) : n.set(r, t)
            }

            t instanceof M ? t.each(r) : t && y(t, r)
        }

        M.prototype = {
            constructor: M, get: function (t) {
                return this.hasOwnProperty(t) ? this[t] : null
            }, set: function (t, e) {
                return this[t] = e
            }, each: function (t, e) {
                for (var n in void 0 !== e && (t = m(t, e)), this) this.hasOwnProperty(n) && t(this[n], n)
            }, removeKey: function (t) {
                delete this[t]
            }
        }, e.$override = function (t, e) {
            "createCanvas" === t && (v = null), c[t] = e
        }, e.clone = f, e.merge = d, e.mergeAll = function (t, e) {
            for (var n = t[0], r = 1, i = t.length; r < i; r++) n = d(n, t[r], e);
            return n
        }, e.extend = function (t, e) {
            for (var n in e) e.hasOwnProperty(n) && (t[n] = e[n]);
            return t
        }, e.defaults = p, e.createCanvas = g, e.getContext = function () {
            return v || (v = g().getContext("2d")), v
        }, e.indexOf = function (t, e) {
            if (t) {
                if (t.indexOf) return t.indexOf(e);
                for (var n = 0, r = t.length; n < r; n++) if (t[n] === e) return n
            }
            return -1
        }, e.inherits = function (t, e) {
            var n = t.prototype;

            function r() {
            }

            for (var i in r.prototype = e.prototype, t.prototype = new r, n) t.prototype[i] = n[i];
            t.prototype.constructor = t, t.superClass = e
        }, e.mixin = function (t, e, n) {
            p(t = "prototype" in t ? t.prototype : t, e = "prototype" in e ? e.prototype : e, n)
        }, e.isArrayLike = function (t) {
            if (t) return "string" != typeof t && "number" == typeof t.length
        }, e.each = y, e.map = function (t, e, n) {
            if (t && e) {
                if (t.map && t.map === h) return t.map(e, n);
                for (var r = [], i = 0, a = t.length; i < a; i++) r.push(e.call(n, t[i], i, t));
                return r
            }
        }, e.reduce = function (t, e, n, r) {
            if (t && e) {
                if (t.reduce && t.reduce === u) return t.reduce(e, n, r);
                for (var i = 0, a = t.length; i < a; i++) n = e.call(r, n, t[i], i, t);
                return n
            }
        }, e.filter = function (t, e, n) {
            if (t && e) {
                if (t.filter && t.filter === s) return t.filter(e, n);
                for (var r = [], i = 0, a = t.length; i < a; i++) e.call(n, t[i], i, t) && r.push(t[i]);
                return r
            }
        }, e.find = function (t, e, n) {
            if (t && e) for (var r = 0, i = t.length; r < i; r++) if (e.call(n, t[r], r, t)) return t[r]
        }, e.bind = m, e.curry = function (t) {
            var e = l.call(arguments, 1);
            return function () {
                return t.apply(this, e.concat(l.call(arguments)))
            }
        }, e.isArray = x, e.isFunction = function (t) {
            return "function" == typeof t
        }, e.isString = function (t) {
            return "[object String]" === i.call(t)
        }, e.isObject = _, e.isBuiltInObject = w, e.isTypedArray = function (t) {
            return !!r[i.call(t)]
        }, e.isDom = b, e.eqNaN = function (t) {
            return t != t
        }, e.retrieve = function (t) {
            for (var e = 0, n = arguments.length; e < n; e++) if (null != arguments[e]) return arguments[e]
        }, e.retrieve2 = function (t, e) {
            return null != t ? t : e
        }, e.retrieve3 = function (t, e, n) {
            return null != t ? t : null != e ? e : n
        }, e.slice = function () {
            return Function.call.apply(l, arguments)
        }, e.normalizeCssArray = function (t) {
            if ("number" == typeof t) return [t, t, t, t];
            var e = t.length;
            return 2 === e ? [t[0], t[1], t[0], t[1]] : 3 === e ? [t[0], t[1], t[2], t[1]] : t
        }, e.assert = function (t, e) {
            if (!t) throw new Error(e)
        }, e.trim = function (t) {
            return null == t ? null : "function" == typeof t.trim ? t.trim() : t.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, "")
        }, e.setAsPrimitive = function (t) {
            t[S] = !0
        }, e.isPrimitive = T, e.createHashMap = function (t) {
            return new M(t)
        }, e.concatArray = function (t, e) {
            for (var n = new t.constructor(t.length + e.length), r = 0; r < t.length; r++) n[r] = t[r];
            var i = t.length;
            for (r = 0; r < e.length; r++) n[r + i] = e[r];
            return n
        }, e.noop = function () {
        }
    }, function (t, e, n) {
        var r = n(7), i = n(0), a = n(8), o = n(49), s = n(55).prototype.getCanvasPattern, l = Math.abs, h = new a(!0);

        function u(t) {
            r.call(this, t), this.path = null
        }

        u.prototype = {
            constructor: u,
            type: "path",
            __dirtyPath: !0,
            strokeContainThreshold: 5,
            brush: function (t, e) {
                var n, r = this.style, i = this.path || h, a = r.hasStroke(), o = r.hasFill(), l = r.fill, u = r.stroke,
                    c = o && !!l.colorStops, f = a && !!u.colorStops, d = o && !!l.image, p = a && !!u.image;
                (r.bind(t, this, e), this.setTransform(t), this.__dirty) && (c && (n = n || this.getBoundingRect(), this._fillGradient = r.getGradient(t, l, n)), f && (n = n || this.getBoundingRect(), this._strokeGradient = r.getGradient(t, u, n)));
                c ? t.fillStyle = this._fillGradient : d && (t.fillStyle = s.call(l, t)), f ? t.strokeStyle = this._strokeGradient : p && (t.strokeStyle = s.call(u, t));
                var v = r.lineDash, g = r.lineDashOffset, y = !!t.setLineDash, m = this.getGlobalScale();
                i.setScale(m[0], m[1]), this.__dirtyPath || v && !y && a ? (i.beginPath(t), v && !y && (i.setLineDash(v), i.setLineDashOffset(g)), this.buildPath(i, this.shape, !1), this.path && (this.__dirtyPath = !1)) : (t.beginPath(), this.path.rebuildPath(t)), o && i.fill(t), v && y && (t.setLineDash(v), t.lineDashOffset = g), a && i.stroke(t), v && y && t.setLineDash([]), null != r.text && (this.restoreTransform(t), this.drawRectText(t, this.getBoundingRect()))
            },
            buildPath: function (t, e, n) {
            },
            createPathProxy: function () {
                this.path = new a
            },
            getBoundingRect: function () {
                var t = this._rect, e = this.style, n = !t;
                if (n) {
                    var r = this.path;
                    r || (r = this.path = new a), this.__dirtyPath && (r.beginPath(), this.buildPath(r, this.shape, !1)), t = r.getBoundingRect()
                }
                if (this._rect = t, e.hasStroke()) {
                    var i = this._rectWithStroke || (this._rectWithStroke = t.clone());
                    if (this.__dirty || n) {
                        i.copy(t);
                        var o = e.lineWidth, s = e.strokeNoScale ? this.getLineScale() : 1;
                        e.hasFill() || (o = Math.max(o, this.strokeContainThreshold || 4)), s > 1e-10 && (i.width += o / s, i.height += o / s, i.x -= o / s / 2, i.y -= o / s / 2)
                    }
                    return i
                }
                return t
            },
            contain: function (t, e) {
                var n = this.transformCoordToLocal(t, e), r = this.getBoundingRect(), i = this.style;
                if (t = n[0], e = n[1], r.contain(t, e)) {
                    var a = this.path.data;
                    if (i.hasStroke()) {
                        var s = i.lineWidth, l = i.strokeNoScale ? this.getLineScale() : 1;
                        if (l > 1e-10 && (i.hasFill() || (s = Math.max(s, this.strokeContainThreshold)), o.containStroke(a, s / l, t, e))) return !0
                    }
                    if (i.hasFill()) return o.contain(a, t, e)
                }
                return !1
            },
            dirty: function (t) {
                null == t && (t = !0), t && (this.__dirtyPath = t, this._rect = null), this.__dirty = !0, this.__zr && this.__zr.refresh(), this.__clipTarget && this.__clipTarget.dirty()
            },
            animateShape: function (t) {
                return this.animate("shape", t)
            },
            attrKV: function (t, e) {
                "shape" === t ? (this.setShape(e), this.__dirtyPath = !0, this._rect = null) : r.prototype.attrKV.call(this, t, e)
            },
            setShape: function (t, e) {
                var n = this.shape;
                if (n) {
                    if (i.isObject(t)) for (var r in t) t.hasOwnProperty(r) && (n[r] = t[r]); else n[t] = e;
                    this.dirty(!0)
                }
                return this
            },
            getLineScale: function () {
                var t = this.transform;
                return t && l(t[0] - 1) > 1e-10 && l(t[3] - 1) > 1e-10 ? Math.sqrt(l(t[0] * t[3] - t[2] * t[1])) : 1
            }
        }, u.extend = function (t) {
            var e = function (e) {
                u.call(this, e), t.style && this.style.extendFrom(t.style, !1);
                var n = t.shape;
                if (n) {
                    this.shape = this.shape || {};
                    var r = this.shape;
                    for (var i in n) !r.hasOwnProperty(i) && n.hasOwnProperty(i) && (r[i] = n[i])
                }
                t.init && t.init.call(this, e)
            };
            for (var n in i.inherits(e, u), t) "style" !== n && "shape" !== n && (e.prototype[n] = t[n]);
            return e
        }, i.inherits(u, r);
        var c = u;
        t.exports = c
    }, function (t, e) {
        var n = "undefined" == typeof Float32Array ? Array : Float32Array;

        function r(t) {
            return Math.sqrt(a(t))
        }

        var i = r;

        function a(t) {
            return t[0] * t[0] + t[1] * t[1]
        }

        var o = a;

        function s(t, e) {
            return Math.sqrt((t[0] - e[0]) * (t[0] - e[0]) + (t[1] - e[1]) * (t[1] - e[1]))
        }

        var l = s;

        function h(t, e) {
            return (t[0] - e[0]) * (t[0] - e[0]) + (t[1] - e[1]) * (t[1] - e[1])
        }

        var u = h;
        e.create = function (t, e) {
            var r = new n(2);
            return null == t && (t = 0), null == e && (e = 0), r[0] = t, r[1] = e, r
        }, e.copy = function (t, e) {
            return t[0] = e[0], t[1] = e[1], t
        }, e.clone = function (t) {
            var e = new n(2);
            return e[0] = t[0], e[1] = t[1], e
        }, e.set = function (t, e, n) {
            return t[0] = e, t[1] = n, t
        }, e.add = function (t, e, n) {
            return t[0] = e[0] + n[0], t[1] = e[1] + n[1], t
        }, e.scaleAndAdd = function (t, e, n, r) {
            return t[0] = e[0] + n[0] * r, t[1] = e[1] + n[1] * r, t
        }, e.sub = function (t, e, n) {
            return t[0] = e[0] - n[0], t[1] = e[1] - n[1], t
        }, e.len = r, e.length = i, e.lenSquare = a, e.lengthSquare = o, e.mul = function (t, e, n) {
            return t[0] = e[0] * n[0], t[1] = e[1] * n[1], t
        }, e.div = function (t, e, n) {
            return t[0] = e[0] / n[0], t[1] = e[1] / n[1], t
        }, e.dot = function (t, e) {
            return t[0] * e[0] + t[1] * e[1]
        }, e.scale = function (t, e, n) {
            return t[0] = e[0] * n, t[1] = e[1] * n, t
        }, e.normalize = function (t, e) {
            var n = r(e);
            return 0 === n ? (t[0] = 0, t[1] = 0) : (t[0] = e[0] / n, t[1] = e[1] / n), t
        }, e.distance = s, e.dist = l, e.distanceSquare = h, e.distSquare = u, e.negate = function (t, e) {
            return t[0] = -e[0], t[1] = -e[1], t
        }, e.lerp = function (t, e, n, r) {
            return t[0] = e[0] + r * (n[0] - e[0]), t[1] = e[1] + r * (n[1] - e[1]), t
        }, e.applyTransform = function (t, e, n) {
            var r = e[0], i = e[1];
            return t[0] = n[0] * r + n[2] * i + n[4], t[1] = n[1] * r + n[3] * i + n[5], t
        }, e.min = function (t, e, n) {
            return t[0] = Math.min(e[0], n[0]), t[1] = Math.min(e[1], n[1]), t
        }, e.max = function (t, e, n) {
            return t[0] = Math.max(e[0], n[0]), t[1] = Math.max(e[1], n[1]), t
        }
    }, function (t, e, n) {
        var r = n(2), i = n(9), a = r.applyTransform, o = Math.min, s = Math.max;

        function l(t, e, n, r) {
            n < 0 && (t += n, n = -n), r < 0 && (e += r, r = -r), this.x = t, this.y = e, this.width = n, this.height = r
        }

        l.prototype = {
            constructor: l, union: function (t) {
                var e = o(t.x, this.x), n = o(t.y, this.y);
                this.width = s(t.x + t.width, this.x + this.width) - e, this.height = s(t.y + t.height, this.y + this.height) - n, this.x = e, this.y = n
            }, applyTransform: function () {
                var t = [], e = [], n = [], r = [];
                return function (i) {
                    if (i) {
                        t[0] = n[0] = this.x, t[1] = r[1] = this.y, e[0] = r[0] = this.x + this.width, e[1] = n[1] = this.y + this.height, a(t, t, i), a(e, e, i), a(n, n, i), a(r, r, i), this.x = o(t[0], e[0], n[0], r[0]), this.y = o(t[1], e[1], n[1], r[1]);
                        var l = s(t[0], e[0], n[0], r[0]), h = s(t[1], e[1], n[1], r[1]);
                        this.width = l - this.x, this.height = h - this.y
                    }
                }
            }(), calculateTransform: function (t) {
                var e = this, n = t.width / e.width, r = t.height / e.height, a = i.create();
                return i.translate(a, a, [-e.x, -e.y]), i.scale(a, a, [n, r]), i.translate(a, a, [t.x, t.y]), a
            }, intersect: function (t) {
                if (!t) return !1;
                t instanceof l || (t = l.create(t));
                var e = this, n = e.x, r = e.x + e.width, i = e.y, a = e.y + e.height, o = t.x, s = t.x + t.width,
                    h = t.y, u = t.y + t.height;
                return !(r < o || s < n || a < h || u < i)
            }, contain: function (t, e) {
                return t >= this.x && t <= this.x + this.width && e >= this.y && e <= this.y + this.height
            }, clone: function () {
                return new l(this.x, this.y, this.width, this.height)
            }, copy: function (t) {
                this.x = t.x, this.y = t.y, this.width = t.width, this.height = t.height
            }, plain: function () {
                return {x: this.x, y: this.y, width: this.width, height: this.height}
            }
        }, l.create = function (t) {
            return new l(t.x, t.y, t.width, t.height)
        };
        var h = l;
        t.exports = h
    }, function (t, e, n) {
        var r = n(2), i = r.create, a = r.distSquare, o = Math.pow, s = Math.sqrt, l = 1e-8, h = 1e-4, u = s(3),
            c = 1 / 3, f = i(), d = i(), p = i();

        function v(t) {
            return t > -l && t < l
        }

        function g(t) {
            return t > l || t < -l
        }

        function y(t, e, n, r, i) {
            var a = 1 - i;
            return a * a * (a * t + 3 * i * e) + i * i * (i * r + 3 * a * n)
        }

        function m(t, e, n, r) {
            var i = 1 - r;
            return i * (i * t + 2 * r * e) + r * r * n
        }

        e.cubicAt = y, e.cubicDerivativeAt = function (t, e, n, r, i) {
            var a = 1 - i;
            return 3 * (((e - t) * a + 2 * (n - e) * i) * a + (r - n) * i * i)
        }, e.cubicRootAt = function (t, e, n, r, i, a) {
            var l = r + 3 * (e - n) - t, h = 3 * (n - 2 * e + t), f = 3 * (e - t), d = t - i, p = h * h - 3 * l * f,
                g = h * f - 9 * l * d, y = f * f - 3 * h * d, m = 0;
            if (v(p) && v(g)) v(h) ? a[0] = 0 : (O = -f / h) >= 0 && O <= 1 && (a[m++] = O); else {
                var x = g * g - 4 * p * y;
                if (v(x)) {
                    var _ = g / p, w = -_ / 2;
                    (O = -h / l + _) >= 0 && O <= 1 && (a[m++] = O), w >= 0 && w <= 1 && (a[m++] = w)
                } else if (x > 0) {
                    var b = s(x), S = p * h + 1.5 * l * (-g + b), T = p * h + 1.5 * l * (-g - b);
                    (O = (-h - ((S = S < 0 ? -o(-S, c) : o(S, c)) + (T = T < 0 ? -o(-T, c) : o(T, c)))) / (3 * l)) >= 0 && O <= 1 && (a[m++] = O)
                } else {
                    var M = (2 * p * h - 3 * l * g) / (2 * s(p * p * p)), P = Math.acos(M) / 3, k = s(p),
                        C = Math.cos(P), O = (-h - 2 * k * C) / (3 * l),
                        A = (w = (-h + k * (C + u * Math.sin(P))) / (3 * l), (-h + k * (C - u * Math.sin(P))) / (3 * l));
                    O >= 0 && O <= 1 && (a[m++] = O), w >= 0 && w <= 1 && (a[m++] = w), A >= 0 && A <= 1 && (a[m++] = A)
                }
            }
            return m
        }, e.cubicExtrema = function (t, e, n, r, i) {
            var a = 6 * n - 12 * e + 6 * t, o = 9 * e + 3 * r - 3 * t - 9 * n, l = 3 * e - 3 * t, h = 0;
            if (v(o)) g(a) && (c = -l / a) >= 0 && c <= 1 && (i[h++] = c); else {
                var u = a * a - 4 * o * l;
                if (v(u)) i[0] = -a / (2 * o); else if (u > 0) {
                    var c, f = s(u), d = (-a - f) / (2 * o);
                    (c = (-a + f) / (2 * o)) >= 0 && c <= 1 && (i[h++] = c), d >= 0 && d <= 1 && (i[h++] = d)
                }
            }
            return h
        }, e.cubicSubdivide = function (t, e, n, r, i, a) {
            var o = (e - t) * i + t, s = (n - e) * i + e, l = (r - n) * i + n, h = (s - o) * i + o, u = (l - s) * i + s,
                c = (u - h) * i + h;
            a[0] = t, a[1] = o, a[2] = h, a[3] = c, a[4] = c, a[5] = u, a[6] = l, a[7] = r
        }, e.cubicProjectPoint = function (t, e, n, r, i, o, l, u, c, v, g) {
            var m, x, _, w, b, S = .005, T = 1 / 0;
            f[0] = c, f[1] = v;
            for (var M = 0; M < 1; M += .05) d[0] = y(t, n, i, l, M), d[1] = y(e, r, o, u, M), (w = a(f, d)) < T && (m = M, T = w);
            T = 1 / 0;
            for (var P = 0; P < 32 && !(S < h); P++) x = m - S, _ = m + S, d[0] = y(t, n, i, l, x), d[1] = y(e, r, o, u, x), w = a(d, f), x >= 0 && w < T ? (m = x, T = w) : (p[0] = y(t, n, i, l, _), p[1] = y(e, r, o, u, _), b = a(p, f), _ <= 1 && b < T ? (m = _, T = b) : S *= .5);
            return g && (g[0] = y(t, n, i, l, m), g[1] = y(e, r, o, u, m)), s(T)
        }, e.quadraticAt = m, e.quadraticDerivativeAt = function (t, e, n, r) {
            return 2 * ((1 - r) * (e - t) + r * (n - e))
        }, e.quadraticRootAt = function (t, e, n, r, i) {
            var a = t - 2 * e + n, o = 2 * (e - t), l = t - r, h = 0;
            if (v(a)) g(o) && (c = -l / o) >= 0 && c <= 1 && (i[h++] = c); else {
                var u = o * o - 4 * a * l;
                if (v(u)) (c = -o / (2 * a)) >= 0 && c <= 1 && (i[h++] = c); else if (u > 0) {
                    var c, f = s(u), d = (-o - f) / (2 * a);
                    (c = (-o + f) / (2 * a)) >= 0 && c <= 1 && (i[h++] = c), d >= 0 && d <= 1 && (i[h++] = d)
                }
            }
            return h
        }, e.quadraticExtremum = function (t, e, n) {
            var r = t + n - 2 * e;
            return 0 === r ? .5 : (t - e) / r
        }, e.quadraticSubdivide = function (t, e, n, r, i) {
            var a = (e - t) * r + t, o = (n - e) * r + e, s = (o - a) * r + a;
            i[0] = t, i[1] = a, i[2] = s, i[3] = s, i[4] = o, i[5] = n
        }, e.quadraticProjectPoint = function (t, e, n, r, i, o, l, u, c) {
            var v, g = .005, y = 1 / 0;
            f[0] = l, f[1] = u;
            for (var x = 0; x < 1; x += .05) d[0] = m(t, n, i, x), d[1] = m(e, r, o, x), (S = a(f, d)) < y && (v = x, y = S);
            y = 1 / 0;
            for (var _ = 0; _ < 32 && !(g < h); _++) {
                var w = v - g, b = v + g;
                d[0] = m(t, n, i, w), d[1] = m(e, r, o, w);
                var S = a(d, f);
                if (w >= 0 && S < y) v = w, y = S; else {
                    p[0] = m(t, n, i, b), p[1] = m(e, r, o, b);
                    var T = a(p, f);
                    b <= 1 && T < y ? (v = b, y = T) : g *= .5
                }
            }
            return c && (c[0] = m(t, n, i, v), c[1] = m(e, r, o, v)), s(y)
        }
    }, function (e, n) {
        e.exports = t
    }, function (t, e, n) {
        (function (t) {
            var n;
            "undefined" != typeof window ? n = window.__DEV__ : void 0 !== t && (n = t.__DEV__), void 0 === n && (n = !0);
            var r = n;
            e.__DEV__ = r
        }).call(this, n(31))
    }, function (t, e, n) {
        var r = n(0), i = n(39), a = n(15), o = n(47);

        function s(t) {
            for (var e in t = t || {}, a.call(this, t), t) t.hasOwnProperty(e) && "style" !== e && (this[e] = t[e]);
            this.style = new i(t.style, this), this._rect = null, this.__clipPaths = []
        }

        s.prototype = {
            constructor: s,
            type: "displayable",
            __dirty: !0,
            invisible: !1,
            z: 0,
            z2: 0,
            zlevel: 0,
            draggable: !1,
            dragging: !1,
            silent: !1,
            culling: !1,
            cursor: "pointer",
            rectHover: !1,
            progressive: !1,
            incremental: !1,
            inplace: !1,
            beforeBrush: function (t) {
            },
            afterBrush: function (t) {
            },
            brush: function (t, e) {
            },
            getBoundingRect: function () {
            },
            contain: function (t, e) {
                return this.rectContain(t, e)
            },
            traverse: function (t, e) {
                t.call(e, this)
            },
            rectContain: function (t, e) {
                var n = this.transformCoordToLocal(t, e);
                return this.getBoundingRect().contain(n[0], n[1])
            },
            dirty: function () {
                this.__dirty = !0, this._rect = null, this.__zr && this.__zr.refresh()
            },
            animateStyle: function (t) {
                return this.animate("style", t)
            },
            attrKV: function (t, e) {
                "style" !== t ? a.prototype.attrKV.call(this, t, e) : this.style.set(e)
            },
            setStyle: function (t, e) {
                return this.style.set(t, e), this.dirty(!1), this
            },
            useStyle: function (t) {
                return this.style = new i(t, this), this.dirty(!1), this
            }
        }, r.inherits(s, a), r.mixin(s, o);
        var l = s;
        t.exports = l
    }, function (t, e, n) {
        var r = n(4), i = n(2), a = n(48), o = n(3), s = n(19).devicePixelRatio,
            l = {M: 1, L: 2, C: 3, Q: 4, A: 5, Z: 6, R: 7}, h = [], u = [], c = [], f = [], d = Math.min, p = Math.max,
            v = Math.cos, g = Math.sin, y = Math.sqrt, m = Math.abs, x = "undefined" != typeof Float32Array,
            _ = function (t) {
                this._saveData = !t, this._saveData && (this.data = []), this._ctx = null
            };
        _.prototype = {
            constructor: _,
            _xi: 0,
            _yi: 0,
            _x0: 0,
            _y0: 0,
            _ux: 0,
            _uy: 0,
            _len: 0,
            _lineDash: null,
            _dashOffset: 0,
            _dashIdx: 0,
            _dashSum: 0,
            setScale: function (t, e) {
                this._ux = m(1 / s / t) || 0, this._uy = m(1 / s / e) || 0
            },
            getContext: function () {
                return this._ctx
            },
            beginPath: function (t) {
                return this._ctx = t, t && t.beginPath(), t && (this.dpr = t.dpr), this._saveData && (this._len = 0), this._lineDash && (this._lineDash = null, this._dashOffset = 0), this
            },
            moveTo: function (t, e) {
                return this.addData(l.M, t, e), this._ctx && this._ctx.moveTo(t, e), this._x0 = t, this._y0 = e, this._xi = t, this._yi = e, this
            },
            lineTo: function (t, e) {
                var n = m(t - this._xi) > this._ux || m(e - this._yi) > this._uy || this._len < 5;
                return this.addData(l.L, t, e), this._ctx && n && (this._needsDash() ? this._dashedLineTo(t, e) : this._ctx.lineTo(t, e)), n && (this._xi = t, this._yi = e), this
            },
            bezierCurveTo: function (t, e, n, r, i, a) {
                return this.addData(l.C, t, e, n, r, i, a), this._ctx && (this._needsDash() ? this._dashedBezierTo(t, e, n, r, i, a) : this._ctx.bezierCurveTo(t, e, n, r, i, a)), this._xi = i, this._yi = a, this
            },
            quadraticCurveTo: function (t, e, n, r) {
                return this.addData(l.Q, t, e, n, r), this._ctx && (this._needsDash() ? this._dashedQuadraticTo(t, e, n, r) : this._ctx.quadraticCurveTo(t, e, n, r)), this._xi = n, this._yi = r, this
            },
            arc: function (t, e, n, r, i, a) {
                return this.addData(l.A, t, e, n, n, r, i - r, 0, a ? 0 : 1), this._ctx && this._ctx.arc(t, e, n, r, i, a), this._xi = v(i) * n + t, this._yi = g(i) * n + t, this
            },
            arcTo: function (t, e, n, r, i) {
                return this._ctx && this._ctx.arcTo(t, e, n, r, i), this
            },
            rect: function (t, e, n, r) {
                return this._ctx && this._ctx.rect(t, e, n, r), this.addData(l.R, t, e, n, r), this
            },
            closePath: function () {
                this.addData(l.Z);
                var t = this._ctx, e = this._x0, n = this._y0;
                return t && (this._needsDash() && this._dashedLineTo(e, n), t.closePath()), this._xi = e, this._yi = n, this
            },
            fill: function (t) {
                t && t.fill(), this.toStatic()
            },
            stroke: function (t) {
                t && t.stroke(), this.toStatic()
            },
            setLineDash: function (t) {
                if (t instanceof Array) {
                    this._lineDash = t, this._dashIdx = 0;
                    for (var e = 0, n = 0; n < t.length; n++) e += t[n];
                    this._dashSum = e
                }
                return this
            },
            setLineDashOffset: function (t) {
                return this._dashOffset = t, this
            },
            len: function () {
                return this._len
            },
            setData: function (t) {
                var e = t.length;
                this.data && this.data.length == e || !x || (this.data = new Float32Array(e));
                for (var n = 0; n < e; n++) this.data[n] = t[n];
                this._len = e
            },
            appendPath: function (t) {
                t instanceof Array || (t = [t]);
                for (var e = t.length, n = 0, r = this._len, i = 0; i < e; i++) n += t[i].len();
                x && this.data instanceof Float32Array && (this.data = new Float32Array(r + n));
                for (i = 0; i < e; i++) for (var a = t[i].data, o = 0; o < a.length; o++) this.data[r++] = a[o];
                this._len = r
            },
            addData: function (t) {
                if (this._saveData) {
                    var e = this.data;
                    this._len + arguments.length > e.length && (this._expandData(), e = this.data);
                    for (var n = 0; n < arguments.length; n++) e[this._len++] = arguments[n];
                    this._prevCmd = t
                }
            },
            _expandData: function () {
                if (!(this.data instanceof Array)) {
                    for (var t = [], e = 0; e < this._len; e++) t[e] = this.data[e];
                    this.data = t
                }
            },
            _needsDash: function () {
                return this._lineDash
            },
            _dashedLineTo: function (t, e) {
                var n, r, i = this._dashSum, a = this._dashOffset, o = this._lineDash, s = this._ctx, l = this._xi,
                    h = this._yi, u = t - l, c = e - h, f = y(u * u + c * c), v = l, g = h, m = o.length;
                for (u /= f, c /= f, a < 0 && (a = i + a), v -= (a %= i) * u, g -= a * c; u > 0 && v <= t || u < 0 && v >= t || 0 == u && (c > 0 && g <= e || c < 0 && g >= e);) v += u * (n = o[r = this._dashIdx]), g += c * n, this._dashIdx = (r + 1) % m, u > 0 && v < l || u < 0 && v > l || c > 0 && g < h || c < 0 && g > h || s[r % 2 ? "moveTo" : "lineTo"](u >= 0 ? d(v, t) : p(v, t), c >= 0 ? d(g, e) : p(g, e));
                u = v - t, c = g - e, this._dashOffset = -y(u * u + c * c)
            },
            _dashedBezierTo: function (t, e, n, i, a, o) {
                var s, l, h, u, c, f = this._dashSum, d = this._dashOffset, p = this._lineDash, v = this._ctx,
                    g = this._xi, m = this._yi, x = r.cubicAt, _ = 0, w = this._dashIdx, b = p.length, S = 0;
                for (d < 0 && (d = f + d), d %= f, s = 0; s < 1; s += .1) l = x(g, t, n, a, s + .1) - x(g, t, n, a, s), h = x(m, e, i, o, s + .1) - x(m, e, i, o, s), _ += y(l * l + h * h);
                for (; w < b && !((S += p[w]) > d); w++) ;
                for (s = (S - d) / _; s <= 1;) u = x(g, t, n, a, s), c = x(m, e, i, o, s), w % 2 ? v.moveTo(u, c) : v.lineTo(u, c), s += p[w] / _, w = (w + 1) % b;
                w % 2 != 0 && v.lineTo(a, o), l = a - u, h = o - c, this._dashOffset = -y(l * l + h * h)
            },
            _dashedQuadraticTo: function (t, e, n, r) {
                var i = n, a = r;
                n = (n + 2 * t) / 3, r = (r + 2 * e) / 3, t = (this._xi + 2 * t) / 3, e = (this._yi + 2 * e) / 3, this._dashedBezierTo(t, e, n, r, i, a)
            },
            toStatic: function () {
                var t = this.data;
                t instanceof Array && (t.length = this._len, x && (this.data = new Float32Array(t)))
            },
            getBoundingRect: function () {
                h[0] = h[1] = c[0] = c[1] = Number.MAX_VALUE, u[0] = u[1] = f[0] = f[1] = -Number.MAX_VALUE;
                for (var t = this.data, e = 0, n = 0, r = 0, s = 0, d = 0; d < t.length;) {
                    var p = t[d++];
                    switch (1 == d && (r = e = t[d], s = n = t[d + 1]), p) {
                        case l.M:
                            e = r = t[d++], n = s = t[d++], c[0] = r, c[1] = s, f[0] = r, f[1] = s;
                            break;
                        case l.L:
                            a.fromLine(e, n, t[d], t[d + 1], c, f), e = t[d++], n = t[d++];
                            break;
                        case l.C:
                            a.fromCubic(e, n, t[d++], t[d++], t[d++], t[d++], t[d], t[d + 1], c, f), e = t[d++], n = t[d++];
                            break;
                        case l.Q:
                            a.fromQuadratic(e, n, t[d++], t[d++], t[d], t[d + 1], c, f), e = t[d++], n = t[d++];
                            break;
                        case l.A:
                            var y = t[d++], m = t[d++], x = t[d++], _ = t[d++], w = t[d++], b = t[d++] + w,
                                S = (t[d++], 1 - t[d++]);
                            1 == d && (r = v(w) * x + y, s = g(w) * _ + m), a.fromArc(y, m, x, _, w, b, S, c, f), e = v(b) * x + y, n = g(b) * _ + m;
                            break;
                        case l.R:
                            r = e = t[d++], s = n = t[d++];
                            var T = t[d++], M = t[d++];
                            a.fromLine(r, s, r + T, s + M, c, f);
                            break;
                        case l.Z:
                            e = r, n = s
                    }
                    i.min(h, h, c), i.max(u, u, f)
                }
                return 0 === d && (h[0] = h[1] = u[0] = u[1] = 0), new o(h[0], h[1], u[0] - h[0], u[1] - h[1])
            },
            rebuildPath: function (t) {
                for (var e, n, r, i, a, o, s = this.data, h = this._ux, u = this._uy, c = this._len, f = 0; f < c;) {
                    var d = s[f++];
                    switch (1 == f && (e = r = s[f], n = i = s[f + 1]), d) {
                        case l.M:
                            e = r = s[f++], n = i = s[f++], t.moveTo(r, i);
                            break;
                        case l.L:
                            a = s[f++], o = s[f++], (m(a - r) > h || m(o - i) > u || f === c - 1) && (t.lineTo(a, o), r = a, i = o);
                            break;
                        case l.C:
                            t.bezierCurveTo(s[f++], s[f++], s[f++], s[f++], s[f++], s[f++]), r = s[f - 2], i = s[f - 1];
                            break;
                        case l.Q:
                            t.quadraticCurveTo(s[f++], s[f++], s[f++], s[f++]), r = s[f - 2], i = s[f - 1];
                            break;
                        case l.A:
                            var p = s[f++], y = s[f++], x = s[f++], _ = s[f++], w = s[f++], b = s[f++], S = s[f++],
                                T = s[f++], M = x > _ ? x : _, P = x > _ ? 1 : x / _, k = x > _ ? _ / x : 1, C = w + b;
                            Math.abs(x - _) > .001 ? (t.translate(p, y), t.rotate(S), t.scale(P, k), t.arc(0, 0, M, w, C, 1 - T), t.scale(1 / P, 1 / k), t.rotate(-S), t.translate(-p, -y)) : t.arc(p, y, M, w, C, 1 - T), 1 == f && (e = v(w) * x + p, n = g(w) * _ + y), r = v(C) * x + p, i = g(C) * _ + y;
                            break;
                        case l.R:
                            e = r = s[f], n = i = s[f + 1], t.rect(s[f++], s[f++], s[f++], s[f++]);
                            break;
                        case l.Z:
                            t.closePath(), r = e, i = n
                    }
                }
            }
        }, _.CMD = l;
        var w = _;
        t.exports = w
    }, function (t, e) {
        var n = "undefined" == typeof Float32Array ? Array : Float32Array;

        function r() {
            var t = new n(6);
            return i(t), t
        }

        function i(t) {
            return t[0] = 1, t[1] = 0, t[2] = 0, t[3] = 1, t[4] = 0, t[5] = 0, t
        }

        function a(t, e) {
            return t[0] = e[0], t[1] = e[1], t[2] = e[2], t[3] = e[3], t[4] = e[4], t[5] = e[5], t
        }

        e.create = r, e.identity = i, e.copy = a, e.mul = function (t, e, n) {
            var r = e[0] * n[0] + e[2] * n[1], i = e[1] * n[0] + e[3] * n[1], a = e[0] * n[2] + e[2] * n[3],
                o = e[1] * n[2] + e[3] * n[3], s = e[0] * n[4] + e[2] * n[5] + e[4],
                l = e[1] * n[4] + e[3] * n[5] + e[5];
            return t[0] = r, t[1] = i, t[2] = a, t[3] = o, t[4] = s, t[5] = l, t
        }, e.translate = function (t, e, n) {
            return t[0] = e[0], t[1] = e[1], t[2] = e[2], t[3] = e[3], t[4] = e[4] + n[0], t[5] = e[5] + n[1], t
        }, e.rotate = function (t, e, n) {
            var r = e[0], i = e[2], a = e[4], o = e[1], s = e[3], l = e[5], h = Math.sin(n), u = Math.cos(n);
            return t[0] = r * u + o * h, t[1] = -r * h + o * u, t[2] = i * u + s * h, t[3] = -i * h + u * s, t[4] = u * a + h * l, t[5] = u * l - h * a, t
        }, e.scale = function (t, e, n) {
            var r = n[0], i = n[1];
            return t[0] = e[0] * r, t[1] = e[1] * i, t[2] = e[2] * r, t[3] = e[3] * i, t[4] = e[4] * r, t[5] = e[5] * i, t
        }, e.invert = function (t, e) {
            var n = e[0], r = e[2], i = e[4], a = e[1], o = e[3], s = e[5], l = n * o - a * r;
            return l ? (l = 1 / l, t[0] = o * l, t[1] = -a * l, t[2] = -r * l, t[3] = n * l, t[4] = (r * s - o * i) * l, t[5] = (a * i - n * s) * l, t) : null
        }, e.clone = function (t) {
            var e = r();
            return a(e, t), e
        }
    }, function (t, e, n) {
        var r = new (n(18))(50);

        function i() {
            var t = this.__cachedImgObj;
            this.onload = this.__cachedImgObj = null;
            for (var e = 0; e < t.pending.length; e++) {
                var n = t.pending[e], r = n.cb;
                r && r(this, n.cbPayload), n.hostEl.dirty()
            }
            t.pending.length = 0
        }

        function a(t) {
            return t && t.width && t.height
        }

        e.findExistImage = function (t) {
            if ("string" == typeof t) {
                var e = r.get(t);
                return e && e.image
            }
            return t
        }, e.createOrUpdateImage = function (t, e, n, o, s) {
            if (t) {
                if ("string" == typeof t) {
                    if (e && e.__zrImageSrc === t || !n) return e;
                    var l = r.get(t), h = {hostEl: n, cb: o, cbPayload: s};
                    return l ? !a(e = l.image) && l.pending.push(h) : (!e && (e = new Image), e.onload = i, r.put(t, e.__cachedImgObj = {
                        image: e,
                        pending: [h]
                    }), e.src = e.__zrImageSrc = t), e
                }
                return t
            }
            return e
        }, e.isImageReady = a
    }, function (t, e, n) {
        var r = n(0), i = r.each, a = r.isObject, o = r.isArray, s = "series\0";

        function l(t) {
            return t instanceof Array ? t : null == t ? [] : [t]
        }

        function h(t) {
            return a(t) && t.id && 0 === (t.id + "").indexOf("\0_ec_\0")
        }

        var u = 0;

        function c(t, e) {
            return t && t.hasOwnProperty(e)
        }

        e.normalizeToArray = l, e.defaultEmphasis = function (t, e, n) {
            if (t) {
                t[e] = t[e] || {}, t.emphasis = t.emphasis || {}, t.emphasis[e] = t.emphasis[e] || {};
                for (var r = 0, i = n.length; r < i; r++) {
                    var a = n[r];
                    !t.emphasis[e].hasOwnProperty(a) && t[e].hasOwnProperty(a) && (t.emphasis[e][a] = t[e][a])
                }
            }
        }, e.TEXT_STYLE_OPTIONS = ["fontStyle", "fontWeight", "fontSize", "fontFamily", "rich", "tag", "color", "textBorderColor", "textBorderWidth", "width", "height", "lineHeight", "align", "verticalAlign", "baseline", "shadowColor", "shadowBlur", "shadowOffsetX", "shadowOffsetY", "textShadowColor", "textShadowBlur", "textShadowOffsetX", "textShadowOffsetY", "backgroundColor", "borderColor", "borderWidth", "borderRadius", "padding"], e.getDataItemValue = function (t) {
            return !a(t) || o(t) || t instanceof Date ? t : t.value
        }, e.isDataItemOption = function (t) {
            return a(t) && !(t instanceof Array)
        }, e.mappingToExists = function (t, e) {
            e = (e || []).slice();
            var n = r.map(t || [], function (t, e) {
                return {exist: t}
            });
            return i(e, function (t, r) {
                if (a(t)) {
                    for (var i = 0; i < n.length; i++) if (!n[i].option && null != t.id && n[i].exist.id === t.id + "") return n[i].option = t, void(e[r] = null);
                    for (i = 0; i < n.length; i++) {
                        var o = n[i].exist;
                        if (!(n[i].option || null != o.id && null != t.id || null == t.name || h(t) || h(o) || o.name !== t.name + "")) return n[i].option = t, void(e[r] = null)
                    }
                }
            }), i(e, function (t, e) {
                if (a(t)) {
                    for (var r = 0; r < n.length; r++) {
                        var i = n[r].exist;
                        if (!n[r].option && !h(i) && null == t.id) {
                            n[r].option = t;
                            break
                        }
                    }
                    r >= n.length && n.push({option: t})
                }
            }), n
        }, e.makeIdAndName = function (t) {
            var e = r.createHashMap();
            i(t, function (t, n) {
                var r = t.exist;
                r && e.set(r.id, t)
            }), i(t, function (t, n) {
                var i = t.option;
                r.assert(!i || null == i.id || !e.get(i.id) || e.get(i.id) === t, "id duplicates: " + (i && i.id)), i && null != i.id && e.set(i.id, t), !t.keyInfo && (t.keyInfo = {})
            }), i(t, function (t, n) {
                var r = t.exist, i = t.option, o = t.keyInfo;
                if (a(i)) {
                    if (o.name = null != i.name ? i.name + "" : r ? r.name : s + n, r) o.id = r.id; else if (null != i.id) o.id = i.id + ""; else {
                        var l = 0;
                        do {
                            o.id = "\0" + o.name + "\0" + l++
                        } while (e.get(o.id))
                    }
                    e.set(o.id, t)
                }
            })
        }, e.isNameSpecified = function (t) {
            var e = t.name;
            return !(!e || !e.indexOf(s))
        }, e.isIdInner = h, e.compressBatches = function (t, e) {
            var n = {}, r = {};
            return i(t || [], n), i(e || [], r, n), [a(n), a(r)];

            function i(t, e, n) {
                for (var r = 0, i = t.length; r < i; r++) for (var a = t[r].seriesId, o = l(t[r].dataIndex), s = n && n[a], h = 0, u = o.length; h < u; h++) {
                    var c = o[h];
                    s && s[c] ? s[c] = null : (e[a] || (e[a] = {}))[c] = 1
                }
            }

            function a(t, e) {
                var n = [];
                for (var r in t) if (t.hasOwnProperty(r) && null != t[r]) if (e) n.push(+r); else {
                    var i = a(t[r], !0);
                    i.length && n.push({seriesId: r, dataIndex: i})
                }
                return n
            }
        }, e.queryDataIndex = function (t, e) {
            return null != e.dataIndexInside ? e.dataIndexInside : null != e.dataIndex ? r.isArray(e.dataIndex) ? r.map(e.dataIndex, function (e) {
                return t.indexOfRawIndex(e)
            }) : t.indexOfRawIndex(e.dataIndex) : null != e.name ? r.isArray(e.name) ? r.map(e.name, function (e) {
                return t.indexOfName(e)
            }) : t.indexOfName(e.name) : void 0
        }, e.makeInner = function () {
            var t = "__\0ec_inner_" + u++ + "_" + Math.random().toFixed(5);
            return function (e) {
                return e[t] || (e[t] = {})
            }
        }, e.parseFinder = function (t, e, n) {
            if (r.isString(e)) {
                var a = {};
                a[e + "Index"] = 0, e = a
            }
            var o = n && n.defaultMainType;
            !o || c(e, o + "Index") || c(e, o + "Id") || c(e, o + "Name") || (e[o + "Index"] = 0);
            var s = {};
            return i(e, function (i, a) {
                if (i = e[a], "dataIndex" !== a && "dataIndexInside" !== a) {
                    var o = a.match(/^(\w+)(Index|Id|Name)$/) || [], l = o[1], h = (o[2] || "").toLowerCase();
                    if (!(!l || !h || null == i || "index" === h && "none" === i || n && n.includeMainTypes && r.indexOf(n.includeMainTypes, l) < 0)) {
                        var u = {mainType: l};
                        "index" === h && "all" === i || (u[h] = i);
                        var c = t.queryComponents(u);
                        s[l + "Models"] = c, s[l + "Model"] = c[0]
                    }
                } else s[a] = i
            }), s
        }, e.setAttribute = function (t, e, n) {
            t.setAttribute ? t.setAttribute(e, n) : t[e] = n
        }, e.getAttribute = function (t, e) {
            return t.getAttribute ? t.getAttribute(e) : t[e]
        }
    }, function (t, e, n) {
        var r = n(0), i = r.createHashMap, a = r.isTypedArray, o = n(33).enableClassCheck, s = n(13),
            l = s.SOURCE_FORMAT_ORIGINAL, h = s.SERIES_LAYOUT_BY_COLUMN, u = s.SOURCE_FORMAT_UNKNOWN,
            c = s.SOURCE_FORMAT_TYPED_ARRAY, f = s.SOURCE_FORMAT_KEYED_COLUMNS;

        function d(t) {
            this.fromDataset = t.fromDataset, this.data = t.data || (t.sourceFormat === f ? {} : []), this.sourceFormat = t.sourceFormat || u, this.seriesLayoutBy = t.seriesLayoutBy || h, this.dimensionsDefine = t.dimensionsDefine, this.encodeDefine = t.encodeDefine && i(t.encodeDefine), this.startIndex = t.startIndex || 0, this.dimensionsDetectCount = t.dimensionsDetectCount
        }

        d.seriesDataToSource = function (t) {
            return new d({data: t, sourceFormat: a(t) ? c : l, fromDataset: !1})
        }, o(d);
        var p = d;
        t.exports = p
    }, function (t, e) {
        e.SOURCE_FORMAT_ORIGINAL = "original", e.SOURCE_FORMAT_ARRAY_ROWS = "arrayRows", e.SOURCE_FORMAT_OBJECT_ROWS = "objectRows", e.SOURCE_FORMAT_KEYED_COLUMNS = "keyedColumns", e.SOURCE_FORMAT_UNKNOWN = "unknown", e.SOURCE_FORMAT_TYPED_ARRAY = "typedArray", e.SERIES_LAYOUT_BY_COLUMN = "column", e.SERIES_LAYOUT_BY_ROW = "row"
    }, function (t, e) {
        var n = {
            shadowBlur: 1,
            shadowOffsetX: 1,
            shadowOffsetY: 1,
            textShadowBlur: 1,
            textShadowOffsetX: 1,
            textShadowOffsetY: 1,
            textBoxShadowBlur: 1,
            textBoxShadowOffsetX: 1,
            textBoxShadowOffsetY: 1
        };
        t.exports = function (t, e, r) {
            return n.hasOwnProperty(e) ? r * t.dpr : r
        }
    }, function (t, e, n) {
        var r = n(40), i = n(41), a = n(16), o = n(42), s = n(0), l = function (t) {
            a.call(this, t), i.call(this, t), o.call(this, t), this.id = t.id || r()
        };
        l.prototype = {
            type: "element",
            name: "",
            __zr: null,
            ignore: !1,
            clipPath: null,
            isGroup: !1,
            drift: function (t, e) {
                switch (this.draggable) {
                    case"horizontal":
                        e = 0;
                        break;
                    case"vertical":
                        t = 0
                }
                var n = this.transform;
                n || (n = this.transform = [1, 0, 0, 1, 0, 0]), n[4] += t, n[5] += e, this.decomposeTransform(), this.dirty(!1)
            },
            beforeUpdate: function () {
            },
            afterUpdate: function () {
            },
            update: function () {
                this.updateTransform()
            },
            traverse: function (t, e) {
            },
            attrKV: function (t, e) {
                if ("position" === t || "scale" === t || "origin" === t) {
                    if (e) {
                        var n = this[t];
                        n || (n = this[t] = []), n[0] = e[0], n[1] = e[1]
                    }
                } else this[t] = e
            },
            hide: function () {
                this.ignore = !0, this.__zr && this.__zr.refresh()
            },
            show: function () {
                this.ignore = !1, this.__zr && this.__zr.refresh()
            },
            attr: function (t, e) {
                if ("string" == typeof t) this.attrKV(t, e); else if (s.isObject(t)) for (var n in t) t.hasOwnProperty(n) && this.attrKV(n, t[n]);
                return this.dirty(!1), this
            },
            setClipPath: function (t) {
                var e = this.__zr;
                e && t.addSelfToZr(e), this.clipPath && this.clipPath !== t && this.removeClipPath(), this.clipPath = t, t.__zr = e, t.__clipTarget = this, this.dirty(!1)
            },
            removeClipPath: function () {
                var t = this.clipPath;
                t && (t.__zr && t.removeSelfFromZr(t.__zr), t.__zr = null, t.__clipTarget = null, this.clipPath = null, this.dirty(!1))
            },
            addSelfToZr: function (t) {
                this.__zr = t;
                var e = this.animators;
                if (e) for (var n = 0; n < e.length; n++) t.animation.addAnimator(e[n]);
                this.clipPath && this.clipPath.addSelfToZr(t)
            },
            removeSelfFromZr: function (t) {
                this.__zr = null;
                var e = this.animators;
                if (e) for (var n = 0; n < e.length; n++) t.animation.removeAnimator(e[n]);
                this.clipPath && this.clipPath.removeSelfFromZr(t)
            }
        }, s.mixin(l, o), s.mixin(l, a), s.mixin(l, i);
        var h = l;
        t.exports = h
    }, function (t, e, n) {
        var r = n(9), i = n(2), a = r.identity, o = 5e-5;

        function s(t) {
            return t > o || t < -o
        }

        var l = function (t) {
            (t = t || {}).position || (this.position = [0, 0]), null == t.rotation && (this.rotation = 0), t.scale || (this.scale = [1, 1]), this.origin = this.origin || null
        }, h = l.prototype;
        h.transform = null, h.needLocalTransform = function () {
            return s(this.rotation) || s(this.position[0]) || s(this.position[1]) || s(this.scale[0] - 1) || s(this.scale[1] - 1)
        }, h.updateTransform = function () {
            var t = this.parent, e = t && t.transform, n = this.needLocalTransform(), i = this.transform;
            n || e ? (i = i || r.create(), n ? this.getLocalTransform(i) : a(i), e && (n ? r.mul(i, t.transform, i) : r.copy(i, t.transform)), this.transform = i, this.invTransform = this.invTransform || r.create(), r.invert(this.invTransform, i)) : i && a(i)
        }, h.getLocalTransform = function (t) {
            return l.getLocalTransform(this, t)
        }, h.setTransform = function (t) {
            var e = this.transform, n = t.dpr || 1;
            e ? t.setTransform(n * e[0], n * e[1], n * e[2], n * e[3], n * e[4], n * e[5]) : t.setTransform(n, 0, 0, n, 0, 0)
        }, h.restoreTransform = function (t) {
            var e = t.dpr || 1;
            t.setTransform(e, 0, 0, e, 0, 0)
        };
        var u = [];
        h.decomposeTransform = function () {
            if (this.transform) {
                var t = this.parent, e = this.transform;
                t && t.transform && (r.mul(u, t.invTransform, e), e = u);
                var n = e[0] * e[0] + e[1] * e[1], i = e[2] * e[2] + e[3] * e[3], a = this.position, o = this.scale;
                s(n - 1) && (n = Math.sqrt(n)), s(i - 1) && (i = Math.sqrt(i)), e[0] < 0 && (n = -n), e[3] < 0 && (i = -i), a[0] = e[4], a[1] = e[5], o[0] = n, o[1] = i, this.rotation = Math.atan2(-e[1] / i, e[0] / n)
            }
        }, h.getGlobalScale = function () {
            var t = this.transform;
            if (!t) return [1, 1];
            var e = Math.sqrt(t[0] * t[0] + t[1] * t[1]), n = Math.sqrt(t[2] * t[2] + t[3] * t[3]);
            return t[0] < 0 && (e = -e), t[3] < 0 && (n = -n), [e, n]
        }, h.transformCoordToLocal = function (t, e) {
            var n = [t, e], r = this.invTransform;
            return r && i.applyTransform(n, n, r), n
        }, h.transformCoordToGlobal = function (t, e) {
            var n = [t, e], r = this.transform;
            return r && i.applyTransform(n, n, r), n
        }, l.getLocalTransform = function (t, e) {
            a(e = e || []);
            var n = t.origin, i = t.scale || [1, 1], o = t.rotation || 0, s = t.position || [0, 0];
            return n && (e[4] -= n[0], e[5] -= n[1]), r.scale(e, e, i), o && r.rotate(e, e, o), n && (e[4] += n[0], e[5] += n[1]), e[4] += s[0], e[5] += s[1], e
        };
        var c = l;
        t.exports = c
    }, function (t, e, n) {
        var r = {
            transparent: [0, 0, 0, 0],
            aliceblue: [240, 248, 255, 1],
            antiquewhite: [250, 235, 215, 1],
            aqua: [0, 255, 255, 1],
            aquamarine: [127, 255, 212, 1],
            azure: [240, 255, 255, 1],
            beige: [245, 245, 220, 1],
            bisque: [255, 228, 196, 1],
            black: [0, 0, 0, 1],
            blanchedalmond: [255, 235, 205, 1],
            blue: [0, 0, 255, 1],
            blueviolet: [138, 43, 226, 1],
            brown: [165, 42, 42, 1],
            burlywood: [222, 184, 135, 1],
            cadetblue: [95, 158, 160, 1],
            chartreuse: [127, 255, 0, 1],
            chocolate: [210, 105, 30, 1],
            coral: [255, 127, 80, 1],
            cornflowerblue: [100, 149, 237, 1],
            cornsilk: [255, 248, 220, 1],
            crimson: [220, 20, 60, 1],
            cyan: [0, 255, 255, 1],
            darkblue: [0, 0, 139, 1],
            darkcyan: [0, 139, 139, 1],
            darkgoldenrod: [184, 134, 11, 1],
            darkgray: [169, 169, 169, 1],
            darkgreen: [0, 100, 0, 1],
            darkgrey: [169, 169, 169, 1],
            darkkhaki: [189, 183, 107, 1],
            darkmagenta: [139, 0, 139, 1],
            darkolivegreen: [85, 107, 47, 1],
            darkorange: [255, 140, 0, 1],
            darkorchid: [153, 50, 204, 1],
            darkred: [139, 0, 0, 1],
            darksalmon: [233, 150, 122, 1],
            darkseagreen: [143, 188, 143, 1],
            darkslateblue: [72, 61, 139, 1],
            darkslategray: [47, 79, 79, 1],
            darkslategrey: [47, 79, 79, 1],
            darkturquoise: [0, 206, 209, 1],
            darkviolet: [148, 0, 211, 1],
            deeppink: [255, 20, 147, 1],
            deepskyblue: [0, 191, 255, 1],
            dimgray: [105, 105, 105, 1],
            dimgrey: [105, 105, 105, 1],
            dodgerblue: [30, 144, 255, 1],
            firebrick: [178, 34, 34, 1],
            floralwhite: [255, 250, 240, 1],
            forestgreen: [34, 139, 34, 1],
            fuchsia: [255, 0, 255, 1],
            gainsboro: [220, 220, 220, 1],
            ghostwhite: [248, 248, 255, 1],
            gold: [255, 215, 0, 1],
            goldenrod: [218, 165, 32, 1],
            gray: [128, 128, 128, 1],
            green: [0, 128, 0, 1],
            greenyellow: [173, 255, 47, 1],
            grey: [128, 128, 128, 1],
            honeydew: [240, 255, 240, 1],
            hotpink: [255, 105, 180, 1],
            indianred: [205, 92, 92, 1],
            indigo: [75, 0, 130, 1],
            ivory: [255, 255, 240, 1],
            khaki: [240, 230, 140, 1],
            lavender: [230, 230, 250, 1],
            lavenderblush: [255, 240, 245, 1],
            lawngreen: [124, 252, 0, 1],
            lemonchiffon: [255, 250, 205, 1],
            lightblue: [173, 216, 230, 1],
            lightcoral: [240, 128, 128, 1],
            lightcyan: [224, 255, 255, 1],
            lightgoldenrodyellow: [250, 250, 210, 1],
            lightgray: [211, 211, 211, 1],
            lightgreen: [144, 238, 144, 1],
            lightgrey: [211, 211, 211, 1],
            lightpink: [255, 182, 193, 1],
            lightsalmon: [255, 160, 122, 1],
            lightseagreen: [32, 178, 170, 1],
            lightskyblue: [135, 206, 250, 1],
            lightslategray: [119, 136, 153, 1],
            lightslategrey: [119, 136, 153, 1],
            lightsteelblue: [176, 196, 222, 1],
            lightyellow: [255, 255, 224, 1],
            lime: [0, 255, 0, 1],
            limegreen: [50, 205, 50, 1],
            linen: [250, 240, 230, 1],
            magenta: [255, 0, 255, 1],
            maroon: [128, 0, 0, 1],
            mediumaquamarine: [102, 205, 170, 1],
            mediumblue: [0, 0, 205, 1],
            mediumorchid: [186, 85, 211, 1],
            mediumpurple: [147, 112, 219, 1],
            mediumseagreen: [60, 179, 113, 1],
            mediumslateblue: [123, 104, 238, 1],
            mediumspringgreen: [0, 250, 154, 1],
            mediumturquoise: [72, 209, 204, 1],
            mediumvioletred: [199, 21, 133, 1],
            midnightblue: [25, 25, 112, 1],
            mintcream: [245, 255, 250, 1],
            mistyrose: [255, 228, 225, 1],
            moccasin: [255, 228, 181, 1],
            navajowhite: [255, 222, 173, 1],
            navy: [0, 0, 128, 1],
            oldlace: [253, 245, 230, 1],
            olive: [128, 128, 0, 1],
            olivedrab: [107, 142, 35, 1],
            orange: [255, 165, 0, 1],
            orangered: [255, 69, 0, 1],
            orchid: [218, 112, 214, 1],
            palegoldenrod: [238, 232, 170, 1],
            palegreen: [152, 251, 152, 1],
            paleturquoise: [175, 238, 238, 1],
            palevioletred: [219, 112, 147, 1],
            papayawhip: [255, 239, 213, 1],
            peachpuff: [255, 218, 185, 1],
            peru: [205, 133, 63, 1],
            pink: [255, 192, 203, 1],
            plum: [221, 160, 221, 1],
            powderblue: [176, 224, 230, 1],
            purple: [128, 0, 128, 1],
            red: [255, 0, 0, 1],
            rosybrown: [188, 143, 143, 1],
            royalblue: [65, 105, 225, 1],
            saddlebrown: [139, 69, 19, 1],
            salmon: [250, 128, 114, 1],
            sandybrown: [244, 164, 96, 1],
            seagreen: [46, 139, 87, 1],
            seashell: [255, 245, 238, 1],
            sienna: [160, 82, 45, 1],
            silver: [192, 192, 192, 1],
            skyblue: [135, 206, 235, 1],
            slateblue: [106, 90, 205, 1],
            slategray: [112, 128, 144, 1],
            slategrey: [112, 128, 144, 1],
            snow: [255, 250, 250, 1],
            springgreen: [0, 255, 127, 1],
            steelblue: [70, 130, 180, 1],
            tan: [210, 180, 140, 1],
            teal: [0, 128, 128, 1],
            thistle: [216, 191, 216, 1],
            tomato: [255, 99, 71, 1],
            turquoise: [64, 224, 208, 1],
            violet: [238, 130, 238, 1],
            wheat: [245, 222, 179, 1],
            white: [255, 255, 255, 1],
            whitesmoke: [245, 245, 245, 1],
            yellow: [255, 255, 0, 1],
            yellowgreen: [154, 205, 50, 1]
        };

        function i(t) {
            return (t = Math.round(t)) < 0 ? 0 : t > 255 ? 255 : t
        }

        function a(t) {
            return t < 0 ? 0 : t > 1 ? 1 : t
        }

        function o(t) {
            return t.length && "%" === t.charAt(t.length - 1) ? i(parseFloat(t) / 100 * 255) : i(parseInt(t, 10))
        }

        function s(t) {
            return t.length && "%" === t.charAt(t.length - 1) ? a(parseFloat(t) / 100) : a(parseFloat(t))
        }

        function l(t, e, n) {
            return n < 0 ? n += 1 : n > 1 && (n -= 1), 6 * n < 1 ? t + (e - t) * n * 6 : 2 * n < 1 ? e : 3 * n < 2 ? t + (e - t) * (2 / 3 - n) * 6 : t
        }

        function h(t, e, n) {
            return t + (e - t) * n
        }

        function u(t, e, n, r, i) {
            return t[0] = e, t[1] = n, t[2] = r, t[3] = i, t
        }

        function c(t, e) {
            return t[0] = e[0], t[1] = e[1], t[2] = e[2], t[3] = e[3], t
        }

        var f = new (n(18))(20), d = null;

        function p(t, e) {
            d && c(d, e), d = f.put(t, d || e.slice())
        }

        function v(t, e) {
            if (t) {
                e = e || [];
                var n = f.get(t);
                if (n) return c(e, n);
                var i, a = (t += "").replace(/ /g, "").toLowerCase();
                if (a in r) return c(e, r[a]), p(t, e), e;
                if ("#" === a.charAt(0)) return 4 === a.length ? (i = parseInt(a.substr(1), 16)) >= 0 && i <= 4095 ? (u(e, (3840 & i) >> 4 | (3840 & i) >> 8, 240 & i | (240 & i) >> 4, 15 & i | (15 & i) << 4, 1), p(t, e), e) : void u(e, 0, 0, 0, 1) : 7 === a.length ? (i = parseInt(a.substr(1), 16)) >= 0 && i <= 16777215 ? (u(e, (16711680 & i) >> 16, (65280 & i) >> 8, 255 & i, 1), p(t, e), e) : void u(e, 0, 0, 0, 1) : void 0;
                var l = a.indexOf("("), h = a.indexOf(")");
                if (-1 !== l && h + 1 === a.length) {
                    var d = a.substr(0, l), v = a.substr(l + 1, h - (l + 1)).split(","), y = 1;
                    switch (d) {
                        case"rgba":
                            if (4 !== v.length) return void u(e, 0, 0, 0, 1);
                            y = s(v.pop());
                        case"rgb":
                            return 3 !== v.length ? void u(e, 0, 0, 0, 1) : (u(e, o(v[0]), o(v[1]), o(v[2]), y), p(t, e), e);
                        case"hsla":
                            return 4 !== v.length ? void u(e, 0, 0, 0, 1) : (v[3] = s(v[3]), g(v, e), p(t, e), e);
                        case"hsl":
                            return 3 !== v.length ? void u(e, 0, 0, 0, 1) : (g(v, e), p(t, e), e);
                        default:
                            return
                    }
                }
                u(e, 0, 0, 0, 1)
            }
        }

        function g(t, e) {
            var n = (parseFloat(t[0]) % 360 + 360) % 360 / 360, r = s(t[1]), a = s(t[2]),
                o = a <= .5 ? a * (r + 1) : a + r - a * r, h = 2 * a - o;
            return u(e = e || [], i(255 * l(h, o, n + 1 / 3)), i(255 * l(h, o, n)), i(255 * l(h, o, n - 1 / 3)), 1), 4 === t.length && (e[3] = t[3]), e
        }

        function y(t, e, n) {
            if (e && e.length && t >= 0 && t <= 1) {
                n = n || [];
                var r = t * (e.length - 1), o = Math.floor(r), s = Math.ceil(r), l = e[o], u = e[s], c = r - o;
                return n[0] = i(h(l[0], u[0], c)), n[1] = i(h(l[1], u[1], c)), n[2] = i(h(l[2], u[2], c)), n[3] = a(h(l[3], u[3], c)), n
            }
        }

        var m = y;

        function x(t, e, n) {
            if (e && e.length && t >= 0 && t <= 1) {
                var r = t * (e.length - 1), o = Math.floor(r), s = Math.ceil(r), l = v(e[o]), u = v(e[s]), c = r - o,
                    f = w([i(h(l[0], u[0], c)), i(h(l[1], u[1], c)), i(h(l[2], u[2], c)), a(h(l[3], u[3], c))], "rgba");
                return n ? {color: f, leftIndex: o, rightIndex: s, value: r} : f
            }
        }

        var _ = x;

        function w(t, e) {
            if (t && t.length) {
                var n = t[0] + "," + t[1] + "," + t[2];
                return "rgba" !== e && "hsva" !== e && "hsla" !== e || (n += "," + t[3]), e + "(" + n + ")"
            }
        }

        e.parse = v, e.lift = function (t, e) {
            var n = v(t);
            if (n) {
                for (var r = 0; r < 3; r++) n[r] = e < 0 ? n[r] * (1 - e) | 0 : (255 - n[r]) * e + n[r] | 0, n[r] > 255 ? n[r] = 255 : t[r] < 0 && (n[r] = 0);
                return w(n, 4 === n.length ? "rgba" : "rgb")
            }
        }, e.toHex = function (t) {
            var e = v(t);
            if (e) return ((1 << 24) + (e[0] << 16) + (e[1] << 8) + +e[2]).toString(16).slice(1)
        }, e.fastLerp = y, e.fastMapToColor = m, e.lerp = x, e.mapToColor = _, e.modifyHSL = function (t, e, n, r) {
            if (t = v(t)) return t = function (t) {
                if (t) {
                    var e, n, r = t[0] / 255, i = t[1] / 255, a = t[2] / 255, o = Math.min(r, i, a),
                        s = Math.max(r, i, a), l = s - o, h = (s + o) / 2;
                    if (0 === l) e = 0, n = 0; else {
                        n = h < .5 ? l / (s + o) : l / (2 - s - o);
                        var u = ((s - r) / 6 + l / 2) / l, c = ((s - i) / 6 + l / 2) / l, f = ((s - a) / 6 + l / 2) / l;
                        r === s ? e = f - c : i === s ? e = 1 / 3 + u - f : a === s && (e = 2 / 3 + c - u), e < 0 && (e += 1), e > 1 && (e -= 1)
                    }
                    var d = [360 * e, n, h];
                    return null != t[3] && d.push(t[3]), d
                }
            }(t), null != e && (t[0] = function (t) {
                return (t = Math.round(t)) < 0 ? 0 : t > 360 ? 360 : t
            }(e)), null != n && (t[1] = s(n)), null != r && (t[2] = s(r)), w(g(t), "rgba")
        }, e.modifyAlpha = function (t, e) {
            if ((t = v(t)) && null != e) return t[3] = a(e), w(t, "rgba")
        }, e.stringify = w
    }, function (t, e) {
        var n = function () {
            this.head = null, this.tail = null, this._len = 0
        }, r = n.prototype;
        r.insert = function (t) {
            var e = new i(t);
            return this.insertEntry(e), e
        }, r.insertEntry = function (t) {
            this.head ? (this.tail.next = t, t.prev = this.tail, t.next = null, this.tail = t) : this.head = this.tail = t, this._len++
        }, r.remove = function (t) {
            var e = t.prev, n = t.next;
            e ? e.next = n : this.head = n, n ? n.prev = e : this.tail = e, t.next = t.prev = null, this._len--
        }, r.len = function () {
            return this._len
        }, r.clear = function () {
            this.head = this.tail = null, this._len = 0
        };
        var i = function (t) {
            this.value = t, this.next, this.prev
        }, a = function (t) {
            this._list = new n, this._map = {}, this._maxSize = t || 10, this._lastRemovedEntry = null
        }, o = a.prototype;
        o.put = function (t, e) {
            var n = this._list, r = this._map, a = null;
            if (null == r[t]) {
                var o = n.len(), s = this._lastRemovedEntry;
                if (o >= this._maxSize && o > 0) {
                    var l = n.head;
                    n.remove(l), delete r[l.key], a = l.value, this._lastRemovedEntry = l
                }
                s ? s.value = e : s = new i(e), s.key = t, n.insertEntry(s), r[t] = s
            }
            return a
        }, o.get = function (t) {
            var e = this._map[t], n = this._list;
            if (null != e) return e !== n.tail && (n.remove(e), n.insertEntry(e)), e.value
        }, o.clear = function () {
            this._list.clear(), this._map = {}
        };
        var s = a;
        t.exports = s
    }, function (t, e) {
        var n = 1;
        "undefined" != typeof window && (n = Math.max(window.devicePixelRatio || 1, 1));
        var r = n;
        e.debugMode = 0, e.devicePixelRatio = r
    }, function (t, e, n) {
        var r = n(0), i = r.retrieve2, a = r.retrieve3, o = r.each, s = r.normalizeCssArray, l = r.isString,
            h = r.isObject, u = n(21), c = n(22), f = n(10), d = n(14), p = {left: 1, right: 1, center: 1},
            v = {top: 1, bottom: 1, middle: 1};

        function g(t) {
            if (t) {
                t.font = u.makeFont(t);
                var e = t.textAlign;
                "middle" === e && (e = "center"), t.textAlign = null == e || p[e] ? e : "left";
                var n = t.textVerticalAlign || t.textBaseline;
                "center" === n && (n = "middle"), t.textVerticalAlign = null == n || v[n] ? n : "top", t.textPadding && (t.textPadding = s(t.textPadding))
            }
        }

        function y(t, e, n, r, i) {
            if (n && e.textRotation) {
                var a = e.textOrigin;
                "center" === a ? (r = n.width / 2 + n.x, i = n.height / 2 + n.y) : a && (r = a[0] + n.x, i = a[1] + n.y), t.translate(r, i), t.rotate(-e.textRotation), t.translate(-r, -i)
            }
        }

        function m(t, e, n, r, o, s, l, h) {
            var c = r.rich[n.styleName] || {}, f = n.textVerticalAlign, d = s + o / 2;
            "top" === f ? d = s + n.height / 2 : "bottom" === f && (d = s + o - n.height / 2), !n.isLineHolder && x(c) && _(t, e, c, "right" === h ? l - n.width : "center" === h ? l - n.width / 2 : l, d - n.height / 2, n.width, n.height);
            var p = n.textPadding;
            p && (l = k(l, h, p), d -= n.height / 2 - p[2] - n.textHeight / 2), S(e, "shadowBlur", a(c.textShadowBlur, r.textShadowBlur, 0)), S(e, "shadowColor", c.textShadowColor || r.textShadowColor || "transparent"), S(e, "shadowOffsetX", a(c.textShadowOffsetX, r.textShadowOffsetX, 0)), S(e, "shadowOffsetY", a(c.textShadowOffsetY, r.textShadowOffsetY, 0)), S(e, "textAlign", h), S(e, "textBaseline", "middle"), S(e, "font", n.font || u.DEFAULT_FONT);
            var v = T(c.textStroke || r.textStroke, y), g = M(c.textFill || r.textFill),
                y = i(c.textStrokeWidth, r.textStrokeWidth);
            v && (S(e, "lineWidth", y), S(e, "strokeStyle", v), e.strokeText(n.text, l, d)), g && (S(e, "fillStyle", g), e.fillText(n.text, l, d))
        }

        function x(t) {
            return t.textBackgroundColor || t.textBorderWidth && t.textBorderColor
        }

        function _(t, e, n, r, i, a, o) {
            var s = n.textBackgroundColor, u = n.textBorderWidth, d = n.textBorderColor, p = l(s);
            if (S(e, "shadowBlur", n.textBoxShadowBlur || 0), S(e, "shadowColor", n.textBoxShadowColor || "transparent"), S(e, "shadowOffsetX", n.textBoxShadowOffsetX || 0), S(e, "shadowOffsetY", n.textBoxShadowOffsetY || 0), p || u && d) {
                e.beginPath();
                var v = n.textBorderRadius;
                v ? c.buildPath(e, {x: r, y: i, width: a, height: o, r: v}) : e.rect(r, i, a, o), e.closePath()
            }
            if (p) S(e, "fillStyle", s), e.fill(); else if (h(s)) {
                var g = s.image;
                (g = f.createOrUpdateImage(g, null, t, w, s)) && f.isImageReady(g) && e.drawImage(g, r, i, a, o)
            }
            u && d && (S(e, "lineWidth", u), S(e, "strokeStyle", d), e.stroke())
        }

        function w(t, e) {
            e.image = t
        }

        function b(t, e, n) {
            var r = e.x || 0, i = e.y || 0, a = e.textAlign, o = e.textVerticalAlign;
            if (n) {
                var s = e.textPosition;
                if (s instanceof Array) r = n.x + P(s[0], n.width), i = n.y + P(s[1], n.height); else {
                    var l = u.adjustTextPositionOnRect(s, n, e.textDistance);
                    r = l.x, i = l.y, a = a || l.textAlign, o = o || l.textVerticalAlign
                }
                var h = e.textOffset;
                h && (r += h[0], i += h[1])
            }
            return {baseX: r, baseY: i, textAlign: a, textVerticalAlign: o}
        }

        function S(t, e, n) {
            return t[e] = d(t, e, n), t[e]
        }

        function T(t, e) {
            return null == t || e <= 0 || "transparent" === t || "none" === t ? null : t.image || t.colorStops ? "#000" : t
        }

        function M(t) {
            return null == t || "none" === t ? null : t.image || t.colorStops ? "#000" : t
        }

        function P(t, e) {
            return "string" == typeof t ? t.lastIndexOf("%") >= 0 ? parseFloat(t) / 100 * e : parseFloat(t) : t
        }

        function k(t, e, n) {
            return "right" === e ? t - n[1] : "center" === e ? t + n[3] / 2 - n[1] / 2 : t + n[3]
        }

        e.normalizeTextStyle = function (t) {
            return g(t), o(t.rich, g), t
        }, e.renderText = function (t, e, n, r, i) {
            r.rich ? function (t, e, n, r, i) {
                var a = t.__textCotentBlock;
                a && !t.__dirty || (a = t.__textCotentBlock = u.parseRichText(n, r)), function (t, e, n, r, i) {
                    var a = n.width, o = n.outerWidth, s = n.outerHeight, l = r.textPadding, h = b(0, r, i),
                        c = h.baseX, f = h.baseY, d = h.textAlign, p = h.textVerticalAlign;
                    y(e, r, i, c, f);
                    var v = u.adjustTextX(c, o, d), g = u.adjustTextY(f, s, p), w = v, S = g;
                    l && (w += l[3], S += l[0]);
                    var T = w + a;
                    x(r) && _(t, e, r, v, g, o, s);
                    for (var M = 0; M < n.lines.length; M++) {
                        for (var P, k = n.lines[M], C = k.tokens, O = C.length, A = k.lineHeight, I = k.width, D = 0, R = w, B = T, L = O - 1; D < O && (!(P = C[D]).textAlign || "left" === P.textAlign);) m(t, e, P, r, A, S, R, "left"), I -= P.width, R += P.width, D++;
                        for (; L >= 0 && "right" === (P = C[L]).textAlign;) m(t, e, P, r, A, S, B, "right"), I -= P.width, B -= P.width, L--;
                        for (R += (a - (R - w) - (T - B) - I) / 2; D <= L;) P = C[D], m(t, e, P, r, A, S, R + P.width / 2, "center"), R += P.width, D++;
                        S += A
                    }
                }(t, e, a, r, i)
            }(t, e, n, r, i) : function (t, e, n, r, i) {
                var a = S(e, "font", r.font || u.DEFAULT_FONT), o = r.textPadding, s = t.__textCotentBlock;
                s && !t.__dirty || (s = t.__textCotentBlock = u.parsePlainText(n, a, o, r.truncate));
                var l = s.outerHeight, h = s.lines, c = s.lineHeight, f = b(0, r, i), d = f.baseX, p = f.baseY,
                    v = f.textAlign, g = f.textVerticalAlign;
                y(e, r, i, d, p);
                var m = u.adjustTextY(p, l, g), w = d, P = m, C = x(r);
                if (C || o) {
                    var O = u.getWidth(n, a), A = O;
                    o && (A += o[1] + o[3]);
                    var I = u.adjustTextX(d, A, v);
                    C && _(t, e, r, I, m, A, l), o && (w = k(d, v, o), P += o[0])
                }
                S(e, "textAlign", v || "left"), S(e, "textBaseline", "middle"), S(e, "shadowBlur", r.textShadowBlur || 0), S(e, "shadowColor", r.textShadowColor || "transparent"), S(e, "shadowOffsetX", r.textShadowOffsetX || 0), S(e, "shadowOffsetY", r.textShadowOffsetY || 0), P += c / 2;
                var D = r.textStrokeWidth, R = T(r.textStroke, D), B = M(r.textFill);
                R && (S(e, "lineWidth", D), S(e, "strokeStyle", R)), B && S(e, "fillStyle", B);
                for (var L = 0; L < h.length; L++) R && e.strokeText(h[L], w, P), B && e.fillText(h[L], w, P), P += c
            }(t, e, n, r, i)
        }, e.getStroke = T, e.getFill = M, e.needDrawText = function (t, e) {
            return null != t && (t || e.textBackgroundColor || e.textBorderWidth && e.textBorderColor || e.textPadding)
        }
    }, function (t, e, n) {
        var r = n(3), i = n(10), a = n(0), o = a.getContext, s = a.extend, l = a.retrieve2, h = a.retrieve3, u = a.trim,
            c = {}, f = 0, d = 5e3, p = /\{([a-zA-Z0-9_]+)\|([^}]*)\}/g, v = "12px sans-serif", g = {};

        function y(t, e) {
            var n = t + ":" + (e = e || v);
            if (c[n]) return c[n];
            for (var r = (t + "").split("\n"), i = 0, a = 0, o = r.length; a < o; a++) i = Math.max(M(r[a], e).width, i);
            return f > d && (f = 0, c = {}), f++, c[n] = i, i
        }

        function m(t, e, n) {
            return "right" === n ? t -= e : "center" === n && (t -= e / 2), t
        }

        function x(t, e, n) {
            return "middle" === n ? t -= e / 2 : "bottom" === n && (t -= e), t
        }

        function _(t, e, n, r, i) {
            if (!e) return "";
            var a = (t + "").split("\n");
            i = w(e, n, r, i);
            for (var o = 0, s = a.length; o < s; o++) a[o] = b(a[o], i);
            return a.join("\n")
        }

        function w(t, e, n, r) {
            (r = s({}, r)).font = e;
            n = l(n, "...");
            r.maxIterations = l(r.maxIterations, 2);
            var i = r.minChar = l(r.minChar, 0);
            r.cnCharWidth = y("国", e);
            var a = r.ascCharWidth = y("a", e);
            r.placeholder = l(r.placeholder, "");
            for (var o = t = Math.max(0, t - 1), h = 0; h < i && o >= a; h++) o -= a;
            var u = y(n);
            return u > o && (n = "", u = 0), o = t - u, r.ellipsis = n, r.ellipsisWidth = u, r.contentWidth = o, r.containerWidth = t, r
        }

        function b(t, e) {
            var n = e.containerWidth, r = e.font, i = e.contentWidth;
            if (!n) return "";
            var a = y(t, r);
            if (a <= n) return t;
            for (var o = 0; ; o++) {
                if (a <= i || o >= e.maxIterations) {
                    t += e.ellipsis;
                    break
                }
                var s = 0 === o ? S(t, i, e.ascCharWidth, e.cnCharWidth) : a > 0 ? Math.floor(t.length * i / a) : 0;
                a = y(t = t.substr(0, s), r)
            }
            return "" === t && (t = e.placeholder), t
        }

        function S(t, e, n, r) {
            for (var i = 0, a = 0, o = t.length; a < o && i < e; a++) {
                var s = t.charCodeAt(a);
                i += 0 <= s && s <= 127 ? n : r
            }
            return a
        }

        function T(t) {
            return y("国", t)
        }

        function M(t, e) {
            return g.measureText(t, e)
        }

        function P(t, e, n, r) {
            null != t && (t += "");
            var i = T(e), a = t ? t.split("\n") : [], o = a.length * i, s = o;
            if (n && (s += n[0] + n[2]), t && r) {
                var l = r.outerHeight, h = r.outerWidth;
                if (null != l && s > l) t = "", a = []; else if (null != h) for (var u = w(h - (n ? n[1] + n[3] : 0), e, r.ellipsis, {
                    minChar: r.minChar,
                    placeholder: r.placeholder
                }), c = 0, f = a.length; c < f; c++) a[c] = b(a[c], u)
            }
            return {lines: a, height: o, outerHeight: s, lineHeight: i}
        }

        function k(t, e) {
            var n = {lines: [], width: 0, height: 0};
            if (null != t && (t += ""), !t) return n;
            for (var r, a = p.lastIndex = 0; null != (r = p.exec(t));) {
                var o = r.index;
                o > a && C(n, t.substring(a, o)), C(n, r[2], r[1]), a = p.lastIndex
            }
            a < t.length && C(n, t.substring(a, t.length));
            var s = n.lines, u = 0, c = 0, f = [], d = e.textPadding, v = e.truncate, g = v && v.outerWidth,
                m = v && v.outerHeight;
            d && (null != g && (g -= d[1] + d[3]), null != m && (m -= d[0] + d[2]));
            for (var x = 0; x < s.length; x++) {
                for (var w = s[x], b = 0, S = 0, M = 0; M < w.tokens.length; M++) {
                    var P = (E = w.tokens[M]).styleName && e.rich[E.styleName] || {}, k = E.textPadding = P.textPadding,
                        O = E.font = P.font || e.font, A = E.textHeight = l(P.textHeight, T(O));
                    if (k && (A += k[0] + k[2]), E.height = A, E.lineHeight = h(P.textLineHeight, e.textLineHeight, A), E.textAlign = P && P.textAlign || e.textAlign, E.textVerticalAlign = P && P.textVerticalAlign || "middle", null != m && u + E.lineHeight > m) return {
                        lines: [],
                        width: 0,
                        height: 0
                    };
                    E.textWidth = y(E.text, O);
                    var I = P.textWidth, D = null == I || "auto" === I;
                    if ("string" == typeof I && "%" === I.charAt(I.length - 1)) E.percentWidth = I, f.push(E), I = 0; else {
                        if (D) {
                            I = E.textWidth;
                            var R = P.textBackgroundColor, B = R && R.image;
                            B && (B = i.findExistImage(B), i.isImageReady(B) && (I = Math.max(I, B.width * A / B.height)))
                        }
                        var L = k ? k[1] + k[3] : 0;
                        I += L;
                        var F = null != g ? g - S : null;
                        null != F && F < I && (!D || F < L ? (E.text = "", E.textWidth = I = 0) : (E.text = _(E.text, F - L, O, v.ellipsis, {minChar: v.minChar}), E.textWidth = y(E.text, O), I = E.textWidth + L))
                    }
                    S += E.width = I, P && (b = Math.max(b, E.lineHeight))
                }
                w.width = S, w.lineHeight = b, u += b, c = Math.max(c, S)
            }
            n.outerWidth = n.width = l(e.textWidth, c), n.outerHeight = n.height = l(e.textHeight, u), d && (n.outerWidth += d[1] + d[3], n.outerHeight += d[0] + d[2]);
            for (x = 0; x < f.length; x++) {
                var E, W = (E = f[x]).percentWidth;
                E.width = parseInt(W, 10) / 100 * c
            }
            return n
        }

        function C(t, e, n) {
            for (var r = "" === e, i = e.split("\n"), a = t.lines, o = 0; o < i.length; o++) {
                var s = i[o], l = {styleName: n, text: s, isLineHolder: !s && !r};
                if (o) a.push({tokens: [l]}); else {
                    var h = (a[a.length - 1] || (a[0] = {tokens: []})).tokens, u = h.length;
                    1 === u && h[0].isLineHolder ? h[0] = l : (s || !u || r) && h.push(l)
                }
            }
        }

        g.measureText = function (t, e) {
            var n = o();
            return n.font = e || v, n.measureText(t)
        }, e.DEFAULT_FONT = v, e.$override = function (t, e) {
            g[t] = e
        }, e.getWidth = y, e.getBoundingRect = function (t, e, n, i, a, o, s) {
            return o ? function (t, e, n, i, a, o, s) {
                var l = k(t, {rich: o, truncate: s, font: e, textAlign: n, textPadding: a}), h = l.outerWidth,
                    u = l.outerHeight, c = m(0, h, n), f = x(0, u, i);
                return new r(c, f, h, u)
            }(t, e, n, i, a, o, s) : function (t, e, n, i, a, o) {
                var s = P(t, e, a, o), l = y(t, e);
                a && (l += a[1] + a[3]);
                var h = s.outerHeight, u = m(0, l, n), c = x(0, h, i), f = new r(u, c, l, h);
                return f.lineHeight = s.lineHeight, f
            }(t, e, n, i, a, s)
        }, e.adjustTextX = m, e.adjustTextY = x, e.adjustTextPositionOnRect = function (t, e, n) {
            var r = e.x, i = e.y, a = e.height, o = e.width, s = a / 2, l = "left", h = "top";
            switch (t) {
                case"left":
                    r -= n, i += s, l = "right", h = "middle";
                    break;
                case"right":
                    r += n + o, i += s, h = "middle";
                    break;
                case"top":
                    r += o / 2, i -= n, l = "center", h = "bottom";
                    break;
                case"bottom":
                    r += o / 2, i += a + n, l = "center";
                    break;
                case"inside":
                    r += o / 2, i += s, l = "center", h = "middle";
                    break;
                case"insideLeft":
                    r += n, i += s, h = "middle";
                    break;
                case"insideRight":
                    r += o - n, i += s, l = "right", h = "middle";
                    break;
                case"insideTop":
                    r += o / 2, i += n, l = "center";
                    break;
                case"insideBottom":
                    r += o / 2, i += a - n, l = "center", h = "bottom";
                    break;
                case"insideTopLeft":
                    r += n, i += n;
                    break;
                case"insideTopRight":
                    r += o - n, i += n, l = "right";
                    break;
                case"insideBottomLeft":
                    r += n, i += a - n, h = "bottom";
                    break;
                case"insideBottomRight":
                    r += o - n, i += a - n, l = "right", h = "bottom"
            }
            return {x: r, y: i, textAlign: l, textVerticalAlign: h}
        }, e.truncateText = _, e.getLineHeight = T, e.measureText = M, e.parsePlainText = P, e.parseRichText = k, e.makeFont = function (t) {
            var e = (t.fontSize || t.fontFamily) && [t.fontStyle, t.fontWeight, (t.fontSize || 12) + "px", t.fontFamily || "sans-serif"].join(" ");
            return e && u(e) || t.textFont || t.font
        }
    }, function (t, e) {
        e.buildPath = function (t, e) {
            var n, r, i, a, o, s = e.x, l = e.y, h = e.width, u = e.height, c = e.r;
            h < 0 && (s += h, h = -h), u < 0 && (l += u, u = -u), "number" == typeof c ? n = r = i = a = c : c instanceof Array ? 1 === c.length ? n = r = i = a = c[0] : 2 === c.length ? (n = i = c[0], r = a = c[1]) : 3 === c.length ? (n = c[0], r = a = c[1], i = c[2]) : (n = c[0], r = c[1], i = c[2], a = c[3]) : n = r = i = a = 0, n + r > h && (n *= h / (o = n + r), r *= h / o), i + a > h && (i *= h / (o = i + a), a *= h / o), r + i > u && (r *= u / (o = r + i), i *= u / o), n + a > u && (n *= u / (o = n + a), a *= u / o), t.moveTo(s + n, l), t.lineTo(s + h - r, l), 0 !== r && t.arc(s + h - r, l + r, r, -Math.PI / 2, 0), t.lineTo(s + h, l + u - i), 0 !== i && t.arc(s + h - i, l + u - i, i, 0, Math.PI / 2), t.lineTo(s + a, l + u), 0 !== a && t.arc(s + a, l + u - a, a, Math.PI / 2, Math.PI), t.lineTo(s, l + n), 0 !== n && t.arc(s + n, l + n, n, Math.PI, 1.5 * Math.PI)
        }
    }, function (t, e) {
        var n = 2 * Math.PI;
        e.normalizeRadian = function (t) {
            return (t %= n) < 0 && (t += n), t
        }
    }, function (t, e, n) {
        var r = n(66), i = n(67);
        e.buildPath = function (t, e, n) {
            var a = e.points, o = e.smooth;
            if (a && a.length >= 2) {
                if (o && "spline" !== o) {
                    var s = i(a, o, n, e.smoothConstraint);
                    t.moveTo(a[0][0], a[0][1]);
                    for (var l = a.length, h = 0; h < (n ? l : l - 1); h++) {
                        var u = s[2 * h], c = s[2 * h + 1], f = a[(h + 1) % l];
                        t.bezierCurveTo(u[0], u[1], c[0], c[1], f[0], f[1])
                    }
                } else {
                    "spline" === o && (a = r(a, n)), t.moveTo(a[0][0], a[0][1]), h = 1;
                    for (var d = a.length; h < d; h++) t.lineTo(a[h][0], a[h][1])
                }
                n && t.closePath()
            }
        }
    }, function (t, e) {
        var n = function (t) {
            this.colorStops = t || []
        };
        n.prototype = {
            constructor: n, addColorStop: function (t, e) {
                this.colorStops.push({offset: t, color: e})
            }
        };
        var r = n;
        t.exports = r
    }, function (t, e, n) {
        t.exports = n(27)
    }, function (t, e, n) {
        var r = n(5);
        n(28), n(35), r.registerVisual(r.util.curry(n(78), "liquidFill"))
    }, function (t, e, n) {
        var r = n(29), i = n(5);
        i.extendSeriesModel({
            type: "series.liquidFill",
            visualColorAccessPath: "textStyle.normal.color",
            optionUpdated: function () {
                var t = this.option;
                t.gridSize = Math.max(Math.floor(t.gridSize), 4)
            },
            getInitialData: function (t, e) {
                var n = r(["value"], t.data), a = new i.List(n, this);
                return a.initData(t.data), a
            },
            defaultOption: {
                color: ["#294D99", "#156ACF", "#1598ED", "#45BDFF"],
                center: ["50%", "50%"],
                radius: "50%",
                amplitude: "8%",
                waveLength: "80%",
                phase: "auto",
                period: "auto",
                direction: "right",
                shape: "circle",
                waveAnimation: !0,
                animationEasing: "linear",
                animationEasingUpdate: "linear",
                animationDuration: 2e3,
                animationDurationUpdate: 1e3,
                outline: {
                    show: !0,
                    borderDistance: 8,
                    itemStyle: {
                        color: "none",
                        borderColor: "#294D99",
                        borderWidth: 8,
                        shadowBlur: 20,
                        shadowColor: "rgba(0, 0, 0, 0.25)"
                    }
                },
                backgroundStyle: {color: "#E3F7FF"},
                itemStyle: {opacity: .95, shadowBlur: 50, shadowColor: "rgba(0, 0, 0, 0.4)"},
                label: {
                    show: !0,
                    color: "#294D99",
                    insideColor: "#fff",
                    fontSize: 50,
                    fontWeight: "bold",
                    align: "center",
                    baseline: "middle",
                    position: "inside"
                },
                emphasis: {itemStyle: {opacity: .8}}
            }
        })
    }, function (t, e, n) {
        var r = n(0), i = r.createHashMap, a = r.each, o = r.isString, s = r.defaults, l = r.extend, h = r.isObject,
            u = r.clone, c = n(11).normalizeToArray, f = n(30).guessOrdinal, d = n(12), p = n(34).OTHER_DIMENSIONS;

        function v(t, e, n) {
            if (n || null != e.get(t)) {
                for (var r = 0; null != e.get(t + r);) r++;
                t += r
            }
            return e.set(t, !0), t
        }

        var g = function (t, e, n) {
            d.isInstance(e) || (e = d.seriesDataToSource(e)), n = n || {}, t = (t || []).slice();
            for (var r = (n.dimsDef || []).slice(), g = i(n.encodeDef), y = i(), m = i(), x = [], _ = function (t, e, n, r) {
                var i = Math.max(t.dimensionsDetectCount || 1, e.length, n.length, r || 0);
                return a(e, function (t) {
                    var e = t.dimsDef;
                    e && (i = Math.max(i, e.length))
                }), i
            }(e, t, r, n.dimCount), w = 0; w < _; w++) {
                var b = r[w] = l({}, h(r[w]) ? r[w] : {name: r[w]}), S = b.name, T = x[w] = {otherDims: {}};
                null != S && null == y.get(S) && (T.name = T.displayName = S, y.set(S, w)), null != b.type && (T.type = b.type), null != b.displayName && (T.displayName = b.displayName)
            }
            g.each(function (t, e) {
                t = c(t).slice();
                var n = g.set(e, []);
                a(t, function (t, r) {
                    o(t) && (t = y.get(t)), null != t && t < _ && (n[r] = t, P(x[t], e, r))
                })
            });
            var M = 0;

            function P(t, e, n) {
                null != p.get(e) ? t.otherDims[e] = n : (t.coordDim = e, t.coordDimIndex = n, m.set(e, !0))
            }

            a(t, function (t, e) {
                var n, r, i;
                if (o(t)) n = t, t = {}; else {
                    n = t.name;
                    var l = t.ordinalMeta;
                    t.ordinalMeta = null, (t = u(t)).ordinalMeta = l, r = t.dimsDef, i = t.otherDims, t.name = t.coordDim = t.coordDimIndex = t.dimsDef = t.otherDims = null
                }
                var f = c(g.get(n));
                if (!f.length) for (var d = 0; d < (r && r.length || 1); d++) {
                    for (; M < x.length && null != x[M].coordDim;) M++;
                    M < x.length && f.push(M++)
                }
                a(f, function (e, a) {
                    var o = x[e];
                    if (P(s(o, t), n, a), null == o.name && r) {
                        var l = r[a];
                        !h(l) && (l = {name: l}), o.name = o.displayName = l.name, o.defaultTooltip = l.defaultTooltip
                    }
                    i && s(o.otherDims, i)
                })
            });
            var k = n.generateCoord, C = n.generateCoordCount, O = null != C;
            C = k ? C || 1 : 0;
            for (var A = k || "value", I = 0; I < _; I++) null == (T = x[I] = x[I] || {}).coordDim && (T.coordDim = v(A, m, O), T.coordDimIndex = 0, (!k || C <= 0) && (T.isExtraCoord = !0), C--), null == T.name && (T.name = v(T.coordDim, y)), null == T.type && f(e, I, T.name) && (T.type = "ordinal");
            return x
        };
        t.exports = g
    }, function (t, e, n) {
        n(6).__DEV__;
        var r = n(11), i = r.makeInner, a = r.getDataItemValue, o = n(32).getCoordSysDefineBySeries, s = n(0),
            l = s.createHashMap, h = s.each, u = s.map, c = s.isArray, f = s.isString, d = s.isObject,
            p = s.isTypedArray, v = s.isArrayLike, g = s.extend, y = (s.assert, n(12)), m = n(13),
            x = m.SOURCE_FORMAT_ORIGINAL, _ = m.SOURCE_FORMAT_ARRAY_ROWS, w = m.SOURCE_FORMAT_OBJECT_ROWS,
            b = m.SOURCE_FORMAT_KEYED_COLUMNS, S = m.SOURCE_FORMAT_UNKNOWN, T = m.SOURCE_FORMAT_TYPED_ARRAY,
            M = m.SERIES_LAYOUT_BY_ROW, P = i();

        function k(t) {
            if (t) {
                var e = l();
                return u(t, function (t, n) {
                    if (null == (t = g({}, d(t) ? t : {name: t})).name) return t;
                    t.name += "", null == t.displayName && (t.displayName = t.name);
                    var r = e.get(t.name);
                    return r ? t.name += "-" + r.count++ : e.set(t.name, {count: 1}), t
                })
            }
        }

        function C(t, e, n, r) {
            if (null == r && (r = 1 / 0), e === M) for (var i = 0; i < n.length && i < r; i++) t(n[i] ? n[i][0] : null, i); else {
                var a = n[0] || [];
                for (i = 0; i < a.length && i < r; i++) t(a[i], i)
            }
        }

        function O(t, e, n, r, i, o) {
            var s, l;
            if (p(t)) return !1;
            if (r && (l = r[o], l = d(l) ? l.name : l), e === _) if (n === M) {
                for (var h = t[o], u = 0; u < (h || []).length && u < 5; u++) if (null != (s = m(h[i + u]))) return s
            } else for (u = 0; u < t.length && u < 5; u++) {
                var v = t[i + u];
                if (v && null != (s = m(v[o]))) return s
            } else if (e === w) {
                if (!l) return;
                for (u = 0; u < t.length && u < 5; u++) {
                    if ((g = t[u]) && null != (s = m(g[l]))) return s
                }
            } else if (e === b) {
                if (!l) return;
                if (!(h = t[l]) || p(h)) return !1;
                for (u = 0; u < h.length && u < 5; u++) if (null != (s = m(h[u]))) return s
            } else if (e === x) for (u = 0; u < t.length && u < 5; u++) {
                var g = t[u], y = a(g);
                if (!c(y)) return !1;
                if (null != (s = m(y[o]))) return s
            }

            function m(t) {
                return (null == t || !isFinite(t) || "" === t) && (!(!f(t) || "-" === t) || void 0)
            }

            return !1
        }

        e.detectSourceFormat = function (t) {
            var e = t.option.source, n = S;
            if (p(e)) n = T; else if (c(e)) for (var r = 0, i = e.length; r < i; r++) {
                var a = e[r];
                if (null != a) {
                    if (c(a)) {
                        n = _;
                        break
                    }
                    if (d(a)) {
                        n = w;
                        break
                    }
                }
            } else if (d(e)) {
                for (var o in e) if (e.hasOwnProperty(o) && v(e[o])) {
                    n = b;
                    break
                }
            } else if (null != e) throw new Error("Invalid data");
            P(t).sourceFormat = n
        }, e.getSource = function (t) {
            return P(t).source
        }, e.resetSourceDefaulter = function (t) {
            P(t).datasetMap = l()
        }, e.prepareSource = function (t) {
            var e = t.option, n = e.data, r = p(n) ? T : x, i = !1, s = e.seriesLayoutBy, u = e.sourceHeader,
                v = e.dimensions, g = function (t) {
                    var e = t.option;
                    if (!e.data) return t.ecModel.getComponent("dataset", e.datasetIndex || 0)
                }(t);
            if (g) {
                var m = g.option;
                n = m.source, r = P(g).sourceFormat, i = !0, s = s || m.seriesLayoutBy, null == u && (u = m.sourceHeader), v = v || m.dimensions
            }
            var S = function (t, e, n, r, i) {
                if (!t) return {dimensionsDefine: k(i)};
                var o, s, l, u;
                if (e === _) "auto" === r || null == r ? C(function (t) {
                    null != t && "-" !== t && (f(t) ? null == s && (s = 1) : s = 0)
                }, n, t, 10) : s = r ? 1 : 0, i || 1 !== s || (i = [], C(function (t, e) {
                    i[e] = null != t ? t : ""
                }, n, t)), o = i ? i.length : n === M ? t.length : t[0] ? t[0].length : null; else if (e === w) i || (i = function (t) {
                    for (var e, n = 0; n < t.length && !(e = t[n++]);) ;
                    if (e) {
                        var r = [];
                        return h(e, function (t, e) {
                            r.push(e)
                        }), r
                    }
                }(t), l = !0); else if (e === b) i || (i = [], l = !0, h(t, function (t, e) {
                    i.push(e)
                })); else if (e === x) {
                    var p = a(t[0]);
                    o = c(p) && p.length || 1
                }
                return l && h(i, function (t, e) {
                    "name" === (d(t) ? t.name : t) && (u = e)
                }), {startIndex: s, dimensionsDefine: k(i), dimensionsDetectCount: o, potentialNameDimIndex: u}
            }(n, r, s, u, v), A = e.encode;
            !A && g && (A = function (t, e, n, r, i, a) {
                var s = o(t), u = {}, c = [], f = [], d = t.subType, p = l(["pie", "map", "funnel"]),
                    v = l(["line", "bar", "pictorialBar", "scatter", "effectScatter", "candlestick", "boxplot"]);
                if (s && null != v.get(d)) {
                    var g = t.ecModel, y = P(g).datasetMap, m = e.uid + "_" + i,
                        x = y.get(m) || y.set(m, {categoryWayDim: 1, valueWayDim: 0});
                    h(s.coordSysDims, function (t) {
                        if (null == s.firstCategoryDimIndex) {
                            var e = x.valueWayDim++;
                            u[t] = e, f.push(e)
                        } else if (s.categoryAxisMap.get(t)) u[t] = 0, c.push(0); else {
                            var e = x.categoryWayDim++;
                            u[t] = e, f.push(e)
                        }
                    })
                } else if (null != p.get(d)) {
                    for (var _, w = 0; w < 5 && null == _; w++) O(n, r, i, a.dimensionsDefine, a.startIndex, w) || (_ = w);
                    if (null != _) {
                        u.value = _;
                        var b = a.potentialNameDimIndex || Math.max(_ - 1, 0);
                        f.push(b), c.push(b)
                    }
                }
                return c.length && (u.itemName = c), f.length && (u.seriesName = f), u
            }(t, g, n, r, s, S)), P(t).source = new y({
                data: n,
                fromDataset: i,
                seriesLayoutBy: s,
                sourceFormat: r,
                dimensionsDefine: S.dimensionsDefine,
                startIndex: S.startIndex,
                dimensionsDetectCount: S.dimensionsDetectCount,
                encodeDefine: A
            })
        }, e.guessOrdinal = function (t, e) {
            return O(t.data, t.sourceFormat, t.seriesLayoutBy, t.dimensionsDefine, t.startIndex, e)
        }
    }, function (t, e) {
        var n;
        n = function () {
            return this
        }();
        try {
            n = n || Function("return this")() || (0, eval)("this")
        } catch (t) {
            "object" == typeof window && (n = window)
        }
        t.exports = n
    }, function (t, e, n) {
        n(6).__DEV__;
        var r = n(0), i = r.createHashMap, a = (r.retrieve, r.each);
        var o = {
            cartesian2d: function (t, e, n, r) {
                var i = t.getReferringComponents("xAxis")[0], a = t.getReferringComponents("yAxis")[0];
                e.coordSysDims = ["x", "y"], n.set("x", i), n.set("y", a), s(i) && (r.set("x", i), e.firstCategoryDimIndex = 0), s(a) && (r.set("y", a), e.firstCategoryDimIndex = 1)
            }, singleAxis: function (t, e, n, r) {
                var i = t.getReferringComponents("singleAxis")[0];
                e.coordSysDims = ["single"], n.set("single", i), s(i) && (r.set("single", i), e.firstCategoryDimIndex = 0)
            }, polar: function (t, e, n, r) {
                var i = t.getReferringComponents("polar")[0], a = i.findAxisModel("radiusAxis"),
                    o = i.findAxisModel("angleAxis");
                e.coordSysDims = ["radius", "angle"], n.set("radius", a), n.set("angle", o), s(a) && (r.set("radius", a), e.firstCategoryDimIndex = 0), s(o) && (r.set("angle", o), e.firstCategoryDimIndex = 1)
            }, geo: function (t, e, n, r) {
                e.coordSysDims = ["lng", "lat"]
            }, parallel: function (t, e, n, r) {
                var i = t.ecModel, o = i.getComponent("parallel", t.get("parallelIndex")),
                    l = e.coordSysDims = o.dimensions.slice();
                a(o.parallelAxisIndex, function (t, a) {
                    var o = i.getComponent("parallelAxis", t), h = l[a];
                    n.set(h, o), s(o) && null == e.firstCategoryDimIndex && (r.set(h, o), e.firstCategoryDimIndex = a)
                })
            }
        };

        function s(t) {
            return "category" === t.get("type")
        }

        e.getCoordSysDefineBySeries = function (t) {
            var e = t.get("coordinateSystem"),
                n = {coordSysName: e, coordSysDims: [], axisMap: i(), categoryAxisMap: i()}, r = o[e];
            if (r) return r(t, n, n.axisMap, n.categoryAxisMap), n
        }
    }, function (t, e, n) {
        n(6).__DEV__;
        var r = n(0), i = ".", a = "___EC__COMPONENT__CONTAINER___";

        function o(t) {
            var e = {main: "", sub: ""};
            return t && (t = t.split(i), e.main = t[0] || "", e.sub = t[1] || ""), e
        }

        var s = 0;

        function l(t, e) {
            var n = r.slice(arguments, 2);
            return this.superClass.prototype[e].apply(t, n)
        }

        function h(t, e, n) {
            return this.superClass.prototype[e].apply(t, n)
        }

        e.parseClassType = o, e.enableClassExtend = function (t, e) {
            t.$constructor = t, t.extend = function (t) {
                var e = this, n = function () {
                    t.$constructor ? t.$constructor.apply(this, arguments) : e.apply(this, arguments)
                };
                return r.extend(n.prototype, t), n.extend = this.extend, n.superCall = l, n.superApply = h, r.inherits(n, this), n.superClass = e, n
            }
        }, e.enableClassCheck = function (t) {
            var e = ["__\0is_clz", s++, Math.random().toFixed(3)].join("_");
            t.prototype[e] = !0, t.isInstance = function (t) {
                return !(!t || !t[e])
            }
        }, e.enableClassManagement = function (t, e) {
            e = e || {};
            var n = {};
            if (t.registerClass = function (t, e) {
                return e && (function (t) {
                    r.assert(/^[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)?$/.test(t), 'componentType "' + t + '" illegal')
                }(e), (e = o(e)).sub ? e.sub !== a && ((function (t) {
                    var e = n[t.main];
                    return e && e[a] || ((e = n[t.main] = {})[a] = !0), e
                }(e))[e.sub] = t) : n[e.main] = t), t
            }, t.getClass = function (t, e, r) {
                var i = n[t];
                if (i && i[a] && (i = e ? i[e] : null), r && !i) throw new Error(e ? "Component " + t + "." + (e || "") + " not exists. Load it first." : t + ".type should be specified.");
                return i
            }, t.getClassesByMainType = function (t) {
                t = o(t);
                var e = [], i = n[t.main];
                return i && i[a] ? r.each(i, function (t, n) {
                    n !== a && e.push(t)
                }) : e.push(i), e
            }, t.hasClass = function (t) {
                return t = o(t), !!n[t.main]
            }, t.getAllClassMainTypes = function () {
                var t = [];
                return r.each(n, function (e, n) {
                    t.push(n)
                }), t
            }, t.hasSubTypes = function (t) {
                t = o(t);
                var e = n[t.main];
                return e && e[a]
            }, t.parseClassType = o, e.registerWhenExtend) {
                var i = t.extend;
                i && (t.extend = function (e) {
                    var n = i.call(this, e);
                    return t.registerClass(n, e.type)
                })
            }
            return t
        }, e.setReadOnly = function (t, e) {
        }
    }, function (t, e, n) {
        var r = n(0), i = r.each, a = r.createHashMap,
            o = (r.assert, n(6).__DEV__, a(["tooltip", "label", "itemName", "itemId", "seriesName"]));
        e.OTHER_DIMENSIONS = o, e.summarizeDimensions = function (t) {
            var e = {}, n = e.encode = {}, r = a(), s = [], l = [];
            i(t.dimensions, function (e) {
                var i = t.getDimensionInfo(e), a = i.coordDim;
                if (a) {
                    var h = n[a];
                    n.hasOwnProperty(a) || (h = n[a] = []), h[i.coordDimIndex] = e, i.isExtraCoord || (r.set(a, 1), function (t) {
                        return !("ordinal" === t || "time" === t)
                    }(i.type) && (s[0] = e)), i.defaultTooltip && l.push(e)
                }
                o.each(function (t, e) {
                    var r = n[e];
                    n.hasOwnProperty(e) || (r = n[e] = []);
                    var a = i.otherDims[e];
                    null != a && !1 !== a && (r[a] = i.name)
                })
            });
            var h = [], u = {};
            r.each(function (t, e) {
                var r = n[e];
                u[e] = r[0], h = h.concat(r)
            }), e.dataDimsOnCoord = h, e.encodeFirstDimNotExtra = u;
            var c = n.label;
            c && c.length && (s = c.slice());
            var f = n.tooltip;
            return f && f.length ? l = f.slice() : l.length || (l = s.slice()), n.defaultedLabel = s, n.defaultedTooltip = l, e
        }, e.getDimensionTypeByAxis = function (t) {
            return "category" === t ? "ordinal" : "time" === t ? "time" : "float"
        }
    }, function (t, e, n) {
        var r = n(5), i = r.number, a = n(36), o = i.parsePercent, s = n(77);
        r.extendChartView({
            type: "liquidFill", render: function (t, e, n) {
                var i = this.group;
                i.removeAll();
                var l = t.getData(), h = l.getItemModel(0), u = h.get("center"), c = h.get("radius"), f = n.getWidth(),
                    d = n.getHeight(), p = Math.min(f, d), v = 0, g = 0, y = t.get("outline.show");
                y && (v = t.get("outline.borderDistance"), g = o(t.get("outline.itemStyle.borderWidth"), p));
                var m, x, _, w = o(u[0], f), b = o(u[1], d), S = !1, T = t.get("shape");
                ("container" === T ? (S = !0, x = [(m = [f / 2, d / 2])[0] - g / 2, m[1] - g / 2], _ = [o(v, f), o(v, d)], c = [Math.max(x[0] - _[0], 0), Math.max(x[1] - _[1], 0)]) : (x = (m = o(c, p) / 2) - g / 2, _ = o(v, p), c = Math.max(x - _, 0)), y) && (I().style.lineWidth = g, i.add(I()));
                var M = S ? 0 : w - c, P = S ? 0 : b - c, k = null;
                i.add(function () {
                    var e = A(c);
                    e.setStyle(t.getModel("backgroundStyle").getItemStyle()), e.style.fill = null, e.z2 = 5;
                    var n = A(c);
                    n.setStyle(t.getModel("backgroundStyle").getItemStyle()), n.style.stroke = null;
                    var i = new r.graphic.Group;
                    return i.add(e), i.add(n), i
                }());
                var C = this._data, O = [];

                function A(t, e) {
                    if (T) {
                        if (0 === T.indexOf("path://")) {
                            var n = r.graphic.makePath(T.slice(7), {}), i = n.getBoundingRect(), o = i.width,
                                s = i.height;
                            o > s ? (s *= 2 * t / o, o = 2 * t) : (o *= 2 * t / s, s = 2 * t);
                            var l = e ? 0 : w - o / 2, h = e ? 0 : b - s / 2;
                            return n = r.graphic.makePath(T.slice(7), {}, new r.graphic.BoundingRect(l, h, o, s)), e && (n.position = [-o / 2, -s / 2]), n
                        }
                        if (S) {
                            var u = e ? -t[0] : w - t[0], c = e ? -t[1] : b - t[1];
                            return a.createSymbol("rect", u, c, 2 * t[0], 2 * t[1])
                        }
                        u = e ? -t : w - t, c = e ? -t : b - t;
                        return "pin" === T ? c += t : "arrow" === T && (c -= t), a.createSymbol(T, u, c, 2 * t, 2 * t)
                    }
                    return new r.graphic.Circle({shape: {cx: e ? 0 : w, cy: e ? 0 : b, r: t}})
                }

                function I() {
                    var e = A(m);
                    return e.style.fill = null, e.setStyle(t.getModel("outline.itemStyle").getItemStyle()), e
                }

                function D(e, n, i) {
                    var a = S ? c[0] : c, h = S ? d / 2 : c;
                    /*console.log(h);*/
                    var u = l.getItemModel(e), f = u.getModel("itemStyle"), p = u.get("phase"),
                        v = o(u.get("amplitude"), 2 * h), g = o(u.get("waveLength"), 2 * a),
                        y = h - l.get("value", e) * h * 2;
                    p = i ? i.shape.phase : "auto" === p ? e * Math.PI / 4 : p;
                    var m = f.getItemStyle();
                    if (!m.fill) {
                        var x = t.get("color"), _ = e % x.length;
                        m.fill = x[_]
                    }
                    var T = new s({
                        shape: {
                            waveLength: g,
                            radius: a,
                            radiusY: h,
                            cx: 2 * a,
                            cy: 0,
                            waterLevel: y,
                            amplitude: v,
                            phase: p,
                            inverse: n
                        }, style: m, position: [w, b]
                    });
                    T.shape._waterLevel = y;
                    var M = u.getModel("emphasis.itemStyle").getItemStyle();
                    M.lineWidth = 0, r.graphic.setHoverStyle(T, M);
                    var P = A(c, !0);
                    return P.setStyle({fill: "white"}), T.setClipPath(P), T
                }

                function R(t, e, n) {
                    var r = l.getItemModel(t), i = r.get("period"), a = r.get("direction"), o = l.get("value", t),
                        s = r.get("phase");
                    s = n ? n.shape.phase : "auto" === s ? t * Math.PI / 4 : s;
                    var h = 0;
                    h = "auto" === i ? function (e) {
                        var n = l.count();
                        return 0 === n ? e : e * (.2 + (n - t) / n * .8)
                    }(5e3) : "function" == typeof i ? i(o, t) : i;
                    var u = 0;
                    "right" === a || null == a ? u = Math.PI : "left" === a ? u = -Math.PI : "none" === a ? u = 0 : console.error("Illegal direction value for liquid fill."), "none" !== a && r.get("waveAnimation") && e.animate("shape", !0).when(0, {phase: s}).when(h / 2, {phase: u + s}).when(h, {phase: 2 * u + s}).during(function () {
                        k && k.dirty(!0)
                    }).start()
                }

                l.diff(C).add(function (e) {
                    var n = D(e, !1), a = n.shape.waterLevel;
                    n.shape.waterLevel = S ? d / 2 : c, r.graphic.initProps(n, {shape: {waterLevel: a}}, t), n.z2 = 2, R(e, n, null), i.add(n), l.setItemGraphicEl(e, n), O.push(n)
                }).update(function (e, n) {
                    for (var a = C.getItemGraphicEl(n), o = D(e, !1, a), s = {}, h = ["amplitude", "cx", "cy", "phase", "radius", "radiusY", "waterLevel", "waveLength"], u = 0; u < h.length; ++u) {
                        var c = h[u];
                        o.shape.hasOwnProperty(c) && (s[c] = o.shape[c])
                    }
                    var f = {}, p = ["fill", "opacity", "shadowBlur", "shadowColor"];
                    for (u = 0; u < p.length; ++u) {
                        c = p[u];
                        o.style.hasOwnProperty(c) && (f[c] = o.style[c])
                    }
                    S && (s.radiusY = d / 2), r.graphic.updateProps(a, {
                        shape: s,
                        style: f
                    }, t), a.position = o.position, a.setClipPath(o.clipPath), a.shape.inverse = o.inverse, R(e, a, a), i.add(a), l.setItemGraphicEl(e, a), O.push(a)
                }).remove(function (t) {
                    var e = C.getItemGraphicEl(t);
                    i.remove(e)
                }).execute(), h.get("label.show") && i.add(function (e) {
                    var n = h.getModel("label");
                    var i = {
                        z2: 10,
                        shape: {x: M, y: P, width: 2 * (S ? c[0] : c), height: 2 * (S ? c[1] : c)},
                        style: {
                            fill: "transparent", text: function () {
                                var e = t.getFormattedLabel(0, "normal"), n = 100 * l.get("value", 0),
                                    r = l.getName(0) || t.name;
                                isNaN(n) || (r = n.toFixed(0) + "%");
                                return null == e ? r : e
                            }(), textAlign: n.get("align"), textVerticalAlign: n.get("baseline")
                        },
                        silent: !0
                    }, a = new r.graphic.Rect(i), o = n.get("color");
                    r.graphic.setText(a.style, n, o);
                    var s = new r.graphic.Rect(i), u = n.get("insideColor");
                    r.graphic.setText(s.style, n, u), s.style.textFill = u;
                    var f = new r.graphic.Group;
                    f.add(a), f.add(s);
                    var d = A(c, !0);
                    return (k = new r.graphic.CompoundPath({
                        shape: {paths: e},
                        position: [w, b]
                    })).setClipPath(d), s.setClipPath(k), f
                }(O)), this._data = l
            }, dispose: function () {
            }
        })
    }, function (t, e, n) {
        var r = n(0), i = n(37), a = n(3), o = i.extendShape({
            type: "triangle",
            shape: {cx: 0, cy: 0, width: 0, height: 0},
            buildPath: function (t, e) {
                var n = e.cx, r = e.cy, i = e.width / 2, a = e.height / 2;
                t.moveTo(n, r - a), t.lineTo(n + i, r + a), t.lineTo(n - i, r + a), t.closePath()
            }
        }), s = i.extendShape({
            type: "diamond", shape: {cx: 0, cy: 0, width: 0, height: 0}, buildPath: function (t, e) {
                var n = e.cx, r = e.cy, i = e.width / 2, a = e.height / 2;
                t.moveTo(n, r - a), t.lineTo(n + i, r), t.lineTo(n, r + a), t.lineTo(n - i, r), t.closePath()
            }
        }), l = i.extendShape({
            type: "pin", shape: {x: 0, y: 0, width: 0, height: 0}, buildPath: function (t, e) {
                var n = e.x, r = e.y, i = e.width / 5 * 3, a = Math.max(i, e.height), o = i / 2, s = o * o / (a - o),
                    l = r - a + o + s, h = Math.asin(s / o), u = Math.cos(h) * o, c = Math.sin(h), f = Math.cos(h),
                    d = .6 * o, p = .7 * o;
                t.moveTo(n - u, l + s), t.arc(n, l, o, Math.PI - h, 2 * Math.PI + h), t.bezierCurveTo(n + u - c * d, l + s + f * d, n, r - p, n, r), t.bezierCurveTo(n, r - p, n - u + c * d, l + s + f * d, n - u, l + s), t.closePath()
            }
        }), h = i.extendShape({
            type: "arrow", shape: {x: 0, y: 0, width: 0, height: 0}, buildPath: function (t, e) {
                var n = e.height, r = e.width, i = e.x, a = e.y, o = r / 3 * 2;
                t.moveTo(i, a), t.lineTo(i + o, a + n), t.lineTo(i, a + n / 4 * 3), t.lineTo(i - o, a + n), t.lineTo(i, a), t.closePath()
            }
        }), u = {
            line: i.Line,
            rect: i.Rect,
            roundRect: i.Rect,
            square: i.Rect,
            circle: i.Circle,
            diamond: s,
            pin: l,
            arrow: h,
            triangle: o
        }, c = {
            line: function (t, e, n, r, i) {
                i.x1 = t, i.y1 = e + r / 2, i.x2 = t + n, i.y2 = e + r / 2
            }, rect: function (t, e, n, r, i) {
                i.x = t, i.y = e, i.width = n, i.height = r
            }, roundRect: function (t, e, n, r, i) {
                i.x = t, i.y = e, i.width = n, i.height = r, i.r = Math.min(n, r) / 4
            }, square: function (t, e, n, r, i) {
                var a = Math.min(n, r);
                i.x = t, i.y = e, i.width = a, i.height = a
            }, circle: function (t, e, n, r, i) {
                i.cx = t + n / 2, i.cy = e + r / 2, i.r = Math.min(n, r) / 2
            }, diamond: function (t, e, n, r, i) {
                i.cx = t + n / 2, i.cy = e + r / 2, i.width = n, i.height = r
            }, pin: function (t, e, n, r, i) {
                i.x = t + n / 2, i.y = e + r / 2, i.width = n, i.height = r
            }, arrow: function (t, e, n, r, i) {
                i.x = t + n / 2, i.y = e + r / 2, i.width = n, i.height = r
            }, triangle: function (t, e, n, r, i) {
                i.cx = t + n / 2, i.cy = e + r / 2, i.width = n, i.height = r
            }
        }, f = {};
        r.each(u, function (t, e) {
            f[e] = new t
        });
        var d = i.extendShape({
            type: "symbol",
            shape: {symbolType: "", x: 0, y: 0, width: 0, height: 0},
            beforeBrush: function () {
                var t = this.style;
                "pin" === this.shape.symbolType && "inside" === t.textPosition && (t.textPosition = ["50%", "40%"], t.textAlign = "center", t.textVerticalAlign = "middle")
            },
            buildPath: function (t, e, n) {
                var r = e.symbolType, i = f[r];
                "none" !== e.symbolType && (i || (i = f[r = "rect"]), c[r](e.x, e.y, e.width, e.height, i.shape), i.buildPath(t, i.shape, n))
            }
        });

        function p(t, e) {
            if ("image" !== this.type) {
                var n = this.style, r = this.shape;
                r && "line" === r.symbolType ? n.stroke = t : this.__isEmptyBrush ? (n.stroke = t, n.fill = e || "#fff") : (n.fill && (n.fill = t), n.stroke && (n.stroke = t)), this.dirty(!1)
            }
        }

        e.createSymbol = function (t, e, n, r, o, s, l) {
            var h, u = 0 === t.indexOf("empty");
            return u && (t = t.substr(5, 1).toLowerCase() + t.substr(6)), (h = 0 === t.indexOf("image://") ? i.makeImage(t.slice(8), new a(e, n, r, o), l ? "center" : "cover") : 0 === t.indexOf("path://") ? i.makePath(t.slice(7), {}, new a(e, n, r, o), l ? "center" : "cover") : new d({
                shape: {
                    symbolType: t,
                    x: e,
                    y: n,
                    width: r,
                    height: o
                }
            })).__isEmptyBrush = u, h.setColor = p, h.setColor(s), h
        }
    }, function (t, e, n) {
        var r = n(0), i = n(38), a = n(17), o = n(9), s = n(2), l = n(1), h = n(16), u = n(57);
        e.Image = u;
        var c = n(58);
        e.Group = c;
        var f = n(59);
        e.Text = f;
        var d = n(60);
        e.Circle = d;
        var p = n(61);
        e.Sector = p;
        var v = n(64);
        e.Ring = v;
        var g = n(65);
        e.Polygon = g;
        var y = n(68);
        e.Polyline = y;
        var m = n(69);
        e.Rect = m;
        var x = n(70);
        e.Line = x;
        var _ = n(71);
        e.BezierCurve = _;
        var w = n(72);
        e.Arc = w;
        var b = n(73);
        e.CompoundPath = b;
        var S = n(74);
        e.LinearGradient = S;
        var T = n(75);
        e.RadialGradient = T;
        var M = n(3);
        e.BoundingRect = M;
        var P = n(76);
        e.IncrementalDisplayable = P;
        var k = Math.round, C = Math.max, O = Math.min, A = {};

        function I(t, e, n, r) {
            var a = i.createFromString(t, e), o = a.getBoundingRect();
            return n && ("center" === r && (n = D(n, o)), B(a, n)), a
        }

        function D(t, e) {
            var n, r = e.width / e.height, i = t.height * r;
            return n = i <= t.width ? t.height : (i = t.width) / r, {
                x: t.x + t.width / 2 - i / 2,
                y: t.y + t.height / 2 - n / 2,
                width: i,
                height: n
            }
        }

        var R = i.mergePath;

        function B(t, e) {
            if (t.applyTransform) {
                var n = t.getBoundingRect().calculateTransform(e);
                t.applyTransform(n)
            }
        }

        function L(t, e, n) {
            var r = k(2 * t);
            return (r + k(e)) % 2 == 0 ? r / 2 : (r + (n ? 1 : -1)) / 2
        }

        function F(t) {
            return null != t && "none" != t
        }

        function E(t) {
            return "string" == typeof t ? a.lift(t, -.1) : t
        }

        function W(t) {
            if (t.__hoverStlDirty) {
                var e = t.style.stroke, n = t.style.fill, r = t.__hoverStl;
                r.fill = r.fill || (F(n) ? E(n) : null), r.stroke = r.stroke || (F(e) ? E(e) : null);
                var i = {};
                for (var a in r) null != r[a] && (i[a] = t.style[a]);
                t.__normalStl = i, t.__hoverStlDirty = !1
            }
        }

        function z(t) {
            if (!t.__isHover) {
                if (W(t), t.useHoverLayer) t.__zr && t.__zr.addHover(t, t.__hoverStl); else {
                    var e = t.style, n = e.insideRollbackOpt;
                    n && function (t) {
                        var e = t.insideRollback;
                        e && (t.textFill = e.textFill, t.textStroke = e.textStroke, t.textStrokeWidth = e.textStrokeWidth)
                    }(e), e.extendFrom(t.__hoverStl), n && (K(e, e.insideOriginalTextPosition, n), null == e.textFill && (e.textFill = n.autoColor)), t.dirty(!1), t.z2 += 1
                }
                t.__isHover = !0
            }
        }

        function N(t) {
            if (t.__isHover) {
                var e = t.__normalStl;
                t.useHoverLayer ? t.__zr && t.__zr.removeHover(t) : (e && t.setStyle(e), t.z2 -= 1), t.__isHover = !1
            }
        }

        function q(t) {
            "group" === t.type ? t.traverse(function (t) {
                "group" !== t.type && z(t)
            }) : z(t)
        }

        function j(t) {
            "group" === t.type ? t.traverse(function (t) {
                "group" !== t.type && N(t)
            }) : N(t)
        }

        function H(t, e) {
            t.__hoverStl = t.hoverStyle || e || {}, t.__hoverStlDirty = !0, t.__isHover && W(t)
        }

        function Y(t) {
            this.__hoverSilentOnTouch && t.zrByTouch || !this.__isEmphasis && q(this)
        }

        function U(t) {
            this.__hoverSilentOnTouch && t.zrByTouch || !this.__isEmphasis && j(this)
        }

        function V() {
            this.__isEmphasis = !0, q(this)
        }

        function G() {
            this.__isEmphasis = !1, j(this)
        }

        function X(t, e, n, i, a) {
            return Q(t, e, i, a), n && r.extend(t, n), t.host && t.host.dirty && t.host.dirty(!1), t
        }

        function Q(t, e, n, i) {
            if ((n = n || A).isRectText) {
                var a = e.getShallow("position") || (i ? null : "inside");
                "outside" === a && (a = "top"), t.textPosition = a, t.textOffset = e.getShallow("offset");
                var o = e.getShallow("rotate");
                null != o && (o *= Math.PI / 180), t.textRotation = o, t.textDistance = r.retrieve2(e.getShallow("distance"), i ? null : 5)
            }
            var s, l = e.ecModel, h = l && l.option.textStyle, u = function (t) {
                var e;
                for (; t && t !== t.ecModel;) {
                    var n = (t.option || A).rich;
                    if (n) for (var r in e = e || {}, n) n.hasOwnProperty(r) && (e[r] = 1);
                    t = t.parentModel
                }
                return e
            }(e);
            if (u) for (var c in s = {}, u) if (u.hasOwnProperty(c)) {
                var f = e.getModel(["rich", c]);
                $(s[c] = {}, f, h, n, i)
            }
            return t.rich = s, $(t, e, h, n, i, !0), n.forceRich && !n.textStyle && (n.textStyle = {}), t
        }

        function $(t, e, n, i, a, o) {
            if (n = !a && n || A, t.textFill = Z(e.getShallow("color"), i) || n.color, t.textStroke = Z(e.getShallow("textBorderColor"), i) || n.textBorderColor, t.textStrokeWidth = r.retrieve2(e.getShallow("textBorderWidth"), n.textBorderWidth), !a) {
                if (o) {
                    var s = t.textPosition;
                    t.insideRollback = K(t, s, i), t.insideOriginalTextPosition = s, t.insideRollbackOpt = i
                }
                null == t.textFill && (t.textFill = i.autoColor)
            }
            t.fontStyle = e.getShallow("fontStyle") || n.fontStyle, t.fontWeight = e.getShallow("fontWeight") || n.fontWeight, t.fontSize = e.getShallow("fontSize") || n.fontSize, t.fontFamily = e.getShallow("fontFamily") || n.fontFamily, t.textAlign = e.getShallow("align"), t.textVerticalAlign = e.getShallow("verticalAlign") || e.getShallow("baseline"), t.textLineHeight = e.getShallow("lineHeight"), t.textWidth = e.getShallow("width"), t.textHeight = e.getShallow("height"), t.textTag = e.getShallow("tag"), o && i.disableBox || (t.textBackgroundColor = Z(e.getShallow("backgroundColor"), i), t.textPadding = e.getShallow("padding"), t.textBorderColor = Z(e.getShallow("borderColor"), i), t.textBorderWidth = e.getShallow("borderWidth"), t.textBorderRadius = e.getShallow("borderRadius"), t.textBoxShadowColor = e.getShallow("shadowColor"), t.textBoxShadowBlur = e.getShallow("shadowBlur"), t.textBoxShadowOffsetX = e.getShallow("shadowOffsetX"), t.textBoxShadowOffsetY = e.getShallow("shadowOffsetY")), t.textShadowColor = e.getShallow("textShadowColor") || n.textShadowColor, t.textShadowBlur = e.getShallow("textShadowBlur") || n.textShadowBlur, t.textShadowOffsetX = e.getShallow("textShadowOffsetX") || n.textShadowOffsetX, t.textShadowOffsetY = e.getShallow("textShadowOffsetY") || n.textShadowOffsetY
        }

        function Z(t, e) {
            return "auto" !== t ? t : e && e.autoColor ? e.autoColor : null
        }

        function K(t, e, n) {
            var r, i = n.useInsideStyle;
            return null == t.textFill && !1 !== i && (!0 === i || n.isRectText && e && "string" == typeof e && e.indexOf("inside") >= 0) && (r = {
                textFill: null,
                textStroke: t.textStroke,
                textStrokeWidth: t.textStrokeWidth
            }, t.textFill = "#fff", null == t.textStroke && (t.textStroke = n.autoColor, null == t.textStrokeWidth && (t.textStrokeWidth = 2))), r
        }

        function J(t, e, n, r, i, a) {
            if ("function" == typeof i && (a = i, i = null), r && r.isAnimationEnabled()) {
                var o = t ? "Update" : "", s = r.getShallow("animationDuration" + o),
                    l = r.getShallow("animationEasing" + o), h = r.getShallow("animationDelay" + o);
                "function" == typeof h && (h = h(i, r.getAnimationDelayParams ? r.getAnimationDelayParams(e, i) : null)), "function" == typeof s && (s = s(i)), s > 0 ? e.animateTo(n, s, h || 0, l, a, !!a) : (e.stopAnimation(), e.attr(n), a && a())
            } else e.stopAnimation(), e.attr(n), a && a()
        }

        function tt(t, e, n, r, i) {
            J(!0, t, e, n, r, i)
        }

        function et(t, e, n) {
            return e && !r.isArrayLike(e) && (e = h.getLocalTransform(e)), n && (e = o.invert([], e)), s.applyTransform([], t, e)
        }

        e.extendShape = function (t) {
            return l.extend(t)
        }, e.extendPath = function (t, e) {
            return i.extendFromString(t, e)
        }, e.makePath = I, e.makeImage = function (t, e, n) {
            var r = new u({
                style: {image: t, x: e.x, y: e.y, width: e.width, height: e.height}, onload: function (t) {
                    if ("center" === n) {
                        var i = {width: t.width, height: t.height};
                        r.setStyle(D(e, i))
                    }
                }
            });
            return r
        }, e.mergePath = R, e.resizePath = B, e.subPixelOptimizeLine = function (t) {
            var e = t.shape, n = t.style.lineWidth;
            return k(2 * e.x1) === k(2 * e.x2) && (e.x1 = e.x2 = L(e.x1, n, !0)), k(2 * e.y1) === k(2 * e.y2) && (e.y1 = e.y2 = L(e.y1, n, !0)), t
        }, e.subPixelOptimizeRect = function (t) {
            var e = t.shape, n = t.style.lineWidth, r = e.x, i = e.y, a = e.width, o = e.height;
            return e.x = L(e.x, n, !0), e.y = L(e.y, n, !0), e.width = Math.max(L(r + a, n, !1) - e.x, 0 === a ? 0 : 1), e.height = Math.max(L(i + o, n, !1) - e.y, 0 === o ? 0 : 1), t
        }, e.subPixelOptimize = L, e.setHoverStyle = function (t, e, n) {
            t.__hoverSilentOnTouch = n && n.hoverSilentOnTouch, "group" === t.type ? t.traverse(function (t) {
                "group" !== t.type && H(t, e)
            }) : H(t, e), t.on("mouseover", Y).on("mouseout", U), t.on("emphasis", V).on("normal", G)
        }, e.setLabelStyle = function (t, e, n, i, a, o, s) {
            var l, h = (a = a || A).labelFetcher, u = a.labelDataIndex, c = a.labelDimIndex, f = n.getShallow("show"),
                d = i.getShallow("show");
            (f || d) && (h && (l = h.getFormattedLabel(u, "normal", null, c)), null == l && (l = r.isFunction(a.defaultText) ? a.defaultText(u, a) : a.defaultText));
            var p = f ? l : null, v = d ? r.retrieve2(h ? h.getFormattedLabel(u, "emphasis", null, c) : null, l) : null;
            null == p && null == v || (X(t, n, o, a), X(e, i, s, a, !0)), t.text = p, e.text = v
        }, e.setTextStyle = X, e.setText = function (t, e, n) {
            var r, i = {isRectText: !0};
            !1 === n ? r = !0 : i.autoColor = n, Q(t, e, i, r), t.host && t.host.dirty && t.host.dirty(!1)
        }, e.getFont = function (t, e) {
            var n = e || e.getModel("textStyle");
            return r.trim([t.fontStyle || n && n.getShallow("fontStyle") || "", t.fontWeight || n && n.getShallow("fontWeight") || "", (t.fontSize || n && n.getShallow("fontSize") || 12) + "px", t.fontFamily || n && n.getShallow("fontFamily") || "sans-serif"].join(" "))
        }, e.updateProps = tt, e.initProps = function (t, e, n, r, i) {
            J(!1, t, e, n, r, i)
        }, e.getTransform = function (t, e) {
            for (var n = o.identity([]); t && t !== e;) o.mul(n, t.getLocalTransform(), n), t = t.parent;
            return n
        }, e.applyTransform = et, e.transformDirection = function (t, e, n) {
            var r = 0 === e[4] || 0 === e[5] || 0 === e[0] ? 1 : Math.abs(2 * e[4] / e[0]),
                i = 0 === e[4] || 0 === e[5] || 0 === e[2] ? 1 : Math.abs(2 * e[4] / e[2]),
                a = ["left" === t ? -r : "right" === t ? r : 0, "top" === t ? -i : "bottom" === t ? i : 0];
            return a = et(a, e, n), Math.abs(a[0]) > Math.abs(a[1]) ? a[0] > 0 ? "right" : "left" : a[1] > 0 ? "bottom" : "top"
        }, e.groupTransition = function (t, e, n, i) {
            if (t && e) {
                var a = function (t) {
                    var e = {};
                    return t.traverse(function (t) {
                        !t.isGroup && t.anid && (e[t.anid] = t)
                    }), e
                }(t);
                e.traverse(function (t) {
                    if (!t.isGroup && t.anid) {
                        var e = a[t.anid];
                        if (e) {
                            var r = o(t);
                            t.attr(o(e)), tt(t, r, n, t.dataIndex)
                        }
                    }
                })
            }

            function o(t) {
                var e = {position: s.clone(t.position), rotation: t.rotation};
                return t.shape && (e.shape = r.extend({}, t.shape)), e
            }
        }, e.clipPointsByRect = function (t, e) {
            return r.map(t, function (t) {
                var n = t[0];
                n = C(n, e.x), n = O(n, e.x + e.width);
                var r = t[1];
                return r = C(r, e.y), [n, r = O(r, e.y + e.height)]
            })
        }, e.clipRectByRect = function (t, e) {
            var n = C(t.x, e.x), r = O(t.x + t.width, e.x + e.width), i = C(t.y, e.y),
                a = O(t.y + t.height, e.y + e.height);
            if (r >= n && a >= i) return {x: n, y: i, width: r - n, height: a - i}
        }, e.createIcon = function (t, e, n) {
            var i = (e = r.extend({rectHover: !0}, e)).style = {strokeNoScale: !0};
            if (n = n || {
                x: -1,
                y: -1,
                width: 2,
                height: 2
            }, t) return 0 === t.indexOf("image://") ? (i.image = t.slice(8), r.defaults(i, n), new u(e)) : I(t.replace("path://", ""), e, n, "center")
        }
    }, function (t, e, n) {
        var r = n(1), i = n(8), a = n(56),
            o = ["m", "M", "l", "L", "v", "V", "h", "H", "z", "Z", "c", "C", "q", "Q", "t", "T", "s", "S", "a", "A"],
            s = Math.sqrt, l = Math.sin, h = Math.cos, u = Math.PI, c = function (t) {
                return Math.sqrt(t[0] * t[0] + t[1] * t[1])
            }, f = function (t, e) {
                return (t[0] * e[0] + t[1] * e[1]) / (c(t) * c(e))
            }, d = function (t, e) {
                return (t[0] * e[1] < t[1] * e[0] ? -1 : 1) * Math.acos(f(t, e))
            };

        function p(t, e, n, r, i, a, o, c, p, v, g) {
            var y = p * (u / 180), m = h(y) * (t - n) / 2 + l(y) * (e - r) / 2,
                x = -1 * l(y) * (t - n) / 2 + h(y) * (e - r) / 2, _ = m * m / (o * o) + x * x / (c * c);
            _ > 1 && (o *= s(_), c *= s(_));
            var w = (i === a ? -1 : 1) * s((o * o * (c * c) - o * o * (x * x) - c * c * (m * m)) / (o * o * (x * x) + c * c * (m * m))) || 0,
                b = w * o * x / c, S = w * -c * m / o, T = (t + n) / 2 + h(y) * b - l(y) * S,
                M = (e + r) / 2 + l(y) * b + h(y) * S, P = d([1, 0], [(m - b) / o, (x - S) / c]),
                k = [(m - b) / o, (x - S) / c], C = [(-1 * m - b) / o, (-1 * x - S) / c], O = d(k, C);
            f(k, C) <= -1 && (O = u), f(k, C) >= 1 && (O = 0), 0 === a && O > 0 && (O -= 2 * u), 1 === a && O < 0 && (O += 2 * u), g.addData(v, T, M, o, c, P, O, y, a)
        }

        function v(t, e) {
            var n = function (t) {
                if (!t) return [];
                var e, n = t.replace(/-/g, " -").replace(/  /g, " ").replace(/ /g, ",").replace(/,,/g, ",");
                for (e = 0; e < o.length; e++) n = n.replace(new RegExp(o[e], "g"), "|" + o[e]);
                var r, a = n.split("|"), s = 0, l = 0, h = new i, u = i.CMD;
                for (e = 1; e < a.length; e++) {
                    var c, f = a[e], d = f.charAt(0), v = 0, g = f.slice(1).replace(/e,-/g, "e-").split(",");
                    g.length > 0 && "" === g[0] && g.shift();
                    for (var y = 0; y < g.length; y++) g[y] = parseFloat(g[y]);
                    for (; v < g.length && !isNaN(g[v]) && !isNaN(g[0]);) {
                        var m, x, _, w, b, S, T, M = s, P = l;
                        switch (d) {
                            case"l":
                                s += g[v++], l += g[v++], c = u.L, h.addData(c, s, l);
                                break;
                            case"L":
                                s = g[v++], l = g[v++], c = u.L, h.addData(c, s, l);
                                break;
                            case"m":
                                s += g[v++], l += g[v++], c = u.M, h.addData(c, s, l), d = "l";
                                break;
                            case"M":
                                s = g[v++], l = g[v++], c = u.M, h.addData(c, s, l), d = "L";
                                break;
                            case"h":
                                s += g[v++], c = u.L, h.addData(c, s, l);
                                break;
                            case"H":
                                s = g[v++], c = u.L, h.addData(c, s, l);
                                break;
                            case"v":
                                l += g[v++], c = u.L, h.addData(c, s, l);
                                break;
                            case"V":
                                l = g[v++], c = u.L, h.addData(c, s, l);
                                break;
                            case"C":
                                c = u.C, h.addData(c, g[v++], g[v++], g[v++], g[v++], g[v++], g[v++]), s = g[v - 2], l = g[v - 1];
                                break;
                            case"c":
                                c = u.C, h.addData(c, g[v++] + s, g[v++] + l, g[v++] + s, g[v++] + l, g[v++] + s, g[v++] + l), s += g[v - 2], l += g[v - 1];
                                break;
                            case"S":
                                m = s, x = l;
                                var k = h.len(), C = h.data;
                                r === u.C && (m += s - C[k - 4], x += l - C[k - 3]), c = u.C, M = g[v++], P = g[v++], s = g[v++], l = g[v++], h.addData(c, m, x, M, P, s, l);
                                break;
                            case"s":
                                m = s, x = l, k = h.len(), C = h.data, r === u.C && (m += s - C[k - 4], x += l - C[k - 3]), c = u.C, M = s + g[v++], P = l + g[v++], s += g[v++], l += g[v++], h.addData(c, m, x, M, P, s, l);
                                break;
                            case"Q":
                                M = g[v++], P = g[v++], s = g[v++], l = g[v++], c = u.Q, h.addData(c, M, P, s, l);
                                break;
                            case"q":
                                M = g[v++] + s, P = g[v++] + l, s += g[v++], l += g[v++], c = u.Q, h.addData(c, M, P, s, l);
                                break;
                            case"T":
                                m = s, x = l, k = h.len(), C = h.data, r === u.Q && (m += s - C[k - 4], x += l - C[k - 3]), s = g[v++], l = g[v++], c = u.Q, h.addData(c, m, x, s, l);
                                break;
                            case"t":
                                m = s, x = l, k = h.len(), C = h.data, r === u.Q && (m += s - C[k - 4], x += l - C[k - 3]), s += g[v++], l += g[v++], c = u.Q, h.addData(c, m, x, s, l);
                                break;
                            case"A":
                                _ = g[v++], w = g[v++], b = g[v++], S = g[v++], T = g[v++], p(M = s, P = l, s = g[v++], l = g[v++], S, T, _, w, b, c = u.A, h);
                                break;
                            case"a":
                                _ = g[v++], w = g[v++], b = g[v++], S = g[v++], T = g[v++], p(M = s, P = l, s += g[v++], l += g[v++], S, T, _, w, b, c = u.A, h)
                        }
                    }
                    "z" !== d && "Z" !== d || (c = u.Z, h.addData(c)), r = c
                }
                return h.toStatic(), h
            }(t);
            return (e = e || {}).buildPath = function (t) {
                if (t.setData) {
                    t.setData(n.data), (e = t.getContext()) && t.rebuildPath(e)
                } else {
                    var e = t;
                    n.rebuildPath(e)
                }
            }, e.applyTransform = function (t) {
                a(n, t), this.dirty(!0)
            }, e
        }

        e.createFromString = function (t, e) {
            return new r(v(t, e))
        }, e.extendFromString = function (t, e) {
            return r.extend(v(t, e))
        }, e.mergePath = function (t, e) {
            for (var n = [], i = t.length, a = 0; a < i; a++) {
                var o = t[a];
                o.path || o.createPathProxy(), o.__dirtyPath && o.buildPath(o.path, o.shape, !0), n.push(o.path)
            }
            var s = new r(e);
            return s.createPathProxy(), s.buildPath = function (t) {
                t.appendPath(n);
                var e = t.getContext();
                e && t.rebuildPath(e)
            }, s
        }
    }, function (t, e, n) {
        var r = n(14),
            i = [["shadowBlur", 0], ["shadowOffsetX", 0], ["shadowOffsetY", 0], ["shadowColor", "#000"], ["lineCap", "butt"], ["lineJoin", "miter"], ["miterLimit", 10]],
            a = function (t, e) {
                this.extendFrom(t, !1), this.host = e
            };

        function o(t, e, n) {
            var r = null == e.x ? 0 : e.x, i = null == e.x2 ? 1 : e.x2, a = null == e.y ? 0 : e.y,
                o = null == e.y2 ? 0 : e.y2;
            return e.global || (r = r * n.width + n.x, i = i * n.width + n.x, a = a * n.height + n.y, o = o * n.height + n.y), r = isNaN(r) ? 0 : r, i = isNaN(i) ? 1 : i, a = isNaN(a) ? 0 : a, o = isNaN(o) ? 0 : o, t.createLinearGradient(r, a, i, o)
        }

        function s(t, e, n) {
            var r = n.width, i = n.height, a = Math.min(r, i), o = null == e.x ? .5 : e.x, s = null == e.y ? .5 : e.y,
                l = null == e.r ? .5 : e.r;
            return e.global || (o = o * r + n.x, s = s * i + n.y, l *= a), t.createRadialGradient(o, s, 0, o, s, l)
        }

        for (var l = a.prototype = {
            constructor: a,
            host: null,
            fill: "#000",
            stroke: null,
            opacity: 1,
            lineDash: null,
            lineDashOffset: 0,
            shadowBlur: 0,
            shadowOffsetX: 0,
            shadowOffsetY: 0,
            lineWidth: 1,
            strokeNoScale: !1,
            text: null,
            font: null,
            textFont: null,
            fontStyle: null,
            fontWeight: null,
            fontSize: null,
            fontFamily: null,
            textTag: null,
            textFill: "#000",
            textStroke: null,
            textWidth: null,
            textHeight: null,
            textStrokeWidth: 0,
            textLineHeight: null,
            textPosition: "inside",
            textRect: null,
            textOffset: null,
            textAlign: null,
            textVerticalAlign: null,
            textDistance: 5,
            textShadowColor: "transparent",
            textShadowBlur: 0,
            textShadowOffsetX: 0,
            textShadowOffsetY: 0,
            textBoxShadowColor: "transparent",
            textBoxShadowBlur: 0,
            textBoxShadowOffsetX: 0,
            textBoxShadowOffsetY: 0,
            transformText: !1,
            textRotation: 0,
            textOrigin: null,
            textBackgroundColor: null,
            textBorderColor: null,
            textBorderWidth: 0,
            textBorderRadius: 0,
            textPadding: null,
            rich: null,
            truncate: null,
            blend: null,
            bind: function (t, e, n) {
                for (var a = n && n.style, o = !a, s = 0; s < i.length; s++) {
                    var l = i[s], h = l[0];
                    (o || this[h] !== a[h]) && (t[h] = r(t, h, this[h] || l[1]))
                }
                if ((o || this.fill !== a.fill) && (t.fillStyle = this.fill), (o || this.stroke !== a.stroke) && (t.strokeStyle = this.stroke), (o || this.opacity !== a.opacity) && (t.globalAlpha = null == this.opacity ? 1 : this.opacity), (o || this.blend !== a.blend) && (t.globalCompositeOperation = this.blend || "source-over"), this.hasStroke()) {
                    var u = this.lineWidth;
                    t.lineWidth = u / (this.strokeNoScale && e && e.getLineScale ? e.getLineScale() : 1)
                }
            },
            hasFill: function () {
                var t = this.fill;
                return null != t && "none" !== t
            },
            hasStroke: function () {
                var t = this.stroke;
                return null != t && "none" !== t && this.lineWidth > 0
            },
            extendFrom: function (t, e) {
                if (t) for (var n in t) !t.hasOwnProperty(n) || !0 !== e && (!1 === e ? this.hasOwnProperty(n) : null == t[n]) || (this[n] = t[n])
            },
            set: function (t, e) {
                "string" == typeof t ? this[t] = e : this.extendFrom(t, !0)
            },
            clone: function () {
                var t = new this.constructor;
                return t.extendFrom(this, !0), t
            },
            getGradient: function (t, e, n) {
                for (var r = ("radial" === e.type ? s : o)(t, e, n), i = e.colorStops, a = 0; a < i.length; a++) r.addColorStop(i[a].offset, i[a].color);
                return r
            }
        }, h = 0; h < i.length; h++) {
            var u = i[h];
            u[0] in l || (l[u[0]] = u[1])
        }
        a.getGradient = l.getGradient;
        var c = a;
        t.exports = c
    }, function (t, e) {
        var n = 2311;
        t.exports = function () {
            return n++
        }
    }, function (t, e) {
        var n = Array.prototype.slice, r = function () {
            this._$handlers = {}
        };
        r.prototype = {
            constructor: r, one: function (t, e, n) {
                var r = this._$handlers;
                if (!e || !t) return this;
                r[t] || (r[t] = []);
                for (var i = 0; i < r[t].length; i++) if (r[t][i].h === e) return this;
                return r[t].push({h: e, one: !0, ctx: n || this}), this
            }, on: function (t, e, n) {
                var r = this._$handlers;
                if (!e || !t) return this;
                r[t] || (r[t] = []);
                for (var i = 0; i < r[t].length; i++) if (r[t][i].h === e) return this;
                return r[t].push({h: e, one: !1, ctx: n || this}), this
            }, isSilent: function (t) {
                var e = this._$handlers;
                return e[t] && e[t].length
            }, off: function (t, e) {
                var n = this._$handlers;
                if (!t) return this._$handlers = {}, this;
                if (e) {
                    if (n[t]) {
                        for (var r = [], i = 0, a = n[t].length; i < a; i++) n[t][i].h != e && r.push(n[t][i]);
                        n[t] = r
                    }
                    n[t] && 0 === n[t].length && delete n[t]
                } else delete n[t];
                return this
            }, trigger: function (t) {
                if (this._$handlers[t]) {
                    var e = arguments, r = e.length;
                    r > 3 && (e = n.call(e, 1));
                    for (var i = this._$handlers[t], a = i.length, o = 0; o < a;) {
                        switch (r) {
                            case 1:
                                i[o].h.call(i[o].ctx);
                                break;
                            case 2:
                                i[o].h.call(i[o].ctx, e[1]);
                                break;
                            case 3:
                                i[o].h.call(i[o].ctx, e[1], e[2]);
                                break;
                            default:
                                i[o].h.apply(i[o].ctx, e)
                        }
                        i[o].one ? (i.splice(o, 1), a--) : o++
                    }
                }
                return this
            }, triggerWithContext: function (t) {
                if (this._$handlers[t]) {
                    var e = arguments, r = e.length;
                    r > 4 && (e = n.call(e, 1, e.length - 1));
                    for (var i = e[e.length - 1], a = this._$handlers[t], o = a.length, s = 0; s < o;) {
                        switch (r) {
                            case 1:
                                a[s].h.call(i);
                                break;
                            case 2:
                                a[s].h.call(i, e[1]);
                                break;
                            case 3:
                                a[s].h.call(i, e[1], e[2]);
                                break;
                            default:
                                a[s].h.apply(i, e)
                        }
                        a[s].one ? (a.splice(s, 1), o--) : s++
                    }
                }
                return this
            }
        };
        var i = r;
        t.exports = i
    }, function (t, e, n) {
        var r = n(43), i = n(46), a = n(0), o = a.isString, s = a.isFunction, l = a.isObject, h = a.isArrayLike,
            u = a.indexOf, c = function () {
                this.animators = []
            };
        c.prototype = {
            constructor: c, animate: function (t, e) {
                var n, a = !1, o = this, s = this.__zr;
                if (t) {
                    var l = t.split("."), h = o;
                    a = "shape" === l[0];
                    for (var c = 0, f = l.length; c < f; c++) h && (h = h[l[c]]);
                    h && (n = h)
                } else n = o;
                if (n) {
                    var d = o.animators, p = new r(n, e);
                    return p.during(function (t) {
                        o.dirty(a)
                    }).done(function () {
                        d.splice(u(d, p), 1)
                    }), d.push(p), s && s.animation.addAnimator(p), p
                }
                i('Property "' + t + '" is not existed in element ' + o.id)
            }, stopAnimation: function (t) {
                for (var e = this.animators, n = e.length, r = 0; r < n; r++) e[r].stop(t);
                return e.length = 0, this
            }, animateTo: function (t, e, n, r, i, a) {
                o(n) ? (i = r, r = n, n = 0) : s(r) ? (i = r, r = "linear", n = 0) : s(n) ? (i = n, n = 0) : s(e) ? (i = e, e = 500) : e || (e = 500), this.stopAnimation(), this._animateToShallow("", this, t, e, n);
                var l = this.animators.slice(), h = l.length;

                function u() {
                    --h || i && i()
                }

                h || i && i();
                for (var c = 0; c < l.length; c++) l[c].done(u).start(r, a)
            }, _animateToShallow: function (t, e, n, r, i) {
                var a = {}, o = 0;
                for (var s in n) if (n.hasOwnProperty(s)) if (null != e[s]) l(n[s]) && !h(n[s]) ? this._animateToShallow(t ? t + "." + s : s, e[s], n[s], r, i) : (a[s] = n[s], o++); else if (null != n[s]) if (t) {
                    var u = {};
                    u[t] = {}, u[t][s] = n[s], this.attr(u)
                } else this.attr(s, n[s]);
                return o > 0 && this.animate(t, !1).when(null == r ? 500 : r, a).delay(i || 0), this
            }
        };
        var f = c;
        t.exports = f
    }, function (t, e, n) {
        var r = n(44), i = n(17), a = n(0).isArrayLike, o = Array.prototype.slice;

        function s(t, e) {
            return t[e]
        }

        function l(t, e, n) {
            t[e] = n
        }

        function h(t, e, n) {
            return (e - t) * n + t
        }

        function u(t, e, n) {
            return n > .5 ? e : t
        }

        function c(t, e, n, r, i) {
            var a = t.length;
            if (1 == i) for (var o = 0; o < a; o++) r[o] = h(t[o], e[o], n); else {
                var s = a && t[0].length;
                for (o = 0; o < a; o++) for (var l = 0; l < s; l++) r[o][l] = h(t[o][l], e[o][l], n)
            }
        }

        function f(t, e, n) {
            var r = t.length, i = e.length;
            if (r !== i) if (r > i) t.length = i; else for (var a = r; a < i; a++) t.push(1 === n ? e[a] : o.call(e[a]));
            var s = t[0] && t[0].length;
            for (a = 0; a < t.length; a++) if (1 === n) isNaN(t[a]) && (t[a] = e[a]); else for (var l = 0; l < s; l++) isNaN(t[a][l]) && (t[a][l] = e[a][l])
        }

        function d(t, e, n) {
            if (t === e) return !0;
            var r = t.length;
            if (r !== e.length) return !1;
            if (1 === n) {
                for (var i = 0; i < r; i++) if (t[i] !== e[i]) return !1
            } else {
                var a = t[0].length;
                for (i = 0; i < r; i++) for (var o = 0; o < a; o++) if (t[i][o] !== e[i][o]) return !1
            }
            return !0
        }

        function p(t, e, n, r, i, a, o, s, l) {
            var h = t.length;
            if (1 == l) for (var u = 0; u < h; u++) s[u] = v(t[u], e[u], n[u], r[u], i, a, o); else {
                var c = t[0].length;
                for (u = 0; u < h; u++) for (var f = 0; f < c; f++) s[u][f] = v(t[u][f], e[u][f], n[u][f], r[u][f], i, a, o)
            }
        }

        function v(t, e, n, r, i, a, o) {
            var s = .5 * (n - t), l = .5 * (r - e);
            return (2 * (e - n) + s + l) * o + (-3 * (e - n) - 2 * s - l) * a + s * i + e
        }

        function g(t) {
            if (a(t)) {
                var e = t.length;
                if (a(t[0])) {
                    for (var n = [], r = 0; r < e; r++) n.push(o.call(t[r]));
                    return n
                }
                return o.call(t)
            }
            return t
        }

        function y(t) {
            return t[0] = Math.floor(t[0]), t[1] = Math.floor(t[1]), t[2] = Math.floor(t[2]), "rgba(" + t.join(",") + ")"
        }

        function m(t, e, n, o, s, l) {
            var g = t._getter, m = t._setter, x = "spline" === e, _ = o.length;
            if (_) {
                var w, b = o[0].value, S = a(b), T = !1, M = !1, P = S ? function (t) {
                    var e = t[t.length - 1].value;
                    return a(e && e[0]) ? 2 : 1
                }(o) : 0;
                o.sort(function (t, e) {
                    return t.time - e.time
                }), w = o[_ - 1].time;
                for (var k = [], C = [], O = o[0].value, A = !0, I = 0; I < _; I++) {
                    k.push(o[I].time / w);
                    var D = o[I].value;
                    if (S && d(D, O, P) || !S && D === O || (A = !1), O = D, "string" == typeof D) {
                        var R = i.parse(D);
                        R ? (D = R, T = !0) : M = !0
                    }
                    C.push(D)
                }
                if (l || !A) {
                    var B = C[_ - 1];
                    for (I = 0; I < _ - 1; I++) S ? f(C[I], B, P) : !isNaN(C[I]) || isNaN(B) || M || T || (C[I] = B);
                    S && f(g(t._target, s), B, P);
                    var L, F, E, W, z, N = 0, q = 0;
                    if (T) var j = [0, 0, 0, 0];
                    var H = new r({
                        target: t._target,
                        life: w,
                        loop: t._loop,
                        delay: t._delay,
                        onframe: function (t, e) {
                            var n;
                            if (e < 0) n = 0; else if (e < q) {
                                for (n = Math.min(N + 1, _ - 1); n >= 0 && !(k[n] <= e); n--) ;
                                n = Math.min(n, _ - 2)
                            } else {
                                for (n = N; n < _ && !(k[n] > e); n++) ;
                                n = Math.min(n - 1, _ - 2)
                            }
                            N = n, q = e;
                            var r = k[n + 1] - k[n];
                            if (0 !== r) if (L = (e - k[n]) / r, x) if (E = C[n], F = C[0 === n ? n : n - 1], W = C[n > _ - 2 ? _ - 1 : n + 1], z = C[n > _ - 3 ? _ - 1 : n + 2], S) p(F, E, W, z, L, L * L, L * L * L, g(t, s), P); else {
                                if (T) i = p(F, E, W, z, L, L * L, L * L * L, j, 1), i = y(j); else {
                                    if (M) return u(E, W, L);
                                    i = v(F, E, W, z, L, L * L, L * L * L)
                                }
                                m(t, s, i)
                            } else if (S) c(C[n], C[n + 1], L, g(t, s), P); else {
                                var i;
                                if (T) c(C[n], C[n + 1], L, j, 1), i = y(j); else {
                                    if (M) return u(C[n], C[n + 1], L);
                                    i = h(C[n], C[n + 1], L)
                                }
                                m(t, s, i)
                            }
                        },
                        ondestroy: n
                    });
                    return e && "spline" !== e && (H.easing = e), H
                }
            }
        }

        var x = function (t, e, n, r) {
            this._tracks = {}, this._target = t, this._loop = e || !1, this._getter = n || s, this._setter = r || l, this._clipCount = 0, this._delay = 0, this._doneList = [], this._onframeList = [], this._clipList = []
        };
        x.prototype = {
            when: function (t, e) {
                var n = this._tracks;
                for (var r in e) if (e.hasOwnProperty(r)) {
                    if (!n[r]) {
                        n[r] = [];
                        var i = this._getter(this._target, r);
                        if (null == i) continue;
                        0 !== t && n[r].push({time: 0, value: g(i)})
                    }
                    n[r].push({time: t, value: e[r]})
                }
                return this
            }, during: function (t) {
                return this._onframeList.push(t), this
            }, pause: function () {
                for (var t = 0; t < this._clipList.length; t++) this._clipList[t].pause();
                this._paused = !0
            }, resume: function () {
                for (var t = 0; t < this._clipList.length; t++) this._clipList[t].resume();
                this._paused = !1
            }, isPaused: function () {
                return !!this._paused
            }, _doneCallback: function () {
                this._tracks = {}, this._clipList.length = 0;
                for (var t = this._doneList, e = t.length, n = 0; n < e; n++) t[n].call(this)
            }, start: function (t, e) {
                var n, r = this, i = 0, a = function () {
                    --i || r._doneCallback()
                };
                for (var o in this._tracks) if (this._tracks.hasOwnProperty(o)) {
                    var s = m(this, t, a, this._tracks[o], o, e);
                    s && (this._clipList.push(s), i++, this.animation && this.animation.addClip(s), n = s)
                }
                if (n) {
                    var l = n.onframe;
                    n.onframe = function (t, e) {
                        l(t, e);
                        for (var n = 0; n < r._onframeList.length; n++) r._onframeList[n](t, e)
                    }
                }
                return i || this._doneCallback(), this
            }, stop: function (t) {
                for (var e = this._clipList, n = this.animation, r = 0; r < e.length; r++) {
                    var i = e[r];
                    t && i.onframe(this._target, 1), n && n.removeClip(i)
                }
                e.length = 0
            }, delay: function (t) {
                return this._delay = t, this
            }, done: function (t) {
                return t && this._doneList.push(t), this
            }, getClips: function () {
                return this._clipList
            }
        };
        var _ = x;
        t.exports = _
    }, function (t, e, n) {
        var r = n(45);

        function i(t) {
            this._target = t.target, this._life = t.life || 1e3, this._delay = t.delay || 0, this._initialized = !1, this.loop = null != t.loop && t.loop, this.gap = t.gap || 0, this.easing = t.easing || "Linear", this.onframe = t.onframe, this.ondestroy = t.ondestroy, this.onrestart = t.onrestart, this._pausedTime = 0, this._paused = !1
        }

        i.prototype = {
            constructor: i, step: function (t, e) {
                if (this._initialized || (this._startTime = t + this._delay, this._initialized = !0), this._paused) this._pausedTime += e; else {
                    var n = (t - this._startTime - this._pausedTime) / this._life;
                    if (!(n < 0)) {
                        n = Math.min(n, 1);
                        var i = this.easing, a = "string" == typeof i ? r[i] : i, o = "function" == typeof a ? a(n) : n;
                        return this.fire("frame", o), 1 == n ? this.loop ? (this.restart(t), "restart") : (this._needsRemove = !0, "destroy") : null
                    }
                }
            }, restart: function (t) {
                var e = (t - this._startTime - this._pausedTime) % this._life;
                this._startTime = t - e + this.gap, this._pausedTime = 0, this._needsRemove = !1
            }, fire: function (t, e) {
                this[t = "on" + t] && this[t](this._target, e)
            }, pause: function () {
                this._paused = !0
            }, resume: function () {
                this._paused = !1
            }
        };
        var a = i;
        t.exports = a
    }, function (t, e) {
        var n = {
            linear: function (t) {
                return t
            }, quadraticIn: function (t) {
                return t * t
            }, quadraticOut: function (t) {
                return t * (2 - t)
            }, quadraticInOut: function (t) {
                return (t *= 2) < 1 ? .5 * t * t : -.5 * (--t * (t - 2) - 1)
            }, cubicIn: function (t) {
                return t * t * t
            }, cubicOut: function (t) {
                return --t * t * t + 1
            }, cubicInOut: function (t) {
                return (t *= 2) < 1 ? .5 * t * t * t : .5 * ((t -= 2) * t * t + 2)
            }, quarticIn: function (t) {
                return t * t * t * t
            }, quarticOut: function (t) {
                return 1 - --t * t * t * t
            }, quarticInOut: function (t) {
                return (t *= 2) < 1 ? .5 * t * t * t * t : -.5 * ((t -= 2) * t * t * t - 2)
            }, quinticIn: function (t) {
                return t * t * t * t * t
            }, quinticOut: function (t) {
                return --t * t * t * t * t + 1
            }, quinticInOut: function (t) {
                return (t *= 2) < 1 ? .5 * t * t * t * t * t : .5 * ((t -= 2) * t * t * t * t + 2)
            }, sinusoidalIn: function (t) {
                return 1 - Math.cos(t * Math.PI / 2)
            }, sinusoidalOut: function (t) {
                return Math.sin(t * Math.PI / 2)
            }, sinusoidalInOut: function (t) {
                return .5 * (1 - Math.cos(Math.PI * t))
            }, exponentialIn: function (t) {
                return 0 === t ? 0 : Math.pow(1024, t - 1)
            }, exponentialOut: function (t) {
                return 1 === t ? 1 : 1 - Math.pow(2, -10 * t)
            }, exponentialInOut: function (t) {
                return 0 === t ? 0 : 1 === t ? 1 : (t *= 2) < 1 ? .5 * Math.pow(1024, t - 1) : .5 * (2 - Math.pow(2, -10 * (t - 1)))
            }, circularIn: function (t) {
                return 1 - Math.sqrt(1 - t * t)
            }, circularOut: function (t) {
                return Math.sqrt(1 - --t * t)
            }, circularInOut: function (t) {
                return (t *= 2) < 1 ? -.5 * (Math.sqrt(1 - t * t) - 1) : .5 * (Math.sqrt(1 - (t -= 2) * t) + 1)
            }, elasticIn: function (t) {
                var e, n = .1;
                return 0 === t ? 0 : 1 === t ? 1 : (!n || n < 1 ? (n = 1, e = .1) : e = .4 * Math.asin(1 / n) / (2 * Math.PI), -n * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - e) * (2 * Math.PI) / .4))
            }, elasticOut: function (t) {
                var e, n = .1;
                return 0 === t ? 0 : 1 === t ? 1 : (!n || n < 1 ? (n = 1, e = .1) : e = .4 * Math.asin(1 / n) / (2 * Math.PI), n * Math.pow(2, -10 * t) * Math.sin((t - e) * (2 * Math.PI) / .4) + 1)
            }, elasticInOut: function (t) {
                var e, n = .1;
                return 0 === t ? 0 : 1 === t ? 1 : (!n || n < 1 ? (n = 1, e = .1) : e = .4 * Math.asin(1 / n) / (2 * Math.PI), (t *= 2) < 1 ? n * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - e) * (2 * Math.PI) / .4) * -.5 : n * Math.pow(2, -10 * (t -= 1)) * Math.sin((t - e) * (2 * Math.PI) / .4) * .5 + 1)
            }, backIn: function (t) {
                var e = 1.70158;
                return t * t * ((e + 1) * t - e)
            }, backOut: function (t) {
                var e = 1.70158;
                return --t * t * ((e + 1) * t + e) + 1
            }, backInOut: function (t) {
                var e = 2.5949095;
                return (t *= 2) < 1 ? t * t * ((e + 1) * t - e) * .5 : .5 * ((t -= 2) * t * ((e + 1) * t + e) + 2)
            }, bounceIn: function (t) {
                return 1 - n.bounceOut(1 - t)
            }, bounceOut: function (t) {
                return t < 1 / 2.75 ? 7.5625 * t * t : t < 2 / 2.75 ? 7.5625 * (t -= 1.5 / 2.75) * t + .75 : t < 2.5 / 2.75 ? 7.5625 * (t -= 2.25 / 2.75) * t + .9375 : 7.5625 * (t -= 2.625 / 2.75) * t + .984375
            }, bounceInOut: function (t) {
                return t < .5 ? .5 * n.bounceIn(2 * t) : .5 * n.bounceOut(2 * t - 1) + .5
            }
        }, r = n;
        t.exports = r
    }, function (t, e, n) {
        var r = n(19).debugMode, i = function () {
        };
        1 === r ? i = function () {
            for (var t in arguments) throw new Error(arguments[t])
        } : r > 1 && (i = function () {
            for (var t in arguments) console.log(arguments[t])
        });
        var a = i;
        t.exports = a
    }, function (t, e, n) {
        var r = n(20), i = new (n(3)), a = function () {
        };
        a.prototype = {
            constructor: a, drawRectText: function (t, e) {
                var n = this.style;
                e = n.textRect || e, this.__dirty && r.normalizeTextStyle(n, !0);
                var a = n.text;
                if (null != a && (a += ""), r.needDrawText(a, n)) {
                    t.save();
                    var o = this.transform;
                    n.transformText ? this.setTransform(t) : o && (i.copy(e), i.applyTransform(o), e = i), r.renderText(this, t, a, n, e), t.restore()
                }
            }
        };
        var o = a;
        t.exports = o
    }, function (t, e, n) {
        var r = n(2), i = n(4), a = Math.min, o = Math.max, s = Math.sin, l = Math.cos, h = 2 * Math.PI, u = r.create(),
            c = r.create(), f = r.create();
        var d = [], p = [];
        e.fromPoints = function (t, e, n) {
            if (0 !== t.length) {
                var r, i = t[0], s = i[0], l = i[0], h = i[1], u = i[1];
                for (r = 1; r < t.length; r++) i = t[r], s = a(s, i[0]), l = o(l, i[0]), h = a(h, i[1]), u = o(u, i[1]);
                e[0] = s, e[1] = h, n[0] = l, n[1] = u
            }
        }, e.fromLine = function (t, e, n, r, i, s) {
            i[0] = a(t, n), i[1] = a(e, r), s[0] = o(t, n), s[1] = o(e, r)
        }, e.fromCubic = function (t, e, n, r, s, l, h, u, c, f) {
            var v, g = i.cubicExtrema, y = i.cubicAt, m = g(t, n, s, h, d);
            for (c[0] = 1 / 0, c[1] = 1 / 0, f[0] = -1 / 0, f[1] = -1 / 0, v = 0; v < m; v++) {
                var x = y(t, n, s, h, d[v]);
                c[0] = a(x, c[0]), f[0] = o(x, f[0])
            }
            for (m = g(e, r, l, u, p), v = 0; v < m; v++) {
                var _ = y(e, r, l, u, p[v]);
                c[1] = a(_, c[1]), f[1] = o(_, f[1])
            }
            c[0] = a(t, c[0]), f[0] = o(t, f[0]), c[0] = a(h, c[0]), f[0] = o(h, f[0]), c[1] = a(e, c[1]), f[1] = o(e, f[1]), c[1] = a(u, c[1]), f[1] = o(u, f[1])
        }, e.fromQuadratic = function (t, e, n, r, s, l, h, u) {
            var c = i.quadraticExtremum, f = i.quadraticAt, d = o(a(c(t, n, s), 1), 0), p = o(a(c(e, r, l), 1), 0),
                v = f(t, n, s, d), g = f(e, r, l, p);
            h[0] = a(t, s, v), h[1] = a(e, l, g), u[0] = o(t, s, v), u[1] = o(e, l, g)
        }, e.fromArc = function (t, e, n, i, a, o, d, p, v) {
            var g = r.min, y = r.max, m = Math.abs(a - o);
            if (m % h < 1e-4 && m > 1e-4) return p[0] = t - n, p[1] = e - i, v[0] = t + n, void(v[1] = e + i);
            if (u[0] = l(a) * n + t, u[1] = s(a) * i + e, c[0] = l(o) * n + t, c[1] = s(o) * i + e, g(p, u, c), y(v, u, c), (a %= h) < 0 && (a += h), (o %= h) < 0 && (o += h), a > o && !d ? o += h : a < o && d && (a += h), d) {
                var x = o;
                o = a, a = x
            }
            for (var _ = 0; _ < o; _ += Math.PI / 2) _ > a && (f[0] = l(_) * n + t, f[1] = s(_) * i + e, g(p, f, p), y(v, f, v))
        }
    }, function (t, e, n) {
        var r = n(8), i = n(50), a = n(51), o = n(52), s = n(53), l = n(23).normalizeRadian, h = n(4), u = n(54),
            c = r.CMD, f = 2 * Math.PI, d = 1e-4;
        var p = [-1, -1, -1], v = [-1, -1];

        function g() {
            var t = v[0];
            v[0] = v[1], v[1] = t
        }

        function y(t, e, n, r, i, a, o, s, l, u) {
            if (u > e && u > r && u > a && u > s || u < e && u < r && u < a && u < s) return 0;
            var c = h.cubicRootAt(e, r, a, s, u, p);
            if (0 === c) return 0;
            for (var f, d, y = 0, m = -1, x = 0; x < c; x++) {
                var _ = p[x], w = 0 === _ || 1 === _ ? .5 : 1;
                h.cubicAt(t, n, i, o, _) < l || (m < 0 && (m = h.cubicExtrema(e, r, a, s, v), v[1] < v[0] && m > 1 && g(), f = h.cubicAt(e, r, a, s, v[0]), m > 1 && (d = h.cubicAt(e, r, a, s, v[1]))), 2 == m ? _ < v[0] ? y += f < e ? w : -w : _ < v[1] ? y += d < f ? w : -w : y += s < d ? w : -w : _ < v[0] ? y += f < e ? w : -w : y += s < f ? w : -w)
            }
            return y
        }

        function m(t, e, n, r, i, a, o, s) {
            if (s > e && s > r && s > a || s < e && s < r && s < a) return 0;
            var l = h.quadraticRootAt(e, r, a, s, p);
            if (0 === l) return 0;
            var u = h.quadraticExtremum(e, r, a);
            if (u >= 0 && u <= 1) {
                for (var c = 0, f = h.quadraticAt(e, r, a, u), d = 0; d < l; d++) {
                    var v = 0 === p[d] || 1 === p[d] ? .5 : 1;
                    h.quadraticAt(t, n, i, p[d]) < o || (p[d] < u ? c += f < e ? v : -v : c += a < f ? v : -v)
                }
                return c
            }
            v = 0 === p[0] || 1 === p[0] ? .5 : 1;
            return h.quadraticAt(t, n, i, p[0]) < o ? 0 : a < e ? v : -v
        }

        function x(t, e, n, r, i, a, o, s) {
            if ((s -= e) > n || s < -n) return 0;
            var h = Math.sqrt(n * n - s * s);
            p[0] = -h, p[1] = h;
            var u = Math.abs(r - i);
            if (u < 1e-4) return 0;
            if (u % f < 1e-4) {
                r = 0, i = f;
                var c = a ? 1 : -1;
                return o >= p[0] + t && o <= p[1] + t ? c : 0
            }
            if (a) {
                h = r;
                r = l(i), i = l(h)
            } else r = l(r), i = l(i);
            r > i && (i += f);
            for (var d = 0, v = 0; v < 2; v++) {
                var g = p[v];
                if (g + t > o) {
                    var y = Math.atan2(s, g);
                    c = a ? 1 : -1;
                    y < 0 && (y = f + y), (y >= r && y <= i || y + f >= r && y + f <= i) && (y > Math.PI / 2 && y < 1.5 * Math.PI && (c = -c), d += c)
                }
            }
            return d
        }

        function _(t, e, n, r, l) {
            for (var h = 0, f = 0, p = 0, v = 0, g = 0, _ = 0; _ < t.length;) {
                var w = t[_++];
                switch (w === c.M && _ > 1 && (n || (h += u(f, p, v, g, r, l))), 1 == _ && (v = f = t[_], g = p = t[_ + 1]), w) {
                    case c.M:
                        f = v = t[_++], p = g = t[_++];
                        break;
                    case c.L:
                        if (n) {
                            if (i.containStroke(f, p, t[_], t[_ + 1], e, r, l)) return !0
                        } else h += u(f, p, t[_], t[_ + 1], r, l) || 0;
                        f = t[_++], p = t[_++];
                        break;
                    case c.C:
                        if (n) {
                            if (a.containStroke(f, p, t[_++], t[_++], t[_++], t[_++], t[_], t[_ + 1], e, r, l)) return !0
                        } else h += y(f, p, t[_++], t[_++], t[_++], t[_++], t[_], t[_ + 1], r, l) || 0;
                        f = t[_++], p = t[_++];
                        break;
                    case c.Q:
                        if (n) {
                            if (o.containStroke(f, p, t[_++], t[_++], t[_], t[_ + 1], e, r, l)) return !0
                        } else h += m(f, p, t[_++], t[_++], t[_], t[_ + 1], r, l) || 0;
                        f = t[_++], p = t[_++];
                        break;
                    case c.A:
                        var b = t[_++], S = t[_++], T = t[_++], M = t[_++], P = t[_++], k = t[_++],
                            C = (t[_++], 1 - t[_++]), O = Math.cos(P) * T + b, A = Math.sin(P) * M + S;
                        _ > 1 ? h += u(f, p, O, A, r, l) : (v = O, g = A);
                        var I = (r - b) * M / T + b;
                        if (n) {
                            if (s.containStroke(b, S, M, P, P + k, C, e, I, l)) return !0
                        } else h += x(b, S, M, P, P + k, C, I, l);
                        f = Math.cos(P + k) * T + b, p = Math.sin(P + k) * M + S;
                        break;
                    case c.R:
                        v = f = t[_++], g = p = t[_++];
                        O = v + t[_++], A = g + t[_++];
                        if (n) {
                            if (i.containStroke(v, g, O, g, e, r, l) || i.containStroke(O, g, O, A, e, r, l) || i.containStroke(O, A, v, A, e, r, l) || i.containStroke(v, A, v, g, e, r, l)) return !0
                        } else h += u(O, g, O, A, r, l), h += u(v, A, v, g, r, l);
                        break;
                    case c.Z:
                        if (n) {
                            if (i.containStroke(f, p, v, g, e, r, l)) return !0
                        } else h += u(f, p, v, g, r, l);
                        f = v, p = g
                }
            }
            return n || function (t, e) {
                return Math.abs(t - e) < d
            }(p, g) || (h += u(f, p, v, g, r, l) || 0), 0 !== h
        }

        e.contain = function (t, e, n) {
            return _(t, 0, !1, e, n)
        }, e.containStroke = function (t, e, n, r) {
            return _(t, e, !0, n, r)
        }
    }, function (t, e) {
        e.containStroke = function (t, e, n, r, i, a, o) {
            if (0 === i) return !1;
            var s = i, l = 0;
            if (o > e + s && o > r + s || o < e - s && o < r - s || a > t + s && a > n + s || a < t - s && a < n - s) return !1;
            if (t === n) return Math.abs(a - t) <= s / 2;
            var h = (l = (e - r) / (t - n)) * a - o + (t * r - n * e) / (t - n);
            return h * h / (l * l + 1) <= s / 2 * s / 2
        }
    }, function (t, e, n) {
        var r = n(4);
        e.containStroke = function (t, e, n, i, a, o, s, l, h, u, c) {
            if (0 === h) return !1;
            var f = h;
            return !(c > e + f && c > i + f && c > o + f && c > l + f || c < e - f && c < i - f && c < o - f && c < l - f || u > t + f && u > n + f && u > a + f && u > s + f || u < t - f && u < n - f && u < a - f && u < s - f) && r.cubicProjectPoint(t, e, n, i, a, o, s, l, u, c, null) <= f / 2
        }
    }, function (t, e, n) {
        var r = n(4).quadraticProjectPoint;
        e.containStroke = function (t, e, n, i, a, o, s, l, h) {
            if (0 === s) return !1;
            var u = s;
            return !(h > e + u && h > i + u && h > o + u || h < e - u && h < i - u && h < o - u || l > t + u && l > n + u && l > a + u || l < t - u && l < n - u && l < a - u) && r(t, e, n, i, a, o, l, h, null) <= u / 2
        }
    }, function (t, e, n) {
        var r = n(23).normalizeRadian, i = 2 * Math.PI;
        e.containStroke = function (t, e, n, a, o, s, l, h, u) {
            if (0 === l) return !1;
            var c = l;
            h -= t, u -= e;
            var f = Math.sqrt(h * h + u * u);
            if (f - c > n || f + c < n) return !1;
            if (Math.abs(a - o) % i < 1e-4) return !0;
            if (s) {
                var d = a;
                a = r(o), o = r(d)
            } else a = r(a), o = r(o);
            a > o && (o += i);
            var p = Math.atan2(u, h);
            return p < 0 && (p += i), p >= a && p <= o || p + i >= a && p + i <= o
        }
    }, function (t, e) {
        t.exports = function (t, e, n, r, i, a) {
            if (a > e && a > r || a < e && a < r) return 0;
            if (r === e) return 0;
            var o = r < e ? 1 : -1, s = (a - e) / (r - e);
            1 !== s && 0 !== s || (o = r < e ? .5 : -.5);
            var l = s * (n - t) + t;
            return l === i ? 1 / 0 : l > i ? o : 0
        }
    }, function (t, e) {
        var n = function (t, e) {
            this.image = t, this.repeat = e, this.type = "pattern"
        };
        n.prototype.getCanvasPattern = function (t) {
            return t.createPattern(this.image, this.repeat || "repeat")
        };
        var r = n;
        t.exports = r
    }, function (t, e, n) {
        var r = n(8), i = n(2).applyTransform, a = r.CMD, o = [[], [], []], s = Math.sqrt, l = Math.atan2;
        t.exports = function (t, e) {
            var n, r, h, u, c, f = t.data, d = a.M, p = a.C, v = a.L, g = a.R, y = a.A, m = a.Q;
            for (h = 0, u = 0; h < f.length;) {
                switch (n = f[h++], u = h, r = 0, n) {
                    case d:
                    case v:
                        r = 1;
                        break;
                    case p:
                        r = 3;
                        break;
                    case m:
                        r = 2;
                        break;
                    case y:
                        var x = e[4], _ = e[5], w = s(e[0] * e[0] + e[1] * e[1]), b = s(e[2] * e[2] + e[3] * e[3]),
                            S = l(-e[1] / b, e[0] / w);
                        f[h] *= w, f[h++] += x, f[h] *= b, f[h++] += _, f[h++] *= w, f[h++] *= b, f[h++] += S, f[h++] += S, u = h += 2;
                        break;
                    case g:
                        T[0] = f[h++], T[1] = f[h++], i(T, T, e), f[u++] = T[0], f[u++] = T[1], T[0] += f[h++], T[1] += f[h++], i(T, T, e), f[u++] = T[0], f[u++] = T[1]
                }
                for (c = 0; c < r; c++) {
                    var T;
                    (T = o[c])[0] = f[h++], T[1] = f[h++], i(T, T, e), f[u++] = T[0], f[u++] = T[1]
                }
            }
        }
    }, function (t, e, n) {
        var r = n(7), i = n(3), a = n(0), o = n(10);

        function s(t) {
            r.call(this, t)
        }

        s.prototype = {
            constructor: s, type: "image", brush: function (t, e) {
                var n = this.style, r = n.image;
                n.bind(t, this, e);
                var i = this._image = o.createOrUpdateImage(r, this._image, this, this.onload);
                if (i && o.isImageReady(i)) {
                    var a = n.x || 0, s = n.y || 0, l = n.width, h = n.height, u = i.width / i.height;
                    if (null == l && null != h ? l = h * u : null == h && null != l ? h = l / u : null == l && null == h && (l = i.width, h = i.height), this.setTransform(t), n.sWidth && n.sHeight) {
                        var c = n.sx || 0, f = n.sy || 0;
                        t.drawImage(i, c, f, n.sWidth, n.sHeight, a, s, l, h)
                    } else if (n.sx && n.sy) {
                        var d = l - (c = n.sx), p = h - (f = n.sy);
                        t.drawImage(i, c, f, d, p, a, s, l, h)
                    } else t.drawImage(i, a, s, l, h);
                    null != n.text && (this.restoreTransform(t), this.drawRectText(t, this.getBoundingRect()))
                }
            }, getBoundingRect: function () {
                var t = this.style;
                return this._rect || (this._rect = new i(t.x || 0, t.y || 0, t.width || 0, t.height || 0)), this._rect
            }
        }, a.inherits(s, r);
        var l = s;
        t.exports = l
    }, function (t, e, n) {
        var r = n(0), i = n(15), a = n(3), o = function (t) {
            for (var e in t = t || {}, i.call(this, t), t) t.hasOwnProperty(e) && (this[e] = t[e]);
            this._children = [], this.__storage = null, this.__dirty = !0
        };
        o.prototype = {
            constructor: o, isGroup: !0, type: "group", silent: !1, children: function () {
                return this._children.slice()
            }, childAt: function (t) {
                return this._children[t]
            }, childOfName: function (t) {
                for (var e = this._children, n = 0; n < e.length; n++) if (e[n].name === t) return e[n]
            }, childCount: function () {
                return this._children.length
            }, add: function (t) {
                return t && t !== this && t.parent !== this && (this._children.push(t), this._doAdd(t)), this
            }, addBefore: function (t, e) {
                if (t && t !== this && t.parent !== this && e && e.parent === this) {
                    var n = this._children, r = n.indexOf(e);
                    r >= 0 && (n.splice(r, 0, t), this._doAdd(t))
                }
                return this
            }, _doAdd: function (t) {
                t.parent && t.parent.remove(t), t.parent = this;
                var e = this.__storage, n = this.__zr;
                e && e !== t.__storage && (e.addToStorage(t), t instanceof o && t.addChildrenToStorage(e)), n && n.refresh()
            }, remove: function (t) {
                var e = this.__zr, n = this.__storage, i = this._children, a = r.indexOf(i, t);
                return a < 0 ? this : (i.splice(a, 1), t.parent = null, n && (n.delFromStorage(t), t instanceof o && t.delChildrenFromStorage(n)), e && e.refresh(), this)
            }, removeAll: function () {
                var t, e, n = this._children, r = this.__storage;
                for (e = 0; e < n.length; e++) t = n[e], r && (r.delFromStorage(t), t instanceof o && t.delChildrenFromStorage(r)), t.parent = null;
                return n.length = 0, this
            }, eachChild: function (t, e) {
                for (var n = this._children, r = 0; r < n.length; r++) {
                    var i = n[r];
                    t.call(e, i, r)
                }
                return this
            }, traverse: function (t, e) {
                for (var n = 0; n < this._children.length; n++) {
                    var r = this._children[n];
                    t.call(e, r), "group" === r.type && r.traverse(t, e)
                }
                return this
            }, addChildrenToStorage: function (t) {
                for (var e = 0; e < this._children.length; e++) {
                    var n = this._children[e];
                    t.addToStorage(n), n instanceof o && n.addChildrenToStorage(t)
                }
            }, delChildrenFromStorage: function (t) {
                for (var e = 0; e < this._children.length; e++) {
                    var n = this._children[e];
                    t.delFromStorage(n), n instanceof o && n.delChildrenFromStorage(t)
                }
            }, dirty: function () {
                return this.__dirty = !0, this.__zr && this.__zr.refresh(), this
            }, getBoundingRect: function (t) {
                for (var e = null, n = new a(0, 0, 0, 0), r = t || this._children, i = [], o = 0; o < r.length; o++) {
                    var s = r[o];
                    if (!s.ignore && !s.invisible) {
                        var l = s.getBoundingRect(), h = s.getLocalTransform(i);
                        h ? (n.copy(l), n.applyTransform(h), (e = e || n.clone()).union(n)) : (e = e || l.clone()).union(l)
                    }
                }
                return e || n
            }
        }, r.inherits(o, i);
        var s = o;
        t.exports = s
    }, function (t, e, n) {
        var r = n(7), i = n(0), a = n(21), o = n(20), s = function (t) {
            r.call(this, t)
        };
        s.prototype = {
            constructor: s, type: "text", brush: function (t, e) {
                var n = this.style;
                this.__dirty && o.normalizeTextStyle(n, !0), n.fill = n.stroke = n.shadowBlur = n.shadowColor = n.shadowOffsetX = n.shadowOffsetY = null;
                var r = n.text;
                null != r && (r += ""), n.bind(t, this, e), o.needDrawText(r, n) && (this.setTransform(t), o.renderText(this, t, r, n), this.restoreTransform(t))
            }, getBoundingRect: function () {
                var t = this.style;
                if (this.__dirty && o.normalizeTextStyle(t, !0), !this._rect) {
                    var e = t.text;
                    null != e ? e += "" : e = "";
                    var n = a.getBoundingRect(t.text + "", t.font, t.textAlign, t.textVerticalAlign, t.textPadding, t.rich);
                    if (n.x += t.x || 0, n.y += t.y || 0, o.getStroke(t.textStroke, t.textStrokeWidth)) {
                        var r = t.textStrokeWidth;
                        n.x -= r / 2, n.y -= r / 2, n.width += r, n.height += r
                    }
                    this._rect = n
                }
                return this._rect
            }
        }, i.inherits(s, r);
        var l = s;
        t.exports = l
    }, function (t, e, n) {
        var r = n(1).extend({
            type: "circle", shape: {cx: 0, cy: 0, r: 0}, buildPath: function (t, e, n) {
                n && t.moveTo(e.cx + e.r, e.cy), t.arc(e.cx, e.cy, e.r, 0, 2 * Math.PI, !0)
            }
        });
        t.exports = r
    }, function (t, e, n) {
        var r = n(1), i = n(62), a = r.extend({
            type: "sector",
            shape: {cx: 0, cy: 0, r0: 0, r: 0, startAngle: 0, endAngle: 2 * Math.PI, clockwise: !0},
            brush: i(r.prototype.brush),
            buildPath: function (t, e) {
                var n = e.cx, r = e.cy, i = Math.max(e.r0 || 0, 0), a = Math.max(e.r, 0), o = e.startAngle,
                    s = e.endAngle, l = e.clockwise, h = Math.cos(o), u = Math.sin(o);
                t.moveTo(h * i + n, u * i + r), t.lineTo(h * a + n, u * a + r), t.arc(n, r, a, o, s, !l), t.lineTo(Math.cos(s) * i + n, Math.sin(s) * i + r), 0 !== i && t.arc(n, r, i, s, o, l), t.closePath()
            }
        });
        t.exports = a
    }, function (t, e, n) {
        var r = n(63), i = [["shadowBlur", 0], ["shadowColor", "#000"], ["shadowOffsetX", 0], ["shadowOffsetY", 0]];
        t.exports = function (t) {
            return r.browser.ie && r.browser.version >= 11 ? function () {
                var e, n = this.__clipPaths, r = this.style;
                if (n) for (var a = 0; a < n.length; a++) {
                    var o = n[a], s = o && o.shape, l = o && o.type;
                    if (s && ("sector" === l && s.startAngle === s.endAngle || "rect" === l && (!s.width || !s.height))) {
                        for (var h = 0; h < i.length; h++) i[h][2] = r[i[h][0]], r[i[h][0]] = i[h][1];
                        e = !0;
                        break
                    }
                }
                if (t.apply(this, arguments), e) for (h = 0; h < i.length; h++) r[i[h][0]] = i[h][2]
            } : t
        }
    }, function (t, e) {
        var n = "object" == typeof wx && "function" == typeof wx.getSystemInfoSync ? {
            browser: {},
            os: {},
            node: !1,
            wxa: !0,
            canvasSupported: !0,
            svgSupported: !1,
            touchEventsSupported: !0
        } : "undefined" == typeof document && "undefined" != typeof self ? {
            browser: {},
            os: {},
            node: !1,
            worker: !0,
            canvasSupported: !0
        } : "undefined" == typeof navigator ? {
            browser: {},
            os: {},
            node: !0,
            worker: !1,
            canvasSupported: !0,
            svgSupported: !0
        } : function (t) {
            var e = {}, n = t.match(/Firefox\/([\d.]+)/),
                r = t.match(/MSIE\s([\d.]+)/) || t.match(/Trident\/.+?rv:(([\d.]+))/), i = t.match(/Edge\/([\d.]+)/),
                a = /micromessenger/i.test(t);
            n && (e.firefox = !0, e.version = n[1]);
            r && (e.ie = !0, e.version = r[1]);
            i && (e.edge = !0, e.version = i[1]);
            a && (e.weChat = !0);
            return {
                browser: e,
                os: {},
                node: !1,
                canvasSupported: !!document.createElement("canvas").getContext,
                svgSupported: "undefined" != typeof SVGRect,
                touchEventsSupported: "ontouchstart" in window && !e.ie && !e.edge,
                pointerEventsSupported: "onpointerdown" in window && (e.edge || e.ie && e.version >= 11)
            }
        }(navigator.userAgent);
        t.exports = n
    }, function (t, e, n) {
        var r = n(1).extend({
            type: "ring", shape: {cx: 0, cy: 0, r: 0, r0: 0}, buildPath: function (t, e) {
                var n = e.cx, r = e.cy, i = 2 * Math.PI;
                t.moveTo(n + e.r, r), t.arc(n, r, e.r, 0, i, !1), t.moveTo(n + e.r0, r), t.arc(n, r, e.r0, 0, i, !0)
            }
        });
        t.exports = r
    }, function (t, e, n) {
        var r = n(1), i = n(24), a = r.extend({
            type: "polygon",
            shape: {points: null, smooth: !1, smoothConstraint: null},
            buildPath: function (t, e) {
                i.buildPath(t, e, !0)
            }
        });
        t.exports = a
    }, function (t, e, n) {
        var r = n(2).distance;

        function i(t, e, n, r, i, a, o) {
            var s = .5 * (n - t), l = .5 * (r - e);
            return (2 * (e - n) + s + l) * o + (-3 * (e - n) - 2 * s - l) * a + s * i + e
        }

        t.exports = function (t, e) {
            for (var n = t.length, a = [], o = 0, s = 1; s < n; s++) o += r(t[s - 1], t[s]);
            var l = o / 2;
            for (l = l < n ? n : l, s = 0; s < l; s++) {
                var h, u, c, f = s / (l - 1) * (e ? n : n - 1), d = Math.floor(f), p = f - d, v = t[d % n];
                e ? (h = t[(d - 1 + n) % n], u = t[(d + 1) % n], c = t[(d + 2) % n]) : (h = t[0 === d ? d : d - 1], u = t[d > n - 2 ? n - 1 : d + 1], c = t[d > n - 3 ? n - 1 : d + 2]);
                var g = p * p, y = p * g;
                a.push([i(h[0], v[0], u[0], c[0], p, g, y), i(h[1], v[1], u[1], c[1], p, g, y)])
            }
            return a
        }
    }, function (t, e, n) {
        var r = n(2), i = r.min, a = r.max, o = r.scale, s = r.distance, l = r.add, h = r.clone, u = r.sub;
        t.exports = function (t, e, n, r) {
            var c, f, d, p, v = [], g = [], y = [], m = [];
            if (r) {
                d = [1 / 0, 1 / 0], p = [-1 / 0, -1 / 0];
                for (var x = 0, _ = t.length; x < _; x++) i(d, d, t[x]), a(p, p, t[x]);
                i(d, d, r[0]), a(p, p, r[1])
            }
            for (x = 0, _ = t.length; x < _; x++) {
                var w = t[x];
                if (n) c = t[x ? x - 1 : _ - 1], f = t[(x + 1) % _]; else {
                    if (0 === x || x === _ - 1) {
                        v.push(h(t[x]));
                        continue
                    }
                    c = t[x - 1], f = t[x + 1]
                }
                u(g, f, c), o(g, g, e);
                var b = s(w, c), S = s(w, f), T = b + S;
                0 !== T && (b /= T, S /= T), o(y, g, -b), o(m, g, S);
                var M = l([], w, y), P = l([], w, m);
                r && (a(M, M, d), i(M, M, p), a(P, P, d), i(P, P, p)), v.push(M), v.push(P)
            }
            return n && v.push(v.shift()), v
        }
    }, function (t, e, n) {
        var r = n(1), i = n(24), a = r.extend({
            type: "polyline",
            shape: {points: null, smooth: !1, smoothConstraint: null},
            style: {stroke: "#000", fill: null},
            buildPath: function (t, e) {
                i.buildPath(t, e, !1)
            }
        });
        t.exports = a
    }, function (t, e, n) {
        var r = n(1), i = n(22), a = r.extend({
            type: "rect", shape: {r: 0, x: 0, y: 0, width: 0, height: 0}, buildPath: function (t, e) {
                var n = e.x, r = e.y, a = e.width, o = e.height;
                e.r ? i.buildPath(t, e) : t.rect(n, r, a, o), t.closePath()
            }
        });
        t.exports = a
    }, function (t, e, n) {
        var r = n(1).extend({
            type: "line",
            shape: {x1: 0, y1: 0, x2: 0, y2: 0, percent: 1},
            style: {stroke: "#000", fill: null},
            buildPath: function (t, e) {
                var n = e.x1, r = e.y1, i = e.x2, a = e.y2, o = e.percent;
                0 !== o && (t.moveTo(n, r), o < 1 && (i = n * (1 - o) + i * o, a = r * (1 - o) + a * o), t.lineTo(i, a))
            },
            pointAt: function (t) {
                var e = this.shape;
                return [e.x1 * (1 - t) + e.x2 * t, e.y1 * (1 - t) + e.y2 * t]
            }
        });
        t.exports = r
    }, function (t, e, n) {
        var r = n(1), i = n(2), a = n(4), o = a.quadraticSubdivide, s = a.cubicSubdivide, l = a.quadraticAt,
            h = a.cubicAt, u = a.quadraticDerivativeAt, c = a.cubicDerivativeAt, f = [];

        function d(t, e, n) {
            var r = t.cpx2, i = t.cpy2;
            return null === r || null === i ? [(n ? c : h)(t.x1, t.cpx1, t.cpx2, t.x2, e), (n ? c : h)(t.y1, t.cpy1, t.cpy2, t.y2, e)] : [(n ? u : l)(t.x1, t.cpx1, t.x2, e), (n ? u : l)(t.y1, t.cpy1, t.y2, e)]
        }

        var p = r.extend({
            type: "bezier-curve",
            shape: {x1: 0, y1: 0, x2: 0, y2: 0, cpx1: 0, cpy1: 0, percent: 1},
            style: {stroke: "#000", fill: null},
            buildPath: function (t, e) {
                var n = e.x1, r = e.y1, i = e.x2, a = e.y2, l = e.cpx1, h = e.cpy1, u = e.cpx2, c = e.cpy2,
                    d = e.percent;
                0 !== d && (t.moveTo(n, r), null == u || null == c ? (d < 1 && (o(n, l, i, d, f), l = f[1], i = f[2], o(r, h, a, d, f), h = f[1], a = f[2]), t.quadraticCurveTo(l, h, i, a)) : (d < 1 && (s(n, l, u, i, d, f), l = f[1], u = f[2], i = f[3], s(r, h, c, a, d, f), h = f[1], c = f[2], a = f[3]), t.bezierCurveTo(l, h, u, c, i, a)))
            },
            pointAt: function (t) {
                return d(this.shape, t, !1)
            },
            tangentAt: function (t) {
                var e = d(this.shape, t, !0);
                return i.normalize(e, e)
            }
        });
        t.exports = p
    }, function (t, e, n) {
        var r = n(1).extend({
            type: "arc",
            shape: {cx: 0, cy: 0, r: 0, startAngle: 0, endAngle: 2 * Math.PI, clockwise: !0},
            style: {stroke: "#000", fill: null},
            buildPath: function (t, e) {
                var n = e.cx, r = e.cy, i = Math.max(e.r, 0), a = e.startAngle, o = e.endAngle, s = e.clockwise,
                    l = Math.cos(a), h = Math.sin(a);
                t.moveTo(l * i + n, h * i + r), t.arc(n, r, i, a, o, !s)
            }
        });
        t.exports = r
    }, function (t, e, n) {
        var r = n(1), i = r.extend({
            type: "compound", shape: {paths: null}, _updatePathDirty: function () {
                for (var t = this.__dirtyPath, e = this.shape.paths, n = 0; n < e.length; n++) t = t || e[n].__dirtyPath;
                this.__dirtyPath = t, this.__dirty = this.__dirty || t
            }, beforeBrush: function () {
                this._updatePathDirty();
                for (var t = this.shape.paths || [], e = this.getGlobalScale(), n = 0; n < t.length; n++) t[n].path || t[n].createPathProxy(), t[n].path.setScale(e[0], e[1])
            }, buildPath: function (t, e) {
                for (var n = e.paths || [], r = 0; r < n.length; r++) n[r].buildPath(t, n[r].shape, !0)
            }, afterBrush: function () {
                for (var t = this.shape.paths || [], e = 0; e < t.length; e++) t[e].__dirtyPath = !1
            }, getBoundingRect: function () {
                return this._updatePathDirty(), r.prototype.getBoundingRect.call(this)
            }
        });
        t.exports = i
    }, function (t, e, n) {
        var r = n(0), i = n(25), a = function (t, e, n, r, a, o) {
            this.x = null == t ? 0 : t, this.y = null == e ? 0 : e, this.x2 = null == n ? 1 : n, this.y2 = null == r ? 0 : r, this.type = "linear", this.global = o || !1, i.call(this, a)
        };
        a.prototype = {constructor: a}, r.inherits(a, i);
        var o = a;
        t.exports = o
    }, function (t, e, n) {
        var r = n(0), i = n(25), a = function (t, e, n, r, a) {
            this.x = null == t ? .5 : t, this.y = null == e ? .5 : e, this.r = null == n ? .5 : n, this.type = "radial", this.global = a || !1, i.call(this, r)
        };
        a.prototype = {constructor: a}, r.inherits(a, i);
        var o = a;
        t.exports = o
    }, function (t, e, n) {
        var r = n(0).inherits, i = n(7), a = n(3);

        function o(t) {
            i.call(this, t), this._displayables = [], this._temporaryDisplayables = [], this._cursor = 0, this.notClear = !0
        }

        o.prototype.incremental = !0, o.prototype.clearDisplaybles = function () {
            this._displayables = [], this._temporaryDisplayables = [], this._cursor = 0, this.dirty(), this.notClear = !1
        }, o.prototype.addDisplayable = function (t, e) {
            e ? this._temporaryDisplayables.push(t) : this._displayables.push(t), this.dirty()
        }, o.prototype.addDisplayables = function (t, e) {
            e = e || !1;
            for (var n = 0; n < t.length; n++) this.addDisplayable(t[n], e)
        }, o.prototype.eachPendingDisplayable = function (t) {
            for (var e = this._cursor; e < this._displayables.length; e++) t && t(this._displayables[e]);
            for (e = 0; e < this._temporaryDisplayables.length; e++) t && t(this._temporaryDisplayables[e])
        }, o.prototype.update = function () {
            this.updateTransform();
            for (var t = this._cursor; t < this._displayables.length; t++) {
                (e = this._displayables[t]).parent = this, e.update(), e.parent = null
            }
            for (t = 0; t < this._temporaryDisplayables.length; t++) {
                var e;
                (e = this._temporaryDisplayables[t]).parent = this, e.update(), e.parent = null
            }
        }, o.prototype.brush = function (t, e) {
            for (var n = this._cursor; n < this._displayables.length; n++) {
                (r = this._displayables[n]).beforeBrush && r.beforeBrush(t), r.brush(t, n === this._cursor ? null : this._displayables[n - 1]), r.afterBrush && r.afterBrush(t)
            }
            this._cursor = n;
            for (n = 0; n < this._temporaryDisplayables.length; n++) {
                var r;
                (r = this._temporaryDisplayables[n]).beforeBrush && r.beforeBrush(t), r.brush(t, 0 === n ? null : this._temporaryDisplayables[n - 1]), r.afterBrush && r.afterBrush(t)
            }
            this._temporaryDisplayables = [], this.notClear = !0
        };
        var s = [];
        o.prototype.getBoundingRect = function () {
            if (!this._rect) {
                for (var t = new a(1 / 0, 1 / 0, -1 / 0, -1 / 0), e = 0; e < this._displayables.length; e++) {
                    var n = this._displayables[e], r = n.getBoundingRect().clone();
                    n.needLocalTransform() && r.applyTransform(n.getLocalTransform(s)), t.union(r)
                }
                this._rect = t
            }
            return this._rect
        }, o.prototype.contain = function (t, e) {
            var n = this.transformCoordToLocal(t, e);
            if (this.getBoundingRect().contain(n[0], n[1])) for (var r = 0; r < this._displayables.length; r++) {
                if (this._displayables[r].contain(t, e)) return !0
            }
            return !1
        }, r(o, i);
        var l = o;
        t.exports = l
    }, function (t, e, n) {
        var r = n(5);

        function i(t, e, n, r) {
            return 0 === e ? [[t + .5 * n / Math.PI / 2, r / 2], [t + .5 * n / Math.PI, r], [t + n / 4, r]] : 1 === e ? [[t + .5 * n / Math.PI / 2 * (Math.PI - 2), r], [t + .5 * n / Math.PI / 2 * (Math.PI - 1), r / 2], [t + n / 4, 0]] : 2 === e ? [[t + .5 * n / Math.PI / 2, -r / 2], [t + .5 * n / Math.PI, -r], [t + n / 4, -r]] : [[t + .5 * n / Math.PI / 2 * (Math.PI - 2), -r], [t + .5 * n / Math.PI / 2 * (Math.PI - 1), -r / 2], [t + n / 4, 0]]
        }

        t.exports = r.graphic.extendShape({
            type: "ec-liquid-fill",
            shape: {
                waveLength: 0,
                radius: 0,
                radiusY: 0,
                cx: 0,
                cy: 0,
                waterLevel: 0,
                amplitude: 0,
                phase: 0,
                inverse: !1
            },
            buildPath: function (t, e) {
                null == e.radiusY && (e.radiusY = e.radius);
                for (var n = Math.max(2 * Math.ceil(2 * e.radius / e.waveLength * 4), 8); e.phase < 2 * -Math.PI;) e.phase += 2 * Math.PI;
                for (; e.phase > 0;) e.phase -= 2 * Math.PI;
                var r = e.phase / Math.PI / 2 * e.waveLength, a = e.cx - e.radius + r - 2 * e.radius;
                t.moveTo(a, e.waterLevel);
                for (var o = 0, s = 0; s < n; ++s) {
                    var l = s % 4, h = i(s * e.waveLength / 4, l, e.waveLength, e.amplitude);
                    t.bezierCurveTo(h[0][0] + a, -h[0][1] + e.waterLevel, h[1][0] + a, -h[1][1] + e.waterLevel, h[2][0] + a, -h[2][1] + e.waterLevel), s === n - 1 && (o = h[2][0])
                }
                e.inverse ? (t.lineTo(o + a, e.cy - e.radiusY), t.lineTo(a, e.cy - e.radiusY), t.lineTo(a, e.waterLevel)) : (t.lineTo(o + a, e.cy + e.radiusY), t.lineTo(a, e.cy + e.radiusY), t.lineTo(a, e.waterLevel)), t.closePath()
            }
        })
    }, function (t, e, n) {
        var r = n(0).createHashMap;
        t.exports = function (t) {
            return {
                getTargetSeries: function (e) {
                    var n = {}, i = r();
                    return e.eachSeriesByType(t, function (t) {
                        t.__paletteScope = n, i.set(t.uid, t)
                    }), i
                }, reset: function (t, e) {
                    var n = t.getRawData(), r = {}, i = t.getData();
                    i.each(function (t) {
                        var e = i.getRawIndex(t);
                        r[e] = t
                    }), n.each(function (e) {
                        var a = r[e], o = null != a && i.getItemVisual(a, "color", !0);
                        if (o) n.setItemVisual(e, "color", o); else {
                            var s = n.getItemModel(e).get("itemStyle.color") || t.getColorFromPalette(n.getName(e) || e + "", t.__paletteScope, n.count());
                            n.setItemVisual(e, "color", s), null != a && i.setItemVisual(a, "color", s)
                        }
                    })
                }
            }
        }
    }])
});
//# sourceMappingURL=echarts-liquidfill.js.map