<OES:Request id="${request.id}">
	<document>${request.documentType}</document>
	<operation>${request.operation}</operation>
	<keys>
	<#list request.keys as key>
		<key id="${key.name}">${key.value}</key>
	</#list>
	</keys>
	<properties>
	<#list request.properties as property>
		<property id="${property.name}">${property.value}</property>
	</#list>
	</properties>
</OES:Request>