package com.test.web.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.BucketBean;

public interface BucketDAO {
	
	public BucketBean selectBucket(BucketBean bean);

	public List<BucketBean> selectBucketList(BucketBean bean);

	public int insertBucket(BucketBean bean);

	public int updateBucket(BucketBean bean);

	public int deleteBucket(BucketBean bean) throws Exception;
	
	public int selectBucketTotal(@Param("bucketBean") BucketBean bean);
}
