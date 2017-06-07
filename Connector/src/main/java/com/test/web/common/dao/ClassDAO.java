package com.test.web.common.dao;


import java.util.List;

import com.test.web.common.bean.ClassBean;

public interface ClassDAO {

	public ClassBean selectClass(ClassBean bean); //덕환
	public int insertClass(ClassBean bean);
	public int updateClass(ClassBean bean);
	public int deleteClass(ClassBean bean) throws Exception;
	
	/** 수엽 내용를 조회해서 리스트로 가져온다. **/
	public List<ClassBean> selectClassList();

}
