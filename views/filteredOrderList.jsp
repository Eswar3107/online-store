<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.entities.orderModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order List</title>
<link rel="stylesheet" type="text/css" href="./css/filteredOrderList.css">

 
    <script src="./js/filteredOrderList.js"></script>

</head>
<body>

<div class="container mt-5">
    <table id="tableData" class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr>
                <th style="text-align: center; vertical-align: middle;">Order ID</th>
                <th style="text-align: center; vertical-align: middle;">Customer ID</th>
                <th style="text-align: center; vertical-align: middle;">Bill Number</th>
                <th style="text-align: center; vertical-align: middle;">Order Date</th>
                <th style="text-align: center; vertical-align: middle;">Total</th>
                <th style="text-align: center; vertical-align: middle;">GST</th>
                <th style="text-align: center; vertical-align: middle;">Payment Reference</th>
                <th style="text-align: center; vertical-align: middle;">Payment Mode</th>
                <th style="text-align: center; vertical-align: middle;">Payment Status</th>
                <th style="text-align: center; vertical-align: middle;">Shipping Address</th>
                <th style="text-align: center; vertical-align: middle;">Shipping Pincode</th>
                <th style="text-align: center; vertical-align: middle;">Shipment Status</th>
                <th style="text-align: center; vertical-align: middle;">Shipment Date</th>
                <th style="text-align: center; vertical-align: middle;">Processed By</th>
            </tr>
        </thead>
        <tbody>
         <% List<orderModel> orders=(List<orderModel>)request.getAttribute("orders"); %>
            <% for (orderModel order : orders) { %>
            <tr>
                <td><%= order.getId() %></td>
                <td><%= order.getOrdr_cust_id() %></td>
                <td><%= order.getBillNumber() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getTotal() %></td>
                <td><%= order.getGst() %></td>
                <td><%= order.getPaymentReference() %></td>
                <td><%= order.getPaymentMode() %></td>
                <td><%= order.getPaymentStatus() %></td>
                <td><%= order.getShippingAddress() %></td>
                <td><%= order.getShippingPincode() %></td>
                <td><%= order.getShipment_status() %></td>
                <td><%= order.getShipmentDate() %></td>
                <td>
                    <% if (order.getOrdr_processedby() == null) { %>
                        <button id="red-button" class="btn btn-danger" data-order-id="<%= order.getId() %>">Unprocessed</button>
                    <% } else { %>
                        <button class="btn <%= (order.getOrdr_processedby().equals("NULL")) ? "btn-danger" : "btn-success" %>" data-order-id="<%= order.getId() %>"><%= order.getOrdr_processedby() %></button>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
