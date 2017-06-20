package com.test.web.android.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.PurchaseDAO;
import com.test.web.common.dao.TeacherDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AndroidController {

	// 파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;

	@Autowired
	private CustomerDAO customerDAO;
	
	@Autowired
	private PurchaseDAO purchaseDAO;
	
	@Autowired
	private TeacherDAO teacherDao;

	@Autowired
	private PhotoDAO photoDao;

	@Autowired
	private ClassDAO classDao;

	@RequestMapping("/androidProfile")
	@ResponseBody
	public Map<String, Object> androidProfile(HttpServletRequest request) {
		
		System.out.println(request.getParameter("user"));
		Gson gson = new Gson();
		CustomerBean customerBean = gson.fromJson(request.getParameter("user"), CustomerBean.class);
		System.out.println(customerBean.getCustomerId());
		
		customerBean = customerDAO.selectCustomer(customerBean);
		
		Map<String, Object> result = new HashMap<>();
		result.put("customerName",customerBean.getCustomerName());
		result.put("customerCellphone",customerBean.getCustomerCellphone());
		result.put("customerProfile",customerBean.getCustomerProfile());
		result.put("customerGender",customerBean.getCustomerGender());
		
		return result;
	}
	
}
