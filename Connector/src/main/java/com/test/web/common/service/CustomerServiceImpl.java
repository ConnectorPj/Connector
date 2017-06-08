package com.test.web.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.dao.CustomerDAO;

@Service
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private CustomerDAO customerDao;

	@Override
	public CustomerBean selectCustomer(CustomerBean bean) throws Exception {
		return customerDao.selectCustomer(bean);
	}

	@Override
	public List<CustomerBean> selectCustomerList(CustomerBean bean, PagingBean pBean) throws Exception  {
		return customerDao.selectCustomerList(bean, pBean);
	}

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	@Override
	public int selectCustomerListTotalCount() {
		return customerDao.selectCustomerListTotalCount();
	}
	
	@Override
	public int insertCustomer(CustomerBean bean) throws Exception {
		int res = customerDao.insertCustomer(bean);
		System.out.println(res);
		return res;
	}

	@Override
	public int updateCustomer(CustomerBean bean) throws Exception {
		return customerDao.updateCustomer(bean);
	}
	
	@Override
	public int deleteCustomer(CustomerBean bean) throws Exception {
		return customerDao.deleteCustomer(bean);
	}
	
	 /** 회원 아이디 중복 체크 */
	 public int customerCheckId(CustomerBean bean) throws Exception {
	  return customerDao.customerCheckId(bean);
	 }



}
