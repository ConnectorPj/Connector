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

	@RequestMapping("/searchAjax")
	@ResponseBody
	public Map<String, Object> searchAjax(ClassBean cBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "class 실패");

		try {
			List<ClassBean> classList = classDao.selectClassList();

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "성공");
			resMap.put("classList", classList);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}


}
