<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-用户中心</title>
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
		<div class="sub_page_name fl">用户中心</div>
		<div class="search_con fr">
			<input type="text" class="input_text fl" id="search" placeholder="搜索商品">
				<input type="button" class="input_btn fr" onclick="search()" value="搜索">
		</div>
	</div>

	<div class="main_con clearfix">
		<div class="left_menu_con clearfix">
			<h3>用户中心</h3>
			<ul>
				<li><a href="user_center_info.jsp" class="active">· 个人信息</a></li>
				<li><a href="user_center_psw.jsp" >· 修改密码</a></li>
				<li><a href="user_center_order.jsp">· 我购买的物品</a></li>
				<li><a href="user_center_salegoods.jsp">· 我卖出的物品</a></li>
				<li><a href="user_center_postgoods.jsp">· 我发布的物品</a></li>
				<li><a href="user_center_site.jsp">· 我发布的求购</a></li>
			</ul>
		</div>
		<div class="right_content clearfix">
			<div class="info_con clearfix">
				<h3 class="common_title2">基本信息</h3>
				<ul class="user_info_list" style="background: #fff">
					<li>
						<form class="layui-form" action="" enctype="multipart/form-data">
							<div class="layui-form-item"
								style="margin-top: 20px; width: 40%;">
								<label class="layui-form-label">姓名</label>
								<div class="layui-input-block">

									<input type="text" placeholder="请输入姓名" name="content"
										id="content" class="layui-input">
								</div>
							</div>
							<button class="layui-btn" type="button"
								style="width: 200px; margin-left: 60px; margin-top: 20px;"
								id="btn">修改</button>
						</form>

					</li>
				</ul>
			</div>

		</div>
	</div>



	<div class="footer"></div>
	<script>
		//查询要修改的数据
		$.ajax({
			url : "${pageContext.request.contextPath}/user/getSelf.do",
			type : "get",
			dataType : "json",
			success : function(result) {
				$("#content").val(result.data.name);
			}
		});
		//添加
		$('#btn').click(function() {
			var content = $('#content').val();
			if (!content) {
				layer.alert('姓名不能为空');
				return;
			}
			var url = '${pageContext.request.contextPath}/user/updateSelf.do';
			var data = {
				name : content,
			};
			var index = layer.load(1);
			$.post(url, data, function(result) {
				if (result.code == 0) {
					layer.alert("修改成功");
				} else if (result.code == 2) {
					top.location.href = '${base}/jsp/login.jsp';
				} else {
					layer.alert(result.msg);
				}
			}, 'json').always(function() {
				//关闭弹层
				layer.close(index);
			});

		});
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