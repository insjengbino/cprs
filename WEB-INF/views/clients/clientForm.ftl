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

		document.addEventListener('input', function (e) {
			const el = e.target;
			// Skip certain input types
			if (el.tagName === 'INPUT') {
				const skipTypes = ['password', 'email', 'search', 'url'];
				if (skipTypes.includes(el.type.toLowerCase())) return;
				if (el.type.toLowerCase() === 'text' || el.type === '') {
					const start = el.selectionStart;
					const end = el.selectionEnd;
					el.value = el.value.toUpperCase();
					el.setSelectionRange(start, end);
				}
			}
			// Apply to textareas too
			else if (el.tagName === 'TEXTAREA') {
				const start = el.selectionStart;
				const end = el.selectionEnd;
				el.value = el.value.toUpperCase();
				el.setSelectionRange(start, end);
			}
		});
	</script>

<@s.form method="POST" enctype="multipart/form-data">

<table name="BodyBackground" width="100%" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td >
<p align=center><font size="4">Major Client Form</font></p><br/>
<table width="95%" align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table width="100%" align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
	
	<tbody>
 	 	<@s.hidden name="id"/>
		<@s.select label="Client Type" name="majorClient.clientType" 
			list="%{clientTypes}" listKey="code" listValue="name" required="true"/>
		<@s.textfield label="Name / Company Name" name="majorClient.company" maxLength=35 required="true"/> 
		<@s.textfield label="Address" name="majorClient.address" maxLength=70 required="true"/>
		<@s.textfield label="City" name="majorClient.city" maxLength=25 required="true"/>
		<@s.textfield label="Zip Code" name="majorClient.zipCode" maxLength=4 required="true"/>
		<@s.select label="Country" name="majorClient.country" 
			list="%{countries}" listKey="code" listValue="name" 
			required="true" preload="false"/>
		<@s.textfield label="Telephone Number" name="majorClient.telephone" maxLength=15 required="true"/>
		<@s.textfield label="Alt Telephone Number" name="majorClient.altTelephone" maxLength=15/>
		<@s.textfield label="Fax" name="majorClient.fax" maxLength=15/>
		<@s.textfield label="Email Address" name="majorClient.email" maxLength=88 required="true"/>
		<@s.textfield label="Website" name="majorClient.website" maxLength=100/>
	</tbody>
	
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 
	<tr><td align=center><@s.submit value="Save" action="saveClient" theme="simple"/><@s.submit value="Cancel" action="listClient" theme="simple"/></td></tr>	
</td></tr></table> 	

</@s.form>
</body>  	
</html>
