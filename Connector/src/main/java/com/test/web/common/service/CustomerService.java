package com.test.web.common.service;

import java.util.List;

import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;

public interface CustomerService {

	/** 회원정보를 조회해서 가져온다. **/
	public CustomerBean selectCustomer(CustomerBean bean) throws Exception;

	/** 회원정보를 조회해서 리스트로 가져온다. **/
	public List<CustomerBean> selectCustomerList(CustomerBean bean, PagingBean pBean) throws Exception;

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectCustomerListTotalCount();

	/** 회원정보를 삽입한다. **/
	public int insertCustomer(CustomerBean bean) throws Exception;

	/** 회원정보를 수정한다. **/
	public int updateCustomer(CustomerBean bean) throws Exception;

	public int deleteCustomer(CustomerBean bean) throws Exception;

	/** 회원 아이디 중복 체크 */
	public int customerCheckId(CustomerBean bean) throws Exception;

	/** customer 와 photo 정보를 한꺼번에 insert 처리 **/
	public int insertCustomerAttach(CustomerBean tBean, PhotoBean pBean, String upPath);
}
