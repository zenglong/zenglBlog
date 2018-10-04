{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}<a href="?act=list" class="btn btn-primary pull-right" role="button">返回列表</a></h2>

{{#err_msg}}<div class="alert alert-danger" role="alert">{{err_msg}}</div>{{/err_msg}}
{{#success_msg}}<div class="alert alert-success" role="alert">{{success_msg}}</div>{{/success_msg}}

<form action="?act={{act}}{{#id}}&amp;id={{id}}{{/id}}" method="post" id="notice_form">
	{{#id}}<input type="hidden" name="id" value="{{id}}">{{/id}}
	<div class="form-group">
		<label for="title">公告标题:</label>
		<input type="text" class="form-control" name="title" {{#posts}}value="{{title}}"{{/posts}} id="title" placeholder="公告标题">
	</div>
	<div class="form-group">
		<label for="description">公告详情:</label>
		<textarea class="form-control" rows="10" name="description" id="description">{{#posts}}{{description}}{{/posts}}</textarea>
	</div>
	<button name="submit" value="Submit" type="submit" class="btn btn-primary">提交</button>
</form>
{{> tpl/footer.tpl}}
