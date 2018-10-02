{{> /tpl/header.tpl}}
<ol class="breadcrumb">
	{{#static}}
		<li><a href="/">{{site_name}}</a></li>
	{{/static}}
	{{^static}}
		<li><a href="/index.zl">{{site_name}}</a></li>
	{{/static}}
	<li class="active">{{ catname }}</li>
</ol>
<div class="row">
	<div class="col-xs-18 col-sm-12">
		{{#articles}}
		<div class="row">
			<div class="thumbnail right-caption col-xs-18 col-sm-12">
				<img {{#thumbnail}}src="{{ thumbnail }}"{{/thumbnail}}{{^thumbnail}}src="/assets/image/defaultpic.jpg"{{/thumbnail}} alt="{{title}}"/>
				<div class="caption">
					{{#static}}
						<h3><a href="/a/{{format_created}}/{{id}}.html">{{ title }}</a><small class="author-create-at">{{ created_at }}</small></h3>
					{{/static}}
					{{^static}}
						<h3><a href="?id={{id}}">{{ title }}</a><small class="author-create-at">{{ created_at }}</small></h3>
					{{/static}}
					<p>{{ description }}</p>
				</div>
			</div>
		</div>
		{{/articles}}
		{{#page}}
		{{#total}}
		<nav aria-label="Page navigation">
		  <ul class="pagination">
			<li>
			  <a href="{{{link}}}{{^static}}page=1{{/static}}" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			  </a>
			</li>
			<li>
			  <a href="{{#static}}{{prev_link}}{{/static}}{{^static}}{{{link}}}page={{prev}}{{/static}}" aria-label="Previous">
				<span aria-hidden="true">&lsaquo;</span>
			  </a>
			</li>
			{{#pages}}
				{{{.}}}
			{{/pages}}
			<li>
			  <a href="{{#static}}{{next_link}}{{/static}}{{^static}}{{{link}}}page={{next}}{{/static}}" aria-label="Next">
				<span aria-hidden="true">&rsaquo;</span>
			  </a>
			</li>
			<li>
			  <a href="{{#static}}{{totalpage_link}}{{/static}}{{^static}}{{{link}}}page={{totalpage}}{{/static}}" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			  </a>
			</li>
		  </ul>
		</nav>
		{{/total}}
		<span>总共{{total}}篇文章/共{{totalpage}}页</span>
		{{/page}}
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function () { 
		$.fn.yestop({yes_image: '/assets/image/yestop.png'});
	});
</script>
{{> /tpl/footer.tpl}}
