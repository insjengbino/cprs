package com.ins.registration.model;

import com.ins.registration.model.Commodity;
import com.ins.registration.model.EquivRespOfficer;
import com.ins.registration.model.Exporter;
import com.ins.registration.model.Importer;
import com.ins.registration.model.MajorClient;
import com.ins.registration.model.MajorStockholder;
import com.ins.registration.model.MajorSupplier;
import com.ins.registration.model.PrincipalOfficer;
import com.ins.registration.model.Profile;
import com.ins.registration.model.Role;
import com.ins.registration.model.Status;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@NamedQueries({@NamedQuery(
        name = "listProfiles",
        query = "select a from Profile a order by a.id asc"
), @NamedQuery(
        name = "listProfilesByClientCode",
        query = "select a from Profile a where a.insClientNo=:insClientNo order by a.id asc"
), @NamedQuery(
        name = "listProfilesByClientType",
        query = "select a from Profile a where a.clientType=:clientType order by a.id asc"
), @NamedQuery(
        name = "listProfilesByStatus",
        query = "select a from Profile a where a.status.id=:status order by a.id asc"
), @NamedQuery(
        name = "listProfilesByTinAndClientType",
        query = "select a from Profile a where a.clientType=:clientType and a.tinNo=:tinNo order by a.id asc"
), @NamedQuery(
        name = "listProfilesByBusinessType",
        query = "select a from Profile a where a.businessType=:businessType order by a.id asc"
), @NamedQuery(
        name = "listProfilesByNatureOfBusiness",
        query = "select a from Profile a where a.natureOfBusiness=:natureOfBusiness order by a.id asc"
), @NamedQuery(
        name = "searchTIN",
        query = "select t from Profile t where t.tinNo like :tinNo"
), @NamedQuery(
        name = "searchTinAndId",
        query = "select t from Profile t where t.tinNo=:tinNo and t.id=:id"
)})
public class Profile implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;

    private String clientType;

    private String clientCcn;

    private String insClientNo;

    private String tinNo;

    private String company;

    private String firstName;

    private String middleName;

    private String lastName;

    private String citizenship;

    private String address;

    private String city;

    private String zipCode;

    private String country;

    private String Telephone;

    private String altTelephone;

    private String fax;

    private String email;

    private String mobile;

    private String website;

    private String prcIdNo;

    private String sssIdNo;

    private String passportIdNo;

    private String driverLicenseIdNo;

    private String pezaIdNo;

    private String secIdNo;

    private String natureOfBusiness;

    private String businessName;

    private String capitalStockAmount;

    private String paidUpCapitalAmount;

    private String businessType;

    private String aabAssignedBankRefNo;

    private String relatedCompanyName1;

    private String relatedCompanyName2;

    private String relatedCompanyName3;

    private String vaspPrimaryCcn;

    private String vaspSecondaryCcn;

    private String jo291;

    private String certificateOfAuthority;

    private String underWritingCapacity;

    private String priBrokerTaxpayerIdNo;

    private String priBrokerCCN;

    private String secBrokerTaxpayerIdNo;

    private String secBrokerCCN;

    private String customBondedWarehouse;

    private String customBondedWarehouseType;

    private String errorMessage;

    @ManyToOne
    private Status status;

    @Temporal(TemporalType.DATE)
    private Date periodOfEffectivity;

    @Temporal(TemporalType.DATE)
    private Date lastDateOfTransaction;

    @Temporal(TemporalType.DATE)
    private Date dateCreated;
    @OneToMany(
            targetEntity = MajorStockholder.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<MajorStockholder> majorStockholders;
    @OneToMany(
            targetEntity = PrincipalOfficer.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<PrincipalOfficer> principalOfficers;
    @OneToMany(
            targetEntity = EquivRespOfficer.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<EquivRespOfficer> equivRespOfficers;
    @OneToMany(
            targetEntity = MajorSupplier.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<MajorSupplier> majorSuppliers;
    @OneToMany(
            targetEntity = MajorClient.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<MajorClient> majorClients;
    @OneToMany(
            targetEntity = Importer.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<Importer> importers;

    @OneToMany(
            targetEntity = Exporter.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL})
    private List<Exporter> exporters;

    @OneToMany(
            targetEntity = Commodity.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<Commodity> commodities;

    @OneToMany(
            targetEntity = ProfileHistory.class,
            mappedBy = "profile",
            cascade = {CascadeType.ALL}
    )
    private List<ProfileHistory> profileHistoryList;
    @ManyToMany(
            mappedBy = "profiles"
    )
    private List<Role> roles = new ArrayList();
    @Lob
    private byte[] importedCommodities;

    @Lob
    private byte[] picture;

    @Transient
    private InputStream pictureAsInputStream;

    @Lob
    private byte[] signature;

    private boolean stored = false;

    private String importerTin;

    private String exporterTin;

    public List<Role> getRoles() {
        return this.roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getClientCcn() {
        return this.clientCcn;
    }

    public void setClientCcn(String clientCcn) {
        this.clientCcn = clientCcn;
    }

    public String getTinNo() {
        return this.tinNo;
    }

    public void setTinNo(String tinNo) {
        this.tinNo = tinNo;
    }

    public String getFirstName() {
        return this.firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return this.middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getCitizenship() {
        return this.citizenship;
    }

    public void setCitizenship(String citizenship) {
        this.citizenship = citizenship;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getZipCode() {
        return this.zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getCountry() {
        return this.country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getTelephone() {
        return this.Telephone;
    }

    public void setTelephone(String telephone) {
        this.Telephone = telephone;
    }

    public String getAltTelephone() {
        return this.altTelephone;
    }

    public void setAltTelephone(String altTelephone) {
        this.altTelephone = altTelephone;
    }

    public String getMobile() {
        return this.mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getFax() {
        return this.fax;
    }

    public String getWebsite() {
        return this.website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getPrcIdNo() {
        return this.prcIdNo;
    }

    public void setPrcIdNo(String prcIdNo) {
        this.prcIdNo = prcIdNo;
    }

    public String getSssIdNo() {
        return this.sssIdNo;
    }

    public void setSssIdNo(String sssIdNo) {
        this.sssIdNo = sssIdNo;
    }

    public String getPassportIdNo() {
        return this.passportIdNo;
    }

    public void setPassportIdNo(String passportIdNo) {
        this.passportIdNo = passportIdNo;
    }

    public String getDriverLicenseIdNo() {
        return this.driverLicenseIdNo;
    }

    public void setDriverLicenseIdNo(String driverLicenseIdNo) {
        this.driverLicenseIdNo = driverLicenseIdNo;
    }

    public String getPezaIdNo() {
        return this.pezaIdNo;
    }

    public void setPezaIdNo(String pezaIdNo) {
        this.pezaIdNo = pezaIdNo;
    }

    public String getSecIdNo() {
        return this.secIdNo;
    }

    public void setSecIdNo(String secIdNo) {
        this.secIdNo = secIdNo;
    }

    public String getNatureOfBusiness() {
        return this.natureOfBusiness;
    }

    public void setNatureOfBusiness(String natureOfBusiness) {
        this.natureOfBusiness = natureOfBusiness;
    }

    public String getBusinessName() {
        return this.businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getCapitalStockAmount() {
        return this.capitalStockAmount;
    }

    public void setCapitalStockAmount(String capitalStockAmount) {
        this.capitalStockAmount = capitalStockAmount;
    }

    public String getPaidUpCapitalAmount() {
        return this.paidUpCapitalAmount;
    }

    public void setPaidUpCapitalAmount(String paidUpCapitalAmount) {
        this.paidUpCapitalAmount = paidUpCapitalAmount;
    }

    public String getBusinessType() {
        return this.businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType;
    }

    public List<MajorStockholder> getMajorStockholders() {
        return this.majorStockholders;
    }

    public void setMajorStockholders(List<MajorStockholder> majorStockholders) {
        this.majorStockholders = majorStockholders;
    }

    public List<PrincipalOfficer> getPrincipalOfficers() {
        return this.principalOfficers;
    }

    public void setPrincipalOfficers(List<PrincipalOfficer> principalOfficers) {
        this.principalOfficers = principalOfficers;
    }

    public List<EquivRespOfficer> getEquivRespOfficers() {
        return this.equivRespOfficers;
    }

    public void setEquivRespOfficers(List<EquivRespOfficer> equivRespOfficers) {
        this.equivRespOfficers = equivRespOfficers;
    }

    public List<MajorSupplier> getMajorSuppliers() {
        return this.majorSuppliers;
    }

    public void setMajorSuppliers(List<MajorSupplier> majorSuppliers) {
        this.majorSuppliers = majorSuppliers;
    }

    public List<MajorClient> getMajorClients() {
        return this.majorClients;
    }

    public void setMajorClients(List<MajorClient> majorClients) {
        this.majorClients = majorClients;
    }

    public void setImporters(List<Importer> importers) {
        this.importers = importers;
    }

    public void setExporters(List<Exporter> exporters) {
        this.exporters = exporters;
    }

    public List<Importer> getImporters() {
        return this.importers;
    }

    public List<Exporter> getExporters() {
        return this.exporters;
    }

    public List<Commodity> getCommodities() {
        return this.commodities;
    }

    public void setCommodities(List<Commodity> commodities) {
        this.commodities = commodities;
    }

    public String getAabAssignedBankRefNo() {
        return this.aabAssignedBankRefNo;
    }

    public void setAabAssignedBankRefNo(String aabAssignedBankRefNo) {
        this.aabAssignedBankRefNo = aabAssignedBankRefNo;
    }

    public String getRelatedCompanyName1() {
        return this.relatedCompanyName1;
    }

    public void setRelatedCompanyName1(String relatedCompanyName1) {
        this.relatedCompanyName1 = relatedCompanyName1;
    }

    public String getRelatedCompanyName2() {
        return this.relatedCompanyName2;
    }

    public void setRelatedCompanyName2(String relatedCompanyName2) {
        this.relatedCompanyName2 = relatedCompanyName2;
    }

    public String getRelatedCompanyName3() {
        return this.relatedCompanyName3;
    }

    public void setRelatedCompanyName3(String relatedCompanyName3) {
        this.relatedCompanyName3 = relatedCompanyName3;
    }

    public String getVaspPrimaryCcn() {
        return this.vaspPrimaryCcn;
    }

    public void setVaspPrimaryCcn(String vaspPrimaryCcn) {
        this.vaspPrimaryCcn = vaspPrimaryCcn;
    }

    public String getVaspSecondaryCcn() {
        return this.vaspSecondaryCcn;
    }

    public void setVaspSecondaryCcn(String vaspSecondaryCcn) {
        this.vaspSecondaryCcn = vaspSecondaryCcn;
    }

    public String getJo291() {
        return this.jo291;
    }

    public void setJo291(String jo291) {
        this.jo291 = jo291;
    }

    public String getCertificateOfAuthority() {
        return this.certificateOfAuthority;
    }

    public void setCertificateOfAuthority(String certificateOfAuthority) {
        this.certificateOfAuthority = certificateOfAuthority;
    }

    public String getUnderWritingCapacity() {
        return this.underWritingCapacity;
    }

    public void setUnderWritingCapacity(String underWritingCapacity) {
        this.underWritingCapacity = underWritingCapacity;
    }

    public String getCustomBondedWarehouse() {
        return this.customBondedWarehouse;
    }

    public void setCustomBondedWarehouse(String customBondedWarehouse) {
        this.customBondedWarehouse = customBondedWarehouse;
    }

    public String getCustomBondedWarehouseType() {
        return this.customBondedWarehouseType;
    }

    public void setCustomBondedWarehouseType(String customBondedWarehouseType) {
        this.customBondedWarehouseType = customBondedWarehouseType;
    }

    public String getCompany() {
        return this.company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getClientType() {
        return this.clientType;
    }

    public void setClientType(String clientType) {
        this.clientType = clientType;
    }

//    @Temporal(TemporalType.DATE)
    public Date getPeriodOfEffectivity() {
        return this.periodOfEffectivity;
    }

//    @Temporal(TemporalType.DATE)
    public void setPeriodOfEffectivity(Date periodOfEffectivity) {
        this.periodOfEffectivity = periodOfEffectivity;
    }

//    @Temporal(TemporalType.DATE)
    public Date getDateCreated() {
        return this.dateCreated;
    }

//    @Temporal(TemporalType.DATE)
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

//    @Temporal(TemporalType.DATE)
    public Date getLastDateOfTransaction() {
        return this.lastDateOfTransaction;
    }

//    @Temporal(TemporalType.DATE)
    public void setLastDateOfTransaction(Date lastDateOfTransaction) {
        this.lastDateOfTransaction = lastDateOfTransaction;
    }

    public String getPriBrokerTaxpayerIdNo() {
        return this.priBrokerTaxpayerIdNo;
    }

    public void setPriBrokerTaxpayerIdNo(String priBrokerTaxpayerIdNo) {
        this.priBrokerTaxpayerIdNo = priBrokerTaxpayerIdNo;
    }

    public String getPriBrokerCCN() {
        return this.priBrokerCCN;
    }

    public void setPriBrokerCCN(String priBrokerCCN) {
        this.priBrokerCCN = priBrokerCCN;
    }

    public String getSecBrokerTaxpayerIdNo() {
        return this.secBrokerTaxpayerIdNo;
    }

    public void setSecBrokerTaxpayerIdNo(String secBrokerTaxpayerIdNo) {
        this.secBrokerTaxpayerIdNo = secBrokerTaxpayerIdNo;
    }

    public String getSecBrokerCCN() {
        return this.secBrokerCCN;
    }

    public void setSecBrokerCCN(String secBrokerCCN) {
        this.secBrokerCCN = secBrokerCCN;
    }

    public byte[] getImportedCommodities() {
        if (this.importedCommodities != null && this.importedCommodities.length == 0)
            return null;
        return this.importedCommodities;
    }

    public void setImportedCommodities(byte[] importedCommodities) {
        this.importedCommodities = importedCommodities;
    }

    public byte[] getPicture() {
        if (this.picture != null && this.picture.length == 0)
            return null;
        return this.picture;
    }

    public void setPictureAsInputStream(InputStream pictureAsInputStream) {
        this.pictureAsInputStream = pictureAsInputStream;
    }

    public InputStream getPictureAsInputStream() {
        if (this.picture != null) {
            this.pictureAsInputStream = new ByteArrayInputStream(this.picture);
            return this.pictureAsInputStream;
        }
        return null;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    public byte[] getSignature() {
        if (this.signature != null && this.signature.length == 0)
            return null;
        return this.signature;
    }

    public void setSignature(byte[] signature) {
        this.signature = signature;
    }

    public String getInsClientNo() {
        return this.insClientNo;
    }

    public void setInsClientNo(String insClientNo) {
        this.insClientNo = insClientNo;
    }

    public Status getStatus() {
        return this.status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getErrorMessage() {
        return this.errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public int hashCode() {
        int prime = 31;
        int result = 1;
        result = 31 * result + ((this.id == null) ? 0 : this.id.hashCode());
        return result;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        } else if (obj == null) {
            return false;
        } else if (this.getClass() != obj.getClass()) {
            return false;
        } else {
            Profile other = (Profile)obj;
            if (this.id == null) {
                if (other.id != null) {
                    return false;
                }
            } else if (!this.id.equals(other.id)) {
                return false;
            }

            return true;
        }
    }

    public List<ProfileHistory> getProfileHistoryList() {
        return this.profileHistoryList;
    }

    public void setProfileHistoryList(List<ProfileHistory> profileHistoryList) {
        this.profileHistoryList = profileHistoryList;
    }

    public boolean isStored() {
        return this.stored;
    }

    public void setStored(boolean stored) {
        this.stored = stored;
    }

    public void setImporterTin(String importer_tin) {
        this.importerTin = importer_tin;
    }

    public String getImporterTin() {
        return this.importerTin;
    }

    public void setExporterTin(String exporter_tin) {
        this.exporterTin = exporter_tin;
    }

    public String getExporterTin() {
        return this.exporterTin;
    }
}
