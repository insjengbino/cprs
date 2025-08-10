<html>	
	<head>
		<meta name="tab" content="profiles"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>
	<body><br/>
	<script>
		window.onload = function () {
			var pictureImage = document.getElementsByName('equivRespOfficerPictureFile')[0];
			var signatureImage = document.getElementsByName('equivRespOfficerSignatureFile')[0];
			if (pictureImage) {
				pictureImage.addEventListener('change', function (event) {
					validateImageEvent(event)
				});
			}
			if (signatureImage) {
				signatureImage.addEventListener('change', function (event) {
					validateImageEvent(event)
				});
			}
		};

		function validateImageEvent(event) {
			var file = event.target.files[0];
			if (file && file.size > 5120) { // 5KB = 5120 bytes
				alert("Please be Informed that the uploaded attachment has exceeded the allowable file size limit of 5kb");
				event.target.value = ''; // Clear the file input
			}
		}
	</script>

	<@s.url id="pictureURL" action="equivRespOfficerPicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="signatureURL" action="equivRespOfficerSignature">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removePictureURL" action="removeEquivRespOfficerPicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removeSignatureURL" action="removeEquivRespOfficerSignature">
		<@s.param name="id" value="id"/>
	</@s.url>

<@s.form method="POST" enctype="multipart/form-data">

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Equivalent Responsible Officer Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
	
		<tbody>
     	 	<@s.hidden name="id"/>
			<@s.textfield label="First Name" name="equivRespOfficer.firstName" maxLength=35 required="true"  /> 
			<@s.textfield label="Middle Name" name="equivRespOfficer.middleName" maxLength=35 required="true"  /> 
			<@s.textfield label="Last Name " name="equivRespOfficer.lastName" maxLength=35 required="true"  />
			<@s.textfield label="Position" name="equivRespOfficer.position" maxLength=35 required="true"  />
			<@s.textfield label="TIN" name="equivRespOfficer.tinNo" maxLength=12 required="true"  />
			<@s.textfield label="Area of Responsibility" name="equivRespOfficer.area" maxLength=35 required="true"  />
			<@s.textfield label="Address" name="equivRespOfficer.address" maxLength=70 required="true"  />
			<@s.textfield label="City" name="equivRespOfficer.city" maxLength=25 required="true"  />
			<@s.textfield label="Zip Code" name="equivRespOfficer.zipCode" maxLength=9 required="true"  />
			
			<@s.select label="Country" name="equivRespOfficer.country" 
			list="%{countries}" listKey="code" listValue="name" required="true"/>
			
			<@s.textfield label="Telephone Number" name="equivRespOfficer.telephone" maxLength=15 required="true"  />
			<@s.textfield label="Alt Telephone Number" name="equivRespOfficer.altTelephone" maxLength=15  />
			<@s.textfield label="Fax" name="equivRespOfficer.fax" maxLength=15  />
			<@s.textfield label="Mobile Number" name="equivRespOfficer.mobile" maxLength=15  />
			<@s.textfield label="Email Address" name="equivRespOfficer.email" maxLength=88 required="true"  /> 
			
			<#if equivRespOfficer.picture?exists>
			<tr><td class="tdLabel"><label class="label">Scanned Picture:</label></td>
				<td>																								
				<img src="${pictureURL}" alt="Picture" length="60" width="60">
				<br/>						
				<@s.a href="${removePictureURL}" onclick="return confirm('This will permanently remove your picture. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
		<#else/>
			<@s.file name="equivRespOfficerPictureFile" label="Scanned Picture" accept="image/*" size="35"   required="true"/>	
		</#if>		
		<#if equivRespOfficer.signature?exists>
			<tr><td class="tdLabel"><label class="label">Scanned Signature:</label></td>
				<td>																								
				<img src="${signatureURL}" alt="Signature" length="60" width="60">
				<br/>						
				<@s.a href="${removeSignatureURL}" onclick="return confirm('This will permanently remove your signature. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
		<#else/>
			<@s.file name="equivRespOfficerSignatureFile" label="Scanned Signature/s" accept="image/*" size="35"   required="true"/>	
		</#if>	
	</tbody>	
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 
	<tr>	
	<td align=center><@s.submit value="Save" action="saveEquivRespOfficer" theme="simple"/><@s.submit value="Cancel" action="cancelEquivRespOfficer" theme="simple"/></td>
	</tr>
</td></tr></table> 	 
	
</@s.form>
</body>
</html>