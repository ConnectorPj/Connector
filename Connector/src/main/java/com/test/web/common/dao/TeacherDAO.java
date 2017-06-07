package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.TeacherBean;

public interface TeacherDAO {

	public TeacherBean selectTeacher(TeacherBean bean);

	public List<TeacherBean> selectTeacherList(TeacherBean bean);

	public int insertTeacher(TeacherBean bean);

	public int updateTeacher(TeacherBean bean);

	public int deleteTeacher(TeacherBean bean) throws Exception;
	
}
