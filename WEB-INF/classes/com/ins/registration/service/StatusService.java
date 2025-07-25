//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.Status;
import java.util.List;
import javax.persistence.EntityManager;

public interface StatusService {
    void save(Status var1);

    Status findById(Long var1);

    Status findByName(String var1);

    void delete(Long var1);

    List<Status> listPage(int var1, int var2);

    List<Status> listByNameCriteria(int var1, Integer var2, String var3);

    void setEm(EntityManager var1);
}
