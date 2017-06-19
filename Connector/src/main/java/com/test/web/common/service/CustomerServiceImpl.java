package com.test.web.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.web.common.Constants;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean10;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.PurchaseBean;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.util.Util;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerDAO customerDao;

	@Autowired
	private PhotoDAO photoDao;

	@Override
	public CustomerBean selectCustomer(CustomerBean bean) throws Exception {
		return customerDao.selectCustomer(bean);
	}

	@Override
	public List<CustomerBean> selectCustomerList(CustomerBean bean, PagingBean10 pBean) throws Exception {
		return customerDao.selectCustomerList(bean, pBean);
	}

	/** 개인별 구매 내역 조회 */
	public List<CustomerBean> selectStudyMember(PurchaseBean pBean) throws Exception{
		return customerDao.selectStudyMember(pBean);

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

	/** customer 와 photo 정보를 한꺼번에 insert 처리 **/
	@Override
	public int insertCustomerAttach(CustomerBean cBean, PhotoBean pBean, String upPath) {

		int resVal1 = customerDao.updateCustomer(cBean);

		if (resVal1 <= 0)
			return 0; // update

		if (pBean != null) {

			for (int i = 0; i < pBean.getUpFile().length; i++) {

				MultipartFile file = pBean.getUpFile()[i];
				String fileName = "";

				try {
					fileName = Util.uploadFileMng(file, upPath);
				} catch (Exception e) {
					e.printStackTrace();
				}

				PhotoBean inBean = new PhotoBean();
				inBean.setMemberId(cBean.getCustomerId());

				try {
					photoDao.deletePhoto(inBean);
				} catch (Exception e) {
					e.printStackTrace();
				}

				// insert
				inBean.setPhotoSort(Constants.FILE_TYPE_BOARD);
				inBean.setPhotoFileName("/upFile/" + fileName);

				// DB
				photoDao.insertPhoto(inBean);
			}
		}
		return resVal1;
	}

}
