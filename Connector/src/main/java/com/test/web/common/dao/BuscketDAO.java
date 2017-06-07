package com.test.web.common.dao;

import java.util.List;

import com.test.web.common.bean.BusketBean;

public interface BuscketDAO {
	
	public BusketBean selectBucket(BusketBean bean);

	public List<BusketBean> selectBucketList(BusketBean bean);

	public int insertBucket(BusketBean bean);

	public int updateBucket(BusketBean bean);

	public int deleteBucket(BusketBean bean) throws Exception;
	
}
