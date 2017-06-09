package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.BusketBean;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PurchaseBean;

public interface ClassDAO {

	public ClassBean selectClass(ClassBean bean); // 덕환

	public int insertClass(ClassBean bean);

	public int updateClass(ClassBean bean);

	public int deleteClass(ClassBean bean) throws Exception;

	/** 수엽 내용를 조회해서 리스트로 가져온다. **/
	public List<ClassBean> selectClassList();

	public List<ClassBean> selectClassListAll(ClassBean bean, PagingBean pBean) throws Exception;

	public List<ClassBean> selectTeacherClassList(ClassBean bean) throws Exception;
	public List<ClassBean> selectCustomerPurchaseList(PurchaseBean pBean) throws Exception;
	public List<ClassBean> selectCustomerBusketList(BusketBean bBean) throws Exception;
}
