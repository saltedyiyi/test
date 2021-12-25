<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易-求购详情</title>
	<link rel="stylesheet" type="text/css" href="../../css/reset.css">
		<link rel="stylesheet" type="text/css" href="../../css/main.css">
			<%@ include file="../commonhead.jsp"%>
</head>
<body>
	<div class="header_con">
		<div class="header">
			<div class="welcome fl">
				<a href="../index2.jsp">欢迎来到校园二手交易平台!</a>
			</div>
			<div class="fr">
				<div class="login_btn fl">
					<a href="${pageContext.request.contextPath}/user/logout.do">退出登录</a>
				</div>
				<div class="user_link fl">
					<span>|</span> <a href="user_center_info.jsp">用户中心</a> <span>|</span>
					<a href="cart.jsp">我的购物车</a> <span>|</span> <a
						href="user_center_order.jsp">我的订单</a> <span>|</span> <a
						href="user_center_site.jsp">我的求购</a>
				</div>
			</div>
		</div>
	</div>

	<div class="search_bar clearfix">
		<div class="search_con fl">
		<input type="text" class="input_text fl" id="search" placeholder="搜索商品">
				<input type="button" class="input_btn fr" onclick="search()" value="搜索">
		</div>
		<div class="guest_cart fr">
			<a href="cart.jsp" class="cart_name fl">我的购物车</a>
		</div>
	</div>

	<div class="navbar_con">
		<div class="navbar">
			<a href="addGoods.jsp"><h1 class="fl">发布闲置</h1></a> <a
				href="addQiuGou.jsp"><h1 class="fl" style="margin-left: 20px;">发布求购</h1></a>
		</div>
	</div>

	<div class="breadcrumb">
		<a href="#">求购详情</a>
	</div>

	<div class="goods_detail_con clearfix">
		<div class="goods_detail_pic fl">
			<img src="../../images/goods_detail.jpg" id="pic"
				style="width: 350px; height: 350px">
		</div>
		<div class="goods_detail_list fr">
			<h3 id="name">大兴大棚草莓</h3>
					<p id="uname"></p>
			<p id="content"></p>
			

		</div>
	</div>

	

	<div class="footer"></div>
	<div class="add_jump"></div>

	<script type="text/javascript" src="../../js/jquery-1.12.2.js"></script>
	<script type="text/javascript">
		var data;
		//从url中获取携带的参数
		let ids = location.search.split("=");
		var data;
		getdata();
		function getdata(){
			$.ajax({
				url : '${pageContext.request.contextPath}/qiugou/getById.do?id='
						+ ids[1],
				dataType : 'json',
				type : 'get',
				success : function(res) {
					data = res.data;
					$("#name").html(data.name);
					$("#uname").html("求购人："+data.uname);
					$("#content").html(data.content);
					//获取当前网址，如： http://localhost:8088/test/test.jsp
					var curPath = window.document.location.href;
					//获取主机地址之后的目录，如： test/test.jsp
					var pathName = window.document.location.pathname;
					var pos = curPath.indexOf(pathName);
					//获取主机地址，如： http://localhost:8088
					var localhostPath = curPath.substring(0, pos);
					var picPath = data.pic;

					$('#pic').attr('src', localhostPath + picPath); //图片链接

				}
			});
		}
	
		$("#search").keypress(function(e) {
			if (e.which == 13) {
				search();
			}
		});
		function search(){
			var key = $('#search').val();
			console.log(key);
			$.ajax({
				//几个参数需要注意一下
				type : "POST",//方法类型
				dataType : "json",//预期服务器返回的数据类型
				url : '${pageContext.request.contextPath}/goods/search.do',
				data:{
					keyword:key,
				},
				success : function(res) {
					if(res.code==0){
						$(location).attr(
								'href',
								'${pageContext.request.contextPath }/jsp/yonghu/search.jsp');
					}else{
						alert(res.msg);
					}
				},
				error : function() {
					alert("服务器异常！");
				}
			});
		}
	
	</script>

</body>
</html>