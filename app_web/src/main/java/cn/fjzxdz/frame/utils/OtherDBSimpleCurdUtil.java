package cn.fjzxdz.frame.utils;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.db.Db;
import cn.hutool.db.Entity;
import cn.hutool.db.ds.DSFactory;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONUtil;
import cn.hutool.setting.dialect.Props;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * OtherDBSimpleCurdUtil use Hutool 4.4.0
 *
 * @author fushixing
 * @time 2018-08-16
 */
public class OtherDBSimpleCurdUtil {
    /**
     * SQL配置文件，统一配置方便管理
     */
    private static Props props = new Props("config/dbsql.properties");
    private static HashMap<String, Db> dbMap = new HashMap<String, Db>();

    /**
     * 初始化数据源
     *
     * @param dataBase
     */
    public static Db initDb(String dataBase) {
        Db db = null;
        if (dbMap.containsKey(dataBase)) {
            db = dbMap.get(dataBase);
        } else {
            DataSource ds = DSFactory.get(dataBase);
            db = Db.use(ds);
            dbMap.put(dataBase,db);
        }
        return db;
    }

    /**
     * 按表名称查询所有数据，返回Json数组
     *
     * @param dataBase  数据库名称
     * @param tableName 查询表名称
     * @return JSONArray 返回查询表的结果集
     * @throws Exception
     */
    public static JSONArray findByTableName(String dataBase, String tableName) throws Exception {
        JSONArray jsonArray = JSONUtil.parseArray(initDb(dataBase).findAll(tableName));
        return jsonArray;
    }

    /**
     * 按SQL查询数据，返回Json数组
     *
     * @param dataBase 数据库名称
     * @param sqlKey   dbsql.properties配置文件中的SQl key
     * @param paramMap 参数
     * @return JSONArray 返回查询SQL对应的结果集
     * @throws Exception
     */
    public static JSONArray findBySQL(String dataBase, String sqlKey, Map<String, Object> paramMap) throws Exception {
        JSONArray jsonArray = new JSONArray();
        String sql = "";
        if (StrUtil.isNotEmpty(sqlKey)) {
            sql = props.getStr(sqlKey);
            if (StrUtil.isNotEmpty(sql)) {
                List<Entity> result = initDb(dataBase).query(fillParams(sql, paramMap));
                jsonArray = JSONUtil.parseArray(result);
            }
        }
        return jsonArray;
    }

    /**
     * 按SQL insert或update数据，返回执行结果
     *
     * @param dataBase 数据库名称
     * @param sqlKey   dbsql.properties配置文件中的SQl key
     * @param paramMap 参数
     * @return int 返回执行数量
     * @throws Exception
     */
    public static int executeBySQL(String dataBase, String sqlKey, Map<String, Object> paramMap) throws Exception {
        String sql = "";
        int result = 0;
        if (StrUtil.isNotEmpty(sqlKey)) {
            sql = props.getStr(sqlKey);
            if (StrUtil.isNotEmpty(sql)) {
                result = initDb(dataBase).execute(fillParams(sql, paramMap));
            }
        }
        return result;
    }

    /**
     * 按Map参数 填充sql模板生成可执行sql
     *
     * @param sql      sql模板
     * @param paramMap 参数map
     * @return 返回填充后的sql
     * @date 2019-02-21
     */
    private static String fillParams(String sql, Map<String, Object> paramMap) {
        for (String key : paramMap.keySet()) {
            sql = sql.replace("@" + key, String.valueOf(paramMap.get(key)));
        }
        //执行sql在控制台标红
        System.err.println("执行sql：\n----------------------------------\n" + sql + "\n----------------------------------");
        return sql;
    }


    public static void main(String[] args) {
        try {
            //参数
            Map<String, Object> paramMap =
                    //MapUtil.builder("id", (Object) " where id='0--nhvMJx308_FHu_-Z6HW' and name = '赖友尧' ").build();
                    MapUtil.builder("id", (Object) "'0--nhvMJx308_FHu_-Z6HW'").put("name1", (Object) "'赖友尧'").build();

            //按表查询
            //findByTableName("epa","sys_user");

            //按SQL查询
            System.out.println(findBySQL("ZZRegulatoryWarning", "erm.module.functionName", paramMap));

            //执行SQL语句
            //executeBySQL("epa","erm.module.updatefunctionName", paramMap);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}