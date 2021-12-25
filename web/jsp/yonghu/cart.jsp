<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>校园二手交易平台-购物车</title>
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
					<a href="${base}/user/logout.do">退出登录</a>
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
		<div class="search_con fr">
			<input type="text" class="input_text fl" id="search" placeholder="搜索商品">
				<input type="button" class="input_btn fr" onclick="search()" value="搜索">
		</div>
	</div>

	<div class="total_count">购物车</div>
	<ul class="cart_list_th clearfix">
		<li class="col01">商品名称</li>
		<li class="col02">商品单位</li>
		<li class="col03">入手价格</li>
		<li class="col04">转手价格</li>
		<li class="col05">小计</li>
		<li class="col06">操作</li>
	</ul>
	<div id="gwc"></div>


	<ul class="settlements">
		<li class="col03" id="heji"></li>
		<li class="col04"><a href="Javascript:order()">提交订单</a></li>
	</ul>

	<div class="footer"></div>
	<script>
		var data;
		getdata();
		function getdata() {
			$.ajax({
				url : '${pageContext.request.contextPath}/car/selectByUser.do',
				dataType : 'json',
				type : 'get',
				success : function(res) {
					if (res.code == 0) {
						data = res.data;
						console.log(data);
						showData(data);
					} else {
						layer.alert(res.msg);
					}

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
				html += '<ul class="cart_list_td clearfix">'
						+ '<li class="col01"><input type="checkbox"  name="goods" value="'
						+ i
						+ '"checked></li>'
						+ '<li class="col02"><img src="'+path+'"></li>'
						+ '<li class="col03">'
						+ data[i].gname
						+ '<br><em>'
						+ data[i].cxprice
						+ '元/'
						+ data[i].danwei
						+ '</em></li>'
						+ '<li class="col04">'
						+ data[i].danwei
						+ '</li>'
						+ '<li class="col05">'
						+ data[i].price
						+ '元</li>'
						+ '<li class="col06">'
						+ data[i].cxprice
						+ '元</li>'
						+ '<li class="col07">'
						+ data[i].cxprice
						+ '元</li>'
						+ '<li class="col08"><a href="javascript:del('
						+ data[i].id + ');">删除</a></li>' + '</ul>';
			}

			var content = $('#gwc');
			content.html(html)
		}

		function order() {
			var id = document.getElementsByName("goods")
			var count = 0;
			var price = 0;
			var gid = "", cid = "";
			for (var i = 0; i < id.length; i++) {
				if (id[i].checked) {
					var index = id[i].value;
					price += data[index].cxprice;
					if (count == 0) {
						gid = data[index].gid;
						cid = data[index].id;

					} else {
						gid += "," + data[index].gid;
						cid += "," + data[index].id;
					}
					count++;
				}
			}
			//alert(gid+"=="+price);
			var url = '${base}/order/add.do';
			var data1 = {
				cid : cid,
				gid : gid,
				price : price,
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