<html>
	<head>
		<meta name="tab" content="profile"/>
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
		<style>
			select[name=natureOfBusiness] {
				width: 500px;
			}
		</style>
	</head>

	<body>
	<@s.form id="businessForm">
		<input type="hidden" name="clientType" value="${clientType?if_exists}"/>
		<table>
			<@s.select label="Type of Business Entity" name="businessType" list="%{businessTypeList}" listKey="code" listValue="name" required="true"/>    
			<@s.select label="Nature Of Business" name="natureOfBusiness" list="%{naturesOfBusiness}" listKey="code" listValue="name" required="true" />
		<tr><td colspan="2" align="right"><br/>	   
		<@s.submit value="Back" action="clientTypeForm" theme="simple"/>
		<@s.submit value="Next" action="profileForm" theme="simple"/>	 
		</td></tr>
		<table> 
	</@s.form>
	</body> 
</html>