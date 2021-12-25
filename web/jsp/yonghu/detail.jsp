<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易-商品详情</title>
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
		<a href="#">商品详情</a>
	</div>

	<div class="goods_detail_con clearfix">
		<div class="goods_detail_pic fl">
			<img src="../../images/goods_detail.jpg" id="pic"
				style="width: 350px; height: 350px">
		</div>
		<div class="goods_detail_list fr">
			<h3 id="name">大兴大棚草莓</h3>
			<p id="gid"></p>
			<div class="prize_bar">
				<span class="show_pirze">¥<em id="cxprice">16.80</em></span> <span
					class="show_unit" id="danwei">单 位：500g</span>
			</div>

			<div class="total">
				入手价：<em id="price">16.80元</em>
			</div>
			<div class="operate_btn">
				<a href="javascript:order();" class="buy_btn">立即购买</a> <a
					href="javascript:toCar();" class="add_cart" id="add_cart">加入购物车</a>
			</div>
		</div>
	</div>

	<div class="main_wrap clearfix">

		<div class="r_wrap fr clearfix">
			<ul class="detail_tab">
				<li class="active">商品介绍</li>
				<li>评论</li>
			</ul>

			<div class="tab_content">
				<dl>
					<dt>商品详情：</dt>
					<dd id="content">草莓采摘园位于北京大兴区 庞各庄镇四各庄村
						，每年1月-6月面向北京以及周围城市提供新鲜草莓采摘和精品礼盒装草莓，草莓品种多样丰富，个大香甜。所有草莓均严格按照有机标准培育，不使用任何化肥和农药。草莓在采摘期间免洗可以直接食用。欢迎喜欢草莓的市民前来采摘，也欢迎各大单位选购精品有机草莓礼盒，有机草莓礼盒是亲朋馈赠、福利送礼的最佳选择。
					</dd>
					<dd>
						<img src="../../images/ban1.jpg" width="756" id="pic2" />
					</dd>
				</dl>
			</div>
			<div class="tab_content" id="aa">
				<table id="tb" lay-filter="tb"></table>
			</div>

		</div>
	</div>

	<div class="footer"></div>
	<div class="add_jump"></div>

	<script type="text/javascript" src="../../js/jquery-1.12.2.js"></script>
	<script type="text/javascript">
		var data;
		$("#aa").hide();
		$(".detail_tab li").click(
				function() {
					$(this).addClass("active").siblings("li").removeClass(
							"active");
					var fangyuan = $(this).index();
					$(".tab_content").eq(fangyuan).show().siblings(
							".tab_content").hide();
				});
		//从url中获取携带的参数
		let ids = location.search.split("=");
		var data;
		getdata();
		function getdata(){
			$.ajax({
				url : '${pageContext.request.contextPath}/goods/getById.do?id='
						+ ids[1],
				dataType : 'json',
				type : 'get',
				success : function(res) {
					data = res.data;
					$("#name").html(data.name);
					$("#gid").html("商品编号：" + data.id);
					$("#cxprice").html(data.cxprice);
					$("#price").html(data.price);
					$("#danwei").html("单位：" + data.danwei);
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
					$('#pic2').attr('src', localhostPath + picPath); //图片链接

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
										url : '${base}/comment/selectByGid.do',
										elem : '#tb',
										method : 'post',
										cellMinWidth : 150,
										where : {
											gid : ids[1],
										},
										cols : [ [ //标题栏
												{
													field : 'id',
													width : 100,
													title : 'ID'
												},
												{
													field : 'content',
													title : '内容',
												},
												{
													field : 'uname',
													width : 200,
													title : '用户'

												},
												{
													field : 'createtime',
													width : 200,
													title : '时间',
													templet : "<div>{{layui.util.toDateString(d.playtime, 'yyyy-MM-dd')}}</div>"

												} ] ],
										page : false
									});
						});

		function toCar() {
			var url = '${pageContext.request.contextPath}/car/add.do';
			var data = {
				gid : ids[1],
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
		function order() {
			if(data.kucun<=0){
				layer.alert("该商品已经被卖掉了", function(index) {
					//关闭弹层
					layer.close(index);
				});
				return;
			}
			var url = '${base}/order/add.do';
			var data1 = {
				gid : ids[1] + "",
				price : data.cxprice,
			};
			var index = layer.load(1);
			$.post(url, data1, function(result) {
				if (result.code == 0) {
					layer.alert("购买成功", function(index) {
						getdata();
						//关闭弹层
						layer.close(index);
					});
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