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
	<div style="text-align:left;padding:20px 0px 0px 20px;">
		<a href="javascript:history.go(-1)" style='color:#1e9fff;cursor: pointer;'>返回上级</a>
	</div>
	<div style="padding:20px 120px 80px 120px;"> 
		<h1 style="height:30px;padding:20px ;">${news.title}</h1>
		<div>
			<img src="../newsImage/${news.picture}" style="width:200px;height:200px;">
		</div>
		<div style="margin-top:20px;line-height:13px;font-size: 16px;height:auto;">
			${news.content}
		</div>
	</div>
	
	
	
</body>

<script type="text/javascript">
	var layer;
	
	layui.use('layer', function(){
		var layer = layui.layer;
		
		
	});
</script>

</html>
