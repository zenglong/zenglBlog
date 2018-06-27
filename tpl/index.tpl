{{> tpl/header.tpl}}
<div class="row">
	<div class="col-xs-18 col-sm-12">
		{{#thumb_articles}}
		<div class="index-thumbnail">
			<div class="thumbnail">
				<a href="/article.zl?id={{id}}" title="{{title}}">
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
		<h3 class="cate-name"><a href="/article.zl?act=list&amp;cid={{ cate_id }}">{{cate_name}}</a></h3>
		{{#articles}}
		<p class="article">{{created_at}}&nbsp;<span class="article-link"><a href="/article.zl?id={{id}}" title="{{title}}">{{title}}</a></span></p>
		{{/articles}}
	</div>
	{{/items}}
</div>
{{> tpl/footer.tpl}}
