/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.config;

import com.ckfinder.connector.configuration.Configuration;
import com.ckfinder.connector.data.ResourceType;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author TUANPLA
 */
public class CKfinderConf extends Configuration {

    public CKfinderConf(ServletConfig servletConfig) {
        super(servletConfig);
    }

    @Override
    protected Configuration createConfigurationInstance() {
        return new CKfinderConf(this.servletConf);
    }

    @Override
    public void init() throws Exception {
        super.init();
        try {
            String webPath = servletConf.getServletContext().getContextPath();
            this.baseURL = webPath + "/upload/article/images";
            ResourceType resourceType = this.types.get("Files");
            resourceType.setAllowedExtensions(resourceType.getAllowedExtensions().concat(",zip,7z"));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

//    @Override
//    public void prepareConfigurationForRequest(HttpServletRequest request) {
//        if (request.getParameter("directThumbAccess") != null) {
//            this.thumbsDirectAccess = true;
//        }
//        String type = request.getParameter("type");
//        if ("Files".equals(type)) {
//            this.imgHeight = 480;
//            this.imgWidth = 600;
//        }
//        if ("Images".equals(type)) {
//            this.imgWidth = 800;
//            this.imgHeight = 600;
//        }
//        this.baseURL = "/webapps/ckfinder/";	//This will not work!
//        this.baseDir = "c:/ckfinder";		//This will not work!
//    }
    @Override
    public boolean checkAuthentication(final HttpServletRequest request) {
//        return request.getSession().getAttribute("loggedIn") != null;
        return true;
    }
//    @Override
//    public String getBaseDir() {
//        return "C:\\tomcat\\webapps\\MyApplication\\userfiles";
//    }
//
//    @Override
//    public String getBaseURL() {
//        return "/MyApplication/userfiles/";
//    }
}
