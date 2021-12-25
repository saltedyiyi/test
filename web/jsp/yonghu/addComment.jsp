<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评价商品</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>校园二手交易平台-评价商品</title>
<link rel="stylesheet" type="text/css" href="../../css/reset.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<%@ include file="../commonhead.jsp"%>
<link rel="stylesheet" href="../../css/pintuer.css">
<!-- <link rel="stylesheet" href="../../css/admin.css"> -->
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
		<div class="sub_page_name fl">评价商品</div>
		<div class="search_con fr">
<input type="text" class="input_text fl" id="search" placeholder="搜索商品">
				<input type="button" class="input_btn fr" onclick="search()" value="搜索">
		</div>
	</div>
	<form method="post" class="form-x layui-form layui-form-pane" action=""
		style="margin-top: 34px;">
		<div class="form-group">
			<div class="label">
				<label>评价内容：</label>
			</div>
			<div class="field">
				<textarea placeholder="请输入评价内容" name="content" id="content"
					class="input w50" style="width: 25%; height: 100px;"></textarea>
				<div class="tips"></div>
			</div>
		</div>

		<div class="form-group">
			<div class="label">
				<label></label>
			</div>
			<div class="field">
				<button class="button bg-main icon-check-square-o" type="button"
					id="btn">提交</button>
			</div>
		</div>
	</form>

	<script charset="utf-8" type="text/javascript">
	//从url中获取携带的参数
	var u = decodeURI(location.search);
	console.log(u);
	let end = u.split("?")[1];
	let params = end.split("&");
	let id, gid;
	for (var i = 0; i < params.length; i++) {
		let temp = params[i];
		if (temp.indexOf('id') != -1) {
			id = temp.split("=")[1];
			continue;
		}
		if (temp.indexOf('goods') != -1) {
			gid = temp.split("=")[1];
			continue;
		}
	}
	console.log(id + "==" + gid);
		layui.use('form', function() {
			var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
			form.render();
		});

		//添加
		$('#btn').click(function() {
			var content = $('#content').val();
			if (!content) {
				layer.alert('评价内容不能为空');
				return;
			}
			var url = '${base}/comment/add.do';
			var data = {
				content : content,
				gid : gid,
				oid:id,
			};
			var index = layer.load(1);
			$.post(url, data, function(result) {
				if (result.code == 0) {
					window.location.href = 'user_center_order.jsp';
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