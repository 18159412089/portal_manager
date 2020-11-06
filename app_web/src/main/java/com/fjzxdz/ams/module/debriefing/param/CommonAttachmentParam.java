package com.fjzxdz.ams.module.debriefing.param;

import com.fjzxdz.ams.module.debriefing.entity.CommonAttachment;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
/**
 * 
 * 文件参数类 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午10:17:22
 */
@SuppressWarnings("serial")
public class CommonAttachmentParam extends BaseQueryParam {

    private String fileName;

    private String relationTableId;
    

    @SuppressWarnings({ "rawtypes", "unused" })
    private Class clazz;

    public CommonAttachmentParam() {
        super(CommonAttachment.class);
        this.clazz = EnvironmentAttach.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("relationTableId", getRelationTableId(), SearchCondition.EQ);
        addClause("fileName", getFileName() , SearchCondition.LIKE);
        setOrderBy(" createDate desc");
    }

    

	public String getRelationTableId() {
		return relationTableId;
	}

	public void setRelationTableId(String relationTableId) {
		this.relationTableId = relationTableId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	
    
    

}