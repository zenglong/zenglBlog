{{> /tpl/header.tpl}}
<ol class="breadcrumb">
  <li><a href="/index.zl">zenglBlog</a></li>
  <li class="active">{{ catname }}</li>
</ol>
<div class="row">
	<div class="col-xs-18 col-sm-12">
		{{#articles}}
		<div class="row">
			<div class="thumbnail right-caption col-xs-18 col-sm-12">
				<img {{#thumbnail}}src="{{ thumbnail }}"{{/thumbnail}}{{^thumbnail}}src="/assets/image/defaultpic.jpg"{{/thumbnail}} alt="{{title}}"/>
				<div class="caption">
					<h3><a href="?id={{id}}">{{ title }}</a><small class="author-create-at">{{ created_at }}</small></h3>
					<p>{{ description }}</p>
				</div>
			</div>
		</div>
		{{/articles}}
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
		<span>总共{{total}}篇文章/共{{totalpage}}页</span>
		{{/page}}
	</div>
</div>
{{> /tpl/footer.tpl}}
