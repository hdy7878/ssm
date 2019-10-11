<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<link rel="stylesheet" href="../layui/css/layui.css">
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../layui/layui.js"></script>

<style>
	body {padding: 40px;padding-top:200px;background:url('../img/img2.jpg') repeat center;}
	div {text-align: center;}
	input {margin: 10px;padding: 10px;}
	.layui-input{width: 400px;display: inline-block;}
	.regist{padding:20px;display:none;height:110px;width: 280px;}
	.regist input{margin: 10px;padding: 10px;width:300px;}
</style>
<body>
	<div >
		<input type="text" class="layui-input" name="username" placeholder="请输入用户名">
	</div>
	<div >
		<input type="password" class="layui-input" name="password" placeholder="请输入密码">
	</div>
	<div >
		<input type="button" class="layui-btn" value="注册" onclick="btn1()">
		<input type="button" class="layui-btn" value="登录" onclick="btn2()">
		<input type="button" class="layui-btn" value="管理员登录" onclick="btn3()">
	</div>
	<div class="regist">
		<input type="text" class="layui-input" name="reUsername" placeholder="请输入用户名">
		<input type="password" class="layui-input" name="rePassword" placeholder="请输入密码">
	</div>
</body>

<script type="text/javascript">
	var layer;
	
	layui.use('layer', function(){
		var layer = layui.layer;
	});
	
	function btn1() {
		layer.open({
			type: 1, 
			title:"用户注册",
			area: ['360px', '260px'],
			btn:['注册'],
			btnAlign:'c',
			content: $(".regist"),
			yes: function(index, layero){
				var username = $("input[name='reUsername']").val();
				var password = $("input[name='rePassword']").val();
				if (username == "") {
					layer.msg("注册用户名不能为空");
					return;
				}
				if (password == "") {
					layer.msg("注册密码不能为空");
					return;
				}
				$.ajax({
		        	type: "POST",
		        	url: "demo/regist.action",
		        	data: {"username":username,"password":password},
		        	dataType: "json",
		        	success: function(data){
		        		if (data.code == 200) {
							layer.closeAll();
							layer.msg("用户注册成功");
						}else{
							layer.msg(data.msg);
						}
		        	}
				});
			}
		});
	}
	function btn2() {
		var username = $("input[name='username']").val();
		var password = $("input[name='password']").val();
		if (username == "") {
			layer.msg("用户名不能为空");
			return;
		}
		if (password == "") {
			layer.msg("密码不能为空");
			return;
		}
		$.ajax({
        	type: "POST",
        	url: "login.action",
        	data: {"username":username,"password":password,"isAdminFlag":"0"},
        	dataType: "json",
        	success: function(data){
				if(data.code == 201){
        			location.href = "listNews.action";
				}else{
					layer.msg(data.msg);
				}
        	}
		});
		
		
		
	}
	
	function btn3() {
		var username = $("input[name='username']").val();
		var password = $("input[name='password']").val();
		if (username == "") {
			layer.msg("用户名不能为空");
			return;
		}
		if (password == "") {
			layer.msg("密码不能为空");
			return;
		}
		$.ajax({
        	type: "POST",
        	url: "login.action",
        	data: {"username":username,"password":password,"isAdminFlag":"1"},
        	dataType: "json",
        	success: function(data){
				if(data.code == 202){
					location.href = "addNews.action";
				}else{
					layer.msg(data.msg);
				}
        	}
		});
	}
</script>

</html>
