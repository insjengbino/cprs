//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.ClientType;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;

public interface ClientTypeService {
    List<ClientType> listAllClientType();

    Map<String, String> listAll();

    ClientType findByCode(String var1);

    ClientType findByName(String var1);

    void save(ClientType var1);

    void delete(ClientType var1);

    void setEm(EntityManager var1);
}
