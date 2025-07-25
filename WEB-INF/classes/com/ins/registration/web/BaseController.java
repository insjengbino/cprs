package com.ins.registration.web;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class BaseController extends ActionSupport {
    private static final long serialVersionUID = 1L;
    public static final String CURRENT_ACCOUNT_ID_KEY = "currentProfileID";
    protected Long id;
    protected Integer pageNo = 1;
    protected Integer pageSize = 12;
    protected final Log log = LogFactory.getLog(this.getClass());

    public Long getId() {
        String[] ids = (String[])ActionContext.getContext().getParameters().get("id");
        if (this.id == null) {
            return ids != null && ids.length > 0 && ids[0] != null && !ids[0].equals("") ? new Long(ids[0]) : null;
        } else {
            return this.id;
        }
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getPageNo() {
        return this.pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return this.pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getActionName() {
        return ActionContext.getContext().getName();
    }

    protected void setInSession(String key, Object value) {
        this.log.debug("setting " + key + " session to value:" + value);
        ActionContext.getContext().getSession().put(key, value);
    }

    protected Object getFromSession(String key) {
        Object value = ActionContext.getContext().getSession().get(key);
        if (value == null) {
            this.log.debug(key + " not found in session");
        }

        return value;
    }

    protected String getParameter(String key) {
        try {
            return ((String[])ActionContext.getContext().getParameters().get(key))[0];
        } catch (Exception e) {
            this.log.debug("Error in getting parameter: " + key + " " + e.getMessage());
            return null;
        }
    }

    protected byte[] readFully(File foo) {
        byte[] result = (byte[])null;
        FileInputStream fis = null;
        ByteArrayOutputStream baos = null;

        try {
            fis = new FileInputStream(foo);
            baos = new ByteArrayOutputStream();

            int i;
            try {
                while((i = fis.read()) >= 0) {
                    baos.write(i);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            result = baos.toByteArray();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (baos != null) {
                try {
                    baos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        return result;
    }
}
