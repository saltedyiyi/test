<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-首页</title>
	<link rel="stylesheet" type="text/css" href="../../css/reset.css">
		<link rel="stylesheet" type="text/css" href="../../css/main.css">
			<script type="text/javascript" src="../../js/jquery-1.12.4.min.js"></script>
			<script type="text/javascript" src="../../js/jquery-ui.min.js"></script>
			<script type="text/javascript" src="../../js/slide.js"></script>
</head>
<body>
	<div class="header_con">
		<div class="header">
			<div class="welcome fl">		<a href="../index2.jsp">欢迎来到校园二手交易平台!</a></div>
			<div class="fr">
				<div class="login_btn fl">
					<a href="${pageContext.request.contextPath}/user/logout.do">退出登录</a>
				</div>
				<div class="user_link fl">
					<span>|</span> <a href="yonghu/user_center_info.jsp">用户中心</a> <span>|</span>
					<a href="cart.jsp">我的购物车</a> <span>|</span> <a
						href="user_center_order.jsp">我的订单</a> <span>|</span> <a
						href="user_center_order.jsp">我的求购</a>
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
			<a href="addGoods.jsp"><h1 class="fl">发布闲置</h1></a>
			<a href="addQiuGou.jsp"><h1 class="fl" style="margin-left: 20px;">发布求购</h1></a>
		</div>
	</div>

	<div class="center_con clearfix" style="margin-top: 34px;">

		<div class="slide fl" >
			<ul class="slide_pics">
				<li><img src="../../images/slide.jpeg"
					style="width: 960px; height: 270px; object-fit: cover;"></li>
				<li><img src="../../images/slide02.jpeg"
					style="width: 960px; height: 270px; object-fit: cover;"></li>
				<li><img src="../../images/slide03.jpeg"
					style="width: 960px; height: 270px; object-fit: cover;"></li>
				<li><img src="../../images/slide04.jpeg"
					style="width: 960px; height: 270px; object-fit: cover;"></li>
			</ul>
			<div class="prev"></div>
			<div class="next"></div>
			<ul class="points"></ul>
		</div>
		<div class="adv fl">
			<a href="#"><img src="../../images/adv01.jpg"></a> <a href="#"><img
				src="../../images/adv02.jpg"></a>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model01">搜索结果</h3>
		</div>

			<ul class="goods_list fl" id="eswp">
			</ul>
	</div>

	


	<script type="text/javascript">
	tosearch("-1");
		$("#search").keypress(function(e) {
			if (e.which == 13) {
				search();
			}
		});
		function search(){
			var key = $('#search').val();
			tosearch(key);
		}
		function tosearch(key) {
			//查推荐数据
			$.ajax({
				//几个参数需要注意一下
				type : "POST",//方法类型
				dataType : "json",//预期服务器返回的数据类型
				url : '${pageContext.request.contextPath}/goods/searchByKeyword.do',
				data : {
					keyword : key
				},
				success : function(res) {
					showData(res.data);
				},
				error : function() {
					alert("服务器异常！");
				}
			});
		}
		function showData(data) {
			//获取当前网址，如： http://localhost:8088/test/test.jsp
			var curPath = window.document.location.href;
			//获取主机地址之后的目录，如： test/test.jsp
			var pathName = window.document.location.pathname;
			var pos = curPath.indexOf(pathName);
			//获取主机地址，如： http://localhost:8088
			var localhostPath = curPath.substring(0, pos);

			var html = '';
			for (var i = 0; i < data.length; i++) {
				var path = localhostPath + data[i].pic;
				html+='<li>'
					+ '<h4>'
					+ '<a href="${pageContext.request.contextPath}/jsp/yonghu/detail.jsp?id='+data[i].id+'">'
					+'<p style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data[i].name+'</p></a>'
					+ '</h4> <a href="${pageContext.request.contextPath}/jsp/yonghu/detail.jsp?id='+data[i].id+'"><img src="'+path+'"></a>'
					+ '<div class="prize">¥ '+ data[i].cxprice+'</div>'
					+ '</li>';
			}

			var content = $('#eswp');
			content.html(html)
		}
	
	</script>

</body>
</html>