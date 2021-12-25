<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-我发布的物品</title>
	<link rel="stylesheet" type="text/css" href="../../css/reset.css">
		<link rel="stylesheet" type="text/css" href="../../css/main.css"><%@ include
				file="../commonhead.jsp"%>
<style type="text/css">
.layui-table-cell {
	height: auto;
	white-space: normal;
	text-align: center;
}
</style>				
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
		<div class="sub_page_name fl">我发布的物品</div>
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

				<li><a href="user_center_order.jsp" >· 我购买的物品</a></li>
				<li><a href="user_center_salegoods.jsp">· 我卖出的物品</a></li>
				<li><a href="user_center_postgoods.jsp" class="active">· 我发布的物品</a></li>
				<li><a href="user_center_site.jsp">· 我发布的求购</a></li>
			</ul>
		</div>
		<div class="right_content clearfix">
			<h3 class="common_title2">我发布的物品</h3>
			<div id="myorder">

				<table id="tb" lay-filter="tb"></table>
			</div>


		</div>
	</div>



	<div class="footer"></div>
	<script type="text/html" id="bar">
	<div class="layui-btn-container">

		<a class="layui-btn layui-btn-sm" lay-event="edit">修改</a>
		<a class="layui-btn layui-btn-sm" lay-event="del">删除</a>
	</div>
	</script>
	<script>
	function reload() {
		var table = layui.table;
		table.reload('tb', {
			where : {

			}
		});
	}
		$(document)
				.ready(
						function() {
							var form = layui.form;
							form.render();
							var table = layui.table;
							table
									.render({
										id : 'tb',
										url : '${base}/goods/selectByUser.do',
										elem : '#tb',
										method : 'post',
										cellMinWidth : 150,
										where : {},
										cols : [ [ //标题栏
											{
												title : '操作',
												toolbar : '#bar',
												width : 200
											},
											
											{
												field : 'pic',
												width : 200,
												title : '商品图片',
												templet : function(res) {
													//获取当前网址，如： http://localhost:8088/test/test.jsp
													var curPath = window.document.location.href;
													//获取主机地址之后的目录，如： test/test.jsp
													var pathName = window.document.location.pathname;
													var pos = curPath
															.indexOf(pathName);
													//获取主机地址，如： http://localhost:8088
													var localhostPath = curPath
															.substring(0,
																	pos);
													var pic = localhostPath
															+ res.pic;
													console.log(pic);

													return '<div><img  src="'+pic+'" ></div>'

												}

											}, {
												field : 'name',
												width : 200,
												title : '商品名'
											}, {
												field : 'price',
												width : 200,
												title : '原价'
											}, {
												field : 'cxprice',
												width : 200,
												title : '转手价'
											}, {
												field : 'kucun',
												width : 200,
												title : '数量'
											}, {
												field : 'danwei',
												width : 200,
												title : '单位'
											} ] ],
										page : false
									});
							//监听工具条
							table.on('tool(tb)', function(obj) { //
								var data = obj.data; //获得当前行数据
								var layEvent = obj.event; //获得 lay-event 对应的值
								var tr = obj.tr; //获得当前行 tr 的DOM对象
								if (layEvent == 'del') {
									layer.confirm('确定删除？', function(index) {
										var url = '${base}/goods/delete.do';
										var reqData = {
											id : data.id,
										};
										var index = layer.load(1);
										$.post(url, reqData, function(result) {
											if (result.code == 0) {
												layer.close(index);
												layer.msg('操作成功');
												reload();
											} else {
												layer.alert(result.msg);
											}
										}, 'json').always(function() {
											//关闭弹层
											layer.close(index);
										});
									});
								} else if (layEvent == 'edit') {
									$(location).attr(
											'href',
											'${pageContext.request.contextPath }/jsp/yonghu/updateGoods.jsp?id='
											+ data.id);
								}
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