/**
 * 
 */
/**
 * @author park deok hwan
 *
 */
package com.test.web.classDetail.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.bean.ReviewBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.dao.reviewDAO;


@Controller
public class DetailController {

	@Autowired
	ClassDAO classDao;
	@Autowired
	TeacherDAO teacherDao;
	@Autowired
	reviewDAO reviewDao;

	//	@Autowired
	//	TeacherDAO teacherDao;
	//	
	//	@Autowired
	//	reviewDAO reviewDao;



	@RequestMapping("/detail")
	public String detail(Model model, ClassBean cBean) {
		ClassBean selBean = classDao.selectClass(cBean);
		model.addAttribute("ClassBean",selBean);
		
		String location[] = selBean.getStudyLocation().split(",");
		model.addAttribute("Alt",location[0]);
		model.addAttribute("Att",location[1]);
		
		// ��¥ ���
		int diff = dayCal(selBean.getStudyStartDate(), selBean.getStudyEndDate());
		model.addAttribute("diff",diff);
		
		
		/*// ���� ����
		TeacherBean bean = new TeacherBean();
		bean.setTeacherId(selBean.getTeacherId());
		
		bean = teacherDao.selectTeacher(bean);
		model.addAttribute("teacher",bean);
		
		// �ı� ����Ʈ ��ȯ
		reviewBean rBean = new reviewBean();
		rBean.setStudyId(selBean.getStudyId());
		
		model.addAttribute("reviewList",reviewDao.selectReviewList(rBean));*/
		
		return "classDetail";
	}
	int dayCal(String str, String str1){
	    try {
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	        Date beginDate = formatter.parse(str);
	        Date endDate = formatter.parse(str1);
	         
	        // �ð����̸� �ð�,��,�ʸ� ���� ������ ������ �Ϸ� ������ ����
	        long diff = endDate.getTime() - beginDate.getTime();
	        long diffDays = diff / (24 * 60 * 60 * 1000);
	        
	        return (int)diffDays / 7;
	 
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }

		return 0;
	}
}


