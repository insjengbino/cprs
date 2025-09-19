//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.web;

import com.ins.message.service.MessageGenerator;
import com.ins.registration.misc.Utils;
import com.ins.registration.model.BusinessType;
import com.ins.registration.model.ClientType;
import com.ins.registration.model.Commodity;
import com.ins.registration.model.Country;
import com.ins.registration.model.CustomBondedWarehouse;
import com.ins.registration.model.CustomBondedWarehouseType;
import com.ins.registration.model.EquivRespOfficer;
import com.ins.registration.model.MajorStockholder;
import com.ins.registration.model.NatureOfBusiness;
import com.ins.registration.model.PrincipalOfficer;
import com.ins.registration.model.Profile;
import com.ins.registration.model.ProfileHistory;
import com.ins.registration.model.Status;
import com.ins.registration.service.BusinessTypeService;
import com.ins.registration.service.ClientTypeService;
import com.ins.registration.service.CountryService;
import com.ins.registration.service.CustomBondedWarehouseService;
import com.ins.registration.service.CustomBondedWarehouseTypeService;
import com.ins.registration.service.IdGeneratorService;
import com.ins.registration.service.NatureOfBusinessService;
import com.ins.registration.service.ProfileHistoryService;
import com.ins.registration.service.ProfileService;
import com.ins.registration.service.StatusService;
import com.ins.registration.util.StringUtils;
import com.opensymphony.xwork2.Preparable;
import com.opensymphony.xwork2.Validateable;
import com.thoughtworks.xstream.XStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class ProfilesController extends BaseController implements Preparable, Validateable, ByteSource {
    private static final String CSV_FILENAME = "temp.csv";
    private static final long serialVersionUID = 1L;
    private byte[] filedata;
    private String contentType;
    private String clientType;
    private String businessType;
    private String natureOfBusiness;
    private String natureOfBusinessName;
    private Date periodOfEffectivity;
    private static Long profileId;
    private static final String DATA_KEY = "_data";
    private static final String CLIENT_TYPE_KEY = "_client_type";
    private static final String CLIENT_CODE_PARAM = "clientCode";
    private static final String BUSINESS_TYPE_KEY = "business_type";
    private static final String NATURE_OF_BUSINESS_KEY = "nature_of_business";
    private Profile profile = new Profile();
    private List<Profile> profiles = new ArrayList();
    private List<Long> selected = new ArrayList();
    private final Log log = LogFactory.getLog(this.getClass());
    @Autowired
    private IdGeneratorService idGeneratorService;
    @Autowired
    private StatusService statusService;
    @Autowired
    private ClientTypeService clientTypeService;
    @Autowired
    private ProfileService profileService;
    @Autowired
    private CountryService countryService;
    @Autowired
    private CustomBondedWarehouseService customBondedWarehouseService;
    @Autowired
    private CustomBondedWarehouseTypeService customBondedWarehouseTypeService;
    @Autowired
    private NatureOfBusinessService natureOfBusinessService;
    @Autowired
    private BusinessTypeService businessTypeService;
    @Autowired
    private ProfileHistoryService profileHistoryService;
    private File profilePictureFile;
    private File profileSignatureFile;
    private File profileImportedCommoditiesFile;
    private byte[] buffer;
    @Autowired
    private MessageGenerator generator;
    List<Profile> profileList = new ArrayList();

    private String clientCode;

    private String role;

    private String saveActionName;

    public byte[] getBytes() {
        return this.buffer;
    }

    public int getLength() {
        return this.buffer == null ? 0 : this.buffer.length;
    }

    public String toString() {
        return this.clientType;
    }

    public void prepare() throws Exception {
        this.log.info("Preparing with id=" + this.id);
        this.log.debug("Preparing " + this.getActionName());
        if (this.getId() != null) {
            this.profile = this.profileService.findByID(this.getId());
            this.clientType = this.profile.getClientType();
            this.businessType = this.profile.getBusinessType();
            this.natureOfBusiness = this.profile.getNatureOfBusiness();
            this.setPeriodOfEffectivity(this.profile.getPeriodOfEffectivity());
        } else {
            String temp = this.getActionName();
            if (!this.getActionName().startsWith("save")) {
                this.profile = new Profile();
                this.profile.setDateCreated(new Date());
                this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
                Country tcountry = this.countryService.findByCode("PH");
                if (tcountry == null) {
                    this.log.error("null country");
                }

                String country = this.countryService.findByCode("PH").getCode();
                this.profile.setCountry(country);
                this.profile.setCitizenship(country);
            }
        }

    }

    public void validate() {
        super.validate();

        //added on phase 3 of cprs enhancement
        prepSaveActionName();

        if (this.getActionName().startsWith("save") && !this.hasErrors()) {
            if (this.profile.getPicture() == null && this.profilePictureFile == null) {
                this.addFieldError("profilePictureFile", "Please attach Scanned Photo");
            }

            if (this.natureOfBusiness.equals("GO004") && this.profile.getUnderWritingCapacity().equals("")) {
                this.addFieldError("profile.underWritingCapacity", "You can not leave this field empty.");
            }

            if (this.hasDuplicateTINV2()) {
                this.addFieldError("profile.tinNo", "Duplicate TIN");
            }

            if (this.natureOfBusiness.equals("GO004")) {
                if (this.periodOfEffectivity == null) {
                    this.addFieldError("periodOfEffectivity", "You can not leave this field empty.");
                } else if (!Utils.isValid(this.periodOfEffectivity, new Date())) {
                    this.addFieldError("periodOfEffectivity", "The period of effectivity is valid only for 1 year.");
                }
            }

            if (this.profile.getPaidUpCapitalAmount() != null && this.profile.getCapitalStockAmount() != null && Double.parseDouble(this.profile.getPaidUpCapitalAmount()) > Double.parseDouble(this.profile.getCapitalStockAmount())) {
                this.addFieldError("profile.paidUpCapitalAmount", "Amount must be less than or equal to the Amount of Authorized Capital Stock.");
            }
        }

    }

    public String execute() {
        this.log.debug("Executing " + this.getActionName());
        if (this.getFromSession("_data") == null) {
            this.setInSession("_data", new HashMap());
        }

        return "success";
    }

    public String getBusinessType() {
        return this.businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType;
        this.setInSession("business_type", businessType);
    }

    public String getNatureOfBusiness() {
        return this.natureOfBusiness;
    }

    public void setNatureOfBusiness(String natureOfBusiness) {
        this.natureOfBusiness = natureOfBusiness;
        this.setInSession("nature_of_business", natureOfBusiness);
    }

    public String getClientType() {
        return this.clientType;
    }

    public void setClientType(String clientType) {
        this.clientType = clientType;
        this.setInSession("_client_type", clientType);
    }

    public List<BusinessType> getBusinessTypeList() {
        List<BusinessType> businessTypeList;
        if ("BR".equals(this.clientType)) {
            businessTypeList = new ArrayList();
            BusinessType businessType = new BusinessType();
            businessType.setCode("IND");
            businessType.setName("Individual");
            businessTypeList.add(businessType);
            businessType = new BusinessType();
            businessType.setCode("PART");
            businessType.setName("Partnership");
            businessTypeList.add(businessType);
            businessType = new BusinessType();
            businessType.setCode("SPROP");
            businessType.setName("Sole Proprietorship");
            businessTypeList.add(businessType);
        } else {
            businessTypeList = this.businessTypeService.listAllBusinessType();
        }

        //set default selected option for dropdown in profileForm
        if(StringUtils.isEmpty(this.getBusinessType())) this.setBusinessType("SPROP");

        return businessTypeList;
    }

    public List<NatureOfBusiness> getNaturesOfBusiness() {
        List<NatureOfBusiness> businessNatureList = this.natureOfBusinessService.listAllNatureOfBusiness();
        this.log.debug(this.clientType);
        if (!"IM".equals(this.clientType)) {
            for(NatureOfBusiness business : businessNatureList) {
                if (business.getCode().equals("GO004")) {
                    businessNatureList.remove(business);
                    break;
                }
            }
        }

        return businessNatureList;
    }

    public List<ClientType> getClientTypes() {
        List<Profile> profiles = this.profileService.listByClientCode((String)this.getFromSession("clientCode"));
        List<ClientType> types = this.clientTypeService.listAllClientType();

        for(Profile profile : profiles) {
            String clientType = profile.getClientType();
            ClientType temp = this.clientTypeService.findByCode(clientType);
            types.remove(temp);
        }

        return types;
    }

    public boolean hasDuplicateTIN() {
        List<Profile> tinList = this.profileService.searchTIN(this.profile.getTinNo());
        List<Profile> sameTinAndId = this.profileService.searchTinAndId(this.profile.getTinNo(), this.profile.getId());
        if (sameTinAndId.size() > 0) {
            tinList.remove(sameTinAndId.get(0));
        }

        return tinList.size() > 0;
    }

    public boolean hasDuplicateTINV2() {
        return !this.profileService.checkDuplicateByTinINSClientNo(
                this.profile.getTinNo(),
                this.profile.getInsClientNo()).isEmpty() ;
    }

    public List<Profile> getProfiles() {
        return this.profiles;
    }

    public String listProfile() {
        this.profiles = this.profileService.listLastN(10);
        return "success";
    }

    public String printProfile() {
        Profile tempProfile = this.profileService.findByID(this.getId());
        if (this.isComplete(tempProfile)) {
            if (tempProfile.getPicture() != null && tempProfile.getPicture().length > 5000) {
                this.addActionError("Profile picture file size exceeds 5000 bytes.");
                return "error";
            } else if (tempProfile.getSignature() != null && tempProfile.getSignature().length > 5000) {
                this.addActionError("Profile signature file size exceeds 5000 bytes.");
                return "error";
            } else if (tempProfile.getImportedCommodities() != null && tempProfile.getImportedCommodities().length > 5000) {
                this.addActionError("Profile imported commodities file size exceeds 5000 bytes.");
                return "error";
            } else {
                if (tempProfile.getEquivRespOfficers() != null) {
                    for(EquivRespOfficer officer : tempProfile.getEquivRespOfficers()) {
                        if (officer.getPicture().length > 5000) {
                            this.addActionError("Equivalent responsible officer picture file size exceeds 5000 bytes.");
                            return "error";
                        }

                        if (officer.getSignature().length > 5000) {
                            this.addActionError("Equivalent responsible officer signature file size exceeds 5000 bytes.");
                            return "error";
                        }
                    }
                }

                if (tempProfile.getMajorStockholders() != null) {
                    for(MajorStockholder stockholder : tempProfile.getMajorStockholders()) {
                        if (stockholder.getPicture().length > 5000) {
                            this.addActionError("Stockholder picture file size exceeds 5000 bytes.");
                            return "error";
                        }

                        if (stockholder.getSignature().length > 5000) {
                            this.addActionError("Stockholder signature file size exceeds 5000 bytes.");
                            return "error";
                        }
                    }
                }

                if (tempProfile.getPrincipalOfficers() != null) {
                    for(PrincipalOfficer officer : tempProfile.getPrincipalOfficers()) {
                        if (officer.getPicture().length > 5000) {
                            this.addActionError("Principal officer picture file size exceeds 5000 bytes.");
                            return "error";
                        }

                        if (officer.getSignature().length > 5000) {
                            this.addActionError("Principal officer signature file size exceeds 5000 bytes.");
                            return "error";
                        }
                    }
                }

                this.profileList.add(tempProfile);
                if (tempProfile.getEquivRespOfficers() != null && tempProfile.getEquivRespOfficers().size() > 5) {
                    this.log.debug(tempProfile.getEquivRespOfficers().size());
                    this.log.debug(tempProfile.getEquivRespOfficers().subList(0, 5).size());
                    tempProfile.setEquivRespOfficers(tempProfile.getEquivRespOfficers().subList(0, 5));
                }

                if (tempProfile.getImporters() != null && tempProfile.getImporters().size() > 5) {
                    this.log.debug(tempProfile.getImporters().size());
                    this.log.debug(tempProfile.getImporters().subList(0, 5).size());
                    tempProfile.setImporters(tempProfile.getImporters().subList(0, 5));
                }

                if (tempProfile.getMajorClients() != null && tempProfile.getMajorClients().size() > 5) {
                    this.log.debug(tempProfile.getMajorClients().size());
                    this.log.debug(tempProfile.getMajorClients().subList(0, 5).size());
                    tempProfile.setMajorClients(tempProfile.getMajorClients().subList(0, 5));
                }

                if (tempProfile.getMajorStockholders() != null && tempProfile.getMajorStockholders().size() > 5) {
                    this.log.debug(tempProfile.getMajorStockholders().size());
                    this.log.debug(tempProfile.getMajorStockholders().subList(0, 5).size());
                    tempProfile.setMajorStockholders(tempProfile.getMajorStockholders().subList(0, 5));
                }

                if (tempProfile.getMajorSuppliers() != null && tempProfile.getMajorSuppliers().size() > 5) {
                    this.log.debug(tempProfile.getMajorSuppliers().size());
                    this.log.debug(tempProfile.getMajorSuppliers().subList(0, 5).size());
                    tempProfile.setMajorSuppliers(tempProfile.getMajorSuppliers().subList(0, 5));
                }

                if (tempProfile.getPrincipalOfficers() != null && tempProfile.getPrincipalOfficers().size() > 5) {
                    this.log.debug(tempProfile.getPrincipalOfficers().size());
                    this.log.debug(tempProfile.getPrincipalOfficers().subList(0, 5).size());
                    tempProfile.setPrincipalOfficers(tempProfile.getPrincipalOfficers().subList(0, 5));
                }

                if (tempProfile.getImportedCommodities() != null && tempProfile.getImportedCommodities().length > 0) {
                    File f = new File("temp.csv");
                    this.writeFully(f, tempProfile.getImportedCommodities());

                    try {
                        BufferedReader bufferedReader = new BufferedReader(new FileReader("temp.csv"));

                        String s;
                        while((s = bufferedReader.readLine()) != null) {
                            String[] tokens = s.split("[,]", -1);
                            Commodity commodity = new Commodity();
                            commodity.setHsCode(tokens[0]);
                            commodity.setItemCode(tokens[1]);
                            commodity.setItemDescription(tokens[2]);
                            tempProfile.getCommodities().add(commodity);
                        }
                    } catch (FileNotFoundException e) {
                        this.log.debug(e);
                    } catch (IOException e) {
                        this.log.debug(e);
                    }
                }

                return this.profile.getClientType();
            }
        } else {
            this.addActionError("Profile details must first be completed before PRINTING.");
            return "error";
        }
    }

    public boolean insClientCodeNotInSession() {
        return this.getFromSession("clientCode") == null;
    }

    public String profileForm() {
        this.log.warn(this.profile.getClientType());
        this.log.warn(this.profile.getBusinessType());
        this.setInSession("nature_of_business", this.natureOfBusiness);
        this.setInSession("business_type", this.businessType);
        this.setInSession("_client_type", this.clientType);
        this.log.warn(this.clientType);
        this.log.warn(this.businessType);
        this.log.warn(this.natureOfBusiness);
        return "success";
    }

    public String clientTypeForm() {
        return "success";
    }

    public String businessForm() {
        return "success";
    }

    public String homepage() {
        return "success";
    }

    public String logout() {
        this.setInSession("clientCode", (Object)null);
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Cookie[] cookies = request.getCookies();

        for(int i = 0; i < cookies.length; ++i) {
            Cookie cookie = cookies[i];
            if ("JSESSIONID".equals(cookie.getName()) || "ASPSESSIONID".equals(cookie.getName())) {
                Cookie deleteCookie = new Cookie(cookie.getName(), "");
                deleteCookie.setMaxAge(0);
                deleteCookie.setPath("/");
                response.addCookie(deleteCookie);
            }
        }

        return "success";
    }

    public void setProfiles(List<Profile> profiles) {
        this.profiles = profiles;
    }

    @Autowired
    public void setProfileService(ProfileService profileService) {
        this.profileService = profileService;
    }

    public ProfileService getProfileService() {
        return this.profileService;
    }

    public Profile getProfile() {
        return this.profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public static String getDATA_KEY() {
        return "_data";
    }

    public static String getCLIENT_TYPE_KEY() {
        return "_client_type";
    }

    public static String getBUSINESS_TYPE_KEY() {
        return "business_type";
    }

    public static String getNATURE_OF_BUSINESS_KEY() {
        return "nature_of_business";
    }

    private void writeFully(File file, byte[] content) {
        try {
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(content);
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    /**
     * Sept-11-2025
     * cprs enhancement v3
     * Removed the use for profileForm.ftl as it has different logic for saving each profile.
     * profileFormV2.ftl's save function is now dynamic
     * All save function of profileFormV2.ftl should be mapped here
     **/
    private void prepSaveActionName(){
        String clientType = this.getClientType();
        String businessType = this.getBusinessType();
        this.setSaveActionName("");

        if(StringUtils.isEmpty(clientType) || StringUtils.isEmpty(businessType)){
            return;
        }

        final HashMap<String, List<String>> clientTypeMap = new HashMap<String, List<String>>();
        ///             clientType            [0]: actionName1    [1]actionName2
        ///
        clientTypeMap.put("AW", Arrays.asList("saveAirport1", "saveAirport2"));
        clientTypeMap.put("BR", Arrays.asList("saveBroker1", "saveBroker2"));
        clientTypeMap.put("CY", Arrays.asList("saveCYCFS1", "saveCYCFS2"));
        clientTypeMap.put("IM", Arrays.asList("saveProfileImporter1", "saveProfileImporter2"));
        clientTypeMap.put("EX", Arrays.asList("saveProfileExporter1", "saveProfileExporter2"));
        clientTypeMap.put("SU", Arrays.asList("saveSurety1", "saveSurety2"));
        clientTypeMap.put("WO", Arrays.asList("saveWarehouse1", "saveWarehouse2"));
        clientTypeMap.put("YI", Arrays.asList("YI1save", "YI2save"));
        clientTypeMap.put("AR", Arrays.asList("saveArrastreOperator1", "saveArrastreOperator2"));

        List<String> actions = clientTypeMap.get(clientType);
        if(actions != null){
            //individual || sole proprietor
            if("IND".equals(businessType) || "SPROP".equals(businessType)){
                this.setSaveActionName(actions.get(0)); //actionName1
            }
            //company || corporation || partnership
            else{
                this.setSaveActionName(actions.get(1)); //actionName2
            }
        }
        log.info("CHECK ==== client type: " + clientType
                + " &&  business  type: " + businessType);
        log.info("ACTION NAME: " + this.getSaveActionName());
    }

    public String saveImporter() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }

        this.profile.setLastDateOfTransaction(new Date());
        this.profile.setPeriodOfEffectivity(this.periodOfEffectivity);
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String saveExporter() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }

        this.profile.setLastDateOfTransaction(new Date());
        this.profile.setPeriodOfEffectivity(this.periodOfEffectivity);
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String saveBroker() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }
        log.info("clientCode in session::::: " + this.getFromSession("clientCode"));
        log.info(insClientCodeNotInSession());
        this.profile.setLastDateOfTransaction(new Date());
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String saveWarehouse() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }

        this.profile.setLastDateOfTransaction(new Date());
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String saveSurety() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }

        this.profile.setLastDateOfTransaction(new Date());
        this.profile.setPeriodOfEffectivity(this.periodOfEffectivity);
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String saveAirport() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }

        this.profile.setLastDateOfTransaction(new Date());
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String saveCYCFS() {
        if (this.profile.getImportedCommodities() == null) {
            this.profile.setImportedCommodities(new byte[0]);
        }

        if (this.profileImportedCommoditiesFile != null) {
            this.profile.setImportedCommodities(this.readFully(this.profileImportedCommoditiesFile));
        }

        if (this.profile.getPicture() == null) {
            this.profile.setPicture(new byte[0]);
        }

        if (this.profilePictureFile != null) {
            this.profile.setPicture(this.readFully(this.profilePictureFile));
        }

        if (this.profile.getSignature() == null) {
            this.profile.setSignature(new byte[0]);
        }

        if (this.profileSignatureFile != null) {
            this.profile.setSignature(this.readFully(this.profileSignatureFile));
        }

        this.profile.setClientType((String)this.getFromSession("_client_type"));
        this.profile.setBusinessType((String)this.getFromSession("business_type"));
        this.profile.setInsClientNo((String)this.getFromSession("clientCode"));
        this.profile.setNatureOfBusiness((String)this.getFromSession("nature_of_business"));
        if (this.profile.getStatus() == null) {
            Status status = this.statusService.findByName("Incomplete");
            this.profile.setStatus(status);
        }

        this.profile.setLastDateOfTransaction(new Date());
        if (this.insClientCodeNotInSession()) {
            return "error";
        } else {
            this.profileService.save(this.profile);
            return "success";
        }
    }

    public String deleteProfile() {
        for(Long checkedId : this.selected) {
            Profile profile = this.profileService.findByID(checkedId);
            this.profileService.delete(profile);
        }

        return "success";
    }

    public String editProfile() {
        return "success";
    }

    public List<Country> getCountries() {
        return this.countryService.listAllCountries();
    }

    public void setCountryService(CountryService countryService) {
        this.countryService = countryService;
    }

    public List<CustomBondedWarehouse> getCustomBondedWarehouse() {
        return this.customBondedWarehouseService.listAllCustomBondedWarehouse();
    }

    public void setCustomBondedWarehouseService(CustomBondedWarehouseService customBondedWarehouseService) {
        this.customBondedWarehouseService = customBondedWarehouseService;
    }

    public List<CustomBondedWarehouseType> getCustomBondedWarehouseType() {
        return this.customBondedWarehouseTypeService.listAllCustomBondedWarehouseType();
    }

    public void setCustomBondedWarehouseTypeService(CustomBondedWarehouseTypeService customBondedWarehouseTypeService) {
        this.customBondedWarehouseTypeService = customBondedWarehouseTypeService;
    }

    public void setNatureOfBusinessService(NatureOfBusinessService natureOfBusinessService) {
        this.natureOfBusinessService = natureOfBusinessService;
    }

    public void setBusinessTypeService(BusinessTypeService businessTypeService) {
        this.businessTypeService = businessTypeService;
    }

    public String getContentType() {
        return this.contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public byte[] getFiledata() {
        return this.filedata;
    }

    public void setFiledata(byte[] filedata) {
        this.filedata = filedata;
    }

    public File getProfilePictureFile() {
        return this.profilePictureFile;
    }

    public void setProfilePictureFile(File pictureName) {
        this.profilePictureFile = pictureName;
    }

    public File getProfileSignatureFile() {
        return this.profileSignatureFile;
    }

    public void setProfileSignatureFile(File profileSignatureFile) {
        this.profileSignatureFile = profileSignatureFile;
    }

    public File getProfileImportedCommoditiesFile() {
        return this.profileImportedCommoditiesFile;
    }

    public void setProfileImportedCommoditiesFile(File profileImportedCommoditiesFile) {
        this.profileImportedCommoditiesFile = profileImportedCommoditiesFile;
    }

    public String loadProfile() {
        String clientType = this.getParameter("clientType");
        String businessType = this.getParameter("businessType");
        String insClientCode = this.getParameter("insClientCode");
        String natureOfBusiness = this.getParameter("natureOfBusiness");
        this.profile.setInsClientNo(insClientCode);
        this.profile.setClientType(clientType);
        this.profile.setBusinessType(businessType);
        this.profile.setNatureOfBusiness(natureOfBusiness);
        return "success";
    }

    public String loadPicture() {
        this.buffer = this.profile.getPicture();
        return "success";
    }

    public String loadSignature() {
        this.buffer = this.profile.getSignature();
        return "success";
    }

    public String loadImportedCommodities() {
        this.buffer = this.profile.getImportedCommodities();
        return "success";
    }

    public String removePicture() {
        this.profile.setPicture(new byte[0]);
        this.profileService.save(this.profile);
        return "success";
    }

    public String removeSignature() {
        this.profile.setSignature(new byte[0]);
        this.profileService.save(this.profile);
        return "success";
    }

    public String removeImportedCommodities() {
        this.profile.setImportedCommodities(new byte[0]);
        this.profileService.save(this.profile);
        return "success";
    }

    public String listProfileVersion() {
        return "success";
    }

    public String loadProfileVersion() {
        return "success";
    }

    public String sendProfile() {
        this.log.info("KK==========: " + this.selected.toString());
        this.log.debug(this.profile.getId());

        for(Long checkedId : this.selected) {
            Profile profile = this.profileService.findByID(checkedId);
            if (!profile.getStatus().getName().equals("Created") && !profile.getStatus().getName().equals("Rejected") && !profile.getStatus().getName().equals("Stored") && !profile.getStatus().getName().equals("Send") && !profile.getStatus().getName().equals("Sending") && !profile.getStatus().getName().equals("Approved")) {
                this.addActionError("Profile must first be completed before sending.");
                return "error";
            }

            if (!this.isComplete()) {
                this.addActionError("Profile must first be completed before sending.");
                return "error";
            }

            Status status = null;
            if (profile.isStored()) {
                status = this.statusService.findByName("SendAmendment");
            } else {
                status = this.statusService.findByName("Send");
            }

            profile.setStatus(status);
            this.profileService.save(profile);
        }

        return "success";
    }

    public String completeProfile() {
        this.log.info("KK==========: " + this.selected.toString());
        for(Long checkedId : this.selected) {
            Profile profile = this.profileService.findByID(checkedId);
            if (!this.isComplete()) {
                this.addActionError("Profile details must first be completed before setting status to CREATE.");
                return "error";
            }

            Status status = this.statusService.findByName("Created");
            profile.setStatus(status);
            this.profileService.save(profile);
        }

        return "success";
    }

    public String renewProfile() {
        this.log.info("KK==========: " + this.selected.toString());
        for(Long checkedId : this.selected) {
            Profile profile = this.profileService.findByID(checkedId);
            if (!this.isComplete(profile)) {
                this.addActionError("Profile details must first be completed before setting status to CREATE.");
                return "error";
            }

            Status status = this.statusService.findByName("Renew");
            profile.setStatus(status);
            this.profileService.save(profile);
        }

        return "success";
    }

    public String amendProfile() {
        this.log.info("KK==========: " + this.selected.toString());
        for(Long checkedId : this.selected) {
            Profile profile = this.profileService.findByID(checkedId);
            if (!this.isComplete()) {
                this.addActionError("Profile details must first be completed before setting status to CREATE.");
                return "error";
            }

            Status status = this.statusService.findByName("SendAmendment");
            profile.setStatus(status);
            this.profileService.save(profile);
        }

        return "success";
    }

    public String snapshotProfile() {
        for(Long checkedId : this.selected) {
            Profile profile = this.profileService.findByID(checkedId);
            if (!this.isComplete(profile)) {
                this.addActionError("Profile details must first be completed before a snapshot can be taken.");
                return "error";
            }

            profile.getPrincipalOfficers().size();
            profile.getEquivRespOfficers().size();
            profile.getImporters().size();
            profile.getMajorStockholders().size();
            profile.getMajorClients().size();
            profile.getMajorSuppliers().size();
            profile.getCommodities().size();
            byte[] xml = (new XStream()).toXML(profile).getBytes();
            ProfileHistory history = new ProfileHistory();
            history.setProfile(profile);
            history.setXmlbytes(xml);
            history.setDateTaken(new Date());
            this.profileHistoryService.save(history);
        }

        return "success";
    }

    private boolean isComplete(Profile profile) {
        if (profile.getClientType().equals("AW")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                    return true;
                }
            } else if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("BR")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getMajorClients().size() > 0) {
                    return true;
                }
            } else if (profile.getMajorClients().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("CY")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                    return true;
                }
            } else if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("IM")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getMajorSuppliers().size() > 0 && profile.getImporters().size() > 0) {
                    return true;
                }
            } else if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getMajorSuppliers().size() > 0 && profile.getImporters().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("EX")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0) {
                    return true;
                }
            } else if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getMajorSuppliers().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("SU")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0) {
                    return true;
                }
            } else if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("WO")) {
            if (!profile.getBusinessType().equals("SPROP") && !profile.getBusinessType().equals("IND")) {
                if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                    return true;
                }
            } else if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                return true;
            }
        } else if (profile.getClientType().equals("YI")) {
            if (profile.getBusinessType().equals("IND")) {
                if (profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                    return true;
                }
            } else if (profile.getMajorStockholders().size() > 0 && profile.getPrincipalOfficers().size() > 0 && profile.getEquivRespOfficers().size() > 0 && profile.getImporters().size() > 0) {
                return true;
            }
        }

        return false;
    }

    private boolean isComplete() {
        Iterator var2 = this.selected.iterator();
        if (var2.hasNext()) {
            Long checkedId = (Long)var2.next();
            Profile profile = this.profileService.findByID(checkedId);
            return this.isComplete(profile);
        } else {
            return false;
        }
    }

    public String listProfiles() {
        String clientCode = this.getParameter("clientCode");
        String sessionClientCode = String.valueOf(this.getFromSession("clientCode"));
        if (StringUtils.isNotEmpty(clientCode) || StringUtils.isNotEmpty(sessionClientCode)) {
            clientCode = StringUtils.isNotEmpty(clientCode) ? clientCode : sessionClientCode;
            this.setInSession("clientCode", clientCode);
            this.profiles = this.profileService.listByClientCode(clientCode);
            return "success";
        } else {
            return "error";
        }
    }

    public String cancel() {
        if (this.profile.getId() != null && this.profile.getPicture() == null && this.profilePictureFile == null) {
            this.addFieldError("profilePictureFile", "Please attach Scanned Photo");
            return "input";
        } else {
            this.listProfiles();
            return "success";
        }
    }

    public void setStatusService(StatusService statusService) {
        this.statusService = statusService;
    }

    public void setIdGeneratorService(IdGeneratorService idGeneratorService) {
        this.idGeneratorService = idGeneratorService;
    }

    public void setClientTypeService(ClientTypeService clientTypeService) {
        this.clientTypeService = clientTypeService;
    }

    public static Long getProfileId() {
        return profileId;
    }

    public static void setProfileId(Long profileId) {
        ProfilesController.profileId = profileId;
    }

    public byte[] getBuffer() {
        return this.buffer;
    }

    public void setBuffer(byte[] buffer) {
        this.buffer = buffer;
    }

    public List<Long> getSelected() {
        return this.selected;
    }

    public void setSelected(List<Long> selected) {
        this.selected = selected;
    }

    public Date getPeriodOfEffectivity() {
        return this.periodOfEffectivity;
    }

    public void setPeriodOfEffectivity(Date periodOfEffectivity) {
        this.periodOfEffectivity = periodOfEffectivity;
    }

    public List<Profile> getProfileList() {
        return this.profileList;
    }

    public void setProfileList(List<Profile> profileList) {
        this.profileList = profileList;
    }

    public String getNatureOfBusinessName() {
        return this.natureOfBusinessName;
    }

    public void setNatureOfBusinessName(String natureOfBusinessName) {
        this.natureOfBusinessName = natureOfBusinessName;
    }

    public void setProfileHistoryService(ProfileHistoryService profileHistoryService) {
        this.profileHistoryService = profileHistoryService;
    }

    public String getSaveActionName() {
        return this.saveActionName;
    }
    public void setSaveActionName(String saveActionName) {
        this.saveActionName = saveActionName;
    }

    public void setClientCode(String clientCode){
        this.clientCode = clientCode;
    }

    public String getCLientCode(){
        return this.clientCode;
    }

    public void setRole(String role){
        this.role = role;
    }

    public String getRole(){
        return this.role;
    }
}
