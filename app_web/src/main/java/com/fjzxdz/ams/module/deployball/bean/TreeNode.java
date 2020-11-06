package com.fjzxdz.ams.module.deployball.bean;

import java.util.ArrayList;
import java.util.List;


public class TreeNode {
	
	private String indexCode; //编号
	private String parentIndexCode;//父编号
	private String text;   //节点内容
	private String nodeType; //节点类型
	private boolean open;   //是否展开
	private boolean isParent;  //是否是父节点
	private List<TreeNode> children = new ArrayList<TreeNode>(); //子节点集合
	private String icon;

    public void addChild(TreeNode treeNode) {
        children.add(treeNode);
    }

    public void addChildren(List<TreeNode> treeNodeList) {
        children.addAll(treeNodeList);
    }
	
	
	public String getIndexCode() {
		return indexCode;
	}
	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}
	public String getParentIndexCode() {
		return parentIndexCode;
	}
	public void setParentIndexCode(String parentIndexCode) {
		this.parentIndexCode = parentIndexCode;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getNodeType() {
		return nodeType;
	}
	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public List<TreeNode> getChildren() {
		return children;
	}
	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}

    public boolean getIsParent() {
        return isParent;
    }

    public void setIsParent(boolean parent) {
        isParent = parent;
    }

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	

}
