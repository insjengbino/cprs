<html>
	<head>
		<meta name="tab" content="profile"/>
		<@s.head theme="ajax"/>
	</head>
	<body>
		<@s.form theme="simple">
		<@s.tabbedPanel id="test" theme="ajax">
			<@s.div id="1" label="New Broker Form" theme="ajax" labelposition="top">
				<table>
					<@s.textfield label="First Name" name="profile.firstName" required="true" theme="ajax"/>
					<@s.textfield label="Middle Name" name="profile.middleName" required="true" theme="ajax"/>
				</table>
			</@s.div>
		
			<@s.div id="2" label="Broker List" theme="ajax">
				<table>
					<@s.textfield label="Last Name " name="profile.lastName" required="true" theme="ajax"/>
				</table>
			</@s.div>
		</@s.tabbedPanel>
		<@s.submit value="Submit" action="submitProfile" align="right" theme="simple"/>
		</@s.form>

	</body>  	
</html>

	 
