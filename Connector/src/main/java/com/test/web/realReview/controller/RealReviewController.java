package  com.test.web.realReview.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.ReviewBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.service.ReviewService;
import com.test.web.common.service.TeacherService;

@Controller
public class RealReviewController {

	@Autowired
	private ReviewService reviewService;

	@RequestMapping("/realreview")
	public String realreview() {
		return "realReview";
	}

	@RequestMapping("/realReviewProc")
	@ResponseBody
	public Map<String, Object> realreviewProc(ReviewBean rBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 상세보기 조회 실패");

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

	@RequestMapping("/realReviewInsertProc")
	@ResponseBody
	public Map<String, Object> realReviewInsertProc(
			ReviewBean rBean, HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "리뷰 작성 실패");

		try {
			//로그인 정보 가져오기
			CustomerBean cBean = (CustomerBean)req.getSession()
					.getAttribute(Constants.MEMBER_LOGIN_BEAN);

			if(cBean != null) {
				rBean.setCustomerId( cBean.getCustomerId() );
				rBean.setCustomerName(cBean.getCustomerName());
			}

			int res = reviewService.insertReviewAttach(rBean);

			if(res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "리뷰 작성 성공");
			}

		} catch(Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}
}
