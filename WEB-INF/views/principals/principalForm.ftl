<html>
	<head>
		<meta name="tab" content="profiles"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>
	<body><br/>
	<script>
		window.onload = function () {
			var pictureImage = document.getElementsByName('principalOfficerPictureFile')[0];
			var signatureImage = document.getElementsByName('principalOfficerSignatureFile')[0];
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

		document.addEventListener('input', function (e) {
			const el = e.target;

			if (el.tagName === 'INPUT') {
				const skipNames = ['principalOfficer.email'];
				if (skipNames.includes(el.name)) return;
				if (el.type.toLowerCase() === 'text' || el.type === '') {
					const start = el.selectionStart;
					const end = el.selectionEnd;
					el.value = el.value.toUpperCase();
					el.setSelectionRange(start, end);
				}
			}

			else if (el.tagName === 'TEXTAREA') {
				const start = el.selectionStart;
				const end = el.selectionEnd;
				el.value = el.value.toUpperCase();
				el.setSelectionRange(start, end);
			}
		});
	</script>

	<@s.url id="pictureURL" action="principalOfficerPicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="signatureURL" action="principalOfficerSignature">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removePictureURL" action="removePrincipalOfficerPicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removeSignatureURL" action="removePrincipalOfficerSignature">
		<@s.param name="id" value="id"/>
	</@s.url>
	
<@s.form method="POST" enctype="multipart/form-data">

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Principal Officer Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >

		<tbody>	
     	 	<@s.hidden name="id"/>
			<@s.textfield label="First Name" name="principalOfficer.firstName" maxLength=35 required="true"/> 
			<@s.textfield label="Middle Name" name="principalOfficer.middleName" maxLength=35 required="true"/> 
			<@s.textfield label="Last Name " name="principalOfficer.lastName" maxLength=35 required="true"/>
			<@s.textfield label="Position" name="principalOfficer.position" maxLength=35 required="true"/>
			<@s.textfield label="TIN" name="principalOfficer.tinNo" maxLength=12 required="true"/>
			<@s.textfield label="Address" name="principalOfficer.address" maxLength=70 required="true"/>
			<@s.textfield label="City" name="principalOfficer.city" maxLength=25 required="true"/>
			<@s.textfield label="Zip Code" name="principalOfficer.zipCode" maxLength=4 required="true"/>
		
			<@s.select label="Country" name="principalOfficer.country" 
			list="%{countries}" listKey="code" listValue="name" required="true" preload="false"/>
			 
			<@s.textfield label="Telephone Number" name="principalOfficer.telephone" maxLength=15 required="true"/>
			<@s.textfield label="Alt Telephone Number" name="principalOfficer.altTelephone" maxLength=15/>
			<@s.textfield label="Fax" name="principalOfficer.fax" maxLength=15/>
			<@s.textfield label="Mobile Number" name="principalOfficer.mobile" maxLength=15/>
			<@s.textfield label="Email Address" name="principalOfficer.email" maxLength=88 required="true"/> 
			
			<#if principalOfficer.picture?exists>
			<tr><td class="tdLabel"><label class="label">Scanned Picture:</label></td>
				<td>																								
				<img src="${pictureURL}" alt="Picture" length="60" width="60">
				<br/>						
				<@s.a href="${removePictureURL}" onclick="return confirm('This will permanently remove your picture. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
		<#else/>
			<@s.file name="principalOfficerPictureFile" label="Scanned Picture" accept="image/*" size="35" required="true"/>	
		</#if>		
		<#if principalOfficer.signature?exists>
			<tr><td class="tdLabel"><label class="label">Scanned Signature:</label></td>
				<td>																								
				<img src="${signatureURL}" alt="Signature" length="60" width="60">
				<br/>						
				<@s.a href="${removeSignatureURL}" onclick="return confirm('This will permanently remove your signature. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
		<#else/>
			<@s.file name="principalOfficerSignatureFile" label="Scanned Signature/s" accept="image/*" size="35" required="true"/>	
		</#if>		
	</tbody>

</td></tr></table> 
</td></tr></table> 
</td></tr></table> 	
	<tr><td align=center><@s.submit value="Save" action="savePrincipalOfficer" theme="simple"/><@s.submit value="Cancel" action="cancelPrincipal" theme="simple"/></td></tr>	 
</td></tr></table> 		

</@s.form>
</body>
</html>