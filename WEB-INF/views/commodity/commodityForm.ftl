<html>
	<head>
		<meta name="tab" content="profiles"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>
	<body><br/>

<@s.form method="POST" enctype="multipart/form-data">

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Imported Commodities Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
 	<tbody>
     	 	<@s.hidden name="commodity.id"/>
			<@s.textfield label="HS Code" name="commodity.hsCode" maxLength=35 required="true"/>
			<@s.textfield label="Item Code" name="commodity.itemCode" maxLength=35 required="true"/>
			<@s.textfield label="Item Description" name="commodity.itemDescription" maxLength=100 required="true"/>
	</tbody>
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 		 

	<tr><td align=center>
	<@s.submit value="Save" action="saveCommodity" theme="simple"/>
	<@s.submit value="Cancel" action="listCommodities" theme="simple"/>
	</td></tr>
</td></tr></table> 	
			
</@s.form>
</body>  	
</html>
