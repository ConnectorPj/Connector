//package com.test.web.common;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import com.test.web.common.bean.CustomerBean;
//
//public class SessionInterceptor extends HandlerInterceptorAdapter {
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception 
//	{
//		if( request.getSession().getAttribute(Constants.MEMBER_LOGIN_BEAN) != null ) return true;
//		
//		response.sendRedirect("/main.do");
//		
//		return false;
//	}
//	
//}
