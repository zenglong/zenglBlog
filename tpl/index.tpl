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
{{#notices_cnt}}
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
	{{#notices}}
	<div class="panel panel-default">
		<div class="panel-heading" role="tab" id="heading-{{id}}">
			<h4 class="panel-title">
				<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse-{{id}}" aria-expanded="true" aria-controls="collapse-{{id}}">
					公告：{{title}}
				</a>
			</h4>
		</div>
		<div id="collapse-{{id}}" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading-{{id}}">
			<div class="panel-body">
				{{description}}
			</div>
		</div>
	</div>
	{{/notices}}
</div>
{{/notices_cnt}}
{{#latest_articles_cnt}}
<div class="row">
	<div class="col-xs-18 col-sm-12">
		<a class="btn-try btn btn-primary btn-lg" href="javascript:void(0);">最近更新</a>
		{{#latest_articles}}
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
		<p class="description">
			{{description}}
		</p>
		{{# thumbnail }}
		<p class="item-thumbnail">
			<img src="{{ thumbnail }}" alt="{{title}}"/>
		</p>
		{{/ thumbnail }}
		{{/latest_articles}}
	</div>
</div>
{{/latest_articles_cnt}}
<div class="row">
	{{#items}}
	<div class="col-xs-18 col-sm-12">
		<a class="btn-try btn btn-primary btn-lg" title="{{cate_name}}"
			href="{{#static}}/c/{{ cate_id }}/{{/static}}{{^static}}/article.zl?act=list&amp;cid={{ cate_id }}{{/static}}">{{cate_name}}</a>
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
		<p class="description">
			{{description}}
		</p>
		{{# thumbnail }}
		<p class="item-thumbnail">
			<img src="{{ thumbnail }}" alt="{{title}}"/>
		</p>
		{{/ thumbnail }}
		{{/articles}}
	</div>
	{{/items}}
</div>
<script type="text/javascript">
	$(document).ready(function () { 
		$.fn.yestop({yes_image: '/assets/image/yestop.png'});
	});
</script>
{{> /tpl/footer.tpl}}
