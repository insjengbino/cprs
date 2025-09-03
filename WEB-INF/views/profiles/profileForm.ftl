<html>
	<head>
		<meta name="tab" content="profiles"/>	
		<link rel="stylesheet" href="/cprs/struts/xhtml/styles.css" type="text/css"/>
		<@jscalendar.head calendarcss="calendar-blue"/>
	</head>
	<body>
	<@s.url id="pictureURL" action="profilePicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="signatureURL" action="profileSignature">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removePictureURL" action="removeProfilePicture">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removeSignatureURL" action="removeProfileSignature">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="importedCommoditiesURL" action="profileImportedCommodities">
		<@s.param name="id" value="id"/>
	</@s.url>
	<@s.url id="removeImportedCommoditiesURL" action="removeProfileImportedCommodities">
		<@s.param name="id" value="id"/>
	</@s.url>
<div class="profileForm">	
	
<table name="BodyBackground" align="center" cellspacing="5" cellpadding="5" border="0" bgcolor="#CCCCCC" ><tr ><td > 
	<#include "/WEB-INF/views/commons/profile_menu.ftl"/>
<table align="center" cellspacing="10" cellpadding="2" border="0" bgcolor="#6A639D" ><tr><td bgcolor="#FFFFFF" >
<table align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
<table align="center" cellspacing="2" cellpadding="2" border="0" bgcolor="#FFFFFF" ><tr><td bgcolor="#FFFFFF" >
 	  <@s.form method="POST" enctype="multipart/form-data">	
		  <@s.hidden name="id"/>

	
		  <input type="hidden" name="clientType" value="${clientType?if_exists}"/>
<#--		  <input type="hidden" name="businessType" value="${businessType?if_exists}"/>-->
			<input type="hidden" name="profile.businessType" value="${profile.businessType?if_exists}"/>
		  <input type="hidden" name="profile.natureOfBusiness" value="${natureOfBusiness?if_exists}"/>
		  <!--<input type="hidden" name="profile.insClientNo" value="${profile.insClientNo?if_exists}"/>-->

		  <#--<@s.textfield label="Customs Client Number" name="profile.clientCcn" readonly="true"  />-->
		
		  <@s.textfield label="Client Type" value="${clientType}" readonly="true"  />


<#--            business entity type-->
		  <#--<@s.textfield label="Type of Business Entity" value="%{businessType}" readonly="true"  />-->
		  <@s.select id = "businessEntityType" label="Type of Business Entity" name="businessType" list="%{businessTypeList}" listKey="code"
          listValue="name" required="true"/>


