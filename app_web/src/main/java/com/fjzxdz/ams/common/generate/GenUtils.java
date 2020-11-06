/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.common.generate;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.db.DbUtil;
import cn.hutool.db.ds.simple.SimpleDataSource;
import cn.hutool.setting.dialect.Props;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * 代码生成工具类
 *
 * @author fushixing
 * @version 2018-07-23
 */
public class GenUtils {

    private static Logger logger = LoggerFactory.getLogger(GenUtils.class);
    //数据源基本信息
    private static Props props = new Props("application-dev-ly.properties");
    private static String jdbcUrlString = props.getProperty("main.datasource.url");
    private static String jdbcUserName = props.getProperty("main.datasource.user");
    private static String jdbcPsw = props.getProperty("main.datasource.password");

    /**
     * 获取数据表字段
     *
     * @param tableName 表名称
     * @return
     * @throws Exception
     */
    @SuppressWarnings("resource")
    public static List<GenTableColumn> findTableColumnList(String tableName) throws Exception {
        DataSource ds = new SimpleDataSource(jdbcUrlString, jdbcUserName, jdbcPsw);
        Connection conn = null;
        List<Map<String, String>> listC = null;
        List<GenTableColumn> columnList = null;
        try {
            conn = ds.getConnection();
            listC = execProcedure(getTableColumnSql(tableName, "oracle"), conn);
            columnList = new ArrayList<GenTableColumn>();
            for (Iterator<Map<String, String>> iterator = listC.iterator(); iterator.hasNext(); ) {
                Map<String, String> map = (Map<String, String>) iterator.next();
                GenTableColumn genTableColumn = new GenTableColumn();
                genTableColumn.setJavaField(StrUtil.toCamelCase(map.get("NAME").toString().toLowerCase()));
                genTableColumn.setJavaType(getFieldSqlTypeShort(map.get("JDBCTYPE").toString()));
                genTableColumn.setComments(map.get("COMMENTS").toString());
                genTableColumn.setIsNotBaseField(isNotBaseField(map.get("NAME").toString().toLowerCase()));
                columnList.add(genTableColumn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.close(conn);
        }
        return columnList;
    }

    /**
     * 判断是否基础字段
     *
     * @param column_name
     * @return
     */
    public static boolean isNotBaseField(String column_name) {
        boolean isNotBaseField = true;
        if ("uuid".equalsIgnoreCase(column_name)
                || "create_date".equalsIgnoreCase(column_name)
                || "create_user".equalsIgnoreCase(column_name)
                || "update_date".equalsIgnoreCase(column_name)
                || "update_user".equalsIgnoreCase(column_name)) {
            isNotBaseField = false;
        }
        return isNotBaseField;
    }

    /**
     * 获取数据库对应的查询列和列属性SQL
     *
     * @param tableName 表名称
     * @param jdbcType  数据库类型
     * @return 返回对应数据库SQL
     */
    public static String getTableColumnSql(String tableName, String jdbcType) {
        StringBuffer sbBuffer = new StringBuffer();
        if ("mysql".equalsIgnoreCase(jdbcType)) {
            sbBuffer.append("SELECT t.COLUMN_NAME AS name, (CASE WHEN t.IS_NULLABLE = 'YES' THEN '1' ELSE '0' END) AS isNull,\n");
            sbBuffer.append("	(t.ORDINAL_POSITION * 10) AS sort,t.COLUMN_COMMENT AS comments,t.COLUMN_TYPE AS jdbcType \n");
            sbBuffer.append("FROM information_schema.`COLUMNS` t \n");
            sbBuffer.append("WHERE t.TABLE_SCHEMA = (select database())\n");
            sbBuffer.append("	AND t.TABLE_NAME = '" + tableName + "'");
            sbBuffer.append(" ORDER BY t.ORDINAL_POSITION");
        } else if ("oracle".equalsIgnoreCase(jdbcType)) {
            sbBuffer.append("SELECT\n");
            sbBuffer.append("	t.COLUMN_NAME AS name,\n");
            sbBuffer.append("	(CASE WHEN t.NULLABLE = 'Y' THEN '1' ELSE '0' END) AS isNull,\n");
            sbBuffer.append("	(t.COLUMN_ID * 10) AS sort,\n");
            sbBuffer.append("	c.COMMENTS AS comments,\n");
            sbBuffer.append("	decode(t.DATA_TYPE,'DATE',t.DATA_TYPE || '(' || t.DATA_LENGTH || ')',\n");
            sbBuffer.append("		'VARCHAR2', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')',\n");
            sbBuffer.append("		'VARCHAR', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')',\n");
            sbBuffer.append("		'NVARCHAR2', t.DATA_TYPE || '(' || t.DATA_LENGTH/2 || ')',\n");
            sbBuffer.append("		'CHAR', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')',\n");
            sbBuffer.append("		'NUMBER',t.DATA_TYPE || (nvl2(t.DATA_PRECISION,nvl2(decode(t.DATA_SCALE,0,null,t.DATA_SCALE),\n");
            sbBuffer.append("			'(' || t.DATA_PRECISION || ',' || t.DATA_SCALE || ')', \n");
            sbBuffer.append("			'(' || t.DATA_PRECISION || ')'),'(18)')),t.DATA_TYPE) AS jdbcType \n");
            sbBuffer.append("	FROM user_tab_columns t, user_col_comments c \n");
            sbBuffer.append("	WHERE t.TABLE_NAME = c.table_name \n");
            sbBuffer.append("	AND t.COLUMN_NAME = c.column_name \n");
            sbBuffer.append("	AND t.TABLE_NAME = '" + tableName + "'");
            sbBuffer.append("ORDER BY t.COLUMN_ID");
        } else if ("mssql".equalsIgnoreCase(jdbcType)) {
            sbBuffer.append("SELECT t.name AS name,b.value AS comments ");
            sbBuffer.append("FROM sys.objects t LEFT JOIN sys.extended_properties b ON b.major_id=t.object_id and b.minor_id=0 and b.class=1 AND b.name='MS_Description'");
            sbBuffer.append("WHERE t.type='U'");
            sbBuffer.append("	AND t.name = ('" + tableName + "')");
            sbBuffer.append("ORDER BY t.name");
        }
        return sbBuffer.toString();
    }

    /**
     * 获取数据模型
     *
     * @param genScheme
     * @param genTable
     * @return
     */
    public static Map<String, Object> getDataModel(Map<String, String> genScheme) {
        Map<String, Object> model = Maps.newHashMap();
        try {
            model.put("packageName", StringUtils.lowerCase(genScheme.get("packageName")));
            model.put("moduleName", StringUtils.lowerCase(genScheme.get("moduleName")));
            model.put("subModuleName", StringUtils.isNotBlank(genScheme.get("subModuleName")) ? "." + StringUtils.lowerCase(genScheme.get("subModuleName")) : "");
            model.put("className", StringUtils.uncapitalize(genScheme.get("className")));
            model.put("ClassName", StringUtils.capitalize(genScheme.get("className")));
            model.put("classAuthor", StringUtils.isNotBlank(genScheme.get("classAuthor")) ? genScheme.get("classAuthor") : "Generate Tools");
            model.put("classVersion", DateUtil.today());
            model.put("functionName", genScheme.get("functionName"));
			/*model.put("tableName", genScheme.get("moduleName")+(StringUtils.isNotBlank(genScheme.get("subModuleName"))
					?"_"+StringUtils.lowerCase(genScheme.get("subModuleName")):"")+"_"+genScheme.get("className"));*/
            model.put("tableName", genScheme.get("tableName"));
            model.put("urlPrefix", genScheme.get("moduleName") + (StringUtils.isNotBlank(genScheme.get("subModuleName"))
                    ? "/" + StringUtils.lowerCase(genScheme.get("subModuleName")) : "") + "/" + genScheme.get("className").substring(0, 1).toLowerCase() + genScheme.get("className").substring(1));
            model.put("viewPrefix", //StringUtils.substringAfterLast(model.get("packageName"),".")+"/"+
                    model.get("urlPrefix"));
            model.put("permissionPrefix", genScheme.get("moduleName") + (StringUtils.isNotBlank(genScheme.get("subModuleName"))
                    ? ":" + StringUtils.lowerCase(genScheme.get("subModuleName")) : "") + ":" + genScheme.get("className"));
            //数据列
            List<GenTableColumn> columnList;
            columnList = findTableColumnList(genScheme.get("tableName"));
            model.put("columnList", columnList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }


    /**
     * 执行SQL 返回SQL对应的列和列属性
     *
     * @param preparedSql 执行的SQL
     * @param connection  数据源链接
     * @return
     * @throws Exception
     */
    public static List<Map<String, String>> execProcedure(String preparedSql, Connection connection) throws Exception {
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
        ResultSet rs = null;
        CallableStatement stmt = connection.prepareCall(preparedSql);
        try {
            rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> row = new HashMap<String, String>();
                for (int i = 1; i < rs.getMetaData().getColumnCount() + 1; i++) {
                    String columnName = rs.getMetaData().getColumnName(i);
                    String fieldValue = rs.getString(i);
                    if (fieldValue == null) {
                        fieldValue = "";
                    }
                    row.put(columnName, fieldValue);
                }
                resultList.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
        return resultList;
    }

    /**
     * 获取数据库表字段类型对应的java类型
     *
     * @param columnType 表字段类型
     * @return 对应的java 类型
     */
    public static String getFieldSqlTypeShort(String columnType) {
        // 设置java类型
        if (StringUtils.startsWithIgnoreCase(columnType, "CHAR")
                || StringUtils.startsWithIgnoreCase(columnType, "VARCHAR")
                || StringUtils.startsWithIgnoreCase(columnType, "NARCHAR")
                || StringUtils.startsWithIgnoreCase(columnType, "text")) {
            return "String";
        } else if (StringUtils.startsWithIgnoreCase(columnType, "DATETIME")
                || StringUtils.startsWithIgnoreCase(columnType, "DATE")
                || StringUtils.startsWithIgnoreCase(columnType, "TIMESTAMP")) {
            return "java.util.Date";
        } else if (StringUtils.startsWithIgnoreCase(columnType, "BIGINT")
                || StringUtils.startsWithIgnoreCase(columnType, "NUMBER")) {
            // 如果是浮点型
            String[] ss = StringUtils.split(StringUtils.substringBetween(columnType, "(", ")"), ",");
            if (ss != null && ss.length == 2 && Integer.parseInt(ss[1]) > 0) {
                return "Double";
            }
            // 如果是整形
            else if (ss != null && ss.length == 1 && Integer.parseInt(ss[0]) <= 10) {
                return "Integer";
            }
            // 长整形
            else {
                return "Long";
            }
        }
        return "String";
    }


    /**
     * 将内容写入文件
     *
     * @param content  文件内容
     * @param filePath 文件路径
     */
    public static void writeFile(String content, String filePath) {
        try {
            if (FileUtil.touch(filePath) != null) {
                FileOutputStream fos = new FileOutputStream(filePath);
                Writer writer = new OutputStreamWriter(fos, "UTF-8");
                BufferedWriter bufferedWriter = new BufferedWriter(writer);
                bufferedWriter.write(content);
                bufferedWriter.close();
                writer.close();
            } else {
                logger.info("生成失败，文件已存在！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println(content);
    }


    /**
     * 获取数据表字段
     *
     * @param tableName 表名称
     * @return
     * @throws Exception
     */
    @SuppressWarnings("resource")
    public static void findTableColumnInsertSql(String tableName) throws Exception {
        DataSource ds = new SimpleDataSource(jdbcUrlString, jdbcUserName, jdbcPsw);
        Connection conn = null;
        List<Map<String, String>> listC = null;
        StringBuilder stringBuilder = new StringBuilder();
        StringBuilder data1 = new StringBuilder();
        StringBuilder data2 = new StringBuilder();
        //"{call P_AIR_SITE_HOUR_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?)}"
        data1.append("{call P_");
        data1.append(tableName);
        data1.append("(");
        try {
            conn = ds.getConnection();
            listC = execProcedure(getTableColumnSql(tableName, "oracle"), conn);
            int i = 1;
            for (Iterator<Map<String, String>> iterator = listC.iterator(); iterator.hasNext(); ) {
                Map<String, String> map = (Map<String, String>) iterator.next();
                String columnName = map.get("NAME").toString();
                String columnType = map.get("JDBCTYPE").toString();
                if (columnType.contains("VARCHAR2") || columnType.contains("CHAR")) {
                    stringBuilder.append("proc.setString(" + i + ", getString(tempObject.get(\"" + columnName + "\")));");
                } else if (columnType.contains("NUMBER") || columnType.contains("FLOAT")) {
                    stringBuilder.append("proc.setBigDecimal(" + i + ", getNumber(tempObject.get(\"" + columnName + "\")));");
                } else if (columnType.contains("DATE")) {
                    stringBuilder.append("proc.setTimestamp(" + i + ", getTimestamp(tempObject.get(\"" + columnName + "\")));");
                }
                stringBuilder.append("\n");
                data2.append("?,");
                i++;
            }
            data1.append(data2.toString().substring(0, data2.toString().length() - 1));
            data1.append(")}");

            System.out.println(data1.toString());
            System.out.println("\n");
            System.out.println("\n");
            System.out.println(stringBuilder.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.close(conn);
        }
    }

    public static void main(String[] args) {

        logger.debug(jdbcUrlString);
        try {

            GenUtils.findTableColumnInsertSql("RISK_PRODUCT_ACCESSORIES_DATA");
        } catch (Exception e) {

        }
    }

}
