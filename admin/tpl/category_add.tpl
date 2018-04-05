{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}<a href="?act=list" class="btn btn-primary pull-right" role="button">返回列表</a></h2>
{{#err_msg}}<div class="alert alert-danger" role="alert">{{err_msg}}</div>{{/err_msg}}
{{#success_msg}}<div class="alert alert-success" role="alert">{{success_msg}}</div>{{/success_msg}}
<form action="?act={{act}}{{#id}}&amp;id={{id}}{{/id}}" method="post" id="cate_form">
	{{#id}}<input type="hidden" name="id" value="{{id}}">{{/id}}
	<div class="form-group">
		<label for="name">分类名:</label>
		<input type="text" class="form-control" name="name" {{#posts}}value="{{name}}"{{/posts}} id="name" placeholder="分类名">
	</div>
	<div class="form-group">
		<label for="description">分类描述/外链地址:</label>
		<textarea class="form-control" rows="5" name="description" id="description">{{#posts}}{{description}}{{/posts}}</textarea>
	</div>
	<div class="form-group">
		<label for="sel_type">类型:</label>
		<select class="form-control" id="sel_type" name="type">
			<option value="0">普通文章</option>
			<option value="1">外部链接</option>
		</select>
	</div>
	{{#category}}
	<div class="form-group" id="p-cate">
		<label>上级分类:<span id="p-cate-name">{{name}}(pid={{id}})</span></label>
		<input type="hidden" name="pid" value="{{id}}" id="pid">
		<a href="javascript:void(0)" id="reset_category" class="btn btn-default" data-loading-text="加载分类列表...">重置上级分类</a>
	</div>
	{{/category}}
	{{^category}}
	<div class="form-group" id="p-cate">
		<label for="pid">上级分类:<span id="p-cate-name">(pid=0)</span></label>
		<input type="hidden" name="pid" value="0" id="pid">
		<select class="form-control sel_pid">
			<option value="0" data-childcnt="0">选择上级分类</option>
			{{#categories}}
			<option value="{{id}}" data-childcnt="{{childcnt}}">{{name}}</option>
			{{/categories}}
		</select>
	</div>
	{{/category}}
	<div id="cate-loading" style="display:none">加载子分类...</div>
	<button name="submit" value="Submit" type="submit" class="btn btn-primary">提交</button>
</form>
<script type="text/javascript">
$( document ).ready(function() {
{{#category}} {{! 如果设置了上级分类，则添加重置上级分类的脚本 }}
$('#reset_category').click(function(){
	$.ajax({
		type: 'GET',
		url: "category.zl",
		dataType: "json",
		data: {
			"act": "ajaxList",
			"pid": 0
		},
		beforeSend:function(){
			$("#reset_category").button('loading');
		},
		success: function(data){
			var sel_html = '<select class="form-control sel_pid"><option value="0" data-childcnt="0">选择上级分类</option>';
			for(var i=0; i < data.length;i++) {
				sel_html += '<option value="'+data[i].id+'" data-childcnt="'+data[i].childcnt+'">'+data[i].name+'</option>';
			}
			sel_html += '</select>';
			$('#reset_category').remove();
			$('#p-cate-name').text('(pid=0)');
			$('#pid').val(0);
			$('#p-cate').append(sel_html);
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			$("#reset_category").button('reset');
		}
	});
});
{{/category}}

{{#posts}}
$('#sel_type').val({{type}});
{{/posts}}

$("#cate_form").on('change', ".sel_pid", function(){
	var option_sel = $(this).find("option:selected");
	var pid = this.value;
	var childcnt = option_sel.data('childcnt');
	if(childcnt <= 0)
		$(this).nextAll().remove();
	if(pid == -1) {
		option_sel = $(this).prev('.sel_pid').find("option:selected");
		pid = option_sel.val();
	}
	var sel_text = option_sel.text();
	$('#pid').val(pid);
	if(pid == 0)
		$('#p-cate-name').text('(pid=0)');
	else
		$('#p-cate-name').text(sel_text + '(pid='+pid+')');
	if(this.value <= 0 || childcnt <= 0)
		return ;
	var that = this;
	$.ajax({
		type: 'GET',
		url: "category.zl",
		dataType: "json",
		data: {
			"act": "ajaxList",
			"pid": pid
		},
		beforeSend:function(){
			$("#cate-loading").show();
		},
		success: function(data){
			if(data.length > 0) {
				var sel_html = '<select class="form-control sel_pid"><option value="-1" data-childcnt="0">[选择子分类]</option>';
				for(var i=0; i < data.length;i++) {
					sel_html += '<option value="'+data[i].id+'" data-childcnt="'+data[i].childcnt+'">'+data[i].name+'</option>';
				}
				sel_html += '</select>';
				$(that).nextAll().remove();
				$('#p-cate').append(sel_html);
			}
			$("#cate-loading").hide();
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			$("#cate-loading").hide();
		}
	});
});
});
</script>
{{> tpl/footer.tpl}}
