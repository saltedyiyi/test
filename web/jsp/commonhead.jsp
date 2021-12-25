<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!--工具库  -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- 核心库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!--  格式化标签库-->
<c:set scope="session" value="${pageContext.request.contextPath}" var="base"></c:set>
<link rel="stylesheet" href="${base}/layui/css/layui.css"><!-- layui的核心css -->
<%-- <script src="${base}/layui/layui.all.js"></script><!-- 一次性加载layui的js --> --%>
<script src="${base}/layui/layui.all.js"></script><!--模块化加载layui的核心js -->
<script src="${base}/js/jquery-3.5.1.min.js"></script>


