package com.ins.registration.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@NamedQueries({@NamedQuery(
        name = "listAll",
        query = "select p from ProfileHistory p order by p.id asc"
), @NamedQuery(
        name = "listByProfileId",
        query = "select p from ProfileHistory p where p.profile.id = :profileId order by p.id asc"
)})
public class ProfileHistory implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "profilehistory_id_seq"
    )
    private Long id;
    @ManyToOne
    private Profile profile;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateTaken;
    @Lob
    private byte[] xmlbytes;

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

    public Date getDateTaken() {
        return this.dateTaken;
    }

    public void setDateTaken(Date dateTaken) {
        this.dateTaken = dateTaken;
    }

    public byte[] getXmlbytes() {
        return this.xmlbytes;
    }

    public void setXmlbytes(byte[] xmlbytes) {
        this.xmlbytes = xmlbytes;
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
            ProfileHistory other = (ProfileHistory)obj;
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
