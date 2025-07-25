<html>
	<head>
		<meta name="tab" content="profiles"/>
	</head>
	<body><br/>
	
<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
	<p align=center><font size="4">Profile History</font></p><br/>
<table width="100%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >

		<table border="2" width="100%" cellspacing="0" cellpadding="0" align=center rules=rows frame=box>
			<thead>
			<tr>
				<td align=center><b>Date</b></td>
				<td align=center><b>Actions</b></td>
			</tr>
			</thead>
			<tbody>
			<@s.iterator value="list">
				<@s.url id="loadURL" action="loadProfileHistory">
					<@s.param name="id" value="id"/>
				</@s.url>
				<tr>
					<td align=center width="80%">
						${dateTaken?string("EEEE, MMMM dd, yyyy, hh:mm:ss a")}
					</td>					
					<td align=center>
						<@s.a href="${loadURL}" onclick="return confirm('Are you sure to replace the current profile with this one?')">Load</@s.a>												
					</td>
				</tr>
			</@s.iterator>
			</tbody>
		</table>
		
</td></tr></table> 
</td></tr></table> 
</td></tr></table>

	<tr><td align=center>	
	<@s.form>
	<@s.submit value="Back" action="listProfiles" theme="simple" align="right"/>
	</@s.form>
	</td></tr>
</td></tr></table> 		


</body>
</html>