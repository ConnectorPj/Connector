package com.test.web.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.web.common.Constants;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.util.Util;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private TeacherDAO teacherDao;
	
	@Autowired
	private PhotoDAO photoDao;

	@Override
	public int insertBoardAttach(TeacherBean tBean, PhotoBean pBean, String upPath) {
		
		int resVal1 = teacherDao.insertTeacher(tBean);
		
		if(resVal1 <= 0) return 0; //insert실패
		
		
		for(int i=0; i<pBean.getUpFile().length; i++) {
			
			MultipartFile file = pBean.getUpFile()[i];
			String fileName = "";
			try {
				fileName = Util.uploadFileMng(file, upPath);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			//insert
			PhotoBean inBean = new PhotoBean();
			inBean.setPhotoSort(Constants.FILE_TYPE_BOARD );
			inBean.setPhotoFileName(fileName );
			
			//DB
			photoDao.insertPhoto(inBean);
		}
		
		return resVal1;
	}

}
