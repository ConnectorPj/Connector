package  com.test.web.realReview.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.ReviewBean;
import com.test.web.common.service.ReviewService;

@Controller
public class RealReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping("/realreview")
	public String realreview() {
		return "realReview";
	}
	
	@RequestMapping("/realreviewProc")
	@ResponseBody
	public Map<String, Object> realreviewProc(ReviewBean rBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 상세보기 조회 실패");
		
		System.out.println(rBean.getStartRow());
		
		try {
			//게시글 통합조회(댓글 목록까지 조회)
			resMap = reviewService.selectReviewInfo(rBean);
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "게시글 상세보기 조회 성공");
		} catch(Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}
	
	
}
