//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.CustomBondedWarehouseType;
import java.util.List;
import java.util.Map;

public interface CustomBondedWarehouseTypeService {
    List<CustomBondedWarehouseType> listAllCustomBondedWarehouseType();

    Map<String, String> listAll();

    CustomBondedWarehouseType findByCode(String var1);

    CustomBondedWarehouseType findByName(String var1);

    void save(CustomBondedWarehouseType var1);

    void delete(CustomBondedWarehouseType var1);
}
