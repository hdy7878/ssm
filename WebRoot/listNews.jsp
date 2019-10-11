<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<link rel="stylesheet" href="../layui/css/layui.css">
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../layui/layui.js"></script>

<style>
	div {text-align: center;}
	input {margin: 10px;padding: 10px;}
	.layui-input{width: 400px;display: inline-block;}
	.regist{padding:20px;display:none;height:110px;width: 280px;}
	.regist input{margin: 10px;padding: 10px;width:300px;}
</style>
<body>
	<ul class="layui-nav">
		<li class="layui-nav-item">今日新闻</li>
		<li class="layui-nav-item" style="float:right;padding-right:50px;">
			<a style='cursor: pointer;' href="outLogin.action">退出</a>
		</li>
		<li class="layui-nav-item" style="float:right;padding-right:50px;">
			<img src="../img/icon2.jpg" class="layui-nav-img">用户：${User.username}
		</li>
	</ul>
	<div style="padding:20px 120px 80px 120px;"> 
		<h3 style="height:30px;padding: 20px 80px 20px 20px;">今日新闻</h3>
		<c:forEach var="news" items="${listNews}">
			<div style="width:43%;padding: 20px;border:#e3e3e3 1px solid;text-align: left;float:left;margin-right:20px">
				<div style="display: inline-block;">
					<img src="../newsImage/${news.picture}" style="width:95px;height:95px;">
				</div>
				<div style="display: inline-block;padding:10px 20px;position:absolute;">
					${news.title}<a href='newsInfo.action?id=${news.id}' style='color:#1e9fff;cursor: pointer;font-size:12px;margin-left:10px;'>查看详情</a>
				</div>
			</div>
		</c:forEach>
	</div>
	
	
</body>

<script type="text/javascript">
	var layer;
	
	layui.use('layer', function(){
		var layer = layui.layer;
		
		
	});
</script>

</html>
