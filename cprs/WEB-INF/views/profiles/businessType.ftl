[
<#list businessTypeList as businessType>
	["${businessType.name}","${businessType.code}"]
	<#if businessType_has_next >,</#if>
</#list>
]