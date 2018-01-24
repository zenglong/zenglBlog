{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}</h2>
<div class="table-responsive">
	<table class="table table-striped">
		<thead>
		<tr>
			<th>id</th>
			<th>用户名</th>
			<th>用户昵称</th>
		</tr>
		</thead>
		<tbody>
			{{#users}}
			<tr>
				<td>{{id}}</td>
				<td>{{username}}</td>
				<td>{{nickname}}</td>
			</tr>
			{{/users}}
		</tbody>
	</table>
</div>
{{> tpl/footer.tpl}}
