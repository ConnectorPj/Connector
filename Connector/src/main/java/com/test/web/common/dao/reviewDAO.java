package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.ReviewBean;

public interface reviewDAO {
public ReviewBean selectReview(ReviewBean bean);
	
	public List<ReviewBean> selectReviewList(ReviewBean bean);
	
	public int insertReview(ReviewBean bean);
	
	public int updateReview(ReviewBean bean);
	
	public int deleteReview(ReviewBean bean);
}
