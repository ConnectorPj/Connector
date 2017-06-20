package com.test.web.android.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.PurchaseDAO;
import com.test.web.common.dao.TeacherDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AndroidController {

   // 파일 업로드 저장경로
   @Value("#{config['file.upload.path']}")
   private String FILE_UPLOAD_PATH;

   @Autowired
   private CustomerDAO customerDAO;
   
   @Autowired
   private PurchaseDAO purchaseDAO;
   
   @Autowired
   private TeacherDAO teacherDAO;

   @Autowired
   private PhotoDAO photoDAO;

   @Autowired
   private ClassDAO classDAO;

   @RequestMapping("/androidProfile")
   @ResponseBody
   public Map<String, Object> androidProfile(HttpServletRequest request) {
      
      System.out.println(request.getParameter("user"));
      CustomerBean customerBean = new CustomerBean();
      PhotoBean photoBean = new PhotoBean();
      customerBean.setCustomerId(request.getParameter("userId"));
      photoBean.setMemberId(request.getParameter("userId"));
      System.out.println(request.getParameter("userId"));
      
      photoBean = photoDAO.selectPhoto(photoBean);
      customerBean = customerDAO.selectCustomer(customerBean);
      Map<String, Object> result = new HashMap<>();
      if(customerBean == null) {
         TeacherBean teacherBean = new TeacherBean();
         teacherBean.setTeacherId(request.getParameter("userId"));
         teacherBean = teacherDAO.selectTeacher(teacherBean);
         
         result.put("userName",teacherBean.getTeacherName());
         result.put("userCellphone",teacherBean.getTeacherCellphone());
         result.put("userProfile",teacherBean.getTeacherInfo());
         result.put("userGender",teacherBean.getTeacherGender());
         
      }else{
         result.put("userName",customerBean.getCustomerName());
         result.put("userCellphone",customerBean.getCustomerCellphone());
         result.put("userProfile",customerBean.getCustomerProfile());
         result.put("userGender",customerBean.getCustomerGender());
      }
      
      result.put("photoFileName",photoBean.getPhotoFileName());
      
      return result;
   }
   
}