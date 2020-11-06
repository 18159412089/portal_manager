package com.fjzxdz.ams.module.enums;

/**
 * @Author lianhuinan
 * @Description //TODO(污染源大地图的区县)
 * @Date 2019/9/21 0021 17:02
 * @version 1.0
 **/
public enum PollutionInfoCountyEnum {
    芗城区 ("XiangCheng", "芗城区", 1, "xcq", "117.6198", "24.6075"),
    龙文区  ("LongWen", "龙文区",  2, "lwq", "117.736096", "24.544785"),
    龙海市 ("LongHai", "龙海市", 8, "lhs", "117.8200", "24.3800"),
    漳浦县("ZhangPu", "漳浦县",  3, "zpx", "117.66", "24.09"),
    长泰县 ("ChangTai", "长泰县",  4, "ctx", "117.778333", "24.7433333"),
    华安县 ("HuaAn", "华安县",  5, "hax", "117.552777777778", "24.9033333333333"),
    东山县 ("DongShan", "东山县", 11, "dsx", "117.416944444444", "23.6947222222222"),
    平和县 ("PingHe", "平和县",  6, "phx", "117.185", "24.36"),
    诏安县  ("ZhaoAn", "诏安县",  7, "zax", "117.095836", "23.887247"),
    南靖县 ("NanJing", "南靖县", 9, "njx", "117.332222", "24.663611"),
    云霄县 ("YunXiao", "云霄县", 10, "yxx", "117.3641", "23.9969"),
    台商投资区 ("TaiShangTouZi", "台商投资区", 12, "tstzq", "117.880308333333", "24.5314027777778"),
    招商局漳州开发区 ("ZhaoShangJuZhangZhouKaiFa", "招商局漳州开发区", 13, "zsjzzkfq", "118.0354886734", "24.3741"),
    常山华侨经济开发区 ("ChangShangHuaQiao", "常山华侨经济开发区", 15, "cshqjjkfq", "117.3046559841", "23.8824197896"),
    漳州高新技术产业开发区 ("ZhangZhouGaoXinJiShuChanYe", "漳州高新技术产业开发区", 14, "zzgxjscykfq", "117.630066", "24.45377517"),
    古雷港经济开发区 ("GuLeiGang", "古雷港经济开发区", 16, "glgjjkfq", "117.5948", "23.949");

    private String key;

    private String value;

    private int index;

    private String abridge;

    private String jd;

    private String wd;

    PollutionInfoCountyEnum(String value, String key, int index, String abridge, String jd, String wd) {
        this.key = key;
        this.value = value;
        this.index = index;
        this.abridge = abridge;
        this.jd = jd;
        this.wd = wd;
    }

    public String getJd() {
        return jd;
    }

    public void setJd(String jd) {
        this.jd = jd;
    }

    public String getWd() {
        return wd;
    }

    public void setWd(String wd) {
        this.wd = wd;
    }

    public String getAbridge() {
        return abridge;
    }

    public void setAbridge(String abridge) {
        this.abridge = abridge;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }
}
