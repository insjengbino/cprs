package com.ins.registration.misc;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Interceptor to protect listProfiles.action
 * - Blocks manual GET access (redirects to ASP login)
 * - Allows POST requests
 * - Allows internal redirects if session flag allowListProfiles is set
 */
public class PostOnlyInterceptor extends AbstractInterceptor {

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();

        // Only apply this logic to listProfiles.action
        String uri = request.getRequestURI();
        if (uri.endsWith("listProfiles.action")) {

            // Check for bypass flag in session
            Boolean allowed = (Boolean) request.getSession().getAttribute("allowListProfiles");

            // If it's a GET and no flag is set → block & redirect
            if ("GET".equalsIgnoreCase(request.getMethod()) && (allowed == null || !allowed)) {
                // cleanup any old flag
                request.getSession().removeAttribute("allowListProfiles");

                // Redirect to ASP login with returnTo param
                String returnTo = request.getRequestURL().toString();
                response.sendRedirect("http://asp-app/login.asp?returnTo=" + returnTo);
                return null; // stop here
            }

            // If allowed flag exists, consume it (one-time use)
            if (allowed != null && allowed) {
                request.getSession().removeAttribute("allowListProfiles");
            }
        }

        // Continue normal flow
        return invocation.invoke();
    }
}
