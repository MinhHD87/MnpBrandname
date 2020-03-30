/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.config;

import gk.myname.vn.admin.Account;
import gk.myname.vn.db.DBPool;
import gk.myname.vn.db.PoolMng;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.ThreadCheckErrors;
import gk.myname.vn.utils.ThreadCheckMoney;
import gk.myname.vn.utils.Tool;
import java.io.File;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.jconfig.Configuration;
import org.jconfig.ConfigurationManager;
import org.jconfig.ConfigurationManagerException;
import org.jconfig.handler.XMLFileHandler;

/**
 *
 * @author TUANPLA
 */
public class MyContext implements ServletContextListener, HttpSessionListener {

    static Logger logger = Logger.getLogger(MyContext.class);
    private static final Map<String, HttpSession> SESSION_ONLINE = new HashMap<>();
    public static String configDir;
    //---
    public static String MYNAME_DIR = "/data/webroot/myname.vn";
    public static String ROOT_DIR;
    public static boolean running = false;
    public static boolean DE_BUG;
    // ----Constants
    public static String SMTP_MAIL;
    public static String SMTP_PASS;
    public static String MAIL_HOST;
    public static String FROM_NAME;
    public static String MAIL_DEBUG;
    public static final int SEND_MAIL_FALSE = 1;
    public static String URL_RELOAD;
    public static String URL_FIREWALL;
    // General

    public static int MAX_HOT;
    public static int MAX_TOP;
    public static String ARTICLES_IMG_THUMB_ALIAS;
    public static String ARTICLES_IMG_CACHE_ALIAS;
    // Noi cache Anh cua Content va Content
    public static int[] WIDTH_IMAGE_THUMBNAIL;
    public static int WIDTH_IMAGE_IN_CONTENT;
    public static int MAX_ROW_IN_CAT;

    //***********
    //-------Define Exception
    public static final int SUCCESS = 0;
    public static final int PROCESS_FAIL = 1;
    public static final int UNKNOW_EXCEPTION = 99;
    public static final int BAD_REQUEST = 400;
    //------------
    public static int ROW_PER_PAGE = 25;
    //---
    public static final int TYPE_CHANGE_STATUS = 1;
    public static final int TYPE_CHANGE_TOP = 2;
    public static final int TYPE_CHANGE_HOT = 3;
    //--Menu Type
    public static final int MENU_TYPE_CAT = 0;
    public static final int MENU_TYPE_LINK = 1;
    //------------STATUS CONTENT------------------------------
    public static final long MAX_FILE_SIZE = 10 * 1024 * 1024;
    ThreadCheckMoney chkMoney;
    ThreadCheckErrors chkErr;
    Monitor m;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext sc = sce.getServletContext();
        running = true;
        //--
        System.setProperty("java.awt.headless", "true");    // Fix Error java.lang.NoClassDefFoundError: Could not initialize class sun.awt.X11GraphicsEnvironmen
        ROOT_DIR = sc.getRealPath("/");
        Tool.debug("ROOT_DIR:" + ROOT_DIR);
        configDir = sc.getInitParameter("config");
        configDir = ROOT_DIR + configDir;
        //Load Log4J
        LoadLog4j(configDir + "/Log4j.properties");
        // Load Config
        MyConfig.config = getConfig("config.xml");
        //-------
        PoolMng.CreatePool();
        // FOR CONSTANTS
        DE_BUG = MyConfig.getBoolean("DE_BUG", false, "General");
        MAX_HOT = MyConfig.getInt("MAX_HOT", 10, "General");
        MAX_TOP = MyConfig.getInt("MAX_TOP", 10, "General");
        MAX_ROW_IN_CAT = MyConfig.getInt("MAX_ROW_IN_CAT", 10, "General");
        URL_RELOAD = MyConfig.getString("URL_RELOAD", "", "General");
        URL_FIREWALL = MyConfig.getString("URL_FIREWALL", "", "General");

        //-- CONFIG MAIL
        SMTP_MAIL = MyConfig.getString("SMTP_MAIL", "smpp.gmail.com", "EMAIL");
        SMTP_PASS = MyConfig.getString("SMTP_PASS", "smpp.gmail.com", "EMAIL");
        MAIL_HOST = MyConfig.getString("MAIL_HOST", "smpp.gmail.com", "EMAIL");
        FROM_NAME = MyConfig.getString("FROM_NAME", "smpp.gmail.com", "EMAIL");
        MAIL_DEBUG = MyConfig.getString("MAIL_DEBUG", "smpp.gmail.com", "EMAIL");

