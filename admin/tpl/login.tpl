<!Doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>{{title}}</title>
	<!-- Bootstrap core CSS -->
	<link href="assets/css/bootstrap.min.css" rel="stylesheet">
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<link href="assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="assets/css/login.css" rel="stylesheet">

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.min.js"></script>
		<script src="assets/js/respond.min.js"></script>
	<![endif]-->
	<script src="/assets/js/jquery.min.js"></script>
</head>
<body>
	<div class="container login-container">
		<div class="form-signin">
			<h2 class="form-signin-heading">{{title}}</h2>
			<label for="username" class="sr-only">用户名</label>
			<input type="text" id="username" class="form-control" placeholder="用户名" required autofocus>
			<label for="password" class="sr-only">密码</label>
			<input type="password" id="password" class="form-control" placeholder="密码" required>
			<button id="submit" class="btn btn-lg btn-primary btn-block" type="button" data-loading-text="登录中...">登 录</button>
		</div>
	</div> <!-- /container -->

	<script type="text/javascript">
	function getError(errTitle, errContent)
	{
		return '<div class="alert alert-danger alert-dismissible err-alert" role="alert">' +
					'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
					'<strong class="err-title">'+errTitle+'</strong> <span class="err-content">'+errContent+'</span>'+
				'</div>';
	}

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
				$('.err-alert').remove();
				$("#submit").button('loading');
			},
			success: function(data){
				if(data.msg == 'success') {
					$('#submit').text('登录成功 准备跳转...');
					setTimeout(function(){
						window.location = 'admin.zl';
					}, 1000);
				}
				else {
					$('.login-container').prepend(getError('登录失败：', data.errmsg));
					$("#submit").button('reset');
				}
			},
			//调用出错执行的函数
			error: function(err){
				$('.login-container').prepend(getError('登录失败：', '未知错误！'));
				$("#submit").button('reset');
			}
		});
	});
	</script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

