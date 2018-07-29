{{> tpl/header.tpl}}
<h2 class="sub-header">
	评论列表
</h2>
<div class="table-responsive">
	<form action="?" method="get">
		<div class="form-group" id="form-stitle">
			<input type="text" class="form-control" name="stitle" {{#stitle}}value="{{stitle}}"{{/stitle}} placeholder="文章标题">
		</div>
		<div class="form-group" id="form-snickname">
			<input type="text" class="form-control" name="snickname" {{#snickname}}value="{{snickname}}"{{/snickname}} placeholder="昵称">
		</div>
		<div class="form-group" id="form-search-status">
			<select class="form-control" name="search_status">
				<option value="-1">状态选择</option>
				<option value="0">待审核</option>
				<option value="1">审核通过</option>
				<option value="2">审核不通过</option>
			</select>
		</div>
		<div style="float:left"><button name="s" value="search" type="submit" class="btn btn-primary">搜索</button></div>
		<div style="clear:both"></div>
	</form>
	<table class="table table-striped">
		<thead>
		<tr>
			<th>id</th>
			<th>文章标题</th>
			<th>昵称</th>
			<th>状态</th>
			<th>发表时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
			{{#comments}}
			<tr>
				<td>{{id}}</td>
				<td>{{title}}</td>
				<td>{{nickname}}</td>
				<td>{{{status_text}}}</td>
				<td>{{created_at}}</td>
				<td>
					<a href="/article.zl?id={{aid}}" title="查看文章" class="glyphicon glyphicon-eye-open" aria-hidden="true" target="_blank"></a>&nbsp;&nbsp;
					<a href="javascript:void(0);" title="审核通过" class="glyphicon glyphicon-ok comment-pass" aria-hidden="true" data-id="{{id}}"></a><span></span>&nbsp;&nbsp;
					<a href="javascript:void(0);" title="审核不通过" class="glyphicon glyphicon-ban-circle comment-reject" aria-hidden="true" data-id="{{id}}"></a><span></span>
				</td>
			</tr>
			<tr>
				<td colspan=6>
					<h4><span class="label label-primary">评论内容：</span></h4>
					{{{ content }}}
					{{#reject_reason}}
						<h5><span class="label label-danger">审核不通过原因：</span>&nbsp;&nbsp;{{reject_reason}}</h5>
					{{/reject_reason}}
				</td>
			</tr>
			{{/comments}}
			{{^comments}}
				<tr><td colspan=6>暂无评论</td></tr>
			{{/comments}}
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
	<span>总共{{total}}个评论/共{{totalpage}}页</span>
	{{/page}}
</div>
<script type="text/javascript">
function ajaxGetPost(arg_url, arg_type, arg_data, next_span)
{
	$.ajax({
		type: arg_type,
		url: arg_url,
		dataType: "json",
		data: arg_data,
		beforeSend:function(){
			next_span.text(' 操作中...');
		},
		success: function(data){
			if(data.msg != 'success') {				
				alert('操作失败: ' + data.errmsg);
				next_span.text('');
				return;
			}
			alert('操作成功');
			window.location.reload();
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			next_span.text('');
		}
	});	
}

$( document ).ready(function() {
	var search_status = {{ search_status }};
	if(search_status >= 0) {
		$('#form-search-status select').val(search_status);
	}

	$('.comment-pass').click(function(){
		var id = $(this).data('id');
		var next_span = $(this).next('span');
		var r = confirm("审核通过确认[id: "+id+"]");
		if(r == true) {
			var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
			var url = "comment.zl?timestamp="+timestamp;
			ajaxGetPost(url, 'GET', {"act": "pass", "id": id}, next_span);
		}
	});

	$('.comment-reject').click(function(){
		var id = $(this).data('id');
		var next_span = $(this).next('span');
		var r = confirm("审核不通过确认[id: "+id+"]");
		if(r == true) {
			var reject_reason=prompt("请输入拒绝(不通过)理由","");
			var timestamp = new Date().getTime();
			var url = "comment.zl?act=reject&timestamp="+timestamp;
			ajaxGetPost(url, 'POST', {"id": id, "reject_reason": reject_reason}, next_span);
		}
	});
});
</script>
{{> tpl/footer.tpl}}
