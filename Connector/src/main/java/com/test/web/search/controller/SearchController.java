package  com.test.web.search.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.dao.ClassDAO;

@Controller
public class SearchController {
	@Autowired
	ClassDAO classDao;



	@RequestMapping("/search")
	public String Search(Model model) {

		List<ClassBean> classList = classDao.selectClassList();

		model.addAttribute("classList", classList);

		return "/search";
	}

	//게시글 상세보기 AJAX
	@RequestMapping("/searchAjax")
	@ResponseBody
	public Map<String, Object> searchAjax(ClassBean cBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "class 정보 출력 실패");

		try {
			//게시글 통합조회(댓글 목록까지 조회)
			List<ClassBean> classList = classDao.selectClassList();

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "게시글 상세보기 조회 성공");
			resMap.put("classList", classList);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}


}
