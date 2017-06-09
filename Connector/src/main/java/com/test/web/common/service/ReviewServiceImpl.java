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
	
//	@Override
//	public int insertBoardAttach(BoardBean bBean, BoardAttachBean baBean, String upPath) {
//		
//		//TODO 테스트 데이터
//		bBean.setMemberId("b");
//		
//		int resVal1 = boardDao.insertBoard(bBean);
//		
//		if(resVal1 <= 0) return 0; //insert실패
//		
//		
//		for(int i=0; i<baBean.getUpFile().length; i++) {
//			
//			MultipartFile file = baBean.getUpFile()[i];
//			String fileName = "";
//			try {
//				fileName = Util.uploadFileMng(file, upPath);
//			} catch(Exception e) {
//				e.printStackTrace();
//			}
//			//insert
//			BoardAttachBean inBean = new BoardAttachBean();
//			inBean.setBoardNo( bBean.getNo() );
//			inBean.setAttachType( Constants.FILE_TYPE_BOARD );
//			inBean.setFileName( fileName );
//			//DB
//			boardAttachDao.insertBoardAttach(inBean);
//		}
//		
//		return resVal1;
//	}
	
}
