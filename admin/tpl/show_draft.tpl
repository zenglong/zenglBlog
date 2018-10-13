<!Doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>查看草稿</title>
</head>
<body>
	{{#message}}
		<p>{{message}}</p>
	{{/message}}
	{{^message}}
		<div>草稿(id:{{id}})保存时间：{{time}}</div>
		<div>标题：{{title}}</div>
		<div>缩略图：{{thumbnail}}</div>
		<div>关键词：{{keywords}}</div>
		<div>描述：{{description}}</div>
		<div>分类ID：{{cid}}</div>
		<div>作者：{{author}}</div>
		<div>内容：</div>
		<div>{{{content}}}</div>
	{{/message}}
</body>
</html>
