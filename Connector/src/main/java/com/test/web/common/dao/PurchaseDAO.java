package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.PurchaseBean;

public interface PurchaseDAO {

	/** 회원정보를 조회해서 가져온다. **/
	public PurchaseBean selectPurchase(PurchaseBean bean);
	
	/** 구매정보를 조회해서 리스트로 가져온다. **/
	public List<PurchaseBean> selectPurchaseList(PurchaseBean bean);
	
	/** 구매정보 중 허가 된 품목만을 가져온다 **/
	public List<PurchaseBean> selectPurchaseListByCheck(PurchaseBean bean);
	
	
	/** 회원정보를 삽입한다. **/
	public int insertPurchase(PurchaseBean bean);
	
	/** 회원정보를 수정한다. **/
	public int updatePurchase(PurchaseBean bean);
	
	public int deletePurchase(PurchaseBean bean) throws Exception;
	public int updateStudyMember(PurchaseBean bean);

}
