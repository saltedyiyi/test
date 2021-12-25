<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>校园二手交易市场</title>
<link rel="stylesheet" href="../css/pintuer.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="../js/jquery-3.5.1.min.js"></script>
</head>
<body style="background-color: #f2f9fd;">
	<div class="header bg-main">
		<div class="logo margin-big-left fadein-top">
			<h1>校园二手交易市场-管理员端</h1>
		</div>
		<div class="head-l">
			<a class="button button-little bg-red"
				href="${pageContext.request.contextPath}/user/logout.do"><span
				class="icon-power-off"></span> 退出登录</a>
		</div>
	</div>
	<div class="leftnav">

		<h2>
			<span class="icon-user"></span>信息管理
		</h2>
		<ul style="display: block">
			<li><a href="user/list.jsp" target="right"><span
					class="icon-caret-right"></span>用户管理</a></li>
			<li><a href="goods/list.jsp" target="right"><span
					class="icon-caret-right"></span>商品管理</a></li>




		</ul>
		<h2>
			<span class="icon-pencil-square-o"></span>个人中心
		</h2>
		<ul>
			<li><a href="user/updateSelf.jsp" target="right"><span
					class="icon-caret-right"></span>个人资料</a></li>
			<li><a href="user/updatePsw.jsp" target="right"><span
					class="icon-caret-right"></span>修改密码</a></li>


		</ul>
	</div>
	<script type="text/javascript">
		$(function() {
			$(".leftnav h2").click(function() {
				$(this).next().slideToggle(200);
				$(this).toggleClass("on");
			})
			$(".leftnav ul li a").click(function() {
				$("#a_leader_txt").text($(this).text());
				$(".leftnav ul li a").removeClass("on");
				$(this).addClass("on");
			})
		});
	</script>

	<div class="admin">
		<iframe scrolling="auto" rameborder="0" src="user/list.jsp"
			name="right" width="100%" height="100%"></iframe>
	</div>


</body>
</html>