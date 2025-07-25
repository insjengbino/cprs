	

	
	<td><b>Click SAVE button to confirm, or BACK if you want to change/edit</b></td>
	
	<@s.url id="pictureURL" action="showPictureData">
	</@s.url>
	<@s.url id="signatureURL" action="showSignatureData">
	</@s.url>
	<@s.url id="importedCommoditiesURL" action="showImportedCommoditiesData">
	</@s.url>

	<@s.url id="stockholder1PictureURL" action="showStockholder1Picture">
	</@s.url>
	<@s.url id="stockholder1SignatureURL" action="showStockholder1Signature">
	</@s.url>
	<@s.url id="stockholder2PictureURL" action="showStockholder2Picture">
	</@s.url>
	<@s.url id="stockholder2SignatureURL" action="showStockholder2Signature">
	</@s.url>
	<@s.url id="stockholder3PictureURL" action="showStockholder3Picture">
	</@s.url>
	<@s.url id="stockholder3SignatureURL" action="showStockholder3Signature">
	</@s.url>
	
	<@s.url id="principalOfficer1PictureURL" action="showPrincipalOfficer1Picture">
	</@s.url>
	<@s.url id="principalOfficer1SignatureURL" action="showPrincipalOfficer1Signature">
	</@s.url>
	<@s.url id="principalOfficer2PictureURL" action="showPrincipalOfficer2Picture">
	</@s.url>
	<@s.url id="principalOfficer2SignatureURL" action="showPrincipalOfficer2Signature">
	</@s.url>
	<@s.url id="principalOfficer3PictureURL" action="showPrincipalOfficer3Picture">
	</@s.url>
	<@s.url id="principalOfficer3SignatureURL" action="showPrincipalOfficer3Signature">
	</@s.url>
	
	<@s.url id="equivRespOfficer1PictureURL" action="showEquivRespOfficer1Picture">
	</@s.url>
	<@s.url id="equivRespOfficer1SignatureURL" action="showEquivRespOfficer1Signature">
	</@s.url>
	<@s.url id="equivRespOfficer2PictureURL" action="showEquivRespOfficer2Picture">
	</@s.url>
	<@s.url id="equivRespOfficer2SignatureURL" action="showEquivRespOfficer2Signature">
	</@s.url>
	<@s.url id="equivRespOfficer3PictureURL" action="showEquivRespOfficer3Picture">
	</@s.url>
	<@s.url id="equivRespOfficer3SignatureURL" action="showEquivRespOfficer3Signature">
	</@s.url>
	
	<@s.form method="POST" enctype="multipart/form-data">
		 <@s.hidden name="profile.id"/>
		 
	     <@s.label label="Customs Client Number" name="profile.clientCcn" readonly="true"/>
		 <@s.textfield label="INS Client Number" name="profile.insClientNo" required="true" readonly="true"/> 
		 <@s.textfield label="Client Type" name="#session._client_type" required="true" readonly="true"/>   
		 <@s.if test="(#session._client_type != 'BR' ) && (#session._client_type != 'occassional')">
		  <@s.textfield label="Business Name/Company Name" name="profile.company" required="true" readonly="true"/>
		 </@s.if>
		  
		 <@s.if test="(#session._client_type == 'BR' ) || (#session._client_type == 'occassional')">
		  <@s.textfield label="First Name" name="profile.firstName" required="true" readonly="true"/> 
		  <@s.textfield label="Middle Name" name="profile.middleName" required="true" readonly="true"/> 
		  <@s.textfield label="Last Name " name="profile.lastName" required="true" readonly="true"/>
		  <@s.textfield label="Citizenship" name="profile.citizenship" required="true" readonly="true"/>
		 </@s.if>

		  <@s.textfield label="Address" name="profile.address" required="true" readonly="true"/>
		  <@s.textfield label="City" name="profile.city" required="true" readonly="true"/>
		  <@s.textfield label="Zip Code" name="profile.zipCode" required="true" readonly="true" />
		  <@s.textfield label="Country" name="profile.country" required="true" readonly="true" />
		  <@s.textfield label="Telephone Number" name="profile.telephone" required="true" readonly="true" />
		  <@s.textfield label="Alternate Telephone Number" name="profile.altTelephone" readonly="true" />
		  <@s.textfield label="Fax" name="profile.fax" readonly="true"/>
		  
		 <@s.if test="(#session._client_type == 'BR' ) || (#session._client_type == 'forwarder') || (#session._client_type == 'occassional')">
		   <@s.textfield label="Mobile Number" name="profile.mobile" readonly="true" />
		 </@s.if>
		  
		   <@s.textfield label="Email Address" name="profile.email" required="true" readonly="true" />
		   <@s.textfield label="Website" name="profile.website" readonly="true" />
		  
		 <@s.if test="(#session._client_type != 'BR' ) && (#session._client_type != 'occassional')">
		   <@s.textfield label="Nature of Business" name="profile.natureOfBusiness" required="true" readonly="true" />
		   <@s.textfield label="Type of Business Entity" name="profile.businessType" required="true" readonly="true" />
		 </@s.if>																		
		 <@s.if test="(#session._client_type == 'WO')">
		    <@s.textfield label="Custom Bonded Warehouse Type" name="profile.customBondedWarehouseType" required="true" theme="ajax" readonly="true"/>
		 </@s.if>																		
		   
		 <@s.if test="(#session._client_type == 'AW' ) || (#session._client_type == 'arrastre')
		   			|| (#session._client_type == 'CY')|| (#session._client_type == 'WO')">
		   <@s.textfield label="Custom Bonded Warehouse" name="profile.customBondedWarehouse" required="true" readonly="true" />
		 </@s.if>
		 
		 <@s.if test="(#session._client_type == 'IM' ) || (#session._client_type == 'EX') || (#session._client_type == 'SU')">
		   <@s.textfield label="J0 2-91 Reference No." name="profile.jo291" required="true" readonly="true"/>
		   <@s.textfield label="Certificate of Authority" name="profile.certificateOfAuthority" required="true" readonly="true"/>
		   <@s.textfield label="Period of Effectivity" name="profile.periodOfEffectivity" required="true" readonly="true"/>
		   <@s.textfield label="Under Writing Capacity" name="profile.underWritingCapacity" required="true" readonly="true"/>
		 </@s.if>
		 
		 <@s.textfield label="TIN Number" name="profile.tinNo" required="true" readonly="true"/>
		  
		 <@s.if test="(#session._client_type == 'BR' ) || (#session._client_type == 'forwarder') || (#session._client_type == 'occassional')">
		   <@s.textfield label="SSS Number" name="profile.sssIdNo" readonly="true"/>
		 </@s.if>
		
		 <@s.if test="(#session._client_type == 'occassional')">
		   <@s.textfield label="Passport Number" name="profile.passportIdNo" readonly="true"/>
		   <@s.textfield label="Driver's License" name="profile.driverLicenseIdNo" readonly="true"/>
     	 </@s.if>
		  
		 <@s.if test="(#session._client_type == 'BR')">
		   <@s.textfield label="PRC Id Number" name="profile.prcIdNo" required="true" readonly="true"/>
		 </@s.if>
		
		 <@s.if test="(#session._client_type != 'occassional') && (#session._client_type != 'vasp')">
		   <@s.textfield label="VASP Primary CCN" name="profile.vaspPrimaryCcn" required="true" readonly="true"/>
		 </@s.if>
		
		 <@s.if test="(#session._client_type != 'AW') && (#session._client_type != 'occassional') && (#session._client_type != 'vasp')">
		   <@s.textfield label="VASP Secondary CCN" name="profile.vaspSecondaryCcn" required="true" readonly="true"/>
		 </@s.if>
		   
		 <@s.if test="(#session._client_type != 'BR' ) && (#session._client_type != 'occassional')">
  		  <@s.textfield label="PEZA BOI Registration Number" name="profile.pezaIdNo" required="true" readonly="true"/>
		  <@s.textfield label="SEC Registration Number" name="profile.secIdNo" required="true" readonly="true"/>
		 </@s.if>
		  
		 <@s.if test="(#session._client_type == 'airlines' ) || (#session._client_type == 'arrastre') 
		  			|| (#session._client_type == 'consolidator') || (#session._client_type == 'IM') || (#session._client_type == 'EX')
		  			|| (#session._client_type == 'shipping')
		  			|| (#session._client_type == 'vasp')">
		  <@s.textfield label="Amount of Authorized Capital Stock" name="profile.capitalStockAmount" required="true" readonly="true"/>
		  <@s.textfield label="Amount of Paid Up Capital" name="profile.paidUpCapitalAmount" required="true" readonly="true"/>
		 </@s.if>
		
		 <@s.if test="(#session._client_type == 'aab')">
		  <@s.textfield label="AAB Reference Code" name="profile.aabAssignedBankRefNo" required="true" readonly="true"/>
		 </@s.if>
		
		 <@s.if test="(#session._client_type == 'airlines' ) || (#session._client_type == 'AW') 
		  			|| (#session._client_type == 'arrastre') || (#session._client_type == 'consolidator')
		  			|| (#session._client_type == 'CY')    || (#session._client_type == 'IM') || (#session._client_type == 'EX') || (#session._client_type == 'WO') 
		  			|| (#session._client_type == 'shipping')">
		   <@s.textfield label="Related Domestic and Foreign Company 1" name="profile.relatedCompanyName1" required="true" readonly="true"/>
		   <@s.textfield label="Related Domestic and Foreign Company 2" name="profile.relatedCompanyName2" required="true" readonly="true"/>
		   <@s.textfield label="Related Domestic and Foreign Company 3" name="profile.relatedCompanyName3" required="true" readonly="true"/>
		 </@s.if>
		 
		  <@s.if test="(#session._client_type == 'IM') || (#session._client_type == 'EX') || (#session._client_type == 'WO')">
			<@s.textfield label="Primary Broker TIN Number" name="profile.priBrokerTaxpayerIdNo" required="true" readonly="true"/>
			<@s.textfield label="Primary Broker CCN" name="profile.priBrokerCCN" required="true" readonly="true"/>
			<@s.textfield label="Primary Broker Port Entry" name="profile.priBrokerPortOfEntry" required="true" readonly="true"/>
			<@s.textfield label="Secondary Broker TIN Number" name="profile.secBrokerTaxpayerIdNo" required="true" readonly="true"/>
			<@s.textfield label="Secondary Broker CCN" name="profile.secBrokerCCN" required="true" readonly="true"/>
			<@s.textfield label="Secondary Broker Port Entry" name="profile.secBrokerPortOfEntry" required="true" readonly="true"/>
	   	    <@s.label name="profileImportedCommoditiesFile" alt="Importable Commodities" length="100" width="50"/>
            
	   	  </@s.if>
            
          <@s.if test="(#session._client_type == 'BR' )    || (#session._client_type == 'IM' ) || (#session._client_type == 'EX' ) 
		  			|| (#session._client_type == 'forwarder') || (#session._client_type == 'occassional' )">
			
			<tr><td>																				
				<img src="${pictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${signatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
			
		  </@s.if>
		  	<@s.textfield label="Last Date of Transaction" name="profile.lastDateOfTransaction" required="true" readonly="true"/>
		 
		 <@s.if test="(#session._client_type == 'AW') || (#session._client_type == 'arrastre') || (#session._client_type == 'consolidator')
   		 		   || (#session._client_typee == 'CY') || (#session._client_type == 'IM') || (#session._client_type == 'EX') || (#session._client_type == 'WO')">
     	 <tr><td colspan="2">__________________________________________________________________________________________</td></tr>
     	 	<@s.hidden name="importer.id"/>
    
     	 	<tr><td colspan="2"><b>Plant Importer 1</b></td></tr>		
			<@s.textfield label="Address" name="importer1.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="importer1.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="importer1.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="importer1.country" required="true" readonly="true"/>
		  	<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Plant Importer 2</b></td></tr>		
		  	<@s.textfield label="Address" name="importer2.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="importer2.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="importer2.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="importer2.country" required="true" readonly="true"/>
		    <tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Plant Importer 3</b></td></tr>	 
		    <@s.textfield label="Address" name="importer3.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="importer3.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="importer3.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="importer3.country" required="true" readonly="true"/>
     	 </@s.if>
     	 
     	 <@s.if test="(#session._client_type != 'BR' ) && (#session._client_type != 'occassional') && (#session._client_type != 'SU')">
     	  <tr><td colspan="2">__________________________________________________________________________________________</td></tr>
     	 	<@s.hidden name="majorStockholder.id"/>
			<tr><td colspan="2"><b>Major Stockholder 1</b></td></tr>
			<@s.textfield label="First Name" name="majorStockholder1.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="majorStockholder1.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="majorStockholder1.lastName" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="majorStockholder1.citizenship" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="majorStockholder1.tinNo" required="true" readonly="true"/>
				 
			<@s.textfield label="Address" name="majorStockholder1.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorStockholder1.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorStockholder1.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorStockholder1.country" required="true" readonly="true"/>
				 
			<@s.textfield label="Telephone Number" name="majorStockholder1.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorStockholder1.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorStockholder1.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorStockholder1.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorStockholder1.email" required="true" readonly="true"/> 
				 
			<tr><td>																				
				<img src="${stockholder1PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${stockholder1SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
				  
		<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Major Stockholder 2</b></td></tr>
			<@s.textfield label="First Name" name="majorStockholder2.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="majorStockholder2.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="majorStockholder2.lastName" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="majorStockholder2.citizenship" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="majorStockholder2.tinNo" required="true" readonly="true"/>
				   
			<@s.textfield label="Address" name="majorStockholder2.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorStockholder2.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorStockholder2.zipCode" required="true" readonly="true"/>
				 
			<@s.textfield label="Country" name="majorStockholder2.country" required="true" readonly="true"/>
			 															
			<@s.textfield label="Telephone Number" name="majorStockholder2.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorStockholder2.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorStockholder2.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorStockholder2.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorStockholder2.email" required="true" readonly="true"/> 
				 
			<tr><td>																				
				<img src="${stockholder2PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${stockholder2SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
				 
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Major Stockholder 3</b></td></tr>
			<@s.textfield label="First Name" name="majorStockholder3.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="majorStockholder3.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="majorStockholder3.lastName" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="majorStockholder3.citizenship" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="majorStockholder3.tinNo" required="true" readonly="true"/>
				 
			<@s.textfield label="Address" name="majorStockholder3.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorStockholder3.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorStockholder3.zipCode" required="true" readonly="true"/>
				 
			<@s.textfield label="Country" name="majorStockholder3.country" required="true" readonly="true"/>
			 															
			<@s.textfield label="Telephone Number" name="majorStockholder3.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorStockholder3.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorStockholder3.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorStockholder3.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorStockholder3.email" required="true" readonly="true"/> 

			<tr><td>																				
				<img src="${stockholder3PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${stockholder3SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
			
     	 </@s.if>
     	  
     	 <@s.if test="(#session._client_type != 'BR' ) && (#session._client_type != 'occassional')">
     	 	<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
     	 	<@s.hidden name="principalOfficer.id"/>
     	 	<tr><td colspan="2"><b>Principal Officer 1</b></td></tr>	
			<@s.textfield label="First Name" name="principalOfficer1.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="principalOfficer1.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="principalOfficer1.lastName" required="true" readonly="true"/>
			<@s.textfield label="Position" name="principalOfficer1.position" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="principalOfficer1.citizenship" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="principalOfficer1.tinNo" required="true" readonly="true"/>
			<@s.textfield label="Address" name="principalOfficer1.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="principalOfficer1.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="principalOfficer1.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="principalOfficer1.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="principalOfficer1.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="principalOfficer1.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="principalOfficer1.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="principalOfficer1.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="principalOfficer1.email" required="true" readonly="true"/> 
				 
		   <tr><td>																				
				<img src="${principalOfficer1PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${principalOfficer1SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
				 
		    <tr><td colspan="2">__________________________________________________________________________________________</td></tr>
		    <tr><td colspan="2"><b>Principal Officer 2</b></td></tr>	
			<@s.textfield label="First Name" name="principalOfficer2.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="principalOfficer2.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="principalOfficer2.lastName" required="true" readonly="true"/>
			<@s.textfield label="Position" name="principalOfficer2.position" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="principalOfficer2.citizenship" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="principalOfficer2.tinNo" required="true" readonly="true"/>
			<@s.textfield label="Address" name="principalOfficer2.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="principalOfficer2.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="principalOfficer2.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="principalOfficer2.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="principalOfficer2.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="principalOfficer2.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="principalOfficer2.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="principalOfficer2.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="principalOfficer2.email" required="true" readonly="true"/>
			
			 <tr><td>																				
				<img src="${principalOfficer2PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${principalOfficer2SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
				 
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Principal Officer 3</b></td></tr>	
			<@s.textfield label="First Name" name="principalOfficer3.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="principalOfficer3.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="principalOfficer3.lastName" required="true" readonly="true"/>
			<@s.textfield label="Position" name="principalOfficer3.position" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="principalOfficer3.citizenship" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="principalOfficer3.tinNo" required="true" readonly="true"/>
			<@s.textfield label="Address" name="principalOfficer3.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="principalOfficer3.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="principalOfficer3.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="principalOfficer3.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="principalOfficer3.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="principalOfficer3.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="principalOfficer3.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="principalOfficer3.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="principalOfficer3.email" required="true" readonly="true"/> 
				 
			<tr><td>																				
				<img src="${principalOfficer3PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${principalOfficer3SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
			
     	  </@s.if>
     	  
     	  
     	  <@s.if test="(#session._client_type != 'occassional')">
     	 	<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
     	 	<@s.hidden name="equivRespOfficer.id"/>
			<tr><td colspan="2"><b>Equivalent Responsible Officer 1</b></td></tr>	
			<@s.textfield label="First Name" name="equivRespOfficer1.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="equivRespOfficer1.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="equivRespOfficer1.lastName" required="true" readonly="true"/>
			<@s.textfield label="Position" name="equivRespOfficer1.position" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="equivRespOfficer1.tinNo" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="equivRespOfficer1.citizenship" required="true" readonly="true"/>
			<@s.textfield label="Area of Responsibility" name="equivRespOfficer1.area" required="true" readonly="true"/>
			<@s.textfield label="Address" name="equivRespOfficer1.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="equivRespOfficer1.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="equivRespOfficer1.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="equivRespOfficer1.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="equivRespOfficer1.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="equivRespOfficer1.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="equivRespOfficer1.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="equivRespOfficer1.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="equivRespOfficer1.email" required="true" readonly="true"/> 
				 
			<tr><td>																				
				<img src="${equivRespOfficer1PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${equivRespOfficer1SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
				 
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Equivalent Responsible Officer 2</b></td></tr>	
     	 	<@s.textfield label="First Name" name="equivRespOfficer2.firstName" required="true" readonly="true"/> 
		    <@s.textfield label="Middle Name" name="equivRespOfficer2.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="equivRespOfficer2.lastName" required="true" readonly="true"/>
			<@s.textfield label="Position" name="equivRespOfficer2.position" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="equivRespOfficer2.tinNo" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="equivRespOfficer2.citizenship" required="true" readonly="true"/>
			<@s.textfield label="Area of Responsibility" name="equivRespOfficer2.area" required="true" readonly="true"/>
			<@s.textfield label="Address" name="equivRespOfficer2.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="equivRespOfficer2.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="equivRespOfficer2.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="equivRespOfficer2.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="equivRespOfficer2.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="equivRespOfficer2.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="equivRespOfficer2.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="equivRespOfficer2.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="equivRespOfficer2.email" required="true" readonly="true"/> 
				 
			<tr><td>																				
				<img src="${equivRespOfficer2PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${equivRespOfficer2SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
				 
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Equivalent Responsible Officer 3</b></td></tr>	
     	 	<@s.textfield label="First Name" name="equivRespOfficer3.firstName" required="true" readonly="true"/> 
			<@s.textfield label="Middle Name" name="equivRespOfficer3.middleName" required="true" readonly="true"/> 
			<@s.textfield label="Last Name " name="equivRespOfficer3.lastName" required="true" readonly="true"/>
			<@s.textfield label="Position" name="equivRespOfficer3.position" required="true" readonly="true"/>
			<@s.textfield label="TIN Number" name="equivRespOfficer3.tinNo" required="true" readonly="true"/>
			<@s.textfield label="Citizenship" name="equivRespOfficer3.citizenship" required="true" readonly="true"/>
			<@s.textfield label="Area of Responsibility" name="equivRespOfficer3.area" required="true" readonly="true"/>
			<@s.textfield label="Address" name="equivRespOfficer3.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="equivRespOfficer3.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="equivRespOfficer3.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="equivRespOfficer3.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="equivRespOfficer3.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="equivRespOfficer3.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="equivRespOfficer3.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="equivRespOfficer3.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="equivRespOfficer3.email" required="true" readonly="true"/>
				 
			<tr><td>																				
				<img src="${equivRespOfficer3PictureURL}" alt="Picture" length="100" width="50">														
			</td></tr>
			<tr><td>																				
				<img src="${equivRespOfficer3SignatureURL}" alt="Signature" length="100" width="50">														
			</td></tr>
			
     	 </@s.if>
     	 
     	 <@s.if test="(#session._client_type == 'BR' ) || (#session._client_type == 'IM') || (#session._client_type == 'EX') || (#session._client_type == 'forwarder') || (#session._client_type == 'WO')">
     		<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
     	 	<@s.hidden name="majorSupplier.id"/>
     	 	<tr><td colspan="2"><b>Major Supplier 1</b></td></tr>	
     	 	 	 
			<@s.textfield label="Company Name" name="majorSupplier1.company" required="true" readonly="true"/> 
			<@s.textfield label="Address" name="majorSupplier1.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorSupplier1.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorSupplier1.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorSupplier1.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="majorSupplier1.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorSupplier1.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorSupplier1.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorSupplier1.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorSupplier1.email" required="true" readonly="true"/>
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Major Supplier 2</b></td></tr>	
					 
			<@s.textfield label="Company Name" name="majorSupplier2.company" required="true" readonly="true"/> 
			<@s.textfield label="Address" name="majorSupplier2.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorSupplier2.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorSupplier2.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorSupplier2.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="majorSupplier2.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorSupplier2.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorSupplier2.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorSupplier2.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorSupplier2.email" required="true" readonly="true"/>
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Major Supplier 3</b></td></tr>	
			
			<@s.textfield label="Company Name" name="majorSupplier3.company" required="true" readonly="true"/> 
			<@s.textfield label="Address" name="majorSupplier3.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorSupplier3.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorSupplier3.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorSupplier3.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="majorSupplier3.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorSupplier3.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorSupplier3.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorSupplier3.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorSupplier3.email" required="true" readonly="true"/>
     	 	<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
     	 	<@s.hidden name="majorClient.id"/>
     	 	<tr><td colspan="2"><b>Major Client 1</b></td></tr>	
     	 <@s.if test="(clientType == 'BR' ) || (clientType == 'forwarder') ">
     	 	<@s.textfield label="Client Type" name="majorClient1.clientType" required="true" readonly="true"/>
		 </@s.if>	
			<@s.textfield label="Company Name" name="majorClient1.company" required="true" readonly="true"/> 
			<@s.textfield label="Address" name="majorClient1.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorClient1.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorClient1.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorClient1.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="majorClient1.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorClient1.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorClient1.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorClient1.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorClient1.email" required="true" readonly="true"/>
			<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Major Client 2</b></td></tr>	
		 <@s.if test="(clientType == 'BR' ) || (clientType == 'forwarder') ">
		    <@s.textfield label="Client Type" name="majorClient2.clientType" required="true" readonly="true"/>
		 </@s.if>	
			<@s.textfield label="Company Name" name="majorClient2.company" required="true" readonly="true"/> 
			<@s.textfield label="Address" name="majorClient2.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorClient2.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorClient2.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorClient2.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="majorClient2.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorClient2.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorClient2.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorClient2.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorClient2.email" required="true" readonly="true"/>
     	 	<tr><td colspan="2">__________________________________________________________________________________________</td></tr>
			<tr><td colspan="2"><b>Major Client 3</b></td></tr>	
		 <@s.if test="(clientType == 'BR' ) || (clientType == 'forwarder') ">
			<@s.textfield label="Client Type" name="majorClient3.clientType" required="true" readonly="true"/>
		 </@s.if>			 
			<@s.textfield label="Company Name" name="majorClient3.company" required="true" readonly="true"/> 
			<@s.textfield label="Address" name="majorClient3.address" required="true" readonly="true"/>
			<@s.textfield label="City" name="majorClient3.city" required="true" readonly="true"/>
			<@s.textfield label="Zip Code" name="majorClient3.zipCode" required="true" readonly="true"/>
			<@s.textfield label="Country" name="majorClient3.country" required="true" readonly="true"/>
			<@s.textfield label="Telephone Number" name="majorClient3.telephone" required="true" readonly="true"/>
			<@s.textfield label="Alt Telephone Number" name="majorClient3.altTelephone" readonly="true"/>
			<@s.textfield label="Fax" name="majorClient3.fax" readonly="true"/>
			<@s.textfield label="Mobile Number" name="majorClient3.mobile" readonly="true"/>
			<@s.textfield label="Email Address" name="majorClient3.email" required="true" readonly="true"/>
		</@s.if>

         <tr><td colspan="2">__________________________________________________________________________________________</td></tr>
		 <td>
		 <@s.submit value="Back" action="profileForm" theme="simple"/>
		 <@s.submit value="Save" action="saveProfile" theme="simple"/>
	     </td>
	</@s.form>
	
		  