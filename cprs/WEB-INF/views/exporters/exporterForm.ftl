<html>
	<head>
		<meta name="tab" content="profiles"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>
	<body><br/>

<@s.form method="POST" enctype="multipart/form-data">

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Plant / Warehouse Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
 	<tbody>
     	 	<@s.hidden name="exporter.id"/>
			<@s.textfield label="Address" name="exporter.address" maxLength=70 required="true"/>
			<@s.textfield label="City" name="exporter.city" maxLength=25 required="true"/>
			<@s.textfield label="Zip Code" name="exporter.zipCode" maxLength=9 required="true"/>
			<@s.select label="Country" name="exporter.country"  
			list="%{countries}" listKey="code" listValue="name"  required="true"/> 
	</tbody>
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 		 

	<tr><td align=center>
	<@s.submit value="Save" action="saveExporter" theme="simple"/>
	<@s.submit value="Cancel" action="listExporters" theme="simple"/>
	</td></tr>
</td></tr></table> 	
			
</@s.form>
</body>  	
</html>
