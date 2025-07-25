//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.CustomBondedWarehouse;
import java.util.List;
import java.util.Map;

public interface CustomBondedWarehouseService {
    List<CustomBondedWarehouse> listAllCustomBondedWarehouse();

    Map<String, String> listAll();

    CustomBondedWarehouse findByCode(String var1);

    CustomBondedWarehouse findByDescription(String var1);

    void save(CustomBondedWarehouse var1);

    void delete(CustomBondedWarehouse var1);
}
