package cn.fjzxdz.frame.common;
import java.io.BufferedReader;
import java.io.Reader;
import java.sql.Clob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.transform.ResultTransformer;

public class SelfResultTransformer implements ResultTransformer {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Object transformTuple(Object[] tuple, String[] aliases) {
		Map result = new HashMap(tuple.length);
		for (int i = 0; i < tuple.length; i++) {
			String alias = aliases[i];
			if (alias != null) {
				if (tuple[i] != null && tuple[i] instanceof Clob) {
					result.put(UnderlineToHump(alias), getClob((Clob) tuple[i]));
				} else {
					result.put(UnderlineToHump(alias), tuple[i]);
				}
			}
		}

		return result;
	}

	public static String UnderlineToHump(String para){
        StringBuilder result=new StringBuilder();
        String a[]=para.split("_");
        for(String s:a){
            if(result.length()==0){
                result.append(s.toLowerCase());
            }else{
                result.append(s.substring(0, 1).toUpperCase());
                result.append(s.substring(1).toLowerCase());
            }
        }
        return result.toString();
    }

	public String getClob(Clob inTuple) {
		Reader reader;
		StringBuffer sb = new StringBuffer();
		try {
			reader = inTuple.getCharacterStream();
			BufferedReader br = new BufferedReader(reader);
			String temp = null;
			while ((temp = br.readLine()) != null) {
				sb.append(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

	 @SuppressWarnings("rawtypes")
	    public List transformList(final List collection) {
	        return collection;
	    }
}