{{> tpl/header.tpl}}
<h2 class="sub-header">
	友情链接
	<a href="?act=add" class="btn btn-primary pull-right" role="button">添加友情链接</a>
</h2>
<div class="table-responsive">
	<table class="table table-hover">
		<thead>
		<tr>
			<th>id</th>
			<th>网站名称</th>
			<th>网站LOGO</th>
			<th>网站url</th>
			<th>创建时间</th>
			<th>更新时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
			{{#items}}
			<tr>
				<td>{{id}}</td>
				<td>{{name}}</td>
				<td>{{#logo}}<img src="{{logo}}" />{{/logo}}{{^logo}}无{{/logo}}</td>
				<td>{{url}}</td>
				<td>{{created_at}}</td>
				<td>{{updated_at}}</td>
				<td>
					<a href="?act=edit&amp;id={{id}}" title="编辑" class="glyphicon glyphicon-edit" aria-hidden="true"></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" data-id="{{id}}" title="删除" class="glyphicon glyphicon-trash del_friendly" aria-hidden="true"></a><span></span>
				</td>
			</tr>
			<tr>
				<td colspan=7>
					{{{ description }}}
				</td>
			</tr>
			{{/items}}
			{{^items}}
				<tr><td colspan=8>暂无友情链接</td></tr>
			{{/items}}
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
	<span>总共{{total}}条友情链接/共{{totalpage}}页</span>
	{{/page}}
</div>
<script type="text/javascript">
$( document ).ready(function() {
	$('.del_friendly').click(function(){
		var id = $(this).data('id');
		var next_span = $(this).next('span');
		var r = confirm("删除友情链接确认[id: "+id+"]");
		if(r == true) {
			var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
			$.ajax({
				type: 'GET',
				url: "friendly.zl?timestamp="+timestamp,
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
});
</script>
{{> tpl/footer.tpl}}
