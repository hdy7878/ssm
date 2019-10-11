<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<link rel="stylesheet" href="../layui/css/layui.css">
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../layui/layui.js"></script>

<style>
	.addNew_top{padding:20px 80px 20px 80px;}
	.addNew_Content{padding:0px 80px 20px 80px;}
	.addNews{padding: 20px;}
	body .layui-table-cell{height: auto;}
</style>
<body>
	<ul class="layui-nav">
		<li class="layui-nav-item">新增新闻</li>
		<li class="layui-nav-item" style="float:right;padding-right:50px;">
			<a style='cursor: pointer;' href="outLogin.action">退出</a>
		</li>
		<li class="layui-nav-item" style="float:right;padding-right:50px;">
			<img src="../img/icon.jpg" class="layui-nav-img">系统管理员：${adminUser.username}
		</li>
	</ul>
	<div class='addNew_top'>
		<input type="button" class='layui-btn' value="新增新闻" onclick='btn1()'>
	</div>
	<div class='addNew_Content'>
		<table id="demo" lay-filter="demo"></table>
	</div>
	
	<div class='addNews' style="display:none;">
		<form class="layui-form" >
			<input type="text" name='title' class='layui-input' placeholder="请输入新闻标题" style="margin-bottom: 10px;">
			<textarea name='content' placeholder="请输入新闻内容" class="layui-textarea" style="margin-bottom: 10px;"></textarea>
			<select name="isDeleteFlag">
				<option value="0">立即发布</option>
				<option value="1">延迟发布</option>
			</select>
			<div class="layui-upload">
				<button type="button" class="layui-btn" id="test3" style="margin:10px 0px;">
					<i class="layui-icon"></i>上传文件
				</button>
				<div class="layui-upload-list">
					<img class="layui-upload-img" id="demo1" style="width:112px;height:90px;">
					<p id="demoText"></p>
				</div>
			</div>
		</form>
	</div>
	
</body>
<script type="text/html" id="titleTp1">
	<img src='../newsImage/{{d.picture}}' style='width:80px;height:80px;' />
</script>
<script type="text/html" id="titleTp2">
	{{d.title}}
</script>
<script type="text/html" id="titleTp3">
	{{d.content}}
</script>
<script type="text/html" id="titleTp4">
	{{#  if(d.isDeleteFlag == 0){ }}
		<a lay-event='cancel' style='color:#1e9fff;cursor: pointer;'>撤销</a>
	{{#  } else { }}
		<a lay-event='online' style='color:#1e9fff;cursor: pointer;'>发布</a>
	{{#  } }}
</script>
<script type="text/javascript">
	var layer;
	
	var imgName = "";
	
	layui.use('layer', function(){
		var layer = layui.layer;
	});
	
	$(function(){
		listNews();
	
		layui.use('upload', function(){
			var upload = layui.upload;
		
			upload.render({
				elem: '#test3',
				url: '../demo/fileupload.action',
				done: function(res){
					$('#demo1').attr('src',"../newsImage/"+res.data);
					imgName = res.data;
				}
			});
		});
	});
	
	function listNews(){
		layui.use('table', function(){
			var table = layui.table;
			table.render({
				elem:'#demo',
				url :'getListNews.action',
				cols: [[ //表头
					{field:'',title:'新闻图片', width:'15%', align:'center', templet: '#titleTp1'},
					{field:'',title:'标题',    width:'20%', align:'center', templet: '#titleTp2'},
					{field:'',title:'内容',    width:'40%', align:'center', templet: '#titleTp3'},
					{field:'',title:'操作',    width:'15%', align:'center', templet: '#titleTp4'}
				]]
			});
			//监听工具条
			table.on('tool(demo)', function(obj){
				var data = obj.data;
			    if(obj.event === 'cancel'){
					$.ajax({
			        	type: "POST",
			        	url: "updateNews.action",
			        	data: {"id":obj.data.id,"isDeleteFlag":"1"},
			        	dataType: "json",
			        	success: function(data){
			        		if (data.code == 200) {
								layer.msg("新闻撤销成功");
								$(obj.tr['0']).find("td:eq(3)").find('a').attr("lay-event","online");
								$(obj.tr['0']).find("td:eq(3)").find('a').text("发布");
							}
			        	}
					});
			    }
			    if(obj.event === 'online'){
			    	$.ajax({
			        	type: "POST",
			        	url: "updateNews.action",
			        	data: {"id":obj.data.id,"isDeleteFlag":"0"},
			        	dataType: "json",
			        	success: function(data){
			        		if (data.code == 200) {
								layer.msg("新闻发布成功");
								$(obj.tr['0']).find("td:eq(3)").find('a').attr("lay-event","cancel");
								$(obj.tr['0']).find("td:eq(3)").find('a').text("撤销");
							}
			        	}
					});
			    }
			});
		});
	}
	
	function btn1() {
		imgName = "";
		layer.open({
			type: 1, 
			title:"新增新闻",
			area: ['30%','70%'],
			btn:['保存','取消'],
			btnAlign:'c',
			closeBtn:false,
			content: $(".addNews"),
			yes: function(index, layero){
				var isDeleteFlag = $("select[name='isDeleteFlag']").val();
				var title = $("input[name='title']").val();
				if (title == "") {
					layer.msg("新闻标题不能为空");
					return;
				}
				var content = $("textarea[name='content']").val();
				if (content == "") {
					layer.msg("新闻内容不能为空");
					return;
				}
				if (imgName == "") {
					layer.msg("新闻图片不能为空");
					return;
				}
				$.ajax({
		        	type: "POST",
		        	url: "addNews2.action",
		        	data: {"title":title,"content":content,"imgName":imgName,"isDeleteFlag":isDeleteFlag},
		        	dataType: "json",
		        	success: function(data){
		        		if (data.code == 200) {
							layer.closeAll();
							layer.msg("新增新闻成功");
							listNews();
						}else{
							layer.msg(data.msg);
						}
		        	}
				});
			},
			btn1:function(){
				layer.closeAll();
			}
		});
	}
</script>

</html>
