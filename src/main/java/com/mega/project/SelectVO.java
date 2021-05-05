package com.mega.project;

public class SelectVO {
	String roomType;
	String saleType;
	String sectionType;

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public String getSaleType() {
		return saleType;
	}

	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}

	public String getSectionType() {
		return sectionType;
	}

	public void setSectionType(String sectionType) {
		this.sectionType = sectionType;
	}
	
	@Override
	public String toString() {
		return "SelectVO [roomType=" + roomType + ", saleType=" + saleType + ", sectionType=" + sectionType + "]";
	}

}
