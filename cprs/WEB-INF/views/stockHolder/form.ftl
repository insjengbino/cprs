<html>
	<head>
		<meta name="tab" content="profiles"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>
	<body><br/>	
	
	<@s.url id="pictureURL" action="stockholderPicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="signatureURL" action="stockholderSignature">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removePictureURL" action="removeStockholderPicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removeSignatureURL" action="removeStockholderSignature">
		<@s.param name="id" value="id"/>
	</@s.url>

<@s.form method="POST" enctype="multipart/form-data">

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Major Stockholder Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >

	<tbody>
		<@s.hidden name="id"/>
		<@s.textfield label="First Name" name="majorStockholder.firstName" maxLength=35 required="true" /> 
		<@s.textfield label="Middle Name" name="majorStockholder.middleName" maxLength=35 required="true" /> 
		<@s.textfield label="Last Name " name="majorStockholder.lastName" maxLength=35 required="true" />
		<@s.select label="Citizenship/Country of Citizenship" name="majorStockholder.citizenship" list="%{countries}" listKey="code" listValue="name" required="true"/>
		<@s.textfield label="TIN" name="majorStockholder.tinNo" maxLength=12 required="true"/>
		<@s.textfield label="Address" name="majorStockholder.address" maxLength=70 required="true" />
		<@s.textfield label="City" name="majorStockholder.city" maxLength=25 required="true" />
		<@s.textfield label="Zip Code" name="majorStockholder.zipCode" maxLength=9 required="true" />
		<@s.select label="Country" name="majorStockholder.country" list="%{countries}" listKey="code" listValue="name" 
			required="true"/>
		<@s.textfield label="Telephone Number" name="majorStockholder.telephone" maxLength=15 required="true" />
		<@s.textfield label="Alt Telephone Number" name="majorStockholder.altTelephone" maxLength=15/>
		<@s.textfield label="Fax" name="majorStockholder.fax" maxLength=15/>
		<@s.textfield label="Mobile Number" name="majorStockholder.mobile" maxLength=15/>
		<@s.textfield label="Email Address" name="majorStockholder.email" required="true" maxLength=88/>
		<#if majorStockholder.picture?exists>
			<tr><td class="tdLabel"><label class="label">Scanned Picture:</label></td>
				<td>																								
				<img src="${pictureURL}" alt="Picture" length="60" width="60">
				<br/>						
				<@s.a href="${removePictureURL}" onclick="return confirm('This will permanently remove your picture. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
		<#else/>
			<@s.file name="stockholderPictureFile" label="Scanned Picture" accept="image/*" size="35"  required="true"/>	
		</#if>		
		<#if majorStockholder.signature?exists>
			<tr><td class="tdLabel"><label class="label">Scanned Signature:</label></td>
				<td>																								
				<img src="${signatureURL}" alt="Signature" length="60" width="60">
				<br/>						
				<@s.a href="${removeSignatureURL}" onclick="return confirm('This will permanently remove your signature. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
		<#else/>
			<@s.file name="stockholderSignatureFile" label="Scanned Signature/s" accept="image/*" size="35"   required="true"/>	
		</#if>		
	</tbody>
	
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 
	<tr><td align=center><@s.submit value="Save" action="saveStockholder" theme="simple"/><@s.submit value="Cancel" action="cancelStockholder" theme="simple"/></td></tr>  
</td></tr></table> 		

</@s.form>
</body>
</html>