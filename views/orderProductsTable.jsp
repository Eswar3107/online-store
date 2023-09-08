<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.output.orderProductsModel,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OrderProducts</title>
<link rel="stylesheet" type="text/css" href="./css/orderProductsTable.css">

 
    <script src="./js/orderProductsTable.js"></script>
</head>

<body>
<%
List<orderProductsModel> orderproducts=(List<orderProductsModel>)request.getAttribute("orderproducts");
%>
<table>
    <thead>
        <tr>
            <th style="text-align: center; vertical-align: middle;">Order ID</th>
            <th style="text-align: center; vertical-align: middle;">Product Id</th>
            <th style="text-align: center; vertical-align: middle;">GST</th>
            <th style="text-align: center; vertical-align: middle;">Quantity</th>
            <th style="text-align: center; vertical-align: middle;">Price</th>
        </tr>
    </thead>
    <tbody>
        <% for (orderProductsModel viewModel : orderproducts) { %>
        <tr>
            <td><%= viewModel.getOrdr_id() %></td>
            <td><%= viewModel.getProd_id() %></td>
            <td><%= viewModel.getOrpr_gst() %></td>
            <td><%= viewModel.getOrpr_qty() %></td>
            <td><%= viewModel.getOrpr_price() %></td>
        </tr>
        <% } %>
    </tbody>
</table>
</body>
</html>
