package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.PhotoBean;

public interface PhotoDAO {
	
	public PhotoBean selectPhoto(PhotoBean bean);
	
	public List<PhotoBean> selectPhotoList(PhotoBean bean);
	
	public int insertPhoto(PhotoBean bean);
	
	public int updatePhoto(PhotoBean bean);
	
	public int deletePhoto(PhotoBean bean) throws Exception;
	
}