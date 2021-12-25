<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增商品</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>校园二手交易平台-提交订单</title>
<link rel="stylesheet" type="text/css" href="../../css/reset.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<%@ include file="../commonhead.jsp"%>
 <link rel="stylesheet" href="../../css/pintuer.css"> 
<!-- <link rel="stylesheet" href="../../css/admin.css"> -->
</head>
<body>
	<div class="header_con">
		<div class="header">
			<div class="welcome fl"><a href="../index2.jsp">欢迎来到校园二手交易平台!</a></div>
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
		<div class="sub_page_name fl">发布闲置物品</div>
		<div class="search_con fr">
			<input type="text" class="input_text fl" id="search" placeholder="搜索商品">
				<input type="button" class="input_btn fr" onclick="search()" value="搜索">
		</div>		
	</div>
	<form method="post" class="form-x layui-form layui-form-pane" action="" style="margin-top: 34px;">

		<div class="form-group">
			<div class="label">
				<label>商品名：</label>
			</div>
			<div class="field">
				<input type="text" class="input w50" style="width: 25%;"id="name" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>原价：</label>
			</div>
			<div class="field">
				<input type="text" class="input w50" style="width: 25%;"id="price" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>转手价：</label>
			</div>
			<div class="field">
				<input type="text" class="input w50"style="width: 25%;" id="cxprice" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>数量：</label>
			</div>
			<div class="field">
				<input type="text" class="input w50"style="width: 25%;" id="kucun" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>单位：</label>
			</div>
			<div class="field">
				<input type="text" class="input w50"style="width: 25%;" id="danwei" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>描述：</label>
			</div>
			<div class="field">
				<textarea placeholder="请输入描述" name="content" id="content"
					class="input w50" style="width: 25%; height: 100px;"></textarea>
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>上传图片：</label>
			</div>
			<div class="field">
				<button class="button bg-main icon-check-square-o" type="button"
					id="uploadfmbtn">选择图片</button>
				<p>
					<img class="layui-upload-img" id="img"
						style="width: 100px; margin-top: 40px;">
				</p>

				<p id="url"></p>
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
		var picPath;
		//从url中获取携带的参数
		let ids = location.search.split("=");
		layui.use('form', function() {
			var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
			form.render();
		});
		//查询要修改的数据
		$.ajax({
			url : "${pageContext.request.contextPath}/goods/getById.do?id="
					+ ids[1],
			type : "get",
			dataType : "json",
			success : function(result) {
				$("#name").val(result.data.name);
				$("#content").val(result.data.content);
				$("#price").val(result.data.price);
				$("#cxprice").val(result.data.cxprice);
				$("#kucun").val(result.data.kucun);
				$("#danwei").val(result.data.danwei);

				//获取当前网址，如： http://localhost:8088/test/test.jsp
				var curPath = window.document.location.href;
				//获取主机地址之后的目录，如： test/test.jsp
				var pathName = window.document.location.pathname;
				var pos = curPath.indexOf(pathName);
				//获取主机地址，如： http://localhost:8088
				var localhostPath = curPath.substring(0, pos);
				picPath = result.data.pic;

				$('#img').attr('src', localhostPath + picPath); //图片链接

				layui.use('form', function() {
					var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
					form.render();
				});
			}
		});



		var $ = layui.jquery, upload = layui.upload;
		//普通图片上传
		var uploadInst = upload
				.render({
					elem : '#uploadfmbtn',
					url : '${base}/goods/upload.do' //上传接口
					,
					before : function(obj) {
						//预读本地文件示例，不支持ie8
						obj.preview(function(index, file, result) {
							$('#img').attr('src', result); //图片链接（base64）
						});
					},
					done : function(res) {
						console.log(res);
						//如果上传失败
						if (res.code > 0) {
							return layer.msg('上传失败');
						}
						//上传成功
						picPath = res.data;
						//演示失败状态，并实现重传
						var url = $('#url');
						url
								.html('<span style="color: #FF5722;margin-left: 40px;">'
										+ res.msg + '</span> ');

					},
					error : function() {
						//演示失败状态，并实现重传
						var url = $('#url');
						url
								.html('<span style="color: #FF5722;margin-left: 40px;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
						url.find('.demo-reload').on('click', function() {
							uploadInst.upload();
						});
					}
				});

		//添加
		$('#btn').click(function() {
			var name = $('#name').val();
			var price = $('#price').val();
			var cxprice = $('#cxprice').val();
			var kucun = $('#kucun').val();
			var danwei = $('#danwei').val();
			var content = $('#content').val();
			if (!name) {
				layer.alert('商品名称不能为空');
				return;
			}
			if (!price) {
				layer.alert('原价不能为空');
				return;
			}
			if (!cxprice) {
				layer.alert('转手价不能为空');
				return;
			}
			if (!kucun) {
				layer.alert('数量不能为空');
				return;
			}
			if (!danwei) {
				layer.alert('单位不能为空');
				return;
			}
			if (!content) {
				layer.alert('商品描述不能为空');
				return;
			}
			if (!picPath) {
				layer.alert('图片不能为空');
				return;
			}
			var url = '${base}/goods/update.do';
			var data = {
				id:ids[1],
				name : name,
				content : content,
				pic : picPath,
				price : price,
				cxprice : cxprice,
				kucun : kucun,
				danwei : danwei,
			};
			var index = layer.load(1);
			$.post(url, data, function(result) {
				if (result.code == 0) {
					window.location.href = 'user_center_postgoods.jsp';
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