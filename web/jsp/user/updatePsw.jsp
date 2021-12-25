<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<%@ include file="../commonhead.jsp"%>
<link rel="stylesheet" href="${base}/css/pintuer.css">
<link rel="stylesheet" href="${base}/css/admin.css">
<script src="${base}/js/pintuer.js"></script>
</head>
<body>

	<form method="post" class="form-x" action="">
		<div class="form-group">
			<div class="label">
				<label>原密码：</label>
			</div>
			<div class="field">
				<input type="password" class="input w50" id="prepassword" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>新密码：</label>
			</div>
			<div class="field">
				<input type="password" class="input w50" id="password" />
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>确认密码：</label>
			</div>
			<div class="field">
				<input type="password" class="input w50" id="repassword" />
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
		//添加
		$('#btn').click(function() {
			var prepassword = $('#prepassword').val();
			var password = $('#password').val();
			var repassword = $('#repassword').val();
			if (!prepassword) {
				layer.alert('原密码不能为空');
				return;
			}
			if (!password) {
				layer.alert('新密码不能为空');
				return;
			}
			if (!repassword) {
				layer.alert('确认密码不能为空');
				return;
			}
			if (repassword != password) {
				layer.alert('两次密码输入不一致');
				return;
			}

			var url = '${base}/user/updatePassword.do';
			var data = {
				prepassword : prepassword,
				password : password,
				type : 0,
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
	</script>
</body>
</html>