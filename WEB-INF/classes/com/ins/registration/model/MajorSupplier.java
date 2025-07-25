//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

@Entity
@NamedQueries({@NamedQuery(
        name = "listMajorSuppliers",
        query = "select s from MajorSupplier s order by s.id asc"
), @NamedQuery(
        name = "listMajorSuppliersByProfileId",
        query = "select s from MajorSupplier s where s.profile.id=:profileId order by s.id asc"
)})
public class MajorSupplier implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue
    private Long id;
    private String company;
    private String tinNo;
    private String address;
    private String city;
    private String zipCode;
    private String country;
    private String telephone;
    private String altTelephone;
    private String fax;
    private String mobile;
    private String email;
    @ManyToOne
    private Profile profile;

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Profile getProfile() {
        return this.profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public String getCompany() {
        return this.company;
    }

    public void setCompany(String majorSupplierCompany) {
        this.company = majorSupplierCompany;
    }

    public String getTinNo() {
        return this.tinNo;
    }

    public void setTinNo(String majorSupplierTinNo) {
        this.tinNo = majorSupplierTinNo;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String majorSupplierAddress) {
        this.address = majorSupplierAddress;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String majorSupplierCity) {
        this.city = majorSupplierCity;
    }

    public String getZipCode() {
        return this.zipCode;
    }

    public void setZipCode(String majorSupplierZipCode) {
        this.zipCode = majorSupplierZipCode;
    }

    public String getCountry() {
        return this.country;
    }

    public void setCountry(String majorSupplierCountry) {
        this.country = majorSupplierCountry;
    }

    public String getTelephone() {
        return this.telephone;
    }

    public void setTelephone(String majorSupplierTelephone) {
        this.telephone = majorSupplierTelephone;
    }

    public String getAltTelephone() {
        return this.altTelephone;
    }

    public void setAltTelephone(String majorSupplierAltTelephone) {
        this.altTelephone = majorSupplierAltTelephone;
    }

    public String getFax() {
        return this.fax;
    }

    public void setFax(String majorSupplierFax) {
        this.fax = majorSupplierFax;
    }

    public String getMobile() {
        return this.mobile;
    }

    public void setMobile(String majorSupplierMobile) {
        this.mobile = majorSupplierMobile;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String majorSupplierEmail) {
        this.email = majorSupplierEmail;
    }

    public int hashCode() {
        int prime = 31;
        int result = 1;
        result = 31 * result + (this.id == null ? 0 : this.id.hashCode());
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
            MajorSupplier other = (MajorSupplier)obj;
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
}
