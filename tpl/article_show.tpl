{{> tpl/header.tpl}}
<ol class="breadcrumb">
  <li><a href="/index.zl">zenglBlog</a></li>
  <li><a href="/article.zl?act=list&amp;cid={{ cid }}">{{ catname }}</a></li>
  <li class="active">{{title}}</li>
</ol>
<div class="row">
	<div class="col-xs-18 col-sm-12">
		<div class="page-header text-center">
			<h2>{{title}}</h2>
			<h3><small>{{ author }}&nbsp;&nbsp;{{ created_at }}</small></h3>
		</div>
		<div class="row description">
			<div class="jumbotron">
				<p>{{ description }}</p>
			</div>
		</div>
		<div class="row content">
			<div>
				{{{ content }}}
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
   $(document).ready(function () { $.fn.yestop({yes_image: '/assets/image/yestop.png'}); })
</script>
{{> tpl/footer.tpl}}
