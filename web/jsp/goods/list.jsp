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
<link rel="stylesheet" href="../../css/pintuer.css">
<link rel="stylesheet" href="../../css/admin.css">

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
			<strong class="icon-reorder">商品列表</strong>
		</div>
		<div class="padding border-bottom">
			<a type="button" class="button border-yellow" id="add"> <span
				class="icon-plus-square-o"></span> 添加商品
			</a>
		</div>
		<table id="tb" lay-filter="tb"></table>
	</div>

	<script type="text/html" id="bar">
	<div class="layui-btn-container">
	<a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>
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
		$(document)
				.ready(
						function() {
							var form = layui.form;
							form.render();
							var table = layui.table;
							table
									.render({
										id : 'tb',
										url : '${base}/goods/selectAll.do',
										elem : '#tb',
										method : 'post',
										cellMinWidth : 150,
										where : {
											type : 0,
										},
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
												},{
													field : 'uname',
													width : 200,
													title : '发布人'
												}  ] ],
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
											'${pageContext.request.contextPath }/jsp/goods/update.jsp?id='
													+ data.id);
								}
							});

						});
		$("#add")
				.click(
						function() {
							$(location)
									.attr('href',
											'${pageContext.request.contextPath }/jsp/goods/add.jsp');
						});
	</script>
</body>
</html>