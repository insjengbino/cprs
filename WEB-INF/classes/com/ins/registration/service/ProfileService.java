package com.ins.registration.service;

import com.ins.registration.model.Profile;
import java.util.List;
import javax.persistence.EntityManager;

public interface ProfileService {
    void save(Profile var1);

    Profile findByID(Long var1);

    void delete(Profile var1);

    List<Profile> listLastN(int var1);

    List<Profile> listByClientCode(String var1);

    List<Profile> listByClientType(String var1);

    List<Profile> listByBusinessType(String var1);

    List<Profile> listByNatureOfBusiness(String var1);

    List<Profile> listByStatus(Long var1);

    List<Profile> listByTinAndClientType(String var1, String var2);

    List<Profile> searchTIN(String var1);

    List<Profile> searchTinAndId(String var1, Long var2);

    void setEm(EntityManager var1);

    int checkDuplicateByTinClientTypeINSClientNo(String tin, String clientType, String insClientNo);
}
