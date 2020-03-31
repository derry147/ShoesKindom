<%@page import="allPay.payment.integration.domain.AioCheckOutALL"%>

<%@page import="java.time.LocalTime"%>

<%@page import="allPay.payment.integration.domain.AioCheckOutOneTime"%>

<%@page import="java.time.LocalDate"%>

<%@page import="uuu.s2k.entity.Customer"%>

<%@page import="uuu.s2k.entity.Order"%>

<%@page import="java.util.Date"%>

<%@page import="java.util.List"%>

<%@page import="allPay.payment.integration.*"%>

<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    Order order = (Order) request.getAttribute("order");

    session.setAttribute("credit_card_order_id", order.getId());

%>

<%

    List<String> enErrors = new ArrayList<>();

    try {

        String protocol = request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/"));

        String ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();

        String url = protocol + "://" + ipAddress + ":" + request.getLocalPort() + request.getContextPath() + "/member/credit_card_back.do";     

       

        AllInOne all = new AllInOne("");

        AioCheckOutALL obj = new AioCheckOutALL();

        obj.setChoosePayment("ALL");//必須是ALL       

        obj.setClientBackURL(url);

        obj.setCreditInstallment("");

        obj.setItemName("非常好書信用卡-"+order.getId()+" "+order.getTotalAmountWithFee());

        obj.setMerchantID("2000132");//必須是2000132

        obj.setMerchantTradeDate(LocalDate.now().toString().replace('-', '/') + " " + LocalTime.now().toString().substring(0, 8));//必須是yyyy/MM/dd hh:mm:ss

        obj.setMerchantTradeNo("s2k201904"+ String.format("%011d", order.getId()));        //必須是20個英數字字元，且不得與上次訂單重複

//        obj.setPaymentType("aio");

//        obj.setRedeem("");

        obj.setReturnURL(url);       

        obj.setTotalAmount(String.valueOf((int)order.getTotalAmountWithFee()));

        obj.setTradeDesc("建立信用卡測試");

        

        String form = all.aioCheckOut(obj, null);       

        System.out.println("form = " + form);

%>

<!DOCTYPE html>

<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Credit</title>

    </head>

    <body>

        <%=form%>

    </body>

</html>

<%

    } catch (Exception e) {

        // 例外錯誤處理。

        e.printStackTrace();

        enErrors.add(e.getMessage());

    } finally {

        // 回覆錯誤訊息。

        if (enErrors.size() > 0) {

            if (!enErrors.contains(null)) {

                out.println("0|" + enErrors + "<br/>");

            } else {

                out.println("0|" + "交易失敗，請重新操作一次" + "<br/>");

            }

            out.println("<br/>");

        }

    }

%>