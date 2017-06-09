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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.BusketBean;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.dao.BuscketDAO;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.dao.ReviewDAO;


@Controller
public class DetailController {

	@Autowired
	ClassDAO classDao;
	@Autowired
	TeacherDAO teacherDao;
	@Autowired
	ReviewDAO reviewDao;
	
	@Autowired
	PhotoDAO photoDao;
	
	@Autowired
	BuscketDAO busketDao;


	@RequestMapping("/detail")
	public String detail(Model model, ClassBean cBean) {
		ClassBean selBean = classDao.selectClass(cBean);
		model.addAttribute("ClassBean",selBean);
		
		String location[] = selBean.getStudyLocation().split(",");
		model.addAttribute("Alt",location[0]);
		model.addAttribute("Att",location[1]);
		
		int diff = dayCal(selBean.getStudyStartDate(), selBean.getStudyEndDate());
		model.addAttribute("diff",diff);
		
		
		// photoBean 생성
		PhotoBean photoBean = new PhotoBean();
		photoBean.setMemberId(cBean.getStudyId());
		
		photoBean = photoDao.selectPhoto(photoBean);
		model.addAttribute("photoBean",photoBean);
		
//		photoBean
		/*
		TeacherBean bean = new TeacherBean();
		bean.setTeacherId(selBean.getTeacherId());
		
		bean = teacherDao.selectTeacher(bean);
		model.addAttribute("teacher",bean);
		
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
	         
	        // 占시곤옙占쏙옙占싱몌옙 占시곤옙,占쏙옙,占십몌옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占싹뤄옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
	        long diff = endDate.getTime() - beginDate.getTime();
	        long diffDays = diff / (24 * 60 * 60 * 1000);
	        
	        return (int)diffDays / 7;
	 
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }

		return 0;
	}
	
	@RequestMapping("/updateBusket")
	@ResponseBody
	public Map<String, Object> updateBusket(BusketBean bBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "데이터 통신 실패");
		
		System.out.println(bBean.getCustomerId());
		System.out.println(bBean.getStudyId());

		try {
			BusketBean sBean = busketDao.selectBucket(bBean);
			if(sBean == null){
			busketDao.insertBucket(bBean);
			}else{
				busketDao.deleteBucket(bBean);
			}
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "데이터 통신 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}
	
	@RequestMapping("/selectClassListAjax")
	@ResponseBody
	public Map<String, Object> selectClassListAjax(ClassBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "�쉶�썝 由ъ뒪�듃 議고쉶�뿉 �떎�뙣 �븯���뒿�땲�떎.");

		try {
			// int totRecord = memberService.selectMemberListTotalCount();
			// pagingBean.calcPage(totRecord);

			List<ClassBean> list = classDao.selectClassListAll(bean, pagingBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pagingBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "�쉶�썝 由ъ뒪�듃 議고쉶�뿉 �꽦怨� �븯���뒿�땲�떎.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}
}


