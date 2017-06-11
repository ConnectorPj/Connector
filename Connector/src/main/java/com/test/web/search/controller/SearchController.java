package  com.test.web.search.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.dao.ClassDAO;

@Controller
public class SearchController {
	@Autowired
	ClassDAO classDao;
	@RequestMapping("/search")
	public String Search(Model model, ClassBean cBean) {
		
		List<ClassBean> classList = classDao.selectClassList();
		model.addAttribute("classList", classList);
		model.addAttribute("cBean",cBean);

		return "/search";
	}
	@RequestMapping("/searchDetail")
	public String searchDetail(Model model, ClassBean cBean) {
		
		List<ClassBean> classList = classDao.selectClassList();
		model.addAttribute("classList", classList);
		model.addAttribute("cBean",cBean);

		return "/search";
	}

	@RequestMapping("/searchAjax")
	@ResponseBody
	public Map<String, Object> searchAjax() {

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

	@RequestMapping("/searchListAjax")
	@ResponseBody
	public Map<String, Object> searchListAjax(ClassBean cBean)
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		List<ClassBean> classList = new ArrayList<>() ;
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "class 실패");

		// str = 1 , web, 
		// str = 2 , mobile 
		// str = 3 , system 
		// str = 4 , iot

		if ( cBean.getStudyProgressName().equals("0")){ cBean.setStudyProgressName("0");}
		if ( cBean.getStudyProgressName().equals("1")){ cBean.setStudyProgressName("WEB");}
		if ( cBean.getStudyProgressName().equals("2")){ cBean.setStudyProgressName("MOBILE");}
		if ( cBean.getStudyProgressName().equals("3")){ cBean.setStudyProgressName("SYSTEM");}
		if ( cBean.getStudyProgressName().equals("4")){ cBean.setStudyProgressName("IOT");}

		if(cBean.getStudyProgressName().equals("0") ){
			try {
				classList =  classDao.selectClassList();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}else{
			classList =  classDao.selectConClassList(cBean);
		}
		
		resMap.put(Constants.RESULT, Constants.RESULT_OK);
		resMap.put(Constants.RESULT_MSG, "성공");
		
		resMap.put("classList", classList);
		
		return resMap;
	}


}
