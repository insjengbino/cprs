//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.misc;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import java.util.Locale;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FieldInterceptor extends AbstractInterceptor {
    private final Log log = LogFactory.getLog(this.getClass());

    public String intercept(ActionInvocation arg0) throws Exception {
        ActionContext actionContext = arg0.getInvocationContext();
        Map<String, Object> map = (Map<String, Object>) actionContext.getParameters();

        for (Map.Entry<String, Object> pairs : map.entrySet()) {
            this.log.debug(pairs.getKey() + " = " + pairs.getValue().toString());
            if (pairs.getValue() instanceof String[] string) {
                for (int i = 0; i < string.length; i++) {
                    if (string[i] != null) {
                        string[i] = string[i].trim().toUpperCase(Locale.ROOT);
                    }
                }
            }
        }

        return arg0.invoke();
    }
}
