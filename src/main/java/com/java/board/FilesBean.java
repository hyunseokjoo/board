package com.java.board;

public class FilesBean {
	private String no;
	private String boardNum;
	private String fileOriginalName;
	private String fileUUIDName;
	
	public FilesBean() {}
	public FilesBean(String no, String boardNum, String fileOriginalName, String fileUUIDName) {
		super();
		this.boardNum = boardNum;
		this.fileOriginalName = fileOriginalName;
		this.fileUUIDName = fileUUIDName;
	}

	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(String boardNum) {
		this.boardNum = boardNum;
	}
	public String getFileOriginalName() {
		return fileOriginalName;
	}
	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}
	public String getFileUUIDName() {
		return fileUUIDName;
	}
	public void setFileUUIDName(String fileUUIDName) {
		this.fileUUIDName = fileUUIDName;
	}
	
	
	
	
}