package com.test.web.common.bean;

import java.util.Calendar;

public class PurchaseBean {
	private String customerId;
	private String studyId;
	private String purchaseSort;
	private int purchaseNo;
	private Calendar purchaseDate;
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
	public String getPurchaseSort() {
		return purchaseSort;
	}
	public void setPurchaseSort(String purchaseSort) {
		this.purchaseSort = purchaseSort;
	}
	public int getpurchaseNo() {
		return purchaseNo;
	}
	public void setpurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}
	public Calendar getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Calendar purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	
}