package com.test.web.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.TeacherBean;

public interface TeacherDAO {

	public TeacherBean selectTeacher(TeacherBean bean);

	public List<TeacherBean> selectTeacherList(TeacherBean bean, PagingBean pBean);

	public int insertTeacher(TeacherBean bean);

	public int updateTeacher(TeacherBean bean);

	public int deleteTeacher(TeacherBean bean) throws Exception;
	 public int teacherCheckId ( TeacherBean bean); 

	 
	 
		

		public int selectTeacherListTotalCount();

}
