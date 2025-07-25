//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.IdGenerator;
import java.util.List;

public interface IdGeneratorService {
    void save(IdGenerator var1);

    IdGenerator findById(String var1);

    void delete(String var1);

    List<IdGenerator> listPage(int var1, int var2);

    Long getNextId(String var1);
}
