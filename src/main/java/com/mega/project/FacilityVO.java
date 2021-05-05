package com.mega.project;
//편의시설에 대한 데이터를 다룰 VO
public class FacilityVO {
	int fid;
	String name;
	float latitude;
	float longtitude;
	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getLatitude() {
		return latitude;
	}
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	public float getLongtitude() {
		return longtitude;
	}
	public void setLongtitude(float longtitude) {
		this.longtitude = longtitude;
	}
	@Override
	public String toString() {
		return "FacilityVO [fid=" + fid + ", name=" + name + ", latitude=" + latitude + ", longtitude=" + longtitude
				+ "]";
	}
	
	
	
}
