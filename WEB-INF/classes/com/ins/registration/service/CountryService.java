//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.Country;
import java.util.List;
import java.util.Map;

public interface CountryService {
    List<Country> listAllCountries();

    Map<String, String> listAll();

    Country findByCode(String var1);

    Country findByName(String var1);

    void save(Country var1);

    void delete(Country var1);
}
