package com.test.web.common.dao;

import java.util.List;
import com.test.web.common.bean.ReviewBean;

public interface ReviewDAO {
	public ReviewBean selectReview(ReviewBean bean);

	public List<ReviewBean> selectReviewListAll(ReviewBean bean);

	public List<ReviewBean> selectReviewList(ReviewBean bean);

	public int insertReview(ReviewBean bean);

	public int updateReview(ReviewBean bean);

	public int deleteReview(ReviewBean bean);

	/** datail.do에서 사진을 사용하기 위해서 **/
	public List<ReviewBean> selectDetailListAll(ReviewBean bean);

	/** datail.do에서 사진을 사용하기 위해서 **/
	public List<ReviewBean> selectDetailList(ReviewBean bean);
}