        ARTICLES_IMG_THUMB_ALIAS = MyConfig.getString("ARTICLES_IMG_THUMB_ALIAS", "/upload/thumb", "General");
        ARTICLES_IMG_CACHE_ALIAS = MyConfig.getString("ARTICLES_IMG_CACHE_ALIAS", "/upload/article", "General");
        String tem = MyConfig.getString("WIDTH_IMAGE_THUMBNAIL", "400,130", "General");
        if (tem != null) {
            String[] arr = tem.split(",");
            if (arr != null && arr.length > 0) {
                WIDTH_IMAGE_THUMBNAIL = new int[arr.length];
                for (int i = 0; i < arr.length; i++) {
                    try {
                        // Gan size thumb to array
                        WIDTH_IMAGE_THUMBNAIL[i] = Tool.string2Integer(arr[i]);
                        File f = new File(ROOT_DIR + ARTICLES_IMG_THUMB_ALIAS + "/" + arr[i]);
                        Tool.debug("Thumb URL:" + f.getPath());
                        if (!f.exists()) {
                            f.mkdirs();
                            Tool.debug("Make path ok");
                        } else {
                            Tool.debug("Path is is Exist");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        WIDTH_IMAGE_IN_CONTENT = MyConfig.getInt("WIDTH_IMAGE_IN_CONTENT", 720, "General");

        // General
        m = new Monitor();
        m.start();
        // start check money vte
        chkMoney = new ThreadCheckMoney();
        chkMoney.start();
//        start errors checking thread
        chkErr = new ThreadCheckErrors();
        chkErr.start();
    }

    @Override
    @SuppressWarnings("empty-statement")
    public void contextDestroyed(ServletContextEvent sce) {
        running = false;
        chkErr.stopThread();
        m.stopThread();
        //
        MyConfig.config.resetCreated();
        //---
        DBPool.release();
        PoolMng.release();
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                Tool.debug(" Deregis Driver:" + driver.toString());
                logger.log(Level.INFO, String.format("deregistering jdbc driver: %s", driver));
            } catch (SQLException e) {
                logger.log(Level.ERROR, String.format("Error deregistering driver %s", driver), e);
            }
        }
        Tool.debug(" contextDestroyed ............");
    }

    private static Configuration getConfig(String configFile) {
        Configuration _config = null;
        String configPath = configDir + "/" + configFile;
        configPath = configPath.replaceAll("\\\\", "/");
        File file = new File(configPath);
        logger.info(file.getName());
        XMLFileHandler handler = new XMLFileHandler();
        handler.setFile(file);
        try {
            logger.debug("trying to load file config");
            ConfigurationManager cm = ConfigurationManager.getInstance();
            cm.load(handler, "engineConfig");
            logger.info("file config successfully processed");
            logger.info("get Config From ConfigurationManager");
            _config = ConfigurationManager.getConfiguration("engineConfig");
        } catch (ConfigurationManagerException e) {
            e.printStackTrace();
        }
        return _config;
    }

    private static void LoadLog4j(String log4jPath) {
        if (log4jPath == null) {
            Tool.debug("==> - log4j-properties-location init param, so initializing log4j with BasicConfigurator");
            BasicConfigurator.configure();
        } else {
            File yoMamaYesThisSaysYoMama = new File(log4jPath);
            if (yoMamaYesThisSaysYoMama.exists()) {
                Tool.debug("====>Initializing Log4j:" + log4jPath);
                PropertyConfigurator.configure(log4jPath);
            } else {
                Tool.debug("=====> " + log4jPath + " file not found, so initializing log4j with BasicConfigurator");
                BasicConfigurator.configure();
            }
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent evt) {
        HttpSession session = evt.getSession();
        if (session.isNew()) {
            Tool.debug("Event New sessionCreated: " + evt.getSession().getId() + ":" + DateProc.createTimestamp());
        } else {
            Tool.debug("Event Old sessionCreated ?? : " + evt.getSession().getId() + ":" + DateProc.createTimestamp());
        }

    }

    @Override
    public void sessionDestroyed(HttpSessionEvent evt) {
        HttpSession evtSession = evt.getSession();
        synchronized (SESSION_ONLINE) {
            Collection<HttpSession> listSession = SESSION_ONLINE.values();
            if (listSession != null && listSession.size() > 0) {
                for (HttpSession oneSession : listSession) {
                    if (oneSession.getId().equals(evtSession.getId())) {
                        Account userlogin = (Account) oneSession.getAttribute("userlogin");
                        if (userlogin != null) {
                            SESSION_ONLINE.remove(userlogin.getUserName());
                            Tool.debug("Ngon lay duoc User [" + userlogin.getUserName() + "] Theo Session [" + oneSession.getId() + "]:" + DateProc.createTimestamp());
                        } else {
                            Tool.debug("Khong lay duoc User theo Session [" + oneSession.getId() + "]:" + DateProc.createTimestamp());
                        }
                        oneSession.invalidate();
                        break;
                    }
                }
            }
            SESSION_ONLINE.notify();
        }
    }

    public static boolean checkUserOneline(String user) {
        synchronized (SESSION_ONLINE) {
            if (!Tool.checkNull(user)) {
                HttpSession userSession = SESSION_ONLINE.get(user);
                return userSession != null;
            } else {
                return false;
            }
        }
    }

    // here is our own method to return the number of current sessions
    public static int getNumberOfSessions() {
        synchronized (SESSION_ONLINE) {
            return SESSION_ONLINE.size();
        }
    }

    public static void putSessionOnline(String user, HttpSession session) {
        synchronized (SESSION_ONLINE) {
            SESSION_ONLINE.put(user, session);
            SESSION_ONLINE.notify();
        }
    }

    public static void logOutSession(String user) {
        synchronized (SESSION_ONLINE) {
            try {
                HttpSession oneSession = SESSION_ONLINE.get(user);
                if (oneSession != null) {
                    // Dau Tien Phai Remove trong quan ly truoc da de deligate no tu huy
                    SESSION_ONLINE.remove(user);
                    Account userlogin = (Account) oneSession.getAttribute("userlogin");
                    if (userlogin != null) {
                        SESSION_ONLINE.remove(userlogin.getUserName());
                        System.out.println("Tim thay 1 User can Logout and Remove From Cache [" + userlogin.getUserName() + "]");
                    }
                    oneSession.removeAttribute("userlogin");
                    oneSession.invalidate();
                }
            } catch (Exception e) {
                logger.error(Tool.getLogMessage(e));
            }

            SESSION_ONLINE.notify();
        }
    }

    public static void removeSessionOnline(String user) {
        synchronized (SESSION_ONLINE) {
            SESSION_ONLINE.remove(user);
            SESSION_ONLINE.notify();
        }
    }
}
