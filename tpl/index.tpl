{{> /tpl/header.tpl}}
<div class="row">
	<div class="col-xs-18 col-sm-12">
		{{#thumb_articles}}
		<div class="index-thumbnail">
			<div class="thumbnail">
				{{#static}}
					<a href="/a/{{format_created}}/{{id}}.html" title="{{title}}">
				{{/static}}
				{{^static}}
					<a href="/article.zl?id={{id}}" title="{{title}}">
				{{/static}}
					<img src="{{ thumbnail }}" alt="{{title}}"/>
					<div class="caption">
						<p>{{ title }}</p>
					</div>
				</a>
			</div>
		</div>
		{{/thumb_articles}}
	</div>
</div>
<div class="row">
	{{#items}}
	<div class="col-xs-18 col-sm-12">
		<h3 class="cate-name">
			{{#static}}
				<a href="/c/{{ cate_id }}/">{{cate_name}}</a>
			{{/static}}
			{{^static}}
				<a href="/article.zl?act=list&amp;cid={{ cate_id }}">{{cate_name}}</a>
			{{/static}}
		</h3>
		{{#articles}}
		<p class="article">{{created_at}}&nbsp;
			<span class="article-link">
				{{#static}}
					<a href="/a/{{format_created}}/{{id}}.html" title="{{title}}">{{title}}</a>
				{{/static}}
				{{^static}}
					<a href="/article.zl?id={{id}}" title="{{title}}">{{title}}</a>
				{{/static}}
			</span>
		</p>
		{{/articles}}
	</div>
	{{/items}}
</div>
{{> /tpl/footer.tpl}}
