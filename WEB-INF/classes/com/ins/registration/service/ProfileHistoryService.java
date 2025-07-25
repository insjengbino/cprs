//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.service;

import com.ins.registration.model.ProfileHistory;
import java.util.List;

public interface ProfileHistoryService {
    List<ProfileHistory> listAll();

    List<ProfileHistory> listByProfileId(Long var1);

    ProfileHistory findById(Long var1);

    void save(ProfileHistory var1);

    void delete(ProfileHistory var1);
}
