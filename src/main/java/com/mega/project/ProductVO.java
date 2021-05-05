package com.mega.project;

public class ProductVO {
	int pnum; // db에 있는 각 컬럼을 변수로 생성(넣고 뺄 수 있는 getters and setters생성)
	String pname;
	String ptype;
	String ctype;
	String price;
	String address;
	String address2;
	String contact;
	String floor;
	String rsize;
	String room;
	String total;
	String placetype;
	String roomimg;
	String roomimg2;
	String roomimg3;
	String pinfo;
	String dstatue;

	@Override
	public String toString() {
		return "ProductVO [pnum=" + pnum + ", pname=" + pname + ", ptype=" + ptype + ", ctype=" + ctype + ", price="
				+ price + ", address=" + address + ", address2=" + address2 + ", contact=" + contact + ", floor="
				+ floor + ", rsize=" + rsize + ", room=" + room + ", total=" + total + ", placetype=" + placetype
				+ ", roomimg=" + roomimg + ", roomimg2=" + roomimg2 + ", roomimg3=" + roomimg3 + ", pinfo=" + pinfo
				+ ", dstatue=" + dstatue + "]";
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPtype() {
		return ptype;
	}

	public void setPtype(String ptype) {
		this.ptype = ptype;
	}

	public String getCtype() {
		return ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	public String getRsize() {
		return rsize;
	}

	public void setRsize(String rsize) {
		this.rsize = rsize;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getPlacetype() {
		return placetype;
	}

	public void setPlacetype(String placetype) {
		this.placetype = placetype;
	}

	public String getRoomimg() {
		return roomimg;
	}

	public void setRoomimg(String roomimg) {
		this.roomimg = roomimg;
	}

	public String getRoomimg2() {
		return roomimg2;
	}

	public void setRoomimg2(String roomimg2) {
		this.roomimg2 = roomimg2;
	}

	public String getRoomimg3() {
		return roomimg3;
	}

	public void setRoomimg3(String roomimg3) {
		this.roomimg3 = roomimg3;
	}

	public String getPinfo() {
		return pinfo;
	}

	public void setPinfo(String pinfo) {
		this.pinfo = pinfo;
	}

	public String getDstatue() {
		return dstatue;
	}

	public void setDstatue(String dstatue) {
		this.dstatue = dstatue;
	}
}
