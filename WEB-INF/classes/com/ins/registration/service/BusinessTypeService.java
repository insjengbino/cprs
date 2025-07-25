//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.BusinessType;
import java.util.List;
import java.util.Map;

public interface BusinessTypeService {
    List<BusinessType> listAllBusinessType();

    Map<String, String> listAll();

    BusinessType findByCode(String var1);

    BusinessType findByName(String var1);

    void save(BusinessType var1);

    void delete(BusinessType var1);
}
