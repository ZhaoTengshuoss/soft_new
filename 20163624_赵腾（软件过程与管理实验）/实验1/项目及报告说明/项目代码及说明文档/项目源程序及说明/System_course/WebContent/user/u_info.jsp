<%@page import="java.util.List"%>
<%@page import="oracle.UserException"%>
<%@page import="Dao.UserDaoImpl"%>
<%@page import="model.User"%>
<%@ page import="oracle.ValidateUtil" %>
<%@page import="Dao.IUserDao"%>
<%@page import="oracle.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息</title>
<link href="css/style2.css" rel="stylesheet" type="text/css"/>
<link href="css/font-awesome-4.7.0" rel="stylesheet" type="text/css"/>
<link href="css/layui/css/layui.css" rel="stylesheet"  media="all">
</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin" >
  <div class="layui-header" style="height:60px">
    <div class="layui-logo" style="font-size:20px">课程信息管理系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a style="font-size:20px" href="info.jsp">首页</a></li>
       <li class="layui-nav-item"><a style="font-size:20px" href="course.jsp">课程信息</a></li>
       <li class="layui-nav-item"><a style="font-size:20px" href="s_info.jsp">学生信息</a></li>
       <li class="layui-nav-item"><a style="font-size:20px" href="teacher.jsp">老师信息</a></li>
        <li class="layui-nav-item"><a style="font-size:20px" href="u_info.jsp">用户信息</a></li>
    </ul> 
   
    <ul class="layui-nav layui-layout-right">
      <!-- <li class="layui-nav-item">
       <li  style="float:right" class="layui-nav-item">
    <a href="" style="font-size:20px">个人中心<span class="layui-badge-dot"></span></a>
  </li> -->
   <li  style="float:right"class="layui-nav-item" lay-unselect="">
    <a href="javascript:;" style="font-size:20px"><img src="../images/person.jpg" class="layui-nav-img">个人中心</a>
    <dl class="layui-nav-child">
      <dd><a href="myself.jsp" style="font-size:20px">修改资料</a></dd>
      <dd><a href="Loginout.jsp" style="font-size:20px">退出登录</a></dd>
       </dl>
       </li>
       </ul>
        </div>
 <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll" >
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree" lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;" style="height:50px;font-size:20px;">课程信息操作</a>
          <dl class="layui-nav-child">
            <dd><a href="course.jsp" style="height:50px;font-size:20px;">课程信息查看</a></dd>
          </dl>
        </li>
        <!-- <li class="layui-nav-item"><a href="">云市场</a></li> -->
      </ul>
    </div>
  </div>
   
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>用户信息</legend>
    </fieldset>
<%
    //筛选
   String content = request.getParameter("content");
    if(content==null||"".equals(content))
    {
    	content = "";
    } 
	UserDaoImpl userDao = new UserDaoImpl();
	 List<User> users = userDao.load4(content); 
	
	
%>
<form action="u_info.jsp"  method="get">
 <div class="my-btn-box" style="margin:10px 10px 10px 10px">
    <span style="float:left;">
        <a class="layui-btn btn-add btn-default" id="btn-add" href="add_u.jsp">添加新用户</a> 
    </span>
    <span style="float:right">
        <span class="layui-form-label">搜索条件：</span>
        <div class="layui-input-inline">
            <input type="text" autocomplete="off" placeholder="请输入用户名" class="layui-input" name="content">
        </div>
        <button class="layui-btn mgl-20" type="submit">查询</button>
    </span>  
</div>
</form>
 <div style="margin-left:50px;margin-right:30px;margin-top:100px;font-size:50px"> 
       <table class="layui-table">
			<thead>
			<tr>
			<th style="font-size:30px;text-align:center;">用户id</th>
			<th style="font-size:30px;text-align:center;">用户名</th>
			<th style="font-size:30px;text-align:center;">用户密码</th>
			<th style="font-size:30px;text-align:center;">用户类型</th>
			<th colspan="3" style="font-size:30px;text-align:center;">操作</th>
		</tr>
		</thead>
		<%
			for( User user : users ){
				
		%>
		<tr>
			<td style="font-size:30px;text-align:center;"><%=user.getId() %></td>
			<td style="font-size:30px;text-align:center;"><%=user.getUsername() %></td>
			<td style="font-size:30px;text-align:center;"><%=user.getPassword() %></td>
			
			<%
			if(user.getU_type()==1)
			{
			
			%>
			<td style="font-size:30px;text-align:center;">学生</td>
			<td style="text-align:center"> <a href="delete_u.jsp?u_id=<%=user.getId() %>&type=<%=user.getU_type()%>&username=<%=user.getUsername() %>"><span style="color:blue;font-size:30px;">删除</span></a></td>
			<td style="text-align:center"> <a href="updateInput_u.jsp?u_id=<%=user.getId()%>"><span style="color:blue;font-size:30px;">修改</span></a></td>
			<td style="text-align:center"> <a href="show_info2.jsp?username=<%=user.getUsername() %>&type=<%=user.getU_type()%>"><span style="color:blue;font-size:30px;">查看详细信息</span></a></td>
			<%}else if(user.getU_type()==2){ %>
			<td style="font-size:30px;text-align:center;">老师</td>
			<td style="text-align:center"> <a href="delete_u.jsp?u_id=<%=user.getId() %>&type=<%=user.getU_type()%>&username=<%=user.getUsername() %>"><span style="color:blue;font-size:30px;">删除</span></a></td>
			<td style="text-align:center"> <a href="updateInput_u.jsp?u_id=<%=user.getId()%>"><span style="color:blue;font-size:30px;">修改</span></a></td>
			<td style="text-align:center"> <a href="show_info.jsp?username=<%=user.getUsername() %>&type=<%=user.getU_type()%>"><span style="color:blue;font-size:30px;">查看详细信息</span></a></td>
			<%}else{ %>
			<td style="font-size:30px;text-align:center;">管理员</td>
			<td colspan="1" style="text-align:center"> <a href="delete_u.jsp?u_id=<%=user.getId() %>&type=<%=user.getU_type()%>&username=<%=user.getUsername() %>"><span style="color:blue;font-size:30px;">删除</span></a></td>
			<td colspan="2" style="text-align:center"> <a href="updateInput_u.jsp?u_id=<%=user.getId()%>"><span style="color:blue;font-size:30px;">修改</span></a></td>
			<%} %>
			
		</tr>
		<%
			}                                                 
		%>
	</table>
</div>

 
  <div class="layui-footer">
  <p style="text-align:center"> &copy;&nbsp;软件工程 某某学生制作&nbsp;|&nbsp;<a href="#" style="font-size:16px; color:red">联系管理员</a></p>
  </div>
</div>

<script src="css/layui/layui.js"></script>
<script>
layui.use('element', function(){
  var element = layui.element(); //导航的hover效果、二级菜单等功能，需要依赖element模块
  
  //监听导航点击
  element.on('nav(demo)', function(elem){
    //console.log(elem)
    layer.msg(elem.text());
  });
});
</script>
</body>
</html>