$(document).ready(function() {
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
		$('#p-cate-name').text('(cid=0)');
	else
		$('#p-cate-name').text(sel_text + '(cid='+pid+')');
	if(this.value <= 0 || childcnt <= 0)
		return ;
	var that = this;
	var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
	$.ajax({
		type: 'GET',
		url: "category.zl?timestamp="+timestamp,
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

function reset_category_ajax() {
	var timestamp = new Date().getTime(); //IE浏览器ajax GET请求有缓存问题！
	$.ajax({
		type: 'GET',
		url: "category.zl?timestamp="+timestamp,
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
			$('#p-cate-name').text('(cid=0)');
			$('#pid').val(0);
			$('#p-cate').append(sel_html);
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			$("#reset_category").button('reset');
		}
	});
}

