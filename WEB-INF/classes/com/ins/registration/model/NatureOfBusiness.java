//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

@Entity
@NamedQueries({@NamedQuery(
        name = "listAllNatureOfBusiness",
        query = "select n from NatureOfBusiness n order by n.name"
)})
public class NatureOfBusiness implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    private String code;
    private String name;

    public String toString() {
        return this.getName();
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int hashCode() {
        int prime = 31;
        int result = 1;
        result = 31 * result + (this.code == null ? 0 : this.code.hashCode());
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
            NatureOfBusiness other = (NatureOfBusiness)obj;
            if (this.code == null) {
                if (other.code != null) {
                    return false;
                }
            } else if (!this.code.equals(other.code)) {
                return false;
            }

            return true;
        }
    }
}
