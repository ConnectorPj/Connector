package com.test.web.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.BucketBean;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PagingBean10;
import com.test.web.common.bean.PurchaseBean;

public interface ClassDAO {

	public ClassBean selectClass(ClassBean bean); // 덕환

	public int insertClass(ClassBean bean);

	public int updateClass(ClassBean bean);

	public int deleteClass(ClassBean bean) throws Exception;

	/** 수업 내용를 조회해서 리스트로 가져온다. **/
	public List<ClassBean> selectClassList();

	/** 회원정보 전체 리스트를 가져온다.(check=1) **/
	public List<ClassBean> selectClassListAll(@Param("classBean") ClassBean bean, @Param("pagingBean") PagingBean pBean)
			throws Exception;

	/** 회원정보 전체 리스트를 가져온다.(check=0) **/
	public List<ClassBean> selectClassListAllunChecked(@Param("classBean") ClassBean bean,
			@Param("pagingBean") PagingBean pBean) throws Exception;

/** 회원정보 전체 리스트를 가져온다.(check=1) classList에서 사용 **/
	public List<ClassBean> selectClassListAll2(@Param("classBean") ClassBean bean, @Param("pagingBean") PagingBean pBean)
			throws Exception;

	/** 회원정보 전체 리스트를 가져온다.(check=0) classList에서 사용 **/
	public List<ClassBean> selectClassListAllunChecked2(@Param("classBean") ClassBean bean,
			@Param("pagingBean") PagingBean pBean) throws Exception;


	/** 회원정보 전체 리스트 갯수를 가져온다.(check=1) **/
	public int selectClassListTotalCount();

	/** 회원정보 전체 리스트 갯수를 가져온다.(check=0) **/
	public int selectClassUnCheckedListTotalCount();

/** 회원정보 전체 리스트 갯수를 가져온다.(check=1)classList에서 사용 **/
	public int selectClassListTotalCount2(@Param("classBean") ClassBean bean);

	/** 회원정보 전체 리스트 갯수를 가져온다.(check=0)classList에서 사용 **/
	public int selectClassUnCheckedListTotalCount2(@Param("classBean") ClassBean bean);

	public List<ClassBean> selectConClassList(ClassBean bean);

	public List<ClassBean> selectTeacherClassList(ClassBean bean) throws Exception;

	/** 개인별 구매 내역 조회 (check=1) **/
	public List<ClassBean> selectCustomerPurchaseList(@Param("purchaseBean") PurchaseBean pBean,
			@Param("pagingBean") PagingBean paBean) throws Exception;

	/** 개인별 구매 내역 조회 (check=0) */
	public List<ClassBean> selectCustomerPurchaseUncheckList(@Param("purchaseBean") PurchaseBean purBean,
			@Param("pagingBean") PagingBean pBean) throws Exception;

	/** 구매내역 개수 조회(check=1) **/
	public int selectCustomerPurchaseListTotal(PurchaseBean pBean);

	/** 구매내역 개수 조회(check=0) **/
	public int selectCustomerPurchaseUncheckListTotal(PurchaseBean purBean);

	/** 개인별 찜목록 조회 */
	public List<ClassBean> selectBucketClassList(@Param("bucketBean") BucketBean bean, @Param("pagingBean") PagingBean10 pBean);

	/** studyList와 teacherId 매핑하여 사진 경로 가져오기 **/
	public ClassBean selectTeacherPhotoList(@Param("classBean") ClassBean bean) throws Exception;
}
