package com.test.web.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.web.common.Constants;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.util.Util;

@Service
public class TeacherServiceImpl implements TeacherService {

	@Autowired
	private PhotoDAO photoDao;
	@Autowired
	private TeacherDAO teacherDao;

	@Autowired
	private ClassDAO classDao;

	@Autowired
	private CustomerDAO customerDao;

	@Override
	public TeacherBean selectTeacher(TeacherBean bean) throws Exception {
		return teacherDao.selectTeacher(bean);
	}

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	@Override
	public int selectTeacherListTotalCount(PagingBean pBean) {
		return teacherDao.selectTeacherListTotalCount();
	}

	@Override
	public int insertTeacher(TeacherBean bean) throws Exception {
		int res = teacherDao.insertTeacher(bean);
		System.out.println(res);
		return res;
	}

	@Override
	public int updateTeacher(TeacherBean bean) throws Exception {
		return teacherDao.updateTeacher(bean);
	}

	@Override
	public int deleteTeacher(TeacherBean bean) throws Exception {
		return teacherDao.deleteTeacher(bean);
	}

	/** 회원 아이디 중복 체크 */
	public int teacherCheckId(TeacherBean bean) throws Exception {
		return teacherDao.teacherCheckId(bean);
	}

	@Override
	public int insertTeacherAttach(TeacherBean tBean, PhotoBean pBean, String upPath) {

		int resVal1 = teacherDao.updateTeacher(tBean);

		if (resVal1 <= 0)
			return 0; // update

		for (int i = 0; i < pBean.getUpFile().length; i++) {

			MultipartFile file = pBean.getUpFile()[i];
			String fileName = "";

			try {
				fileName = Util.uploadFileMng(file, upPath);
			} catch (Exception e) {
				e.printStackTrace();
			}

			PhotoBean inBean = new PhotoBean();
			inBean.setMemberId(tBean.getTeacherId());

			try {
				photoDao.deletePhoto(inBean);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// insert
			inBean.setPhotoSort(Constants.FILE_TYPE_BOARD);
			inBean.setPhotoFileName("/upFile/" + fileName);

			// DB
			photoDao.insertPhoto(inBean);

		}

		return resVal1;
	}

	@Override
	public List<TeacherBean> selectTeacherList(TeacherBean bean, PagingBean pBean) throws Exception {
		return teacherDao.selectTeacherList(bean, pBean);
	}

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	@Override
	public int selectTeacherListTotalCount(TeacherBean bean, PagingBean pBean) {
		return teacherDao.selectTeacherListTotalCount();
	}

	@Override
	public int selectClassListTotalCount(ClassBean bean, PagingBean pBean) {
		return classDao.selectClassListTotalCount();
	}

	@Override
	public int selectCustomerListTotalCount(CustomerBean bean, PagingBean pBean) {
		return customerDao.selectCustomerListTotalCount();
	}

}
