package com.test.web.common.service;

import java.util.List;
import java.util.Map;

import com.test.web.common.bean.ReviewBean;

public interface ReviewService {

	// // 게시글 1건 조회
	// public BoardBean selectBoard(BoardBean bean);

	// 댓글 전체 목록 조회
	public List<ReviewBean> selectReviewListAll(ReviewBean bean);

	// 댓글 목록 조회
	public List<ReviewBean> selectReviewList(ReviewBean bean);

	// 게시글과 댓글목록을 한꺼번에 조회하는 처리
	public Map<String, Object> selectReviewInfo(ReviewBean rBean);

	// 게시글과 파일의 정보를 한꺼번에 insert처리
	public int insertReviewAttach(ReviewBean rBean);

	// 댓글 전체 목록 조회
	public List<ReviewBean> selectDetailListAll(ReviewBean bean);

	// 댓글 목록 조회
	public List<ReviewBean> selectDetailList(ReviewBean bean);

	// 게시글과 댓글목록을 한꺼번에 조회하는 처리
	public Map<String, Object> selectDetailInfo(ReviewBean rBean);
}
