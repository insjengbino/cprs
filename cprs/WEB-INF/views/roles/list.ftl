<h2>Role List</h2>

<@s.url id="newRoleURL" action="roleForm"/>
<@s.a href="${newRoleURL}"> New Role </@s.a>
<hr/>
<table border="1">
	<tr>
		<td>ID</td>
		<td>Name</td>
		<td>Actions</td>
	</tr>
	<@s.iterator value="roles">
		<@s.url id="editRoleURL" action="roleForm">
			<@s.param name="id" value="id"/>
		</@s.url>		
		<tr>
			<td><@s.property value="id"/></td>
			<td><@s.property value="name"/></td>
			<td>
				<@s.a href="${editRoleURL}"> Edit </@s.a>
			</td>
		</tr>
	</@s.iterator>
</table>
