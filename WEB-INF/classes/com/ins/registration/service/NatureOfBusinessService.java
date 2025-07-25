//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.NatureOfBusiness;
import java.util.List;
import java.util.Map;

public interface NatureOfBusinessService {
    List<NatureOfBusiness> listAllNatureOfBusiness();

    Map<String, String> listAll();

    NatureOfBusiness findByCode(String var1);

    NatureOfBusiness findByName(String var1);

    void save(NatureOfBusiness var1);

    void delete(NatureOfBusiness var1);
}
