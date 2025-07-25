<html>
	<head>
	
	
		<meta name="tab" content="profiles"/>
		
	</head>
	<body><br/>
	
	
	
<@s.form>

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
	<p align=center><font size="4">Client Profile List</font></p><br/>
<table width="100%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >

<table border="2" width="100%" cellspacing="0" cellpadding="0" align=center rules=rows frame=box>

  <br>
  <thead>
	<tr>
		<td align=center><b>ID</b></td>
		<td align=center><b>Client Type</b></td>
		<td align=center><b>Status</b></td>
		<td align=center><b>Error</b></td>
		<td align=center><b>Actions</b></td>		
	</tr>
  </thead>
 
  <tbody>
   <@s.iterator value="profiles">
		<@s.url id="editURL" action="editProfile">
			<@s.param name="id"  value="id"/>
		</@s.url>
		<@s.url id="renewURL" action="renewProfile">
				<@s.param name="id" value="id"/>
		</@s.url>
		<@s.url id="amendURL" action="amendProfile">
				<@s.param name="id" value="id"/>
		</@s.url>	
		<@s.url id="deleteURL" action="deleteProfile">
				<@s.param name="id" value="id"/>
		</@s.url>
		<@s.url id="completeURL" action="completeProfile">
				<@s.param name="id" value="id"/>
		</@s.url>
		<@s.url id="sendURL" action="sendProfile">
				<@s.param name="id" value="id"/>
		</@s.url>
		<@s.url id="snapshotURL" action="snapshotProfile">
				<@s.param name="id" value="id"/>
		</@s.url>
		<@s.url id="historyURL" action="listProfileHistory">
				<@s.param name="id" value="id"/>
		</@s.url>
		
        
        <tr align="center" valign="bottom">
       
          <td align="left"><@s.checkboxlist name="selected" list="    id " theme="simple"/></td>
       	  <td><@s.property value="clientType"/></td>
	      <td align=center>
				<#if status?exists>
					${status.name}
				</#if>
       	  </td>
	   	  <td align=center>
				<#if errorMessage?exists>
					${errorMessage}
				</#if>
       	  </td>
       	  <td align=center>
       			<@s.a href="${editURL}">Edit</@s.a> 
       			<@s.a href="${historyURL}">History</@s.a> 
       	  </td>
       	</tr>
     </@s.iterator>
  	</tbody>   
  	</table>
  	<br>
	
</td></tr></table> 
</td></tr></table> 
</td></tr></table><br/> 

	<@s.submit value="Delete" action="deleteProfile" theme="simple" onclick="return confirm('Are you sure?')"/>
	<@s.submit value="Renew" action="renewProfile" theme="simple" onclick="return confirm('Are you sure?')"/>
	<@s.submit value="Amend" action="amendProfile" theme="simple" onclick="return confirm('Are you sure?')"/>
	<@s.submit value="Complete" action="completeProfile" theme="simple" onclick="return confirm('Are you sure?')"/>
	<@s.submit value="Send" action="sendProfile" theme="simple" onclick="return confirm('Are you sure?')"/>
	<@s.submit value="Snapshot" action="snapshotProfile" theme="simple" onclick="return confirm('Are you sure?')"/>
	
	<#if profiles?size < 6 >
	<@s.submit value="Add Profile" action="clientTypeForm" theme="simple"/>
	</#if>

</td></tr></table> 	

</@s.form>
</body>
</html>
	
	
	
