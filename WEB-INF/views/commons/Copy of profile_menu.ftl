
<@s.if test="(clientType == 'AW') || (clientType == 'CY') || (clientType == 'IM') || (clientType == 'WO')">
	<@s.url id="importersURL" action="listImporters">
		<@s.param name="currentProfileID" value="profile.id"/>
	</@s.url>		
	<button onClick="window.location='/cprs/listImporters.action?currentProfileID=${profile.id?c}'">Importers</button>
</@s.if>

<@s.if test="(clientType == 'AW') || (clientType == 'CY') || (clientType == 'IM') || (clientType == 'WO')">
	<@s.url id="stockholdersURL" action="listStockholders">
		<@s.param name="currentProfileID" value="profile.id"/>
	</@s.url>		
	<button onClick="window.location='/cprs/listStockholders.action?currentProfileID=${profile.id?c}'">Stockholders</button>
</@s.if>

<@s.if test="(clientType == 'AW') || (clientType == 'CY') || (clientType == 'IM') || (clientType == 'WO') || (clientType == 'SU')">	
	<@s.url id="principalsURL" action="listPrincipalOfficers">
		<@s.param name="currentProfileID" value="profile.id"/>
	</@s.url>		
	<button onClick="window.location='/cprs/listPrincipalOfficers.action?currentProfileID=${profile.id?c}'">Principals</button>
</@s.if>

<@s.if test="(clientType == 'AW') || (clientType == 'BR') || (clientType == 'CY') || (clientType == 'IM') || (clientType == 'WO') || (clientType == 'SU')">		
	<@s.url id="equivRespsURL" action="listEquivRespOfficers">
		<@s.param name="currentProfileID" value="profile.id"/>
	</@s.url>		
	<button onClick="window.location='/cprs/listEquivRespOfficers.action?currentProfileID=${profile.id?c}'">Equiv Resp.Officers</button>
</@s.if>

<@s.if test="(clientType == 'BR')  || (clientType == 'IM') || (clientType == 'WO')">			
	<@s.url id="suppliersURL" action="listSupplier">
		<@s.param name="currentProfileID" value="profile.id"/>
	</@s.url>		
	<button onClick="window.location='/cprs/listSupplier.action?currentProfileID=${profile.id?c}'">Suppliers</button>
</@s.if>

<@s.if test="(clientType == 'BR')  || (clientType == 'IM') || (clientType == 'WO')">				
	<@s.url id="clientsURL" action="listClient">
		<@s.param name="currentProfileID" value="profile.id"/>
	</@s.url>		
	<button onClick="window.location='/cprs/listClient.action?currentProfileID=${profile.id?c}'">Clients</button>
</@s.if>
	