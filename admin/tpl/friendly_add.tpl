{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}<a href="?act=list" class="btn btn-primary pull-right" role="button">返回列表</a></h2>

{{#err_msg}}<div class="alert alert-danger" role="alert">{{err_msg}}</div>{{/err_msg}}
{{#success_msg}}<div class="alert alert-success" role="alert">{{success_msg}}</div>{{/success_msg}}

<form action="?act={{act}}{{#id}}&amp;id={{id}}{{/id}}" method="post" id="notice_form">
	{{#id}}<input type="hidden" name="id" value="{{id}}">{{/id}}
	<div class="form-group">
		<label for="title">网站名称:</label>
		<input type="text" class="form-control" name="name" {{#posts}}value="{{name}}"{{/posts}} id="title" placeholder="网站名称">
	</div>
	<div class="form-group">
		<label for="title">网站url:</label>
		<input type="text" class="form-control" name="url" {{#posts}}value="{{url}}"{{/posts}} id="title" placeholder="网站url">
	</div>
	<div class="form-group">
		<label for="logo-upload">网站LOGO:</label>
		<input id="logo-upload" type="file" name="thumbnail_up" data-url="upload.zl?act=thumbImg&amp;width=200&amp;height=100">
		<input id="logo" type="text" name="logo" {{#posts}}value="{{logo}}"{{/posts}} class="form-control"><br/>
		<span id="logo-span"></span>
		<img {{#posts}}src="{{logo}}"{{/posts}} style="display:none" id="logo-img" />
	</div>
	<div class="form-group">
		<label for="description">网站描述:</label>
		<textarea class="form-control" rows="5" name="description" id="description">{{#posts}}{{description}}{{/posts}}</textarea>
	</div>
	<button name="submit" value="Submit" type="submit" class="btn btn-primary">提交</button>
</form>
<script type="text/javascript">
	$('#logo-upload').fileupload({
		dataType: 'json',
		formData: {},
		add: function(e, data) {
			$('#logo-span').text('上传中...');
			data.submit();
		},
		done: function (e, data) {
			if(typeof data.result.error === "undefined") {
				var $img = $('#logo-img');
				$img.attr("src", data.result.urlpath);
				$img.show();
				$('#logo-span').text('');
				$('#logo').val(data.result.urlpath);
			} else {
				$('#logo-img').hide();
				$('#logo-span').text(data.result.error);
				$('#logo').val("");
			}
		},
		fail: function() {
			$('#logo-span').text('上传失败');
		}
	});

	$(document).ready(function() {
		var $img = $('#logo-img');
		if($img.attr('src') != '') { // 如果所略图不为空，则在一开始就显示出来
			$img.show();
		}
	});
</script>
{{> tpl/footer.tpl}}
