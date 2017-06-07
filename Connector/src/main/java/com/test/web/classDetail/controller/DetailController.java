/**
 * 
 */
/**
 * @author park deok hwan
 *
 */
package com.test.web.classDetail.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.web.common.bean.ClassBean;
import com.test.web.common.dao.ClassDAO;


@Controller
public class DetailController {

	@Autowired
	ClassDAO classDao;

	//	@Autowired
	//	TeacherDAO teacherDao;
	//	
	//	@Autowired
	//	reviewDAO reviewDao;



	@RequestMapping("/detail")
	public String detail(Model model, ClassBean cBean) {

		

		return "classDetail";
	}

}
