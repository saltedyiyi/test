<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-注册</title>
	<link rel="stylesheet" type="text/css" charset="utf-8" href="../css/reset.css">
	<link rel="stylesheet" type="text/css" charset="utf-8" href="../css/main.css">
<%--	<script type="text/javascript" charset="utf-8" src="../js/jquery-1.12.4.min.js"></script>--%>
<%--	<script type="text/javascript" charset="utf-8" src="../js/register.js"></script>--%>
	<%@ include file="commonhead.jsp"%>
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
				<form id="reg_form">
				<ul>
					<li>
						<label>用户名:</label>
						<input type="text" name="account" id="user_account">
						<span class="error_tip">提示信息</span>
					</li>		
					<li>
						<label>姓名:</label>
						<input type="text" name="name" id="user_name">
						<span class="error_tip">提示信息</span>
					</li>				
					<li>
						<label>密码:</label>
						<input type="password" name="password" id="pwd">
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


	<script type="application/javascript">
		$(function(){

			var error_name = false;
			var error_password = false;
			var error_check_password = false;
			var error_email = false;
			var error_check = false;


			$('#user_name').blur(function() {
				check_user_name();
			});

			$('#pwd').blur(function() {
				check_pwd();
			});

			$('#cpwd').blur(function() {
				check_cpwd();
			});

			$('#allow').click(function() {
				if($(this).is(':checked'))
				{
					error_check = false;
					$(this).siblings('span').hide();
				}
				else
				{
					error_check = true;
					$(this).siblings('span').html('请勾选同意');
					$(this).siblings('span').show();
				}
			});


			function check_user_name(){
				var len = $('#user_name').val().length;
				if(len<5||len>20)
				{
					$('#user_name').next().html('请输入5-20个字符的用户名')
					$('#user_name').next().show();
					error_name = true;
				}
				else
				{
					$('#user_name').next().hide();
					error_name = false;
				}
			}

			function check_pwd(){
				var len = $('#pwd').val().length;
				if(len<8||len>20)
				{
					$('#pwd').next().html('密码最少8位，最长20位')
					$('#pwd').next().show();
					error_password = true;
				}
				else
				{
					$('#pwd').next().hide();
					error_password = false;
				}
			}


			function check_cpwd(){
				var pass = $('#pwd').val();
				var cpass = $('#cpwd').val();

				if(pass!=cpass)
				{
					$('#cpwd').next().html('两次输入的密码不一致')
					$('#cpwd').next().show();
					error_check_password = true;
				}
				else
				{
					$('#cpwd').next().hide();
					error_check_password = false;
				}

			}


			$('#reg_form').submit(function(e) {
				e.preventDefault()
				check_user_name();
				check_pwd();
				check_cpwd();

				if(error_name == false && error_password == false && error_check_password == false && error_email == false && error_check == false)
				{
					var index = layer.load(1);
					var url = '${base}/user/add.do';
					$.post(url, $('#reg_form').serialize(), function(result) {
						if (result.code == 0) {
							layer.alert('注册成功', () => window.location.href = '${base}/jsp/login.jsp');


						} else {
							layer.alert(result.msg);
						}

					}, 'json').always(function() {
						//关闭弹层
						layer.close(index);
					});
				}
				else
				{
					return false;
				}

			});

		})
	</script>
</body>
</html>