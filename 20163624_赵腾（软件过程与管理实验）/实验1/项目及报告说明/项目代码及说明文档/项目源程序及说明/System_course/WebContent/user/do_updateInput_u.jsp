<%@page import="oracle.DaoFactory"%>
<%@page import="Dao.IUserDao"%>
<%@page import="model.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
    //接收客户端传递过来的参数
    int id=Integer.parseInt(request.getParameter("id"));
    String name=request.getParameter("username");
    String password=request.getParameter("password");
    boolean flag=true;
    boolean flag1=true;
     boolean flag2=true;
     IUserDao userDao=DaoFactory.getDaoImpl();
     List<User> users=userDao.find_users_u();
     User Login_user=(User)session.getAttribute("loginUser");
     User user=userDao.find_user_u(id);
     String o_username=user.getUsername();
     if(name==null||"".equals(name))
     {
    	 session.setAttribute("INFO", "姓名不可设置为空");
    	 flag1=false;
     }
     else{
    	 
    	 if(!((name.trim()==user.getUsername())))
    	 {
    		 session.setAttribute("INFO", "修改成功");
    	 }
              user.setUsername(name);
     }
     if(flag1)
     {
     if(password==null||"".equals(password))
     {
    	 session.setAttribute("INFO", "密码不可设置为空");
    	 flag2=false;
     }
     else
     {
    	 
    	 if(!(user.getPassword()==(password.trim())))
    	 {
    		 session.setAttribute("INFO", "修改成功");
    	 }
    	 user.setPassword(password);
     }
     if(flag2)
     {
     for(User user2:users)
     {
    	 if(user2.getUsername()==name)
    	 {
    		 flag=false;
    	 }
     }
     if(flag)
     {
     
     user.setPassword(password);
     user.setUsername(name);
     
     session.setAttribute("INFO", "修改成功");
     }
     else
     {
    	 if(!(user.getUsername().equals(name)))
    	 {
    	 session.setAttribute("INFO", "该姓名已存在");
    	 }
     }
     }
     }
      userDao.update_user_a(user,o_username); 
     user=userDao.find_user_u(id);
     if(Login_user.getId()==id)
     {
    	   //将查询出来的数据封装到session中
         session.setAttribute("loginUser", user); 
     }
     response.sendRedirect("./updateInput_u.jsp");
     
  	  
%>
