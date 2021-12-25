<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-注册</title>
	<link rel="stylesheet" type="text/css" href="../css/reset.css">
	<link rel="stylesheet" type="text/css" href="../css/main.css">
	<script type="text/javascript" src="../js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="../js/register.js"></script>
</head>
<body>
	<div class="register_con">
		<div class="l_con fl">
			<a class="reg_logo"><img src="../images/logo02.png"></a>
			<div class="reg_slogan">校园二手 · 为你所有</div>
			<div class="reg_banner"></div>
		</div>

		<div class="r_con fr">
			<div class="reg_title clearfix">
				<h1>用户注册</h1>
				<a href="login.jsp">登录</a>
			</div>
			<div class="reg_form clearfix">
				<form>
				<ul>
					<li>
						<label>用户名:</label>
						<input type="text" name="user_account" id="user_account">
						<span class="error_tip">提示信息</span>
					</li>		
					<li>
						<label>姓名:</label>
						<input type="text" name="user_name" id="user_name">
						<span class="error_tip">提示信息</span>
					</li>				
					<li>
						<label>密码:</label>
						<input type="password" name="pwd" id="pwd">
						<span class="error_tip">提示信息</span>
					</li>
					<li>
						<label>确认密码:</label>
						<input type="password" name="cpwd" id="cpwd">
						<span class="error_tip">提示信息</span>
					</li>
				
					<li class="reg_sub">
						<input type="submit" value="注 册" name="">
					</li>
				</ul>				
				</form>
			</div>

		</div>

	</div>


	
</body>
</html>