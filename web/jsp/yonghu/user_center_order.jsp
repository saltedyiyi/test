<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-我的订单</title>
	<link rel="stylesheet" type="text/css" href="../../css/reset.css">
		<link rel="stylesheet" type="text/css" href="../../css/main.css"><%@ include
				file="../commonhead.jsp"%>
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
		<div class="sub_page_name fl">我的订单</div>
		<div class="search_con fr">
			<input type="text" class="input_text fl" id="search" placeholder="搜索商品">
				<input type="button" class="input_btn fr" onclick="search()" value="搜索">
		</div>
	</div>

	<div class="main_con clearfix">
		<div class="left_menu_con clearfix">
			<h3>用户中心</h3>
			<ul>
				<li><a href="user_center_info.jsp">· 个人信息</a></li>
				<li><a href="user_center_psw.jsp" >· 修改密码</a></li>

				<li><a href="user_center_order.jsp" class="active">· 我购买的物品</a></li>
				<li><a href="user_center_salegoods.jsp">· 我卖出的物品</a></li>
				<li><a href="user_center_postgoods.jsp">· 我发布的物品</a></li>
				<li><a href="user_center_site.jsp">· 我发布的求购</a></li>
			</ul>
		</div>
		<div class="right_content clearfix">
			<h3 class="common_title2">我购买的物品</h3>
			<div id="myorder">
			</div>


		</div>
	</div>



	<div class="footer"></div>
	<script>
		$.ajax({
			url : '${pageContext.request.contextPath}/order/selectByUser.do',
			dataType : 'json',
			type : 'get',
			success : function(res) {
				if(res.code==0){
					var data = res.data;
					showData(data);
				}else{
					layer.alert(res.msg);
				}
				

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
				var time = layui.util.toDateString(data[i].createtime,
						'yyyy-MM-dd');
				html += '<ul class="order_list_th w978 clearfix">'
						+ '<li class="col01">' + time + '</li>'
						+ '<li class="col02">订单号：' + data[i].id + '</li>'
						+ '</ul>';

				html += '<table class="order_list_table w980">' + '<tbody>'
						+ '<tr>' + '<td width="55%">';
				for (var j = 0; j < data[i].goods.length; j++) {
					var path2 = localhostPath + data[i].goods[j].pic;
					html += '<ul class="order_goods_list clearfix">'
							+ '<li class="col01"><img src="'+path2+'"></li>'
							+ '<li class="col02"><a href="detail.jsp?id='+data[i].goods[j].id+'">'+data[i].goods[j].name+'</a><em>'
							+ data[i].goods[j].cxprice + '元/'
							+ data[i].goods[j].danwei + '</em></li>'
							+ '<li class="col03">' + data[i].goods[j].cxprice
							+ '元</li>' 
							+ '<li class="col04"><div style="padding-left:20px;">'
							+'<a href="addComment.jsp?goods='+data[i].goods[j].id+'&id='+data[i].id+'">去评价</a></div></li>'
							+ '</ul>';
				}
				html += '</td>'
						+ '<td width="15%">'
						+ data[i].price
						+ '元</td>'
						+ '<td width="15%">已付款</td>'
					
						+ '</tr>' + '</tbody>' + '</table>';

			}

			var content = $('#myorder');
			content.html(html)
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