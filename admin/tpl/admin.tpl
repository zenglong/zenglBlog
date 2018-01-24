{{> tpl/header.tpl}}
<h2 class="sub-header">{{title}}</h2>
用户名：{{username}}
昵称：{{nickname}}

<h2 class="sub-header">配置信息: </h2>
<div class="table-responsive">
	<table class="table table-striped">
	  <thead>
		<tr>
		  <th>配置项</th>
		  <th>配置值</th>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td>mysql客户端库的版本信息</td>
			<td>{{mysql_client_info}}</td>
		</tr>
		<tr>
			<td>mysql服务端的版本号信息</td>
			<td>{{mysql_server_version}}</td>
		</tr>
		<tr>
			<td>zenglServer版本</td>
			<td>{{zenglServerVersion}}</td>
		</tr>
		<tr>
			<td>zengl语言版本</td>
			<td>{{zenglVersion}}</td>
		</tr>
	  </tbody>
	</table>
</div>
{{> tpl/footer.tpl}}
