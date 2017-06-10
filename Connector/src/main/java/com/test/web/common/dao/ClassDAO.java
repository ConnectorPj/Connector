package com.test.web.common.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PurchaseBean;

public interface ClassDAO {

	public ClassBean selectClass(ClassBean bean); //덕환
	public int insertClass(ClassBean bean);
	public int updateClass(ClassBean bean);
	public int deleteClass(ClassBean bean) throws Exception;
	
	/** 수업 내용를 조회해서 리스트로 가져온다. **/
	public List<ClassBean> selectClassList();
	public List<ClassBean> selectClassListAll(
			@Param("classBean") ClassBean bean,
			@Param("pagingBean") PagingBean pBean) 
			throws Exception;

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectClassListTotalCount();
	
	
	public List<ClassBean> selectConClassList(ClassBean bean);
	
	public List<ClassBean> selectCustomerPurchaseList(PurchaseBean pBean) throws Exception;
}
