
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="eStoreProduct.model.admin.entities.orderModel,java.util.*"%>

<!DOCTYPE html>
<html>
  <div id="tab">
<head>
    
    <title>Slam Store</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/GSTReports.css">

 
    <script src="./js/GSTReports.js"></script>
  
</head>
<body>
<br/>
<h3 style="text-align:center"><b>GST Reports</b></h3><br/>
<div>
        <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" onchange="setMinEndDate()">
            <label for="endDate">End Date:</label>
        <input type="date" id="endDate" name="endDate">
        <button onclick="applyFilters()">Apply Filters</button>
        
    </div>
  
<%List<orderModel> orders=(List<orderModel>)request.getAttribute("orders");
if(orders.size()>0){
//System.out.println("jello\n"+orders.get(0).getGst());%>

    <table>
        <thead>
            <tr>
                <th style="text-align: center; vertical-align: middle;">Order ID</th>
                <th style="text-align: center; vertical-align: middle;">Customer ID</th>
                <th style="text-align: center; vertical-align: middle;">Bill Number</th>
                <th style="text-align: center; vertical-align: middle;">Order Date</th>
                <th style="text-align: center; vertical-align: middle;">Total</th>
                <th style="text-align: center; vertical-align: middle;">GST</th>
                <th style="text-align: center; vertical-align: middle;">Payment Reference</th>
              <!--   <th>Payment Mode</th>
                <th>Payment Status</th>
                <th>Shipping Pincode</th> -->
                <th style="text-align: center; vertical-align: middle;">Processed By</th>
            </tr>
        </thead>
        <tbody>
        <% double gstTotal = 0;
        double grandTotal = 0;
        for (orderModel viewModel : orders) {
            gstTotal += viewModel.getGst();
            grandTotal += viewModel.getTotal();
        %>
            <tr onclick="toggleDropdownGST('<%= viewModel.getId() %>')">
                <td><%= viewModel.getId() %></td>
                <td><%= viewModel.getOrdr_cust_id() %></td>
                <td><%= viewModel.getBillNumber() %></td>
                <td><%= viewModel.getOrderDate() %></td>
                <td><%= viewModel.getTotal() %></td>
                <td><%= viewModel.getGst() %></td>
                <td><%= viewModel.getPaymentReference() %></td>
              <%--   <td><%= viewModel.getPaymentMode() %></td>
                <td><%= viewModel.getPaymentStatus() %></td>
                <td><%= viewModel.getShippingPincode() %></td> --%>
                <td><%= viewModel.getOrdr_processedby() %></td>
            </tr>
            <tr>
                <td colspan="11" class="dropdown-content" id="dropdown-<%= viewModel.getId() %>">
                    <!-- Dropdown content here -->
                    <div id="orderproducts-<%= viewModel.getId() %>"></div> <!-- Container to hold the order products -->
                </td>
            </tr>
        <% } %>
            <tr class="total-row">
                <td colspan="4">Total</td>
                <td><%= grandTotal %></td>
                <td><%= gstTotal %></td>
                <td colspan="5"></td>
            </tr>
        </tbody>
    </table>
    <%}
	else{%>
		<p align="center">There are no orders in this time period</p>
	<%}
		%>
</body>
    </div>

</html>
