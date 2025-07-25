<?xml version="1.0" encoding="UTF-8"?>
<Gateway>
  <ClientRegistrationForm>
    <#if (cprs.tinNo?exists) && (cprs.tinNo != "")>
      <ClientTaxpayerIdNo>${cprs.tinNo}</ClientTaxpayerIdNo>
    </#if>
    <#if (cprs.clientCcn?exists) && cprs.clientCcn != "">
      <ClientCCN>${cprs.clientCcn}</ClientCCN>
    </#if>
    <#if (cprs.secIdNo?exists) && (cprs.secIdNo != "")>
      <SecIdNo>${cprs.secIdNo?upper_case}</SecIdNo>
    </#if>
    <#if (cprs.pezaIdNo?exists) && (cprs.pezaIdNo != "")>
      <PezaIdNo>${cprs.pezaIdNo?upper_case}</PezaIdNo>
    </#if>
    <#if (cprs.prcIdNo?exists) && (cprs.prcIdNo != "")>
      <PrcIdNo>${cprs.prcIdNo?upper_case}</PrcIdNo>
    </#if>
    <#if (cprs.sssIdNo?exists) && (cprs.sssIdNo != "")>   
      <SssIdNo>${cprs.sssIdNo}</SssIdNo>
    </#if>
    <#if (cprs.passportIdNo?exists) && (cprs.passportIdNo != "")>   
      <PassportIdNo>${cprs.passportIdNo?upper_case}</PassportIdNo>
    </#if> 
    <#if (cprs.driverLicenseIdNo?exists) && (cprs.driverLicenseIdNo != "")>
      <DriverLicenseIdNo>${cprs.driverLicenseIdNo?upper_case}</DriverLicenseIdNo>
    </#if>
    <#if aabAssignedBank?exists>
      <AABAssignedBanks>
        <AABRefNo>${aabAssignedBank.aabAssignedBankRefNo?upper_case}</AABRefNo>
      </AABAssignedBanks>
      </#if>
    <#if profilePicture?exists>
      <Picture oes1-unsign-content="true"><![CDATA[${profilePicture}]]></Picture>
    </#if>
    <#if (clientType.code?exists) && (clientType.code != "")>
      <ClientTypeCode>${clientType.code}</ClientTypeCode>
    </#if>
    <#if (clientType.name?exists) && (clientType.name != "")>
      <ClientTypeName oes1-unsign-content="true">${clientType.name}</ClientTypeName>
    </#if>
    <#if (cprs.periodOfEffectivity?exists)>
      <DateOfEffectivity>${cprs.periodOfEffectivity?string("yyyy-MM-dd")}</DateOfEffectivity>
    </#if>
    <#if (cprs.lastDateOfTransaction?exists)>
      <LastDateofTransaction>${cprs.lastDateOfTransaction?string("yyyy-MM-dd")}</LastDateofTransaction>
    </#if>
    <#if (cprs.natureOfBusiness?exists) && (cprs.natureOfBusiness != "")>
      <Business>
        <NatureOfBusiness>${cprs.natureOfBusiness}</NatureOfBusiness>
        <BusinessEntity>${cprs.businessType}</BusinessEntity>
      </Business>
    </#if>
    <#if (cprs.firstName?exists) && (cprs.firstName != "")>
      <FullName>
        <First>${cprs.firstName?upper_case}</First>
        <Middle>${cprs.middleName?upper_case}</Middle>
        <Last>${cprs.lastName?upper_case}</Last>
      </FullName>
    </#if>
    <#if (cprs.company?exists) && (cprs.company != "")>
      <BusinessName>${cprs.company?upper_case}</BusinessName>
    </#if>
    <#if (cprs.citizenship?exists) && (cprs.citizenship != "")>
      <Citizenship>${cprs.citizenship}</Citizenship>
    </#if>
    <#if (cprs.address?exists) && (cprs.address != "")>
      <Location>
        <Address>${cprs.address?upper_case}</Address>
        <City>${cprs.city?upper_case}</City>
        <Country>${cprs.country?upper_case}</Country>
        <ZIP>${cprs.zipCode?upper_case}</ZIP>
      </Location>
    </#if>
    <#if (cprs.telephone?exists) && (cprs.telephone != "")>
      <ContactInformation>
        <Telephone>${cprs.telephone}</Telephone>
        <#if (cprs.altTelephone?exists) && (cprs.altTelephone != "")>
        <AlternateTelephone>${cprs.altTelephone}</AlternateTelephone>
        </#if>
        <#if (cprs.mobile?exists) && (cprs.mobile != "")>
        <Mobile>${cprs.mobile}</Mobile>
        </#if>
        <#if (cprs.fax?exists) && (cprs.fax != "")>
        <Facsimile>${cprs.fax}</Facsimile>
        </#if>
        <Email>${cprs.email}</Email>
      </ContactInformation>
    </#if>
    <#if (cprs.website?exists) && (cprs.website != "")>
      <Website>${cprs.website}</Website>
    </#if>
    <#if (cprs.customBondedWarehouseType?exists) && (cprs.customBondedWarehouseType != "")>
      <CBWType>${cprs.customBondedWarehouseType}</CBWType>
    </#if>
    <#if (clientType.code?exists) && (clientType.code != "")>
	  <#if ((cprs.clientType == "IM") || (clientType.code == "EX")) && ((cprs.customBondedWarehouse?exists) || (cprs.jo291?exists) || (cprs.certificateOfAuthority?exists) || (cprs.periodOfEffectivity?exists) || (cprs.underWritingCapacity?exists))>
	  <Special>
	    <#if (cprs.customBondedWarehouse?exists)>
	    <WarehouseCode>${cprs.customBondedWarehouse?upper_case}</WarehouseCode>
		</#if>
		<#if (cprs.jo291?exists)>
		<JO291ReferenceNumber>${cprs.jo291?upper_case}</JO291ReferenceNumber>
		</#if>
		<#if (cprs.certificateOfAuthority?exists)>
		<CertificateOfAuthority>${cprs.certificateOfAuthority!?upper_case}</CertificateOfAuthority>
		</#if>
		<#if (cprs.periodOfEffectivity?exists)>
		<JO291PeriodOfEffectivity>${cprs.periodOfEffectivity?string("yyyy-MM-dd")}</JO291PeriodOfEffectivity>
		</#if>
		<#if (cprs.underWritingCapacity?exists)>
		<JO291Capacity>${cprs.underWritingCapacity}</JO291Capacity>
		</#if>
	  </Special>
	  </#if>
    </#if>    
    <#if (cprs.capitalStockAmount?exists)>
    <Capital>
      <CapitalStockAmount>${cprs.capitalStockAmount}</CapitalStockAmount>
      <#if (cprs.paidUpCapitalAmount?exists)>
      <PaidUpCapitalAmount>${cprs.paidUpCapitalAmount}</PaidUpCapitalAmount>
      </#if>
    </Capital>
    </#if>
    <#if (cprs.vaspPrimaryCcn?exists) && (cprs.vaspPrimaryCcn != "")>
    <VASP>
      <PrimaryCCN>${cprs.vaspPrimaryCcn}</PrimaryCCN>
      <#if (cprs.vaspSecondaryCcn?exists) && (cprs.vaspSecondaryCcn != "")>
      <SecondaryCCN>${cprs.vaspSecondaryCcn}</SecondaryCCN>
      </#if>
    </VASP>
    </#if>
    <#if (cprs.relatedCompanyName1?exists) && (cprs.relatedCompanyName1 != "")>
    <RelatedCompany>
      <RelCompanyName1>${cprs.relatedCompanyName1?upper_case}</RelCompanyName1>
      <#if (cprs.relatedCompanyName2?exists) && (cprs.relatedCompanyName2 != "")>
      <RelCompanyName2>${cprs.relatedCompanyName2?upper_case}</RelCompanyName2>
      </#if>
      <#if (cprs.relatedCompanyName3?exists) && (cprs.relatedCompanyName3 != "")>
      <RelCompanyName3>${cprs.relatedCompanyName3?upper_case}</RelCompanyName3>
      </#if>
    </RelatedCompany>
    </#if>
    <#if (cprs.priBrokerTaxpayerIdNo?exists) && (cprs.priBrokerTaxpayerIdNo != "")>
    <PrimaryBroker>
      <TaxpayerIdNo>${cprs.priBrokerTaxpayerIdNo}</TaxpayerIdNo>
      <Code>${cprs.priBrokerCCN}</Code>
    </PrimaryBroker>
    </#if>
    <#if (cprs.secBrokerTaxpayerIdNo?exists) && (cprs.secBrokerTaxpayerIdNo != "")>
    <SecondaryBroker>
      <TaxpayerIdNo>${cprs.secBrokerTaxpayerIdNo}</TaxpayerIdNo>
      <Code>${cprs.secBrokerCCN}</Code>
    </SecondaryBroker>
    </#if>
    <#if (cprs.importers?exists) && (cprs.importers?size > 0)>
      <ImporterPlantList>
      <#list cprs.importers as importerPlant>
      <ImporterPlant>
        <Location>
          <Address>${importerPlant.address?upper_case}</Address>
          <City>${importerPlant.city?upper_case}</City>
          <Country>${importerPlant.country?upper_case}</Country>
          <ZIP>${importerPlant.zipCode?upper_case}</ZIP>
        </Location>
      </ImporterPlant>
      </#list>
      </ImporterPlantList>
    </#if>
    <#if (cprs.exporters?exists) && (cprs.exporters?size > 0)>
      <ImporterPlantList>
      <#list exporters as exporterPlant>
      <ImporterPlant>
        <Location>
          <Address>${exporterPlant.address?upper_case}</Address>
          <City>${exporterPlant.city?upper_case}</City>
          <Country>${exporterPlant.country?upper_case}</Country>
          <ZIP>${exporterPlant.zipCode?upper_case}</ZIP>
        </Location>
      </ImporterPlant>
      </#list>
      </ImporterPlantList>
    </#if>
    <#if (stockholders?exists) && (stockholders?size > 0)>
      <StockholdersList>
      <#list stockholders as stockholder>
      <Stockholders>
        <#if stockholder.picture?exists>
          <Picture oes1-unsign-content="true"><![CDATA[${stockholder.picture}]]></Picture>
        </#if>
        <#if stockholder.signature?exists>
          <Signature oes1-unsign-content="true"><![CDATA[${stockholder.signature}]]></Signature>
        </#if>
        <Name>
          <First>${stockholder.firstName?upper_case}</First>
          <Middle>${stockholder.middleName?upper_case}</Middle>
          <Last>${stockholder.lastName?upper_case}</Last>
        </Name>
        <Citizenship>${stockholder.citizenship?upper_case}</Citizenship>
        <TaxpayerIdNo>${stockholder.tinNo}</TaxpayerIdNo>
        <Location>
          <Address>${stockholder.address?upper_case}</Address>
          <City>${stockholder.city?upper_case}</City>
          <Country>${stockholder.country?upper_case}</Country>
          <ZIP>${stockholder.zipCode?upper_case}</ZIP>
        </Location>
        <ContactInformation>
          <Telephone>${stockholder.telephone}</Telephone>
          <#if (stockholder.altTelephone?exists) && (stockholder.altTelephone != "")>
          <AlternateTelephone>${stockholder.altTelephone}</AlternateTelephone>
          </#if>
          <#if (stockholder.mobile?exists) && (stockholder.mobile != "")>
          <Mobile>${stockholder.mobile}</Mobile>
          </#if>
          <#if (stockholder.fax?exists) && (stockholder.fax != "")>
          <Facsimile>${stockholder.fax}</Facsimile>
          </#if>
          <Email>${stockholder.email}</Email>
        </ContactInformation>
      </Stockholders>
      </#list>
      </StockholdersList>
    </#if>
    <#if (principalOfficers?exists) && (principalOfficers?size > 0)>
      <PrincipalOfficerList>
      <#list principalOfficers as principalOfficer>
      <PrincipalOfficer>
        <#if principalOfficer.picture?exists>
          <Picture oes1-unsign-content="true"><![CDATA[${principalOfficer.picture}]]></Picture>
        </#if>
        <#if principalOfficer.signature?exists>
          <Signature oes1-unsign-content="true"><![CDATA[${principalOfficer.signature}]]></Signature>
        </#if>
        <Name>
          <First>${principalOfficer.firstName?upper_case}</First>
          <Middle>${principalOfficer.middleName?upper_case}</Middle>
          <Last>${principalOfficer.lastName?upper_case}</Last>
        </Name>
        <TaxpayerIdNo>${principalOfficer.tinNo}</TaxpayerIdNo>
        <Position>${principalOfficer.position?upper_case}</Position>
        <Location>
          <Address>${principalOfficer.address?upper_case}</Address>
          <City>${principalOfficer.city?upper_case}</City>
          <Country>${principalOfficer.country?upper_case}</Country>
          <ZIP>${principalOfficer.zipCode?upper_case}</ZIP>
        </Location>
        <ContactInformation>
          <Telephone>${principalOfficer.telephone}</Telephone>
          <#if (principalOfficer.altTelephone?exists) && (principalOfficer.altTelephone != "")>
          <AlternateTelephone>${principalOfficer.altTelephone}</AlternateTelephone>
          </#if>
          <#if (principalOfficer.mobile?exists) && (principalOfficer.mobile != "")>
          <Mobile>${principalOfficer.mobile}</Mobile>
          </#if>
          <#if (principalOfficer.fax?exists) && (principalOfficer.fax != "")>
          <Facsimile>${principalOfficer.fax}</Facsimile>
          </#if>
          <Email>${principalOfficer.email}</Email>
        </ContactInformation>
      </PrincipalOfficer>
      </#list>
      </PrincipalOfficerList>
    </#if>
    <#if (equivRespOfficers?exists) && (equivRespOfficers?size > 0)>
      <EquivRespOfcrList>
      <#list equivRespOfficers as equivalentResponsibleOfficer>
      <EquivRespOfcr>
        <#if equivalentResponsibleOfficer.picture?exists>
          <Picture oes1-unsign-content="true"><![CDATA[${equivalentResponsibleOfficer.picture}]]></Picture>
        </#if>
        <#if equivalentResponsibleOfficer.signature?exists>
          <Signature oes1-unsign-content="true"><![CDATA[${equivalentResponsibleOfficer.signature}]]></Signature>
        </#if>
        <Name>
          <First>${equivalentResponsibleOfficer.firstName?upper_case}</First>
          <Middle>${equivalentResponsibleOfficer.middleName?upper_case}</Middle>
          <Last>${equivalentResponsibleOfficer.lastName?upper_case}</Last>
        </Name>
        <Position>${equivalentResponsibleOfficer.position?upper_case}</Position>
        <TaxpayerIdNo>${equivalentResponsibleOfficer.tinNo}</TaxpayerIdNo>
        <AreaOfResponsibility>${equivalentResponsibleOfficer.area?upper_case}</AreaOfResponsibility>
        <Location>
          <Address>${equivalentResponsibleOfficer.address?upper_case}</Address>
          <City>${equivalentResponsibleOfficer.city?upper_case}</City>
          <Country>${equivalentResponsibleOfficer.country?upper_case}</Country>
          <ZIP>${equivalentResponsibleOfficer.zipCode?upper_case}</ZIP>
        </Location>
        <ContactInformation>
          <Telephone>${equivalentResponsibleOfficer.telephone}</Telephone>
          <#if (equivalentResponsibleOfficer.altTelephone?exists) && (equivalentResponsibleOfficer.altTelephone != "")>
          <AlternateTelephone>${equivalentResponsibleOfficer.altTelephone}</AlternateTelephone>
          </#if>
          <#if (equivalentResponsibleOfficer.mobile?exists) && (equivalentResponsibleOfficer.mobile != "")>
          <Mobile>${equivalentResponsibleOfficer.mobile}</Mobile>
          </#if>
          <#if (equivalentResponsibleOfficer.fax?exists) && (equivalentResponsibleOfficer.fax != "")>
          <Facsimile>${equivalentResponsibleOfficer.fax}</Facsimile>
          </#if>
          <Email>${equivalentResponsibleOfficer.email}</Email>
        </ContactInformation>
      </EquivRespOfcr>
      </#list>
      </EquivRespOfcrList>
    </#if>
    <#if (cprs.majorSuppliers?exists) && (cprs.majorSuppliers?size > 0)>
      <MajorSupplierList>
      <#list cprs.majorSuppliers as majorSupplier>
      <MajorSupplier>
        <#if (majorSupplier.tinNo?exists) && (majorSupplier.tinNo != "")>
        <TIN>${majorSupplier.tinNo}</TIN>
        </#if>
        <CompanyName>${majorSupplier.company?upper_case}</CompanyName>
        <Location>
          <Address>${majorSupplier.address?upper_case}</Address>
          <City>${majorSupplier.city?upper_case}</City>
          <Country>${majorSupplier.country?upper_case}</Country>
          <ZIP>${majorSupplier.zipCode?upper_case}</ZIP>
        </Location>
        <ContactInformation>
          <Telephone>${majorSupplier.telephone}</Telephone>
          <#if (majorSupplier.altTelephone?exists) && (majorSupplier.altTelephone != "")>
          <AlternateTelephone>${majorSupplier.altTelephone}</AlternateTelephone>
          </#if>
          <#if (majorSupplier.mobile?exists) && (majorSupplier.mobile != "")>
          <Mobile>${majorSupplier.mobile}</Mobile>
          </#if>
          <#if (majorSupplier.fax?exists) && (majorSupplier.fax != "")>
          <Facsimile>${majorSupplier.fax}</Facsimile>
          </#if>
          <Email>${majorSupplier.email}</Email>
        </ContactInformation>
      </MajorSupplier>
      </#list>
      </MajorSupplierList>
    </#if>
    <#if (cprs.majorClients?exists) && (cprs.majorClients?size > 0)>
      <MajorClientList>
      <#list cprs.majorClients as majorClient>
      <MajorClient>
        <Name>${majorClient.company?upper_case}</Name>
        <#if (majorClient.clientType?exists) && (majorClient.clientType != "")>
        <ClientType>${majorClient.clientType}</ClientType>
        </#if>
        <Location>
          <Address>${majorClient.address?upper_case}</Address>
          <City>${majorClient.city?upper_case}</City>
          <Country>${majorClient.country?upper_case}</Country>
          <ZIP>${majorClient.zipCode?upper_case}</ZIP>
        </Location>
        <ContactInformation>
          <Telephone>${majorClient.telephone}</Telephone>
          <#if (majorClient.altTelephone?exists) && (majorClient.altTelephone != "")>
          <AlternateTelephone>${majorClient.altTelephone}</AlternateTelephone>
          </#if>
          <#if (majorClient.mobile?exists) && (majorClient.mobile != "")>
          <Mobile>${majorClient.mobile}</Mobile>
          </#if>
          <#if (majorClient.fax?exists) && (majorClient.fax != "")>
          <Facsimile>${majorClient.fax}</Facsimile>
          </#if>
          <Email>${majorClient.email}</Email>
          <#if (majorClient.website?exists) && (majorClient.website != "")>
          <Website>${majorClient.website}</Website>
          </#if>
        </ContactInformation>
      </MajorClient>
      </#list>
      </MajorClientList>
    </#if>
    <#if (importedCommodities?exists) && (importedCommodities?size > 0)>
      <ImportedCommodities>
      <#list importedCommodities as commodity>
      <Commodity>
        <HSCode>${commodity.hsCode}</HSCode>
        <ItemCode>${commodity.itemCode}</ItemCode>
        <ItemDescription>${commodity.itemDescription}</ItemDescription>
      </Commodity>
      </#list>
      </ImportedCommodities>    
    </#if>
  </ClientRegistrationForm>
</Gateway>