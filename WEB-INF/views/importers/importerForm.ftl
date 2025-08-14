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
	<script>
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
     	 	<@s.hidden name="importer.id"/>
			<@s.textfield label="Address" name="importer.address" maxLength=70 required="true"/>
			<@s.textfield label="City" name="importer.city" maxLength=25 required="true"/>
			<@s.textfield label="Zip Code" name="importer.zipCode" maxLength=4 required="true"/>
			<@s.select label="Country" name="importer.country"  
			list="%{countries}" listKey="code" listValue="name"  required="true"/> 
	</tbody>
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 		 

	<tr><td align=center>
	<@s.submit value="Save" action="saveImporter" theme="simple"/>
	<@s.submit value="Cancel" action="listImporters" theme="simple"/>
	</td></tr>
</td></tr></table> 	
			
</@s.form>
</body>  	
</html>
