
<table width="60%" border="1" cellspacing="0" cellpadding="0" align=center>
  <caption><h2>Profile List</h2></caption>
  <thead>
	<tr>
		<td align=center><b>ID</b></td>
		<td align=center><b>Actions</b></td>
	</tr>
	</thead>
 
  <tbody>
   <@s.iterator value="profiles">
		<@s.url id="viewDetailsProfileURL" action="profileForm.action"/>
			<@s.param name="id"  value="id"/>
		
        <tr align="center" valign="bottom">
          <td><@s.property value="id"/></td>
       
       <td align=center>
      
        <@s.a href="profileForm.action?id=%{id}">View Details</@s.a>
       
      </td>
      </tr>
     </@s.iterator>
  </tbody>   
  </table>
	
	
	
