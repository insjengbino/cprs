<OES:Response id="${response.requestId}" ok="${response.ok}">
	<operation>${response.operation}</operation>
	<keys>
	<#list request.keys as key>
		<key id="${key.name}">${key.value}</key>
	</#list>
	</keys>
	<error data="${response.error}" name="${response.name}"/>${response.value}</error>
	<warning>${response.warning}</warning>
</OES:Response>