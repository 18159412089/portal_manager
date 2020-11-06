package cn.fjzxdz.frame.service.sys.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.sys.DictDao;
import cn.fjzxdz.frame.entity.core.Dict;
import cn.fjzxdz.frame.entity.core.DictChildParam;
import cn.fjzxdz.frame.entity.core.DictParam;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.sys.DictService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
@Service
@Transactional(rollbackFor=Exception.class)
public class DictServiceImpl implements DictService{

	@Autowired
	private DictDao dictDao;
	
	@Override
	public R save(Dict dict) {
		dictDao.save(dict);
		return R.ok();
	}
	
	@Override
	public Dict getById(String uuid) {
		return dictDao.getById(uuid);
	}
	
	@Override
	public void delete(String uuid) {
		dictDao.createQuery("delete from Dict where parent.uuid=?", uuid).executeUpdate();
		Dict dict = dictDao.getById(uuid);
		dictDao.delete(dict);
	}
	
	@Override
	public Page<Dict> listByPage(DictParam dictParam, Page<Dict> page) {
		return dictDao.listByPage(dictParam, page);
	}
	
	@Override
	public Page<Dict> listByPage(DictChildParam dictParam, Page<Dict> page) {
		return dictDao.listByPage(dictParam, page);
	}

	@SuppressWarnings("unchecked")
	@Override
	public JSONArray getDictData(String type) {
		JSONArray jsonArray = new JSONArray();
		List<Dict> result = dictDao.createQuery("from Dict where parent.type=? and enable=1 and parent.enable=1", type).getResultList();
		if(null!=result&&result.size()>0) {
			for (Dict dict : result) {
				JSONObject jsonObject =new JSONObject();
				jsonObject.put("id", dict.getType());
				jsonObject.put("text", dict.getValue());
				jsonArray.add(jsonObject);
			}
		}
		return jsonArray;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, String> getValueMap(String type) {
		List<Dict> dicts=dictDao.createQuery("from Dict where parent.type=? and enable=1 and parent.enable=1",type).getResultList();
		if (ToolUtil.isNotEmpty(dicts)) {
			Map<String,String> dictMap=new HashMap<String,String>();
			for (Dict obj : dicts) {
				dictMap.put(obj.getType(), obj.getValue());
			}
			return dictMap;
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String getValueByType(String type) {
		List<Dict> dicts=dictDao.createQuery("from Dict where type=? and enable=1 and parent.enable=1",type).getResultList();
		if (ToolUtil.isNotEmpty(dicts)) {
			return dicts.get(0).getValue();
		}
		return null;
	}

	@Override
	public Map<String, Object> getDictById(String id) {
		if(id == null) return null;
        String value = "";
        try {
            Dict dict = dictDao.getById(id);
            if (dict != null) {
                value = dict.getValue();
            } 
        } catch (Exception e) {
            e.printStackTrace();
            return R.error(e.getMessage());
        }
        return R.ok().put("value", value);
	}
}
