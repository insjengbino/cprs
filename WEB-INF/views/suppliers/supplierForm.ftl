<html>
	<head>
		<meta name="tab" content="profiles"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>
	<body><br/>

<@s.form method="POST" enctype="multipart/form-data">
<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Major Supplier Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >

	<tbody>
		<@s.hidden name="id"/>
		<@s.textfield label="Name / Company Name" name="majorSupplier.company" maxLength=35 required="true"/> 
		<@s.textfield label="TIN" name="majorSupplier.tinNo" maxLength=12 required="true"/> 
		<@s.textfield label="Address" name="majorSupplier.address" maxLength=70 required="true"/>
		<@s.textfield label="City" name="majorSupplier.city" maxLength=25 required="true"/>
		<@s.textfield label="Zip Code" name="majorSupplier.zipCode" maxLength=4 required="true"/>
		<@s.select label="Country" name="majorSupplier.country"  
			list="%{countries}" listKey="code" listValue="name" required="true" 
			required="true"  preload="false"/>
		<@s.textfield label="Telephone Number" name="majorSupplier.telephone" maxLength=15 required="true"/>
		<@s.textfield label="Alt Telephone Number" name="majorSupplier.altTelephone" maxLength=15/>
		<@s.textfield label="Fax" name="majorSupplier.fax" maxLength=15/>
		<@s.textfield label="Mobile Number" name="majorSupplier.mobile" maxLength=15/>
		<@s.textfield label="Email Address" name="majorSupplier.email" maxLength=88 required="true"/>
	</tbody>
	
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 
	<tr><td align=center><@s.submit value="Save" action="saveSupplier" theme="simple"/><@s.submit value="Cancel" action="listSuppliers" theme="simple"/></td></tr>
</td></tr></table> 	

</@s.form>
</body>
</html>



