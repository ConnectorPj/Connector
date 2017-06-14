package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.PurchaseBean;

public interface PurchaseDAO {

	/** ȸ�������� ��ȸ�ؼ� �����´�. **/
	public PurchaseBean selectPurchase(PurchaseBean bean);
	
	/** ȸ�������� ��ȸ�ؼ� ����Ʈ�� �����´�. **/
	public List<PurchaseBean> selectPurchaseList(PurchaseBean bean);
	
	/** ȸ�������� �����Ѵ�. **/
	public int insertPurchase(PurchaseBean bean);
	
	/** ȸ�������� �����Ѵ�. **/
	public int updatePurchase(PurchaseBean bean);
	
	public int deletePurchase(PurchaseBean bean) throws Exception;
	public int updateStudyMember(PurchaseBean bean);

}
