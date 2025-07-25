
package com.ins.registration.model;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Transient;

@Entity
@NamedQueries({@NamedQuery(
        name = "listMajorStockholders",
        query = "select h from MajorStockholder h order by h.id asc"
), @NamedQuery(
        name = "listMajorStockholdersByProfileId",
        query = "select h from MajorStockholder h where h.profile.id = :profileId order by h.id asc"
)})
public class MajorStockholder implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue
    private Long id;
    private String firstName;
    private String middleName;
    private String lastName;
    private String citizenship;
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
    @Lob
    private byte[] picture;
    @Transient
    private InputStream stockholderPictureAsInputStream;
    @Lob
    private byte[] signature;
    @Transient
    private InputStream stockholderSignatureAsInputStream;
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

    public String getTinNo() {
        return this.tinNo;
    }

    public void setTinNo(String tinNo) {
        this.tinNo = tinNo;
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
        return this.telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAltTelephone() {
        return this.altTelephone;
    }

    public void setAltTelephone(String altTelephone) {
        this.altTelephone = altTelephone;
    }

    public String getFax() {
        return this.fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getMobile() {
        return this.mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public byte[] getPicture() {
        return this.picture != null && this.picture.length == 0 ? null : this.picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    public byte[] getSignature() {
        return this.signature != null && this.signature.length == 0 ? null : this.signature;
    }

    public void setSignature(byte[] signature) {
        this.signature = signature;
    }

    public void setStockholderPictureAsInputStream(InputStream stockholderPictureAsInputStream) {
        this.stockholderPictureAsInputStream = stockholderPictureAsInputStream;
    }

    public InputStream getStockholderPictureAsInputStream() {
        if (this.picture != null) {
            this.stockholderPictureAsInputStream = new ByteArrayInputStream(this.picture);
            return this.stockholderPictureAsInputStream;
        } else {
            return null;
        }
    }

    public void setStockholderSignatureAsInputStream(InputStream stockholderSignatureAsInputStream) {
        this.stockholderSignatureAsInputStream = stockholderSignatureAsInputStream;
    }

    public InputStream getStockholderSignatureAsInputStream() {
        if (this.signature != null) {
            this.stockholderSignatureAsInputStream = new ByteArrayInputStream(this.signature);
            return this.stockholderSignatureAsInputStream;
        } else {
            return null;
        }
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
            MajorStockholder other = (MajorStockholder)obj;
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
