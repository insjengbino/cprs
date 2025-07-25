package com.ins.registration.action;

import com.ins.registration.misc.Utils;
import com.ins.registration.model.Profile;
import com.ins.registration.service.ProfileService;
import com.ins.registration.web.BaseController;
import com.opensymphony.xwork2.Preparable;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class ProfileAction extends BaseController implements Preparable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private ProfileService profileService;
    private Profile profile = new Profile();
    private List<Profile> profiles;
    private final Log log = LogFactory.getLog(this.getClass());
    private static final String DATA_KEY = "_data";
    @Temporal(TemporalType.DATE)
    private Date dateCreated = new Date();

    public List<Profile> getProfiles() {
        return this.profiles;
    }

    public void prepare() throws Exception {
        this.log.info("Preparing with id=" + this.id);
        if (this.id != null) {
            this.profile = this.profileService.findByID(this.id);
        } else {
            this.profile = new Profile();
        }

        if (this.getActionName().equals("reviewData")) {
            Map data = (Map)this.getFromSession("_data");
            this.profile = new Profile();
            this.profile.setClientType((String)data.get("clientType"));
            this.profile.setClientCcn((String)data.get("clientCcn"));
            this.profile.setCompany((String)data.get("company"));
            this.profile.setFirstName((String)data.get("firstName"));
            this.profile.setMiddleName((String)data.get("middleName"));
            this.profile.setLastName((String)data.get("lastName"));
            this.profile.setCitizenship((String)data.get("citizenship"));
            this.profile.setAddress((String)data.get("address"));
            this.profile.setCity((String)data.get("city"));
            this.profile.setZipCode((String)data.get("zipCode"));
            this.profile.setCountry((String)data.get("country"));
            this.profile.setTelephone((String)data.get("telephone"));
            this.profile.setAltTelephone((String)data.get("altTelephone"));
            this.profile.setFax((String)data.get("fax"));
            this.profile.setMobile((String)data.get("mobile"));
            this.profile.setEmail((String)data.get("email"));
            this.profile.setWebsite((String)data.get("website"));
            this.profile.setNatureOfBusiness((String)data.get("natureOfBusiness"));
            this.profile.setBusinessType((String)data.get("profile.businessType"));
            this.profile.setCustomBondedWarehouse((String)data.get("customBondedWarehouse"));
            this.profile.setJo291((String)data.get("jo291"));
            this.profile.setPeriodOfEffectivity((Date)data.get("periodOfEffectivity"));
            this.profile.setUnderWritingCapacity((String)data.get("underWritingCapacity"));
            this.profile.setTinNo((String)data.get("tinNo"));
            this.profile.setSssIdNo((String)data.get("sssIdNo"));
            this.profile.setPassportIdNo((String)data.get("passportIdNo"));
            this.profile.setDriverLicenseIdNo((String)data.get("driverLicenseIdNo"));
            this.profile.setPrcIdNo((String)data.get("prcIdNo"));
            this.profile.setVaspPrimaryCcn((String)data.get("vaspPrimaryCcn"));
            this.profile.setVaspSecondaryCcn((String)data.get("vaspSecondaryCcn"));
            this.profile.setPezaIdNo((String)data.get("pezaIdNo"));
            this.profile.setSecIdNo((String)data.get("secIdNo"));
            this.profile.setCapitalStockAmount(Utils.formatTwoDecimal((String)data.get("capitalStockAmount")));
            this.profile.setPaidUpCapitalAmount(Utils.formatTwoDecimal((String)data.get("paidUpCapitalAmount")));
            this.profile.setAabAssignedBankRefNo((String)data.get("aabAssignedBankRefNo"));
            this.profile.setRelatedCompanyName1((String)data.get("relatedCompanyName1"));
            this.profile.setRelatedCompanyName2((String)data.get("relatedCompanyName2"));
            this.profile.setRelatedCompanyName3((String)data.get("relatedCompanyName3"));
            data = (Map)this.getFromSession("_data");
        }

    }

    public String execute() {
        this.profiles = this.profileService.listLastN(5);
        return "success";
    }

    public String profileForm() {
        this.log.warn(this.profile.getClientType());
        return "success";
    }

    public String clientTypeForm() {
        return "success";
    }

    public String saveProfile() {
        this.profileService.save(this.profile);
        return "success";
    }

    public String deleteProfile() {
        this.profileService.delete(this.profile);
        return "success";
    }

    @Autowired
    public void setProfileService(ProfileService profileService) {
        this.profileService = profileService;
    }

    public Profile getProfile() {
        return this.profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateCreated() {
        return this.dateCreated;
    }

    public void setProfiles(List<Profile> profiles) {
        this.profiles = profiles;
    }
}
