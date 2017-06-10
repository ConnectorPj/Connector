package com.test.web.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.web.common.bean.ReviewBean;
import com.test.web.common.dao.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

//	@Autowired
//	private BoardDao boardDao;
	@Autowired
	private ReviewDAO reviewDao;
//	@Autowired
//	private AttachDao boardAttachDao;
	
	
//	@Override
//	public BoardBean selectBoard(BoardBean bean) {
//		return boardDao.selectBoard(bean);
//	}

	@Override
	public List<ReviewBean> selectReviewListAll(ReviewBean bean) 
	{
		return reviewDao.selectReviewListAll(bean);
	}
	@Override
	public List<ReviewBean> selectReviewList(ReviewBean bean) 
	{
		return reviewDao.selectReviewList(bean);
	}

	@Override
	public Map<String, Object> selectReviewInfo(ReviewBean rBean) 
	{
		List<ReviewBean> listAll = selectReviewListAll(rBean);
		List<ReviewBean> list = selectReviewList(rBean);
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("reviewListAll", listAll);
		resMap.put("reviewList", list);
		
		return resMap;
	}
	
	@Override
	public int insertReviewAttach(ReviewBean rBean) {
		
		//TODO 테스트 데이터
		rBean.setCustomerId("abcde");
		rBean.setTeacherId("ffff");
		rBean.setStudyProgressname("IoT");
		rBean.setTeacherName("아무개");
		
		int resVal1 = reviewDao.insertReview(rBean);
		
		if(resVal1 <= 0) return 0; //insert실패
		
		return resVal1;
	}
	
}
