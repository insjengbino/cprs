<html>
	<head>
		<meta name="tab" content="profile"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
	</head>

	<body>

	<@s.form id="clientTypeForm">
		<table>
			<@s.select label="Customer Client Type" name="clientType" list="%{clientTypes}" listKey="code" listValue="name" required="true" />
		<tr><td colspan="2" align="right"><br/>	   
		<@s.submit value="Back" action="listProfiles" theme="simple"/>
		<@s.submit value="Next" action="businessForm" theme="simple"/>	 
		</td></tr>
		<table> 
	</@s.form>
	</body>  	
</html>