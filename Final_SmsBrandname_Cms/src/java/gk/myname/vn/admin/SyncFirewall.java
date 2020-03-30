/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.admin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;

/**
 *
 * @author congnx
 */
public class SyncFirewall {
    String ip_address="1";
    int port_access=80;
    String ip_source_call="2";
    String ip_permit = "3";
    public SyncFirewall(String ipValue, int portValue, String ipSourceValue, String ipPermit){
        ip_address = ipValue;
        port_access = portValue;
        ip_source_call = ipSourceValue;
        ip_permit = ipPermit;
    }
    
    private boolean permitAccess(){
        if(ip_source_call.equals(ip_permit)){
            return true;
        }else{
            return false;
        }
    }
    
    private String reloadFireWall() throws Exception {
        String cmd = "firewall-cmd --reload";
        return executeCommand(cmd);
    }
    
    public String applyDel() throws Exception {
        int remove = doRemoveIPCmd(ip_address, port_access);
        if (remove == 0) {
            return reloadFireWall();
        } else {
            return "false";
        }
    }
    
    private int doRemoveIPCmd(String ip, int port) {
        int iExitValue = 0;
        CommandLine executeAddIPCmd = new CommandLine("firewall-cmd");
        executeAddIPCmd.addArgument("--permanent");
        executeAddIPCmd.addArgument("--zone=public");
        executeAddIPCmd.addArgument("--remove-rich-rule=\"\"rule family=ipv4 source address=" + ip + " port port=" + port + " protocol=tcp accept\"\"", false);
        DefaultExecutor oDefaultExecutor = new DefaultExecutor();
        oDefaultExecutor.setExitValue(0);
        try {
            iExitValue = oDefaultExecutor.execute(executeAddIPCmd);
        } catch (Exception e) {
            System.err.println("Execution failed.");
            e.printStackTrace();
        }
        return iExitValue;
    }
    
    private String executeCommand(String command) {
//        Tool.debug("Execute Command:" + command);
        StringBuilder output = new StringBuilder();
        Process p;
        try {
            p = Runtime.getRuntime().exec(command);
//            int tmp = p.waitFor();
            p.waitFor();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    output.append(line + System.lineSeparator());
                }
                //Check result
//            int tmp = p.waitFor();
//            if (tmp == 0) {
//                System.out.println("executeCommand: Success!");
//            } else {
//                System.out.println("tmp:" + tmp);
//            }
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
//        Tool.debug("Execute Result:" + output.toString());
        return output.toString();
    }
    
    public int applyAdd(){
        if(permitAccess()){
            //Add firewall
            int iExitValue = 0;
            CommandLine executeAddIPCmd = new CommandLine("firewall-cmd");
            executeAddIPCmd.addArgument("--permanent");
            executeAddIPCmd.addArgument("--zone=public");
            executeAddIPCmd.addArgument("--add-rich-rule=\"\"rule family=ipv4 source address=" + ip_address + " port port=" + port_access + " protocol=tcp accept\"\"", false);
            DefaultExecutor oDefaultExecutor = new DefaultExecutor();
            oDefaultExecutor.setExitValue(0);
            try {
                iExitValue = oDefaultExecutor.execute(executeAddIPCmd);
            } catch (Exception e) {
                System.err.println("Execution failed.");
                e.printStackTrace();
            }
            return iExitValue;
        }else{
            return 0;
        }
    }
}
