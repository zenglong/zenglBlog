<!Doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>{{title}}</title>
	<!-- Bootstrap core CSS -->
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet">
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<link href="/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="/assets/css/common.css" rel="stylesheet">
	{{# csses}}
	<link href="/assets/css/{{ . }}" rel="stylesheet">
	{{/ csses}}

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.min.js"></script>
		<script src="assets/js/respond.min.js"></script>
	<![endif]-->
	<script src="/assets/js/jquery.min.js"></script>
	{{# head_js}}
	<script src="/assets/js/{{{.}}}"></script>
	{{/ head_js}}
</head>
<body>
<nav class="navbar navbar-fixed-top navbar-inverse">
	<div class="container">
		<div class="navbar-header">
			<!--<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>-->
			{{#static}}
			<a class="navbar-brand" href="/">zenglBlog</a>
			{{/static}}
			{{^static}}
			<a class="navbar-brand" href="/index.zl">zenglBlog</a>
			{{/static}}
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				{{#categories}}
				<li {{#cur}}class="active"{{/cur}} data-id="{{id}}">
					{{#static}}
					<a href="/c/{{id}}/">{{name}}</a>
					{{/static}}
					{{^static}}
					<a href="/article.zl?act=list&amp;cid={{id}}">{{name}}</a>
					{{/static}}
				</li>
				{{/categories}}
				<!--<li class="active"><a href="#">Home</a></li>
				<li><a href="#about">About</a></li>
				<li><a href="#contact">Contact</a></li>-->
			</ul>
		</div><!-- /.nav-collapse -->
	</div><!-- /.container -->
</nav><!-- /.navbar -->

<div class="container">
