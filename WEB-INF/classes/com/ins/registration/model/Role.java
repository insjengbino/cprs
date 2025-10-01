package com.ins.registration.model;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

@Entity
@NamedQueries({@NamedQuery(name = "listAllRoles", query = "select r from Role r order by r.id asc"), @NamedQuery(name = "Role.findByName", query = "SELECT r FROM Role r WHERE r.name = :name"), @NamedQuery(name = "listRolesByName", query = "select r from Role r where r.name like :name order by r.name asc")})
public class Role implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    @ManyToMany
    @JoinTable(name = "profile_role", joinColumns = {@JoinColumn(name = "role_id")}, inverseJoinColumns = {@JoinColumn(name = "profile_id")})
    private List<Profile> profiles = new ArrayList<Profile>();

    public List<Profile> getProfiles() {
        return this.profiles;
    }

    public void setProfiles(List<Profile> profiles) {
        this.profiles = profiles;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String toString() {
        return this.name;
    }

    public int hashCode() {
        int prime = 31;
        int result = 1;
        result = 31 * result + ((this.id == null) ? 0 : this.id.hashCode());
        return result;
    }

    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Role other = (Role)obj;
        if (this.id == null) {
            if (other.id != null)
                return false;
        } else if (!this.id.equals(other.id)) {
            return false;
        }
        return true;
    }
}