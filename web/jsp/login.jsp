<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-登录</title>
	<link rel="stylesheet" type="text/css" href="../css/reset.css">
	<link rel="stylesheet" type="text/css" href="../css/main.css">
	<%@ include file="commonhead.jsp"%>
</head>
<body>
	<div class="login_top clearfix">
		<a class="login_logo"><img src="../images/logo02.png"></a>	
	</div>

	<div class="login_form_bg">
		<div class="login_form_wrap clearfix">
			<div class="login_banner fl"></div>
			<div class="slogan fl">校园二手 · 为你所有</div>
			<div class="login_form fr">
				<div class="login_title clearfix">
					<h1>用户登录</h1>
					<a href="regist.jsp">立即注册</a>
				</div>
				<div class="form_input">
					<form>
						<input type="text" id="username" class="name_input" placeholder="请输入用户名">
						<div class="user_error">输入错误</div>
						<input type="password" id="pwd" class="pass_input" placeholder="请输入密码">
						<div class="pwd_error">输入错误</div>
						
						<input type="button" name="" value="登录" class="input_submit" id="btn">
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$("#btn").click(function(event) {
				var username = $('#username').val();
				var password = $('#pwd').val();
				if (!username) {
					layer.alert('用户名不能为空');
					return;
				}
				if (!password) {
					layer.alert('密码不能为空');
					return;
				}
				var url = '${base}/user/login.do';
				var data = {
					account : username,
					password : password,
				};
				var index = layer.load(1);
				$.post(url, data, function(result) {
					if (result.code == 0) {
						if (result.data.type == 0) {//管理员
							window.location.href = '${base}/jsp/index.jsp';
						} else if (result.data.type == 1) {//用户
							window.location.href = '${base}/jsp/index2.jsp';
						}

					} else {
						layer.alert(result.msg);
					}

				}, 'json').always(function() {
					//关闭弹层
					layer.close(index);
				});

			});

		});
	</script>
	
</body>
</html>
