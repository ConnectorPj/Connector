package com.test.web.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PurchaseBean;

public interface CustomerDAO {

	public CustomerBean selectCustomer(CustomerBean bean);

	/** 회원정보를 조회해서 리스트로 가져온다. **/
	public List<CustomerBean> selectCustomerList(
			@Param("customerBean") CustomerBean bean,
			@Param("pagingBean") PagingBean pBean);

	public int insertCustomer(CustomerBean bean);

	public int updateCustomer(CustomerBean bean);

	public int deleteCustomer(CustomerBean bean) throws Exception;

	public int customerCheckId(CustomerBean bean);
	

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectCustomerListTotalCount();

/** 개인별 구매 내역 조회 */
	public List<CustomerBean> selectStudyMember(PurchaseBean pBean) throws Exception;

}
