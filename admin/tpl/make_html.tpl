{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}</h2>
<div class="table-responsive">
	<div class="form-group">
		<select class="form-control" id="sel-category">
			<option value="0">生成全部分类</option>
			{{#categories}}
				<option value="{{id}}">{{name}}</option>
			{{/categories}}
		</select>
	</div>
	<div class="form-group">
		<button class="btn btn-primary" id="start-make" type="button" data-loading-text="生成中...">开始生成</button>
	</div>
	<div class="progress">
	  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
		0%
	  </div>
	</div>
	<div class="form-group">
		<textarea id="log-textarea" readonly style="width:100%; height: 400px"></textarea>
	</div>
</div>
<script type="text/javascript">
$('#start-make').on('click', function(){
	setProgress(0);
	$('#log-textarea').text('');
	var sel_cid = $('#sel-category').val();
	if(sel_cid > 0) {
		makeArticle(sel_cid, [], 1, -1, 0, 0, 2);
	}
	else if (sel_cid == 0) {
		cids = [];
		$("#sel-category option").each(function(){
			var cid = $(this).val();
			if(cid > 0)
				cids.push(cid);
		});
		if(cids.length == 0) {
			alert('暂无分类，无需执行');
			return;
		}
		makeArticle(cids[0], cids, 1, -1, 0, 0, cids.length + 1);
	}
});

function makeArticle(cid, cids, page, total_count, get_count, cur_idx, total){
	var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
	$.ajax({
		type: 'GET',
		url: "make_article_html.zl?timestamp="+timestamp,
		dataType: "json",
		data: {
			"cid": cid,
			"p": page,
			"getinfo": ((total_count < 0) ? 'yes' : 'no'),
		},
		beforeSend:function(){
			$("#start-make").button('loading');
		},
		success: function(data){
			if(total_count < 0) {
				total_count = data.info.count;
			}
			get_count += data.articles.length;
			for(var i=0; i < data.articles.length;i++) {
				$('#log-textarea').append('生成文章 [id:' + data.articles[i].id + '] ' + data.articles[i].title + "\n\n");
			}
			if(typeof data.category.id !== 'undefined' && typeof data.category.name !== 'undefined') {
				$('#log-textarea').append('生成分类 [cid:' + data.category.id + '] ' + data.category.name + ' [页数:' + page + ']' + "\n\n");
			}
			if(total_count == 0 || get_count >= total_count) {
				setProgress((++cur_idx / total) * 100);
				if(cids.length == 0 || cur_idx >= (total - 1)) {
					makeIndex();
				}
				else {
					makeArticle(cids[cur_idx], cids, 1, -1, 0, cur_idx, total);
				}
				return;
			}
			if(get_count < total_count) {
				setProgress((cur_idx / total + ((1 / total) * (get_count / total_count))) * 100);
				makeArticle(cid, cids, ++page, total_count, get_count, cur_idx, total);
			}
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			$("#start-make").button('reset');
		}
	});
}

function makeIndex() {
	var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
	$.ajax({
		type: 'GET',
		url: "make_index_html.zl?timestamp="+timestamp,
		dataType: "json",
		beforeSend:function(){
			$("#start-make").button('loading');
		},
		success: function(data){
			$('#log-textarea').append("生成首页\n\n");
			setProgress(100);
			$("#start-make").button('reset');
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			$("#start-make").button('reset');
		}
	});
}

function setProgress(percent)
{
	$('.progress-bar').css('width', percent + "%");
	$('.progress-bar').text(percent + "%");
}

</script>
{{> tpl/footer.tpl}}
