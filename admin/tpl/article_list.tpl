{{> tpl/header.tpl}}
<h2 class="sub-header">
	文章列表
	<a href="?act=add" class="btn btn-primary pull-right" role="button">添加文章</a>
</h2>
<div class="table-responsive">
	<form action="?" method="get" id="cate_form">
		<div class="form-group" id="p-title">
			<input type="text" class="form-control" name="stitle" {{#stitle}}value="{{stitle}}"{{/stitle}} placeholder="标题">
		</div>
		<div class="form-group" id="p-cate">
			{{#category}}
				<label id="p-cate-label">所属分类:<span id="p-cate-name">{{name}}(cid={{id}})</span></label>
				<input type="hidden" name="cid" value="{{id}}" id="pid">
				<a href="javascript:void(0)" id="reset_category" class="btn btn-default" data-loading-text="加载分类列表...">重置分类</a>
			{{/category}}
			{{^category}}
				<input type="hidden" name="cid" value="0" id="pid">
				<select class="form-control sel_pid">
					<option value="0" data-childcnt="0">选择上级分类</option>
					{{#categories}}
					<option value="{{id}}" data-childcnt="{{childcnt}}">{{name}}</option>
					{{/categories}}
				</select>
			{{/category}}
		</div>
		<div style="float:left"><button name="s" value="search" type="submit" class="btn btn-primary">搜索</button></div>
		<div style="clear:both"></div>
	</form>
	<table class="table table-hover">
		<thead>
		<tr>
			<th>id</th>
			<th>缩略图</th>
			<th>标题</th>
			<th>作者</th>
			<th>所属分类</th>
			<th>创建时间</th>
			<th>更新时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
			{{#articles}}
			<tr>
				<td>{{id}}</td>
				<td>{{#thumbnail}}<img src="{{thumbnail}}" width="100" height="80"/>{{/thumbnail}}</td>
				<td>{{title}}</td>
				<td>{{author}}</td>
				<td>{{cname}}</td>
				<td>{{created_at}}</td>
				<td>{{updated_at}}</td>
				<td>
					<a href="/article.zl?id={{id}}" title="查看" class="glyphicon glyphicon-eye-open" aria-hidden="true" target="_blank"></a>&nbsp;&nbsp;
					<a href="?act=edit&amp;id={{id}}" title="编辑" class="glyphicon glyphicon-edit" aria-hidden="true"></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" data-id="{{id}}" title="删除" class="glyphicon glyphicon-trash del_article" aria-hidden="true"></a><span></span></td>
			</tr>
			{{/articles}}
			{{^articles}}
				<tr><td colspan=8>暂无文章</td></tr>
			{{/articles}}
		</tbody>
	</table>
	{{#page}}
	<nav aria-label="Page navigation">
	  <ul class="pagination">
		<li>
		  <a href="{{{link}}}page=1" aria-label="Previous">
		    <span aria-hidden="true">&laquo;</span>
		  </a>
		</li>
		<li>
		  <a href="{{{link}}}page={{prev}}" aria-label="Previous">
		    <span aria-hidden="true">&lsaquo;</span>
		  </a>
		</li>
		{{#pages}}
			{{{.}}}
		{{/pages}}
		<li>
		  <a href="{{{link}}}page={{next}}" aria-label="Next">
		    <span aria-hidden="true">&rsaquo;</span>
		  </a>
		</li>
		<li>
		  <a href="{{{link}}}page={{totalpage}}" aria-label="Next">
		    <span aria-hidden="true">&raquo;</span>
		  </a>
		</li>
	  </ul>
	</nav>
	<span>总共{{total}}篇文章/共{{totalpage}}页</span>
	{{/page}}
</div>
<script type="text/javascript">
$( document ).ready(function() {
	$('.del_article').click(function(){
		var id = $(this).data('id');
		var next_span = $(this).next('span');
		var r = confirm("删除文章确认[id: "+id+"]");
		if(r == true) {
			var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
			$.ajax({
				type: 'GET',
				url: "article.zl?timestamp="+timestamp,
				dataType: "json",
				data: {
					"act": "delete",
					"id": id
				},
				beforeSend:function(){
					next_span.text(' 删除中...');
				},
				success: function(data){
					if(data.msg != 'success') {					
						alert('删除失败: ' + data.errmsg);
						next_span.text('');
						return;
					}
					alert('删除成功');
					window.location.reload();
				},
				//调用出错执行的函数
				error: function(err){
					alert('未知异常');
					next_span.text('');
				}
			});
		}
	});

	{{#category}} {{! 如果设置了上级分类，则添加重置上级分类的脚本 }}	
	$('#reset_category').click(function(){
		reset_category_ajax();
		$('#p-cate-label').hide();
	});
	{{/category}}
});
</script>
{{> tpl/footer.tpl}}
