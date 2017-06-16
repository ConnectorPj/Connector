package com.test.web.common.service;

import java.io.Console;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.ReviewBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

	// @Autowired
	// private BoardDao boardDao;
	@Autowired
	private ReviewDAO reviewDao;
	@Autowired
	private PhotoDAO photoDAO;
	@Autowired
	private ClassDAO classDAO;
	// @Autowired
	// private AttachDao boardAttachDao;

	// @Override
	// public BoardBean selectBoard(BoardBean bean) {
	// return boardDao.selectBoard(bean);
	// }

	@Override
	public List<ReviewBean> selectReviewListAll(ReviewBean bean) {
		return reviewDao.selectReviewListAll(bean);
	}

	@Override
	public List<ReviewBean> selectReviewList(ReviewBean bean) {
		return reviewDao.selectReviewList(bean);
	}

	@Override
	public Map<String, Object> selectReviewInfo(ReviewBean rBean) {
		List<ReviewBean> listAll = selectReviewListAll(rBean);
		List<ReviewBean> list = selectReviewList(rBean);

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("reviewListAll", listAll);
		resMap.put("reviewList", list);

		return resMap;
	}

	@Override
	public int insertReviewAttach(ReviewBean rBean) {

		PhotoBean photoBean = new PhotoBean();
		ClassBean cBean = new ClassBean();
		// 학생 사진 넣기(Realreview안에)
		photoBean.setMemberId(rBean.getCustomerId());
		cBean.setStudyId(rBean.getStudyId());
		cBean = classDAO.selectClass(cBean);
		rBean.setStudyProgressname(cBean.getStudyProgressName());

		try {
			photoBean = photoDAO.selectPhoto(photoBean);
			rBean.setCustomerPicture(photoBean.getPhotoFileName());
		} catch (NullPointerException e) {
			System.out.println("사진이 없는 계정");
		}
		// 강사 사진 넣기(Realreview안에)
		photoBean.setMemberId(rBean.getTeacherId());

		try {
			photoBean = photoDAO.selectPhoto(photoBean);
			rBean.setTeacherPicture(photoBean.getPhotoFileName());
		} catch (NullPointerException e) {
			System.out.println("사진이 없는 계정");
		}

		int resVal1 = reviewDao.insertReview(rBean);

		if (resVal1 <= 0)
			return 0; // insert실패

		return resVal1;
	}

	@Override
	public List<ReviewBean> selectDetailListAll(ReviewBean bean) {
		return reviewDao.selectDetailListAll(bean);
	}

	@Override
	public List<ReviewBean> selectDetailList(ReviewBean bean) {
		return reviewDao.selectDetailList(bean);
	}

	@Override
	public Map<String, Object> selectDetailInfo(ReviewBean rBean) {
		List<ReviewBean> listAll = selectDetailListAll(rBean);
		List<ReviewBean> list = selectDetailList(rBean);

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("detailListAll", listAll);
		resMap.put("detailList", list);

		return resMap;
	}
}
