<html>
	<head>
		<meta name="tab" content="profiles"/>
	</head>
	<body><br/>
	
<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
	<p align=center><font size="4">Major Supplier List</font></p><br/>
<table width="100%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
	
		<table border="2" width="100%" cellspacing="0" cellpadding="0" align=center rules=rows frame=box>
		<thead>
			<tr>				
				<td align=center><b>Name</b></td>
				<td align=center><b>Actions</b></td>
			</tr>
		</thead>	
		<tbody>
			<@s.iterator value="majorSuppliers">
				<@s.url id="editURL" action="editSupplier">
					<@s.param name="id" value="id"/>
				</@s.url>			
				<@s.url id="deleteURL" action="deleteSupplier">
					<@s.param name="id" value="id"/>
				</@s.url>
				<tr>
					<td align=center><@s.property value="company"/> </td>					
					<td align=center>
						<@s.a href="${editURL}">Edit</@s.a> |
						<@s.a href="${deleteURL}" onclick="return confirm('Are you sure?')">Delete</@s.a>												
					</td>
				</tr>
			</@s.iterator>
			</tbody>
		</table>
		
</td></tr></table> 
</td></tr></table> 
</td></tr></table>
		<tr><td align=center>
		<@s.url id="addSupplier" action="addSupplier"/>		
		<button onClick="window.location='${addSupplier}'">Add</button>	
		
		<@s.url id="myProfileURL" action="profileForm.action" includeParams="none">
			<@s.param name="id" value="profileId"/>
		</@s.url>	
		<button onClick="window.location='${myProfileURL}'">My Profile</button>
						
		</td></tr>
</td></tr></table> 		
	</body>
</html>