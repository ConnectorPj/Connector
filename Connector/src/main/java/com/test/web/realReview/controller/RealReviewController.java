package com.test.web.realReview.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.web.common.bean.ReviewBean;
import com.test.web.common.dao.reviewDAO;

@Controller
public class RealReviewController {

	@Autowired
	reviewDAO reviewDao;

	@RequestMapping("/realreview")
	public String realreview(@RequestParam("selectLevel") String selectLevel, Model model) {

		ReviewBean bean = new ReviewBean();

		bean.setStudyProgressname("웹개발");
		List<ReviewBean> listWeb = reviewDao.selectReviewList(bean);
		bean.setStudyProgressname("모바일개발");
		List<ReviewBean> listMobile = reviewDao.selectReviewList(bean);
		bean.setStudyProgressname("시스템개발");
		List<ReviewBean> listSystem = reviewDao.selectReviewList(bean);
		bean.setStudyProgressname("IoT");
		List<ReviewBean> listIoT = reviewDao.selectReviewList(bean);

		String reviewCountWeb = listWeb.size() + "";
		model.addAttribute("reviewCountWeb", reviewCountWeb);

		String reviewCountMobile = listMobile.size() + "";
		model.addAttribute("reviewCountMobile", reviewCountMobile);

		String reviewCountSystem = listSystem.size() + "";
		model.addAttribute("reviewCountSystem", reviewCountSystem);

		String reviewCountIoT = listIoT.size() + "";
		model.addAttribute("reviewCountIoT", reviewCountIoT);
		
		
		bean.setStudyProgressname(selectLevel);

		List<ReviewBean> list = reviewDao.selectReviewList(bean);

		model.addAttribute("reviewListTitle", selectLevel);

		String reviewCount = list.size() + "";
		model.addAttribute("reviewCount", reviewCount);

		model.addAttribute("reviewList", list);

		// reviewBean bean = new reviewBean();
		// bean.setCustomerId("ttt");
		// bean.setStudyId("y");
		// bean.setReviewContent("abdc");

		// reviewDao.insertReview(bean);
		// System.out.println("!5555");

		// reviewDao.updateReview(bean);
		// reviewDao.deleteReview(bean);
		// bean.setReviewRating(4);
		// reviewDao.selectReview(bean);

		// reviewBean bean1 = reviewDao.selectReview(bean);

		return "realReview";
	}

}
