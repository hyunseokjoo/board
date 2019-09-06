package com.java.board;


public class ContentBean {

	private String title;
	private String image;
	private String content;
	
	public ContentBean(){
		
	}
	
	public ContentBean(String title, String image, String content) {
		this.title = title;
		this.image = image;
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}