<#--            nature of business-->
<#--		  <@s.textfield label="Nature of Business" value="%{natureOfBusiness}" readonly="true"  />-->
			<@s.select label="Nature of Business" name="natureOfBusiness" list="%{naturesOfBusiness}" listKey="code" listValue="%{(name.length() > 40 ? name.substring(0,40) + '...' : name) + ' (' + code + ')'}" required="true" cssStyle="width: 279.33px;" id="natureOfBusinessSelect"/>
		  <@s.textfield label="INS Client Number" name="profile.insClientNo" required="true" readonly="true"  />
		  <!--<@s.textfield label="INS Client Number" value="%{profile.insClientNo}" readonly="true"  />-->
		
		  <@s.textfield label="Business Name/Company Name" name="profile.company" maxLength=35 required="true"  />

        <@s.textfield id="firstName" label="First Name" name="profile.firstName" maxLength=35 required="true"  />
        <@s.textfield id="middleName" label="Middle Name" name="profile.middleName" maxLength=35 required="true"  />
        <@s.textfield id="lastName" label="Last Name " name="profile.lastName" maxLength=35 required="true"  />

		  <@s.select label="Country of Citizenship" name="profile.citizenship" list="%{countries}" listKey="code" listValue="name" required="true" />
		  <@s.textfield label="Address" name="profile.address" maxLength=70 required="true"  />
		  <@s.textfield label="City" name="profile.city" maxLength=25 required="true"  />
		  <@s.textfield label="Zip Code" type="number" name="profile.zipCode" maxlength="4" required="true" />

		  <@s.select label="Country" name="profile.country" list="%{countries}" listKey="code" listValue="name" required="true" />
		  
		  <@s.textfield label="Telephone Number" name="profile.telephone" maxLength=15 required="true"/>
		  <@s.textfield label="Alternate Telephone Number" name="profile.altTelephone" maxLength=15  />
		  <@s.textfield label="Fax" name="profile.fax" maxLength=15  />
		  <@s.textfield label="Mobile Number" name="profile.mobile" maxLength=15   />
		  <@s.textfield label="Email Address" name="profile.email" maxLength=88 required="true"  />
		  <@s.textfield label="Website" name="profile.website" maxLength=100  />
		  
		<@s.if test="(clientType == 'WO') || (clientType == 'AW') || (clientType == 'CY')">
			<@s.select label="Custom Bonded Warehouse Type" name="profile.customBondedWarehouseType" list="%{customBondedWarehouseType}" 
			listKey="code" listValue="name" required="true"  />
		 </@s.if>
		 	
		 <@s.if test="(clientType == 'SU')">  
		  	<@s.textfield label="Certificate of Authority" name="profile.certificateOfAuthority" maxLength=18 required="true"   />
		  </@s.if>

		 <@s.if test="(clientType == 'IM')">  
		  	<@s.textfield label="Warehouse Code" name="profile.CustomBondedWarehouse" maxLength=15 required="false"   />
		  </@s.if>

		 <@s.if test="(natureOfBusiness == 'GO004')">  
		  	<@s.textfield label="JO 2-91 Reference Number" name="profile.jo291" maxLength=17/>	
			<@jscalendar.jscalendar format="%m/%d/%Y" name="periodOfEffectivity" label="Period of Effectivity" size="10" required="true" maxLength="10"/>
			<@s.textfield label="Under Writing Capacity" name="profile.underWritingCapacity" maxLength=16 required="true"   />
		 </@s.if>
		<@s.if test="(clientType == 'SU')">  
			<@s.textfield label="Under Writing Capacity" name="profile.underWritingCapacity" maxLength=16 required="true"   />
		 </@s.if>
		
		  	<@s.textfield label="TIN" name="profile.tinNo" minLength=12 maxLength=12 required="true"   />
		 
		 <@s.if test="(clientType == 'BR')">
		  	<@s.textfield label="SSS Number" name="profile.sssIdNo" maxLength=17 required="true"  />
		 </@s.if>
		 
		 <@s.if test="(clientType != 'BR' && clientType != 'YI' )">
		  	<@s.textfield label="SSS Number" name="profile.sssIdNo" maxLength=17  />
		 </@s.if>

		 <@s.if test="(clientType != 'YI' )">   
		 	<@s.textfield label="Passport Number" name="profile.passportIdNo" maxLength=17   />
		 	<@s.textfield label="Driver's License" name="profile.driverLicenseIdNo" maxLength=17  />
		 </@s.if>
 	
		 <@s.if test="(clientType == 'BR')"> 
			<@s.if test="(clientType == 'BR' && natureOfBusiness == '0000' )"> 
				<@s.textfield label="PRC Id Number" value="NONBROKER" name="profile.prcIdNo" maxLength=17 required="true" readonly="true"    />
			</@s.if> 
			<@s.else>
				<@s.textfield label="PRC Id Number" name="profile.prcIdNo" maxLength=17 required="true"    />
			</@s.else>
		 </@s.if> 
		 
		 <@s.if test="(clientType != 'BR' && clientType != 'YI' )"> 
		  	<@s.textfield label="PRC Id Number" name="profile.prcIdNo" maxLength=17    />
		 </@s.if> 
		 
		  	<@s.textfield label="VASP Primary CCN" value="VA0000000116" name="profile.vaspPrimaryCcn" maxLength=12 required="true" readonly="true"/>
		  	<@s.textfield label="VASP Secondary CCN" name="profile.vaspSecondaryCcn" maxLength=12   />
			
		 <!-- added code by toqaf -->	
		 <@s.if test="(clientType == 'BR' && natureOfBusiness == '0000' )"> 
		  	<@s.textfield label="Importer TIN" name="profile.importerTin" maxLength=12 required="true"    />
		  	<@s.textfield label="Exporter TIN" name="profile.exporterTin" maxLength=12 required="true"    />
		 </@s.if> 
		 <!-- added code by toqaf /-->
		 
		 <@s.if test="(clientType != 'BR' && clientType != 'YI' && clientType != 'EX')">
		  	<@s.textfield label="Unique Reference Number" name="profile.pezaIdNo" maxLength=17/>
		 </@s.if> 
		 
		 <@s.if test="(clientType == 'EX')">
		  	<@s.textfield label="Unique Reference Number" name="profile.pezaIdNo" maxLength=17 required="true" />
		 </@s.if> 		 
		 
		<@s.if test="((businessType == 'PART' ) || (businessType ==  'CORP' ) || (businessType ==  'CMP' ) && (clientType != 'YI')) ">
		 	<@s.textfield label="SEC Registration Number" name="profile.secIdNo" maxLength=17 required="true"   />
		  	<@s.textfield label="Authorized Capital Stock Amount" name="profile.capitalStockAmount" maxLength=18 required="true"   />
		  	<@s.textfield label="Paid Up Capital Amount" name="profile.paidUpCapitalAmount" type="number" maxLength=18 required="true"   />
		 </@s.if> 
		   
		<@s.if test="(clientType == 'IM' ) || (clientType == 'EX')">   
		   	<@s.textfield label="AAB Assigned Bank Reference No." name="profile.aabAssignedBankRefNo" readonly="true"   />
		</@s.if>    

		<@s.if test="(clientType != 'YI' )">   
		  	<@s.textfield label="Related Company" name="profile.relatedCompanyName1"  maxLength=100   />
		  	<@s.textfield label="Related Company" name="profile.relatedCompanyName2"  maxLength=100   />
		  	<@s.textfield label="Related Company" name="profile.relatedCompanyName3"  maxLength=100   />
		</@s.if>    
		
		<@s.if test="(clientType == 'IM') || (clientType == 'EX') || (clientType == 'WO')">  
			<@s.textfield label="Primary Broker TIN" name="profile.priBrokerTaxpayerIdNo" maxLength=12 required="true"  />
			<@s.textfield label="Primary Broker CCN" name="profile.priBrokerCCN" maxLength=12 required="true"   />
			
			<@s.textfield label="Secondary Broker TIN" name="profile.secBrokerTaxpayerIdNo" maxLength=12  />
			<@s.textfield label="Secondary Broker CCN" name="profile.secBrokerCCN" maxLength=12  />
	 		
		  	<!--<#if profile.importedCommodities?exists>
			<tr><td class="tdLabel"><label class="label">Imported Commodities:</label></td>
				<td>																								
				<img src="${importedCommoditiesURL}" alt="Imported Commodities" length="60" width="60">
				<br/>						
				<@s.a href="${removeImportedCommoditiesURL}"> Remove </@s.a>								
			</td></tr>
			<#else/>
		  		<@s.file name="ProfileImportedCommoditiesFile" label="Importable Commodities" accept="text/*" size="35"  />
	  	 	</#if>	-->	
		</@s.if>  
	    	<@s.if test="(clientType != 'YI' )">  
	    		<#if profile.picture?exists>
				<tr><td class="tdLabel"><label class="label">Scanned Picture:</label></td>
				<td>																								
				<img src="${pictureURL}" alt="Picture" length="60" width="60">
				<br/>						
				<@s.a href="${removePictureURL}" onclick="return confirm('This will permanently remove your picture. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
			<#else/>
				<@s.file name="profilePictureFile" label="Scanned Picture" accept="image/*" size="35" required="true" />
			</#if>		
		
			<#if profile.signature?exists>
				<tr><td class="tdLabel"><label class="label">Scanned Signature:</label></td>
				<td>																								
				<img src="${signatureURL}" alt="Signature" length="60" width="60">
				<br/>						
				<@s.a href="${removeSignatureURL}" onclick="return confirm('This will permanently remove your signature. Are you sure you want to remove this?')"> Remove </@s.a>								
			</td></tr>
			<#else/>
				<@s.file name="profileSignatureFile" label="Scanned Signature/s" accept="image/*" size="35"  />	
			</#if>		
		</@s.if>  
		 
		<@s.hidden name="profile.lastDateOfTransaction" 
			displayFormat="MM/dd/yyyy" cssStyle="width: 100px;"   readonly="true"/>
		
		<@s.hidden name="profile.dateCreated" 
			displayFormat="MM/dd/yyyy" cssStyle="width: 100px;"   readonly="true"/>
		
			
