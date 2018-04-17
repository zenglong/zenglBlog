{{> tpl/header.tpl}}
<h2 class="sub-header">
	{{#category}}[{{name}}] {{/category}}
	{{pid_title}}{{title}}
	<a href="?pid=-1" class="btn btn-default pull-right" role="button" style="margin-left:10px">查看所有分类</a>
	<a href="?act=add" class="btn btn-primary pull-right" role="button">添加分类</a>
</h2>
<div class="table-responsive">
	<table class="table table-hover">
		<thead>
		<tr>
			<th>id</th>
			<th>分类名</th>
			<th>类型</th>
			<th>分类描述</th>
			<th>pid</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
			{{#categories}}
			<tr>
				<td>{{id}}</td>
				<td>{{name}}</td>
				<td>{{type_name}}</td>
				<td>{{description}}</td>
				<td>{{pid}}</td>
				<td>{{#childcnt}}
					<a href="?pid={{id}}" title="查看子分类({{childcnt}})" class="glyphicon glyphicon-list-alt" aria-hidden="true"></a>&nbsp;&nbsp;
					{{/childcnt}}
					<a href="?act=edit&amp;id={{id}}" title="编辑" class="glyphicon glyphicon-edit" aria-hidden="true"></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" data-id="{{id}}" title="删除" class="glyphicon glyphicon-trash del_category" aria-hidden="true"></a><span></span></td>
			</tr>
			{{/categories}}
			{{^categories}}
				<tr><td colspan=6>暂无分类或子分类</td></tr>
			{{/categories}}
		</tbody>
	</table>
</div>
<script type="text/javascript">
$( document ).ready(function() {
$('.del_category').click(function(){
	var id = $(this).data('id');
	var next_span = $(this).next('span');
	var r = confirm("删除确认");
	if(r == true) {
		var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
		$.ajax({
			type: 'GET',
			url: "category.zl?timestamp="+timestamp,
			dataType: "json",
			data: {
				"act": "ajaxDelete",
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
