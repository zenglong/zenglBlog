<!Doctype html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<script src="/assets/jquery.min.js"></script>
	<title>{{title}}</title>
</head>
<body>
<h3>{{title}}</h3>

<div>
	<p>用户名: <input type="text" id="username" /></p>
	<p>密码: <input type="text" id="password" /></p>
	<input type="button" id="submit" value="登录" />
</div>
<script type="text/javascript">
$('#submit').click(function(){
	$.ajax({
		type: 'POST',
		url: "login.zl",
		dataType: "json",
		data: {
			"username": $('#username').val(),
			"password": $('#password').val(),
			"submit": "Submit"
		},
		beforeSend:function(){
			$("#submit").html("登录中...");
		},
		success: function(data){
			if(data.msg == 'success') {
				alert("success");
				window.location = 'admin.zl';
			}
			else
				alert("failed");
			console.log(data);
		},
		//调用出错执行的函数
		error: function(err){
			alert("error");
			console.log(err);
		},
		complete: function(XMLHttpRequest, textStatus){
			$("#submit").html("登录");
		}
	});
});
</script>
</body>
</html>