</td></tr></table> 
</td></tr></table> 
</td></tr></table> 		 
		
		 
		<tr><td align=center>
 		<@s.if test="clientType == 'AW'">
 			<@s.if test="businessType == 'IND' || businessType == 'SPROP'">
				<@s.submit value="Save" action="saveAirport1" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		<@s.if test="clientType == 'AW'">
 			<@s.if test="businessType == 'CMP' || businessType == 'CORP' || businessType == 'PART'">
				<@s.submit value="Save" action="saveAirport2" theme="simple"/>
 			</@s.if>
 		</@s.if>

 		<@s.if test="clientType == 'BR'">
 			<@s.if test="businessType == 'IND' || businessType == 'SPROP'">
				<@s.submit value="Save" action="saveBroker1" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		<@s.if test="clientType == 'BR'">
 			<@s.if test="businessType == 'CMP' || businessType == 'CORP' || businessType == 'PART'">
				<@s.submit value="Save" action="saveBroker2" theme="simple"/>
 			</@s.if>
 		</@s.if>

 		<@s.if test="(clientType == 'CY')">
 			<@s.if test="(businessType == 'IND') || (businessType == 'SPROP')">
				<@s.submit value="Save" action="saveCYCFS1" theme="simple"/>
			</@s.if>
 		</@s.if>
 		<@s.if test="(clientType == 'CY')">
 			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="saveCYCFS2" theme="simple"/>
			</@s.if>
 		</@s.if>
 		
		<@s.if test="(clientType == 'IM')">
			<@s.if test="(businessType == 'IND') || (businessType == 'SPROP')">
				<@s.submit value="Save" action="saveProfileImporter1" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		<@s.if test="(clientType == 'IM')">
			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="saveProfileImporter2" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		
 		<@s.if test="(clientType == 'EX')">
			<@s.if test="(businessType == 'IND') || (businessType == 'SPROP')">
				<@s.submit value="Save" action="saveProfileExporter1" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		<@s.if test="(clientType == 'EX')">
			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="saveProfileExporter2" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		
 		
 		<@s.if test="(clientType == 'SU')">
 			<@s.if test="(businessType == 'IND') || (businessType == 'SPROP')">
				<@s.submit value="Save" action="saveSurety1" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		<@s.if test="(clientType == 'SU')">
 			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="saveSurety2" theme="simple"/>
 			</@s.if>
 		</@s.if>
 		
 		<@s.if test="(clientType == 'WO')">
 			<@s.if test="(businessType == 'IND') || (businessType == 'SPROP')">
				<@s.submit value="Save" action="saveWarehouse1" theme="simple"/>
			</@s.if>
		</@s.if>
		<@s.if test="(clientType == 'WO')">
 			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="saveWarehouse2" theme="simple"/>
			</@s.if>
		</@s.if>
		<@s.if test="(clientType == 'YI')">
 			<@s.if test="(businessType == 'IND')">
				<@s.submit value="Save" action="YI1save" theme="simple"/>
			</@s.if>
 		</@s.if>
 		<@s.if test="(clientType == 'YI')">
 			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="YI2save" theme="simple"/>
			</@s.if>
 		</@s.if>

		<@s.if test="(clientType == 'AR')">
			<@s.if test="(businessType == 'IND') || (businessType == 'SPROP')">
				<@s.submit value="Save" action="saveArrastreOperator1" theme="simple"/>
			</@s.if>
		</@s.if>
		<@s.if test="(clientType == 'AR')">
			<@s.if test="(businessType == 'CMP') || (businessType == 'CORP') || (businessType == 'PART')">
				<@s.submit value="Save" action="saveArrastreOperator2" theme="simple"/>
			</@s.if>
		</@s.if>

		<@s.submit value="Cancel" action="cancel" theme="simple"/> 
		
		<@s.if test="(profile.id != null )">
			<@s.submit value="Print" action="printProfile" theme="simple"/> 
		</@s.if>
		
		
		</td></tr>
</td></tr></table> 	  
	</@s.form>
		
		 </div>
    <script>
        var natureOfBusinessFullNames = [
            <#list naturesOfBusiness as item>
            "${item.name?js_string}"<#if item_has_next>,</#if>
            </#list>
        ];
    </script>
     <script src="${base}/js/profilesForm.js"></script>
	</body>
</html>


