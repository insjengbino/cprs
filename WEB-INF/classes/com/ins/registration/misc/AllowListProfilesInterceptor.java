package com.ins.registration.misc;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.config.entities.ResultConfig;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;


import java.util.Map;

public class AllowListProfilesInterceptor extends AbstractInterceptor {

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        // Execute action first
        String resultCode = invocation.invoke();

        // Get ResultConfig from current ActionConfig
        Map<String, ResultConfig> results = invocation.getProxy()
                .getConfig()
                .getResults();
        ResultConfig rc = results.get(resultCode);
        if (rc != null) {
            String cls = rc.getClassName();
            // Check if it's a redirect type
            if (cls != null && cls.contains("ServletRedirectResult")) {
                // Check the "location" parameter from config
                String location = rc.getParams().get("location").toString();
                if (location != null && location.contains("listProfiles.action")) {
                    ServletActionContext.getRequest().getSession()
                            .setAttribute("allowListProfiles", true);
                }
            }
        }

        return resultCode;
    }
}
