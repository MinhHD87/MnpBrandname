<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="gk.myname.vn.entity.MsgBrandSubmit"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.sql.*"%><%@page import="java.io.FileOutputStream"%><%@page import="java.io.File"%><%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="java.util.Set"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%><%@page import="java.util.ArrayList"%><%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %>
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        ArrayList<MsgBrandSubmit> all = null;
        MsgBrandSubmit smDao = new MsgBrandSubmit();

        String _label = RequestTool.getString(request, "_label");
        int type = RequestTool.getInt(request, "type", -1);
        String provider = RequestTool.getString(request, "provider");
        String groupBr = RequestTool.getString(request, "groupBr");
        String stRequest = RequestTool.getString(request, "stRequest");
        String endRequest = RequestTool.getString(request, "endRequest");
        String oper = RequestTool.getString(request, "oper");
        int result = RequestTool.getInt(request, "result", 0);
        String cp_code = RequestTool.getString(request, "cp_code");
        String userSender = RequestTool.getString(request, "userSender", "0");
        all = smDao.statisticSubm(userSender, cp_code, _label, type, provider, stRequest, endRequest, oper, result, groupBr);
        
//        System.out.println(all);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response, provider, stRequest, endRequest);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<MsgBrandSubmit> allMoLog, HttpServletResponse response, String provider, String stRequest, String endRequest) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();

    Locale localeEN = new Locale("en", "EN");
    NumberFormat en = NumberFormat.getInstance(localeEN);
        ArrayList<Object[]> data = new ArrayList();
        int vteN0 = 0;
        int vteN1 = 0;
        int vteN2 = 0;
        int vteN3 = 0;
        int vteN4 = 0;
        int vteN5 = 0;
        int vteN6 = 0;
        int vteN7 = 0;
        int vteN8 = 0;
        int vteN9 = 0;
        int vteN10 = 0;
        int vteN11 = 0;
        int vteN12 = 0;
        int vteN13 = 0;
        int vteN14 = 0;
        int vteN15 = 0;
        int vteNNLC = 0;
        int mobiN0 = 0;
        int mobiN1 = 0;
        int mobiN2 = 0;
        int mobiN3 = 0;
        int mobiN4 = 0;
        int mobiN5 = 0;
        int mobiN6 = 0;
        int mobiN7 = 0;
        int mobiN8 = 0;
        int mobiN9 = 0;
        int mobiN10 = 0;
        int mobiN11 = 0;
        int mobiN12 = 0;
        int mobiN13 = 0;
        int mobiN14 = 0;
        int mobiN15 = 0;
        int mobiNNLC = 0;
        int vinaN0 = 0;
        int vinaN1 = 0;
        int vinaN2 = 0;
        int vinaN3 = 0;
        int vinaN4 = 0;
        int vinaN5 = 0;
        int vinaN6 = 0;
        int vinaN7 = 0;
        int vinaN8 = 0;
        int vinaN9 = 0;
        int vinaN10 = 0;
        int vinaN11 = 0;
        int vinaN12 = 0;
        int vinaN13 = 0;
        int vinaN14 = 0;
        int vinaN15 = 0;
        int vinaNNLC = 0;
        int vnmN0 = 0;
        int vnmN1 = 0;
        int vnmN2 = 0;
        int vnmN3 = 0;
        int vnmN4 = 0;
        int vnmN5 = 0;
        int vnmN6 = 0;
        int vnmN7 = 0;
        int vnmN8 = 0;
        int vnmN9 = 0;
        int vnmN10 = 0;
        int vnmN11 = 0;
        int vnmN12 = 0;
        int vnmN13 = 0;
        int vnmN14 = 0;
        int vnmN15 = 0;
        int vnmNNLC = 0;
        int blN0 = 0;
        int blN1 = 0;
        int blN2 = 0;
        int blN3 = 0;
        int blN4 = 0;
        int blN5 = 0;
        int blN6 = 0;
        int blN7 = 0;
        int blN8 = 0;
        int blN9 = 0;
        int blN10 = 0;
        int blN11 = 0;
        int blN12 = 0;
        int blN13 = 0;
        int blN14 = 0;
        int blN15 = 0;
        int blNNLC = 0;
        int ddgN0 = 0;
        int ddgN1 = 0;
        int ddgN2 = 0;
        int ddgN3 = 0;
        int ddgN4 = 0;
        int ddgN5 = 0;
        int ddgN6 = 0;
        int ddgN7 = 0;
        int ddgN8 = 0;
        int ddgN9 = 0;
        int ddgN10 = 0;
        int ddgN11 = 0;
        int ddgN12 = 0;
        int ddgN13 = 0;
        int ddgN14 = 0;
        int ddgN15 = 0;
        int ddgNNLC = 0;

        data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "Báo cáo",
            "sản lượng",
            "SMS",
            "theo nhóm",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
        data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "Từ",
            stRequest,
            "đến",
            endRequest,
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
        data.add(new Object[]{            
            "Nhà mạng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng"
        });
        for (MsgBrandSubmit onemo : allMoLog) {
            if (onemo.getBrGroup().equals("N1")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN1 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N2")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN2 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N3")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN3 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N4")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN4 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N5")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN5 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N6")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN6 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N7")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN7 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N8")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN8 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N9")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN9 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N10")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN10 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N11")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN11 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N12")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN12 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N13")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN13 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N14")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN14 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N15")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN15 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("NNLC")) {
                if (onemo.getOper().equals("VTE")) {
                    vteNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgNNLC += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("0")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN0 += onemo.getTotalSms();
                }
            }
        }
        int vteTotal = vteN0+vteN1+vteN2+vteN3+vteN4+vteN5+vteN6+vteN7+vteN8+vteN9+vteN10+vteN11+vteN12+vteN13+vteN14+vteN15+vteNNLC;
        int vinaTotal = vinaN0+vinaN1+vinaN2+vinaN3+vinaN4+vinaN5+vinaN6+vinaN7+vinaN8+vinaN9+vinaN10+vinaN11+vinaN12+vinaN13+vinaN14+vinaN15+vinaNNLC;
        int vnmTotal = vnmN0+vnmN1+vnmN2+vnmN3+vnmN4+vnmN5+vnmN6+vnmN7+vnmN8+vnmN9+vnmN10+vnmN11+vnmN12+vnmN13+vnmN14+vnmN15+vnmNNLC;
        int mobiTotal = mobiN0+mobiN1+mobiN2+mobiN3+mobiN4+mobiN5+mobiN6+mobiN7+mobiN8+mobiN9+mobiN10+mobiN11+mobiN12+mobiN13+mobiN14+mobiN15+mobiNNLC;
        int blTotal = blN0+blN1+blN2+blN3+blN4+blN5+blN6+blN7+blN8+blN9+blN10+blN11+blN12+blN13+blN14+blN15+blNNLC;
        int ddgTotal = ddgN0+ddgN1+ddgN2+ddgN3+ddgN4+ddgN5+ddgN6+ddgN7+ddgN8+ddgN9+ddgN10+ddgN11+ddgN12+ddgN13+ddgN14+ddgN15+ddgNNLC;
        data.add(new Object[]{
            "VIETTEL",
            vteN0+ "",
            vteN1+ "",
            vteN2+ "",
            vteN3+ "",
            vteN4+ "",
            vteN5+ "",
            vteN6+ "",
            vteN7+ "",
            vteN8+ "",
            vteN9+ "",
            vteN10+ "",
            vteN11+ "",
            vteN12+ "",
            vteN13+ "",
            vteN14+ "",
            vteN15+ "",
            vteNNLC+ "",
            vteTotal+ ""
        });
        data.add(new Object[]{
            "MOBIFONE",
            mobiN0+ "",
            mobiN1+ "",
            mobiN2+ "",
            mobiN3+ "",
            mobiN4+ "",
            mobiN5+ "",
            mobiN6+ "",
            mobiN7+ "",
            mobiN8+ "",
            mobiN9+ "",
            mobiN10+ "",
            mobiN11+ "",
            mobiN12+ "",
            mobiN13+ "",
            mobiN14+ "",
            mobiN15+ "",
            mobiNNLC+ "",
            mobiTotal+ ""
        });
        data.add(new Object[]{
            "VINAFONE",
            vinaN0+ "",
            vinaN1+ "",
            vinaN2+ "",
            vinaN3+ "",
            vinaN4+ "",
            vinaN5+ "",
            vinaN6+ "",
            vinaN7+ "",
            vinaN8+ "",
            vinaN9+ "",
            vinaN10+ "",
            vinaN11+ "",
            vinaN12+ "",
            vinaN13+ "",
            vinaN14+ "",
            vinaN15+ "",
            vinaNNLC+ "",
            vinaTotal+ ""
        });
        data.add(new Object[]{
            "VIETNAM MOBILE",
            vnmN0+ "",
            vnmN1+ "",
            vnmN2+ "",
            vnmN3+ "",
            vnmN4+ "",
            vnmN5+ "",
            vnmN6+ "",
            vnmN7+ "",
            vnmN8+ "",
            vnmN9+ "",
            vnmN10+ "",
            vnmN11+ "",
            vnmN12+ "",
            vnmN13+ "",
            vnmN14+ "",
            vnmN15+ "",
            vnmNNLC+ "",
            vnmTotal+ ""
        });
        data.add(new Object[]{
            "GMOBILE",
            blN0+ "",
            blN1+ "",
            blN2+ "",
            blN3+ "",
            blN4+ "",
            blN5+ "",
            blN6+ "",
            blN7+ "",
            blN8+ "",
            blN9+ "",
            blN10+ "",
            blN11+ "",
            blN12+ "",
            blN13+ "",
            blN14+ "",
            blN15+ "",
            blNNLC+ "",
            blTotal+ ""
        });
        data.add(new Object[]{
            "ITELECOM",
            ddgN0+ "",
            ddgN1+ "",
            ddgN2+ "",
            ddgN3+ "",
            ddgN4+ "",
            ddgN5+ "",
            ddgN6+ "",
            ddgN7+ "",
            ddgN8+ "",
            ddgN9+ "",
            ddgN10+ "",
            ddgN11+ "",
            ddgN12+ "",
            ddgN13+ "",
            ddgN14+ "",
            ddgN15+ "",
            ddgTotal+ ""
        });
        int totalAll = vteTotal + mobiTotal + vinaTotal + vnmTotal + blTotal + ddgTotal;
        data.add(new Object[]{            
            "Nhà mạng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng : " + totalAll+ ""
        });
        int rownum = 0;
        for (Object[] objArr : data) {
            Row row = sheet.createRow(rownum++);
            int cellnum = 0;
            for (Object obj : objArr) {
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof Date) {
                    cell.setCellValue((Date) obj);
                } else if (obj instanceof Boolean) {
                    cell.setCellValue((Boolean) obj);
                } else if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Double) {
                    cell.setCellValue((Double) obj);
                } else {
                    cell.setCellValue((String) obj);
                }
            }
        }

        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
//            response.setHeader("Content-Disposition", "attachment; filename=Baocao-" + DateProc.createDDMMYYYY() + ".xls");
            response.setHeader("Content-Disposition", "attachment; filename=Baocao-" + stRequest+"-"+endRequest + ".xls");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            // e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    private static String getType(int type) {
        if (type == BrandLabel.TYPE.CSKH.val) {
            return "CSKH";
        } else if (type == BrandLabel.TYPE.QC.val) {
            return "Tin QC";
        } else {
            return type + "";
        }
    }
%>