<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,maximum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title></title>
<%@ include file="../commonhead.jsp"%>
<link rel="stylesheet" href="${base}/css/pintuer.css">
<link rel="stylesheet" href="${base}/css/admin.css">
<script src="${base}/js/pintuer.js"></script>
<style type="text/css">
.layui-table-cell {
	height: auto;
	white-space: normal;
	text-align: center;
}
</style>
</head>
<body style="margin: 10px;">

	<div class="panel admin-panel">
		<div class="panel-head">
			<strong class="icon-reorder">用户列表</strong>
		</div>
		<table id="tb" lay-filter="tb"></table>
	</div>


	<script type="text/html" id="bar">
	<div class="layui-btn-container">
		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
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
		$(document).ready(function() {
			var form = layui.form;
			form.render();
			var table = layui.table;
			table.render({
				id : 'tb',
				url : '${base}/user/selectAll.do',
				elem : '#tb',
				method : 'post',
				cellMinWidth : 150,
				where : {},
				cols : [ [ //标题栏
				{
					field : 'id',
					width : 100,
					title : 'ID'
				}, {
					field : 'account',
					width : 200,
					title : '用户名'
				}, {
					field : 'name',
					width : 200,
					title : '姓名'
				}, {
					title : '操作',
					toolbar : '#bar',
					width : 200
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
						var url = '${base}/user/delete.do';
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
				}
			});

		});

	</script>
</body>
</html>