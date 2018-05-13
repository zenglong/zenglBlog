{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}<a href="?act=list" class="btn btn-primary pull-right" role="button">返回列表</a></h2>
{{#err_msg}}<div class="alert alert-danger" role="alert">{{err_msg}}</div>{{/err_msg}}
{{#success_msg}}<div class="alert alert-success" role="alert">{{success_msg}}</div>{{/success_msg}}
<form action="?act={{act}}{{#id}}&amp;id={{id}}{{/id}}" method="post" id="cate_form">
	{{#id}}<input type="hidden" name="id" value="{{id}}">{{/id}}
	<div class="form-group">
		<label for="title">标题:</label>
		<input type="text" class="form-control" name="title" {{#posts}}value="{{title}}"{{/posts}} id="title" placeholder="标题">
	</div>
	<div class="form-group">
		<label for="thumbnail-upload">缩略图:</label>
		<input id="thumbnail-upload" type="file" name="thumbnail_up" data-url="upload.zl?act=thumbImg">
		<input id="thumbnail-hidden" type="hidden" name="thumbnail" {{#posts}}value="{{thumbnail}}"{{/posts}}>
		<span id="thumbnail-span"></span>
		<img {{#posts}}src="{{thumbnail}}"{{/posts}} style="display:none" id="thumbnail-img" />
	</div>
	<div class="form-group">
		<label for="description">描述:</label>
		<textarea class="form-control" rows="5" name="description" id="description">{{#posts}}{{description}}{{/posts}}</textarea>
	</div>
	<div class="form-group">
		<label for="content">内容:</label>
		<textarea class="form-control" rows="20" cols="80" name="content" id="content">{{#posts}}{{content}}{{/posts}}</textarea>
	</div>
	{{#category}}
	<div class="form-group" id="p-cate">
		<label>上级分类:<span id="p-cate-name">{{name}}(cid={{id}})</span></label>
		<input type="hidden" name="cid" value="{{id}}" id="pid">
		<a href="javascript:void(0)" id="reset_category" class="btn btn-default" data-loading-text="加载分类列表...">重置上级分类</a>
	</div>
	{{/category}}
	{{^category}}
	<div class="form-group" id="p-cate">
		<label for="pid">上级分类:<span id="p-cate-name">(cid=0)</span></label>
		<input type="hidden" name="cid" value="0" id="pid">
		<select class="form-control sel_pid">
			<option value="0" data-childcnt="0">选择上级分类</option>
			{{#categories}}
			<option value="{{id}}" data-childcnt="{{childcnt}}">{{name}}</option>
			{{/categories}}
		</select>
	</div>
	{{/category}}
	<div class="form-group">
		<label for="author">作者:</label>
		<input type="text" class="form-control" name="author" {{#posts}}value="{{author}}"{{/posts}} id="author" placeholder="作者">
	</div>
	<button name="submit" value="Submit" type="submit" class="btn btn-primary">提交</button>
</form>
<script type="text/javascript">
	CKEDITOR.replace( 'content' ,{
		height: 300,
		filebrowserUploadUrl: 'upload.zl?act=ckImage',
		filebrowserUploadMethod: 'form'
	});
	$('#thumbnail-upload').fileupload({
		dataType: 'json',
		formData: {},
		add: function(e, data) {
			$('#thumbnail-span').text('上传中...');
			data.submit();
		},
		done: function (e, data) {
			if(typeof data.result.error === "undefined") {
				var $img = $('#thumbnail-img');
				$img.attr("src", data.result.urlpath);
				$img.show();
				$('#thumbnail-span').text('');
				$('#thumbnail-hidden').val(data.result.urlpath);
			} else {
				$('#thumbnail-img').hide();
				$('#thumbnail-span').text(data.result.error);
				$('#thumbnail-hidden').val("");
			}
        },
		fail: function() {
			$('#thumbnail-span').text('上传失败');
		}
	});

	$(document).ready(function() {
		{{#category}} {{! 如果设置了上级分类，则添加重置上级分类的脚本 }}	
		$('#reset_category').click(function(){
			reset_category_ajax();
		});
		{{/category}}
		var $img = $('#thumbnail-img');
		if($img.attr('src') != '') { // 如果所略图不为空，则在一开始就显示出来
			$img.show();
		}
	});
</script>
{{> tpl/footer.tpl}}
