<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="eStoreProduct.model.admin.output.OrderValueWiseShippingCharge,java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Value Wise Shipping Charges</title>
   <link rel="stylesheet" type="text/css" href="./css/OrderValueWisePage.css">

 
    <script src="./js/OrderValueWisePage.js"></script>
 
</head>
<body>
<% List<OrderValueWiseShippingCharge> chargeList = (List<OrderValueWiseShippingCharge>) request.getAttribute("chargeList"); %>

<h3 style="text-align:center"><b>Order Value Wise Shipping Charges</b></h3><br/>
<div class="add-button">
    <a href="#" onclick="addEntryForm()">Add Entry</a>
</div>
<div id="add-form" class="add-form" style="display: none;">
    <form>
        <input type="text" id="ordvlFrom" placeholder="Order Value From" required><br>
        <input type="text" id="ordvlTo" placeholder="Order Value To" required><br>
        <input type="text" id="ordvlShippingAmount" placeholder="Shipping Amount" required><br>
        <button type="button" onclick="submitEntryForm()">Submit</button>
    </form>
</div>
<table>
    <thead>
        <tr>
            <th style="text-align: center; vertical-align: middle;">S.No</th>
            <th style="text-align: center; vertical-align: middle;">Order Value From</th>
            <th style="text-align: center; vertical-align: middle;">Order Value To</th>
            <th style="text-align: center; vertical-align: middle;">Shipping Amount</th>
            <th style="text-align: center; vertical-align: middle;">Actions</th>
        </tr>
    </thead>
    <tbody>
        <% for (OrderValueWiseShippingCharge charge : chargeList) { %>
        <tr>
            <td><%= charge.getId() %></td>
            <td><%= charge.getFrom() %></td>
            <td><%= charge.getTo()%></td>
            <td><%= charge.getShippingAmount() %></td>
            <td>
                <a href="#" class="edit-button" onclick="makeEditable(this.parentNode.parentNode)">Edit</a>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
</body>
</html>
