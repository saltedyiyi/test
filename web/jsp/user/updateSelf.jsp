<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑用户</title>
<%@ include file="../commonhead.jsp"%>
<link rel="stylesheet" href="${base}/css/pintuer.css">
<link rel="stylesheet" href="${base}/css/admin.css">
<script src="${base}/js/pintuer.js"></script>
</head>
<body>
	
	<form method="post" class="form-x  layui-form layui-form-pane" action="">
		<div class="form-group">
			<div class="label">
				<label>姓名：</label>
			</div>
			<div class="field">
				<input type="text" class="input w50" id="name" />
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
	
		layui.use('form', function() {
			var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
			form.render();
		});
		//查询要修改的数据
		$.ajax({
			url : "${pageContext.request.contextPath}/user/getSelf.do",
			type : "get",
			dataType : "json",
			success : function(result) {
				console.log(result.code+"=="+result.data);
				if(result.code==2){
					top.location.href = '${base}/jsp/login.jsp';
				}else{
					$("#name").val(result.data.name);
				}
				layui.use('form', function() {
					var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
					form.render();
				});
			}
		});
	
		//修改
		$('#btn').click(function() {
			var name = $('#name').val();
			
			if (!name) {
				layer.alert('姓名不能为空');
				return;
			}
			var url = '${base}/user/updateSelf.do';
			var data = {
				name : name,
			};
			var index = layer.load(1);
			$.post(url, data, function(result) {
				if (result.code == 0) {
					layer.alert("修改成功");
				}else if (result.code == 2) {
					top.location.href = '${base}/jsp/login.jsp';
				}else {
					layer.alert(result.msg);
				}

			}, 'json').always(function() {
				//关闭弹层
				layer.close(index);
			});

		});
	</script>
</body>
</html>