package com.java.board;

import java.util.List;

public class BoardBean {
	private String no;
	private String title;
	private String content;
	private String name;
	private int star;
	private int num;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public BoardBean() {}
	public BoardBean(String title, String content, String name,String no, int star, int num) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.name = name;
		this.star = star;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
}
