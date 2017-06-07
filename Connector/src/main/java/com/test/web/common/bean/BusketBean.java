package com.test.web.common.bean;

import java.util.Calendar;

public class BusketBean {
	private String busketNo;
	private String customerId;
	private String studyId;
	private Calendar buscketDate;
	
	public String getBusketNo() {
		return busketNo;
	}
	public void setBusketNo(String busketNo) {
		this.busketNo = busketNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getStudyId() {
		return studyId;
	}
	public void setStudyId(String studyId) {
		this.studyId = studyId;
	}
	public Calendar getBuscketDate() {
		return buscketDate;
	}
	public void setBuscketDate(Calendar buscketDate) {
		this.buscketDate = buscketDate;
	}
	
}
