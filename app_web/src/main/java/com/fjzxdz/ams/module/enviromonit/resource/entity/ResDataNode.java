package com.fjzxdz.ams.module.enviromonit.resource.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * 首页构建资源目录树
 *
 * @author liuyankun
 */
public class ResDataNode implements Serializable, Comparable<Object> {

	private static final long serialVersionUID = 1L;

	/**
	 * 节点id
	 */
	private String id;

	/**
	 * 父节点
	 */
	private String parentId;

	/**
	 * 节点名称
	 */
	private String name;

	/**
	 * 按钮级别
	 */
	private Integer levels;

	/**
	 * 按钮的排序
	 */
	private Integer num;

	/**
	 * 节点的url
	 */
	private String url;

	/**
	 * 节点图标
	 */
	private String icon;

	/**
	 * 子节点的集合
	 */
	private List<ResDataNode> children;

	/**
	 * 查询子节点时候的临时集合
	 */
	private List<ResDataNode> linkedList = new ArrayList<ResDataNode>();

	public ResDataNode() {
		super();
	}

	public ResDataNode(String id, String parentId) {
		super();
		this.id = id;
		this.parentId = parentId;
	}

	public Integer getLevels() {
		return levels;
	}

	public void setLevels(Integer levels) {
		this.levels = levels;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public static ResDataNode createRoot() {
		return new ResDataNode("0", "-1");
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<ResDataNode> getChildren() {
		return children;
	}

	public void setChildren(List<ResDataNode> children) {
		this.children = children;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "ResDataNode{" + "id=" + id + ", parentId=" + parentId + ", name='" + name + '\'' + ", levels=" + levels
				+ ", num=" + num + ", url='" + url + '\'' + ", icon='" + icon + '\'' + ", children=" + children
				+ ", linkedList=" + linkedList + '}';
	}

	@Override
	public int compareTo(Object o) {
		ResDataNode menuNode = (ResDataNode) o;
		Integer num = menuNode.getNum();
		if (num == null) {
			num = 0;
		}
		return this.num.compareTo(num);
	}

	/**
	 * 构建整个菜单树
	 */
	public void buildNodeTree(List<ResDataNode> nodeList) {
		for (ResDataNode treeNode : nodeList) {
			List<ResDataNode> linkedList = treeNode.findChildNodes(nodeList, treeNode.getId());
			if (linkedList.size() > 0) {
				treeNode.setChildren(linkedList);
			}
		}
	}

	/**
	 * 查询子节点的集合
	 */
	public List<ResDataNode> findChildNodes(List<ResDataNode> nodeList, String parentId) {
		if (nodeList == null && parentId == null)
			return null;
		for (Iterator<ResDataNode> iterator = nodeList.iterator(); iterator.hasNext();) {
			ResDataNode node = iterator.next();
			// 根据传入的某个父节点ID,遍历该父节点的所有子节点
			if (!node.getParentId().equals("0") && parentId.equals(node.getParentId())) {
				recursionFn(nodeList, node, parentId);
			}
		}
		return linkedList;
	}

	/**
	 * 遍历一个节点的子节点
	 */
	public void recursionFn(List<ResDataNode> nodeList, ResDataNode node, String pId) {
		List<ResDataNode> childList = getChildList(nodeList, node);// 得到子节点列表
		if (childList.size() > 0) {// 判断是否有子节点
			if (node.getParentId().equals(pId)) {
				linkedList.add(node);
			}
			Iterator<ResDataNode> it = childList.iterator();
			while (it.hasNext()) {
				ResDataNode n = (ResDataNode) it.next();
				recursionFn(nodeList, n, pId);
			}
		} else {
			if (node.getParentId().equals(pId)) {
				linkedList.add(node);
			}
		}
	}

	/**
	 * 得到子节点列表
	 */
	private List<ResDataNode> getChildList(List<ResDataNode> list, ResDataNode node) {
		List<ResDataNode> nodeList = new ArrayList<ResDataNode>();
		Iterator<ResDataNode> it = list.iterator();
		while (it.hasNext()) {
			ResDataNode n = it.next();
			if (n.getParentId().equals(node.getId())) {
				nodeList.add(n);
			}
		}
		return nodeList;
	}

	/**
	 * 清除掉按钮级别的资源
	 */
	public static List<ResDataNode> clearBtn(List<ResDataNode> nodes) {
		ArrayList<ResDataNode> noBtns = new ArrayList<ResDataNode>();
		for (ResDataNode node : nodes) {
			if (node.getLevels() < 4) {
				noBtns.add(node);
			}
		}
		return noBtns;
	}

	/**
	 * 清除所有二级菜单
	 */
	public static List<ResDataNode> clearLevelTwo(List<ResDataNode> nodes) {
		ArrayList<ResDataNode> results = new ArrayList<ResDataNode>();
		for (ResDataNode node : nodes) {
			Integer levels = node.getLevels();
			if (levels.equals(1)) {
				results.add(node);
			}
		}
		return results;
	}

	/**
	 * 构建菜单列表
	 */
	public static List<ResDataNode> buildTitle(List<ResDataNode> nodes) {
		List<ResDataNode> clearBtn = clearBtn(nodes);
		new ResDataNode().buildNodeTree(clearBtn);
		List<ResDataNode> menuNodes = clearLevelTwo(clearBtn);

		// 对菜单排序
		Collections.sort(menuNodes);

		// 对菜单的子菜单进行排序
		for (ResDataNode firstMn : menuNodes) {
			List<ResDataNode> secondMns = firstMn.getChildren();
			if (secondMns != null && secondMns.size() > 0) {
				Collections.sort(secondMns);
				// 对三级菜单进行排序
				for (ResDataNode secondMn : secondMns) {
					List<ResDataNode> thirdMns = secondMn.getChildren();
					if (thirdMns != null && thirdMns.size() > 0) {
						Collections.sort(thirdMns);
					}
				}
			}
		}

		return menuNodes;
	}
}
