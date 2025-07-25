package com.ins.registration.service;

import com.ins.registration.model.Profile;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
@Service
public class ProfileServiceImpl implements ProfileService {
    @PersistenceContext
    private EntityManager em;

    public void save(Profile profile) {
        if (profile.getId() == null) {
            this.em.persist(profile);
        } else {
            this.em.merge(profile);
        }

    }

    public void setEm(EntityManager em) {
        this.em = em;
    }

    @Transactional(
            readOnly = true
    )
    public Profile findByID(Long id) {
        return (Profile)this.em.find(Profile.class, id);
    }

    public void delete(Profile profile) {
        profile = this.findByID(profile.getId());
        if (profile != null) {
            this.em.remove(profile);
        }

    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listLastN(int n) {
        Query query = this.em.createQuery("select a from Profile a order by a.id desc");
        query.setMaxResults(n);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listByClientCode(String clientCode) {
        Query query = this.em.createNamedQuery("listProfilesByClientCode");
        query.setParameter("insClientNo", clientCode);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listByClientType(String clientType) {
        Query query = this.em.createNamedQuery("listProfilesByClientType");
        query.setParameter("clientType", clientType);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listByBusinessType(String businessType) {
        Query query = this.em.createNamedQuery("listProfilesByBusinessType");
        query.setParameter("businessType", businessType);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listByNatureOfBusiness(String natureOfBusiness) {
        Query query = this.em.createNamedQuery("listProfilesByNatureOfBusiness");
        query.setParameter("natureOfBusiness", natureOfBusiness);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listByStatus(Long status) {
        Query query = this.em.createNamedQuery("listProfilesByStatus");
        query.setParameter("status", status);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> listByTinAndClientType(String tin, String clientType) {
        Query query = this.em.createNamedQuery("listProfilesByTinAndClientType");
        query.setParameter("clientType", clientType);
        query.setParameter("tinNo", tin);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> searchTIN(String tin) {
        Query query = this.em.createQuery("select t from Profile t where t.tinNo like :tinNo");
        query.setParameter("tinNo", tin);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> searchTinAndClientTypeAndNotId(String tin, String clientType, Long id) {
        Query query = this.em.createQuery("select t from Profile t where t.tinNo=:tinNo and t.clientType=:clientType and t.id<>:id");
        query.setParameter("tinNo", tin);
        query.setParameter("clientType", clientType);
        query.setParameter("id", id);
        return query.getResultList();
    }

    @Transactional(
            readOnly = true
    )
    public List<Profile> searchTinAndId(String tin, Long id) {
        Query query = this.em.createQuery("select t from Profile t where t.tinNo=:tinNo and t.id=:id");
        query.setParameter("tinNo", tin);
        query.setParameter("id", id);
        return query.getResultList();
    }

    public List<Profile> searchTinAndClientType(String var1, String var2) {
        Query var3 = this.em.createQuery("select t from Profile t where t.tinNo=:tinNo and t.clientType=:clientType");
        var3.setParameter("tinNo", var1);
        var3.setParameter("clientType", var2);
        return var3.getResultList();
    }
}

