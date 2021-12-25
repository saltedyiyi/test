<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>校园二手交易平台-闲置物品列表</title>
<link rel="stylesheet" type="text/css" href="../../css/reset.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<script type="text/javascript" src="../../js/jquery-1.12.4.min.js"></script>
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
			<a href="#" class="cart_name fl">我的购物车</a>
			<div class="goods_count fl" id="show_count">1</div>
		</div>
	</div>



	<div class="navbar_con">
		<div class="navbar">
			<a href="addGoods.jsp"><h1 class="fl">发布闲置</h1></a> <a
				href="addQiuGou.jsp"><h1 class="fl"
					style="margin-left: 20px;">发布求购</h1></a>
		</div>
	</div>

	<div class="breadcrumb">
		<a href="#">闲置物品</a>
	</div>

	<div class="main_wrap clearfix">
		<div class="r_wrap fr clearfix">
			<ul class="goods_type_list clearfix" id="allgoods">
			</ul>
		</div>
	</div>

	<div class="footer"></div>
	<script>
		$.ajax({
			url : '${pageContext.request.contextPath}/goods/selectAll.do',
			dataType : 'json',
			type : 'get',
			success : function(res) {
				var data = res.data;
				showData(data);

			}
		});
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
				html += '<li>'
						+ '<a href="detail.jsp?id='
						+ data[i].id
						+ '"><img src="'+path+'" style="object-fit:cover;"></a>'
						+ '<h4><a href="detail.jsp?id='
						+ data[i].id + '"> ' + data[i].name + '</a></h4>'
						+ '<div class="operate">' + '	<span class="prize">￥'
						+ data[i].cxprice + '</span>' + '<span class="unit">￥'
						+ data[i].cxprice + '/' + data[i].danwei + '</span>'
						+ '	<a href="javascript:toCar('+data[i].id+')" class="add_goods" title="加入购物车"></a>'
						+ '</div>' + '	</li>';

			}

			var content = $('#allgoods');
			content.html(html)
		}
		function toCar(id){
				var url = '${pageContext.request.contextPath}/car/add.do';
				var data = {
					gid : id,
				};
				var index = layer.load(1);
				$.post(url, data, function(result) {
					if (result.code == 0) {
						layer.alert("已加入购物车");
					} else {
						layer.alert(result.msg);
					}

				}, 'json').always(function() {
					//关闭弹层
					layer.close(index);
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