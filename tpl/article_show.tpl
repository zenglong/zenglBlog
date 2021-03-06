{{> /tpl/header.tpl}}
<ol class="breadcrumb">
  {{#static}}
  <li><a href="/">{{site_name}}</a></li>
  <li><a href="/c/{{ cid }}/">{{ catname }}</a></li>
  {{/static}}
  {{^static}}
  <li><a href="/index.zl">{{site_name}}</a></li>
  <li><a href="/article.zl?act=list&amp;cid={{ cid }}">{{ catname }}</a></li>
  {{/static}}
  <li class="active">{{title}}</li>
</ol>
<div class="row">
	<div class="col-xs-18 col-sm-12">
		<div class="page-header text-center">
			<h2>{{title}}</h2>
			<h3><small>{{ author }}&nbsp;&nbsp;{{ created_at }}</small></h3>
		</div>
		<div class="row description container">
			<div class="jumbotron">
				<p>{{ description }}</p>
			</div>
		</div>
		<div class="row content container">
			<div>
				{{{ content }}}
			</div>
			<div>
				<a class="btn-try btn btn-primary btn-lg disabled" href="javascript:void(0);">上下篇</a>
				<p>下一篇：
					{{^next_article}}暂无{{/next_article}}
					{{#next_article}}
						{{#static}}
							<a href="/a/{{format_created}}/{{id}}.html">{{ title }}</a>
						{{/static}}
						{{^static}}
							<a href="?id={{id}}">{{ title }}</a>
						{{/static}}
					{{/next_article}}
				</p>
				<p>上一篇：
					{{^prev_article}}暂无{{/prev_article}}
					{{#prev_article}}
						{{#static}}
							<a href="/a/{{format_created}}/{{id}}.html">{{ title }}</a>
						{{/static}}
						{{^static}}
							<a href="?id={{id}}">{{ title }}</a>
						{{/static}}
					{{/prev_article}}
				</p>
			</div>
			<div>
				<a class="btn-try btn btn-primary btn-lg disabled" href="javascript:void(0);">相关文章</a>
				{{^rand_article}}暂无{{/rand_article}}
				{{#rand_article}}
					{{#static}}
						<p><a href="/a/{{format_created}}/{{id}}.html">{{ title }}</a></p>
					{{/static}}
					{{^static}}
						<p><a href="?id={{id}}">{{ title }}</a></p>
					{{/static}}
				{{/rand_article}}
			</div>
		</div>
	</div>
</div>
{{#show_comment}}
<div class="row comment-list left-right-pad">
	<a class="btn-try btn btn-primary btn-lg disabled" href="javascript:void(0);">评论列表</a>
	<span class="comment-loading"></span>
</div>

<div class="row text-center left-right-pad">
	<button type="button" class="btn btn-inverse comment-load-btn" style="display:none" data-loading-text="加载中...">
		加载更多
	</button>
	<span class="no-more-comment-tip" style="display:none">没有更多评论了</span>
</div>

<div class="row left-right-pad">
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-default comment-btn">
		发表评论
	</button>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">发表评论</h4>
				</div>
				<div class="modal-body" id="comment-modal-body">
					<div class="form-group">
						<label for="comment-nickname">昵称</label>
						<input type="text" class="form-control" id="comment-nickname" placeholder="请输入昵称">
					</div>
					<div class="form-group">
						<label for="comment-content">评论内容</label>
						<textarea class="form-control" id="comment-content" rows="5"></textarea>
					</div>
					<div class="form-group">
						<label for="comment-captcha">验证码</label>
						<input type="text" class="form-control" id="comment-captcha" placeholder="请输入验证码">
						<img id="comment-captcha-img" src="" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="comment-submit" data-loading-text="提交中...">提交</button>
				</div>
			</div>
		</div>
	</div>
</div>
{{/show_comment}}
<script type="text/javascript">
	$(document).ready(function () { 
		if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) { // 检测到手机端则使用小的返回顶部图片
			$.fn.yestop({yes_image: '/assets/image/yestop_sm.png', yes_bottom:"15px", yes_right: "15px", yes_width: "36px", yes_height: "36px"});
		}
		else { // 否则使用大的返回顶部图片
			$.fn.yestop({yes_image: '/assets/image/yestop.png'});
		}
		$(".row .content img").removeAttr("style").addClass("img-responsive center-block");
	});
	{{#show_comment}}
	function getError(errTitle, errContent)
	{
		return '<div class="alert alert-danger alert-dismissible err-alert" role="alert">' +
					'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
					'<strong class="err-title">'+errTitle+'</strong> <span class="err-content">'+errContent+'</span>'+
				'</div>';
	}

	$('.comment-btn').click(function(){
		$("#comment-captcha-img").attr("src", '/captcha.zl?' + (new Date().getTime()));
		$('#myModal').modal({
			keyboard: false
		});
	});

	$('#comment-submit').click(function(){
		$.ajax({
			type: 'POST',
			url: "/comment.zl?act=add",
			dataType: "json",
			data: {
				"nickname": $('#comment-nickname').val(),
				"content": $('#comment-content').val(),
				"captcha": $('#comment-captcha').val(),
				"aid": {{ id }}
			},
			beforeSend:function(){
				$('.err-alert').remove();
				$("#comment-submit").button('loading');
			},
			success: function(data){
				if(data.msg == 'success') {
					$('#comment-content').val('');
					alert('提交成功，等待审核');
				}
				else {
					$('#comment-modal-body').prepend(getError('提交失败：', data.errmsg));
				}
				$("#comment-captcha-img").attr("src", '/captcha.zl?' + (new Date().getTime()));
				$("#comment-submit").button('reset');
			},
			//调用出错执行的函数
			error: function(err){
				$('#comment-modal-body').prepend(getError('提交失败：', '未知错误！'));
				$("#comment-submit").button('reset');
			}
		});
	});

	var comment_load_page = 1;

	function comment_load()
	{
		var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
		$.ajax({
			type: 'GET',
			url: "/comment.zl?timestamp=" + timestamp,
			data: {
				"act": 'list',
				"aid": {{ id }},
				"page": comment_load_page++
			},
			dataType: "json",
			beforeSend:function(){
				if((comment_load_page - 1) == 1)
					$(".comment-loading").text('loading');
				else
					$(".comment-load-btn").button('loading');
			},
			success: function(data){
				if(data.msg == 'success') {
					if(data.comments.length > 0) {
						var comments_list_html = '';
						for(var i=0; i < data.comments.length; i++) {
							comments_list_html += '<div class="panel panel-default">';
							comments_list_html += '<div class="panel-heading">'+data.comments[i].nickname + '&nbsp;&nbsp;<small class="author-create-at">' + data.comments[i].created_at +'</small></div>';
							comments_list_html += '<div class="panel-body">'+data.comments[i].content.replace(/(?:\r\n|\r|\n)/g, '<br>')+'</div>';
							comments_list_html += '</div>';
						}
						$('.comment-list').append(comments_list_html);
					}
					if(data.comments.length <= 0 || data.comments.length < data.per_page) {
						$(".comment-load-btn").remove();
						if((comment_load_page - 1) == 1) {
							if(data.comments.length <= 0)
								$(".no-more-comment-tip").text('暂无评论');
							else
								$(".no-more-comment-tip").text('');
						}
						$(".no-more-comment-tip").show();
					}
					else {
						$(".comment-load-btn").show();
						$(".no-more-comment-tip").hide();
					}
				}
				$(".comment-loading").text('');
				$(".comment-load-btn").button('reset');
			},
			error: function(err){
				if((comment_load_page - 1) == 1)
					$(".comment-loading").text('loading failed: unknown error');
				else
					alert('loading failed: unknown error');
				$(".comment-load-btn").button('reset');
			}
		});
	}

	$(document).ready(function () {
		comment_load();
	});

	$(".comment-load-btn").click(function(){
		comment_load();
	});
	{{/show_comment}}

	// 锚链跳转
	global_this_url=location.href;
	url_reg = /#.*?$/g
	global_this_url = global_this_url.replace(url_reg,"");
	function this_jumpto(name)
	{
		window.location.href=global_this_url+"#"+name;
	}
</script>
{{> /tpl/footer.tpl}}
