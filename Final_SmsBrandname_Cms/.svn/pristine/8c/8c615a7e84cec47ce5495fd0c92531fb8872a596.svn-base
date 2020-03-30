<%@page import="gk.myname.vn.admin.SyncFirewall"%>
<%
    String permitIP="192.168.1.2";
    String ipRemote = request.getHeader("X-Forwarded-For");  
    if (ipRemote == null || ipRemote.length() == 0 || "unknown".equalsIgnoreCase(ipRemote)) {  
        ipRemote = request.getHeader("Proxy-Client-IP");  
    }  
    if (ipRemote == null || ipRemote.length() == 0 || "unknown".equalsIgnoreCase(ipRemote)) {  
        ipRemote = request.getHeader("WL-Proxy-Client-IP");  
    }  
    if (ipRemote == null || ipRemote.length() == 0 || "unknown".equalsIgnoreCase(ipRemote)) {  
        ipRemote = request.getHeader("HTTP_CLIENT_IP");  
    }  
    if (ipRemote == null || ipRemote.length() == 0 || "unknown".equalsIgnoreCase(ipRemote)) {  
        ipRemote = request.getHeader("HTTP_X_FORWARDED_FOR");  
    }  
    if (ipRemote == null || ipRemote.length() == 0 || "unknown".equalsIgnoreCase(ipRemote)) {  
        ipRemote = request.getRemoteAddr();  
    }
    
    String ipAccess = "1";
    ipAccess = String.valueOf(request.getParameter("ipaccessfw"));
    
    int portAccess = 0;
    portAccess = Integer.parseInt(String.valueOf(request.getParameter("portaccessfw")));
    
    String typeAction="";
    typeAction = String.valueOf(request.getParameter("typeaction"));
    SyncFirewall syncFW = new SyncFirewall(ipAccess,portAccess,ipRemote,permitIP);
    if(typeAction.equals("ADDSYNC")){
        syncFW.applyAdd();
    }
    
    if(typeAction.equals("DELSYNC")){
        syncFW.applyAdd();
    }
    
    
    
%>
