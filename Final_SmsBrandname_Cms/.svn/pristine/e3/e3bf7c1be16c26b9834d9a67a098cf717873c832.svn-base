/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.utils;

import gk.myname.vn.config.MyContext;
import static gk.myname.vn.config.MyContext.FROM_NAME;
import static gk.myname.vn.config.MyContext.MAIL_HOST;
import static gk.myname.vn.config.MyContext.SMTP_MAIL;
import static gk.myname.vn.config.MyContext.SMTP_PASS;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import org.apache.log4j.Logger;

/**
 *
 * @author TUANPLA
 */
public class SendMail {

    static Logger logger = Logger.getLogger(SendMail.class);

    static String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";

    public static boolean send(String smtpServer, String port, String to, String from, String psw,
            String subject, String body) {
        boolean flag = false;
        try {
// Code provide by congdongjava.com
            Properties props = System.getProperties();
            props.put("mail.smtp.host", smtpServer);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.starttls.enable", "true");
            final String login = from;
            final String pwd = psw;
            Authenticator pa = null;
            if (login != null && pwd != null) {
                props.put("mail.smtp.auth", "true");
                pa = new Authenticator() {

                    public PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(login, pwd);
                    }
                };
            }//else: no authentication
            Session session = Session.getInstance(props, pa);
// — Create a new message –
            Message msg = new MimeMessage(session);
// — Set the FROM and TO fields –
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(
                    to, false));

// — Set the subject and body text –
            msg.setSubject(subject);
            msg.setText(body);//Để gởi nội dung dạng utf-8 các bạn dùng msg.setContent(body, "text/html; charset=UTF-8");
// — Set some other header information –
            msg.setHeader("X-Mailer", "LOTONtechEmail");
            msg.saveChanges();
// — Send the message –
            Transport.send(msg);
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public static boolean sendMailOneToOne(String fromName, String fromEmail, String fromPassMail, String host, String port,
            String subject, String content, String toEmail) {
        boolean flag = false;
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", host); //MyContext.MAIL_HOST
            props.put("mail.smtp.socketFactory.port", port);
            props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.port", port);
            props.put("mail.debug", false);
            props.put("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            // Get the default Session object.
            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {

                    return new PasswordAuthentication(fromEmail, fromPassMail);

                }
            }
            );
            // Create a default MimeMessage object.
            MimeMessage messageSend = new MimeMessage(session);
            // Set the RFC 822 "From" header field using the
            // value of the InternetAddress.getLocalAddress method.
            messageSend.setFrom(new InternetAddress(fromEmail, fromName));
//            
            messageSend.setRecipients(Message.RecipientType.TO, InternetAddress.parse(fromEmail));
            messageSend.setRecipients(Message.RecipientType.CC, InternetAddress.parse(toEmail));
//            }
            messageSend.setSubject(subject, "utf-8");
            // Sets the given String as this part's content,
            // with a MIME type of "text/plain".
            messageSend.setText(content, "utf-8");
            // Send message
            Transport.send(messageSend);
            flag = true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean sendMailOneToOne(String fromEmail, String fromPassMail, String host, String port,
            String subject, String content, String toEmail) {
        boolean flag = false;
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", host); //MyContext.MAIL_HOST
            props.put("mail.smtp.socketFactory.port", port);
            props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.port", port);
            props.put("mail.debug", false);
            props.put("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            // Get the default Session object.
            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {

                    return new PasswordAuthentication(fromEmail, fromPassMail);

                }
            }
            );
            // Create a default MimeMessage object.
            MimeMessage messageSend = new MimeMessage(session);
            // Set the RFC 822 "From" header field using the
            // value of the InternetAddress.getLocalAddress method.
            messageSend.setFrom(new InternetAddress(fromEmail));
//            
            messageSend.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
//            }
            messageSend.setSubject(subject, "utf-8");
            // Sets the given String as this part's content,
            // with a MIME type of "text/plain".
            messageSend.setText(content, "utf-8");
            // Send message
            Transport.send(messageSend);
            flag = true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean sendMail(String fromEmail, String fromPassMail,
            String subject, String content, ArrayList<String> toEmail, String fromName) {
        boolean flag = false;
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", MAIL_HOST); //MyContext.MAIL_HOST
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.debug", false);
            props.put("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            // Get the default Session object.
            Session session = Session.getInstance(props);
            // Create a default MimeMessage object.
            MimeMessage messageSend = new MimeMessage(session);
            // Set the RFC 822 "From" header field using the
            // value of the InternetAddress.getLocalAddress method.
            messageSend.setFrom(new InternetAddress(fromEmail, fromName));

            Address[] addresses = new Address[toEmail.size()];
            for (int i = 0; i < toEmail.size(); i++) {
                Address address = new InternetAddress(toEmail.get(i));
                addresses[i] = address;
                // Add the given addresses to the specified recipient type.
                messageSend.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail.get(i)));
            }
            // Set the "Subject" header field.
            messageSend.setSubject(subject, "utf-8");
            // Sets the given String as this part's content,
            // with a MIME type of "text/plain".
            Multipart mp = new MimeMultipart("alternative");
            MimeBodyPart mbp = new MimeBodyPart();
            mbp.setContent(content, "text/html;charset=utf-8");
            mp.addBodyPart(mbp);
            messageSend.setContent(mp);
            messageSend.saveChanges();
            // Send message
            Transport transport = session.getTransport("smtp");
//            transport.connect(MyConfig.MAIL_HOST, MyConfig.SMTP_MAIL, MyConfig.SMTP_PASS);
            transport.connect(fromEmail, fromPassMail);
            transport.sendMessage(messageSend, addresses);
            transport.close();
            flag = true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean sendMail(String subject, String content, ArrayList<String> toEmail, String fromName) {
        boolean flag = false;
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", MAIL_HOST); //MyContext.MAIL_HOST
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.debug", false);
            props.put("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            // Get the default Session object.
            Session session = Session.getInstance(props);
            // Create a default MimeMessage object.
            MimeMessage messageSend = new MimeMessage(session);
            // Set the RFC 822 "From" header field using the
            // value of the InternetAddress.getLocalAddress method.
            messageSend.setFrom(new InternetAddress(MyContext.SMTP_MAIL, fromName));

            Address[] addresses = new Address[toEmail.size()];
            for (int i = 0; i < toEmail.size(); i++) {
                Address address = new InternetAddress(toEmail.get(i));
                addresses[i] = address;
                // Add the given addresses to the specified recipient type.
                messageSend.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail.get(i)));
            }
            // Set the "Subject" header field.
            messageSend.setSubject(subject, "utf-8");
            // Sets the given String as this part's content,
            // with a MIME type of "text/plain".
            Multipart mp = new MimeMultipart("alternative");
            MimeBodyPart mbp = new MimeBodyPart();
            mbp.setContent(content, "text/html;charset=utf-8");
            mp.addBodyPart(mbp);
            messageSend.setContent(mp);
            messageSend.saveChanges();
            // Send message
            Transport transport = session.getTransport("smtp");
//            transport.connect(MyConfig.MAIL_HOST, MyConfig.SMTP_MAIL, MyConfig.SMTP_PASS);
            transport.connect(MyContext.SMTP_MAIL, MyContext.SMTP_PASS);
            transport.sendMessage(messageSend, addresses);
            transport.close();
            flag = true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
            e.printStackTrace();
        }
        return flag;
    }

    public static ArrayList<String> parseListMail(String input) {
        String[] arrMail = input.split(",|;|\\n|\\s");
        ArrayList<String> list = new ArrayList<>();
        for (String one : arrMail) {
            if (!Tool.checkNull(one) && one.contains("@")) {
                list.add(one.trim());
            }
        }
        return list;
    }

    public static boolean sendMail(String subject, String content, String mailList) {
        boolean flag = false;
        ArrayList<String> listEmail = parseListMail(mailList);
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", MAIL_HOST); //MyContext.MAIL_HOST
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.debug", false);
            props.put("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            // Get the default Session object.
            Session session = Session.getInstance(props);
            // Create a default MimeMessage object.
            MimeMessage messageSend = new MimeMessage(session);
            // Set the RFC 822 "From" header field using the
            // value of the InternetAddress.getLocalAddress method.
            messageSend.setFrom(new InternetAddress(SMTP_MAIL, FROM_NAME));

            Address[] addresses = new Address[listEmail.size()];
            for (int i = 0; i < listEmail.size(); i++) {
                Address address = new InternetAddress(listEmail.get(i));
                addresses[i] = address;
                // Add the given addresses to the specified recipient type.
                messageSend.addRecipient(Message.RecipientType.TO, new InternetAddress(listEmail.get(i)));
            }
            // Set the "Subject" header field.
            messageSend.setSubject(subject, "utf-8");
            // Sets the given String as this part's content,
            // with a MIME type of "text/plain".
            Multipart mp = new MimeMultipart("alternative");
            MimeBodyPart mbp = new MimeBodyPart();
            mbp.setContent(content, "text/html;charset=utf-8");
            mp.addBodyPart(mbp);
            messageSend.setContent(mp);
            messageSend.saveChanges();
            // Send message
            Transport transport = session.getTransport("smtp");
//            transport.connect(MyConfig.MAIL_HOST, MyConfig.SMTP_MAIL, MyConfig.SMTP_PASS);
            transport.connect(SMTP_MAIL, SMTP_PASS);
            transport.sendMessage(messageSend, addresses);
            transport.close();
            flag = true;
            for (String s : listEmail) {
                System.out.println(" EMAIL WAS SENT TO  : " + s);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        }
        return flag;
    }

//    public static boolean sendMail(String subject, String content, String mailList) {
//        boolean flag = false;
//        ArrayList<String> listEmail = parseListMail(mailList);
//        try {
//            Properties props = new Properties();
//            props.put("mail.smtp.host", MAIL_HOST);
//            props.put("mail.smtp.port", "25");
//            props.put("mail.debug", false);
//            props.put("mail.smtp.auth", "true");
//            props.put("mail.smtp.starttls.enable", "true");
//            props.setProperty("mail.smtp.socketFactory.port", "25");
////            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
//            props.setProperty("mail.smtp.socketFactory.fallback", "false");
//            // Get the default Session object.
//            Session session = Session.getInstance(props);
//            // Create a default MimeMessage object.
//            MimeMessage messageSend = new MimeMessage(session);
//            // Set the RFC 822 "From" header field using the
//            // value of the InternetAddress.getLocalAddress method.
//            messageSend.setFrom(new InternetAddress(SMTP_MAIL, FROM_NAME));
//
//            Address[] addresses = new Address[listEmail.size()];
//            for (int i = 0; i < listEmail.size(); i++) {
//                Address address = new InternetAddress(listEmail.get(i));
//                addresses[i] = address;
//                // Add the given addresses to the specified recipient type.
//                messageSend.addRecipient(Message.RecipientType.TO, new InternetAddress(listEmail.get(i)));
//            }
//            // Set the "Subject" header field.
//            messageSend.setSubject(subject, "utf-8");
//            // Sets the given String as this part's content,
//            // with a MIME type of "text/plain".
//            Multipart mp = new MimeMultipart("alternative");
//            MimeBodyPart mbp = new MimeBodyPart();
//            mbp.setContent(content, "text/html;charset=utf-8");
//            mp.addBodyPart(mbp);
//            messageSend.setContent(mp);
//            messageSend.saveChanges();
//            // Send message
//            Transport transport = session.getTransport("smtp");
////            transport.connect(MyConfig.MAIL_HOST, MyConfig.SMTP_MAIL, MyConfig.SMTP_PASS);
//            transport.connect(SMTP_MAIL, SMTP_PASS);
//            transport.sendMessage(messageSend, addresses);
//            transport.close();
//            flag = true;
//
//            for (String s : listEmail) {
//                System.out.println(" EMAIL WAS SENT TO  : " + s);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return flag;
//    }
}
