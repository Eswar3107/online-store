<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.entities.orderModel, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shipments </title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/shipmentProgressPage.css">
<link rel="stylesheet" type="text/css" href="./css/admin.css">
    <script src="./js/shipmentProgressPage.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


</head>
<style>
.popup {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 9999;
}

.popup-content {
  background-color: #fff;
  width: auto;
  max-width: 80%;
  padding: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

</style>
<body>



<h3 style="text-align:center"><b>Shipments in Progress</b></h3>

 <select id="OrderSorting" onchange="sortBy(this.value)">
    <option>Sort By</option>
    <option id="Price" value="Price">Price</option>
    <option id="Order_ID" value="Order_ID">Order_ID</option>
        <option id="order_date" value="Order_date">Order Date</option>
    
  </select>

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
                <th style="text-align: center; vertical-align: middle;">Shipment Date</th>
                <th style="text-align: center; vertical-align: middle;">Shipment Status</th>
            </tr>
        </thead>
        <tbody>
        <% List<orderModel> orders=(List<orderModel>)request.getAttribute("orders"); %>
        <% for (orderModel order : orders) { 
            if (order.getOrdr_processedby() != null) { 
           %>
                <tr id="update-button" data-order-id="<%= order.getId() %>">
                    <td class="orderId" data-order-id="<%= order.getId() %>"><%= order.getId() %></td>

                    <td><%= order.getOrdr_cust_id() %></td>
                    <td><%= order.getBillNumber() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= order.getTotal() %></td>
                    <td><%= order.getGst() %></td>
                    <td><%= order.getShipmentDate() %></td>
                    <td>
                        <button class="btn btn-success" id="update-button" data-order-id="<%= order.getId() %>">Update</button>
                    </td>
                </tr>
        <% }}  %>
        </tbody>
    </table>
</div>

<!-- Simple Popup -->
<div id="popup"  class="popup" style="display: none;">
<div class="popup-content">
    <h5>Update Order Status</h5>
    <div id="load-content">
        </div>
    <button class="btn btn-secondary close-button">Close</button>
    </div>
</div>

<script>
	  var orderId = 0; // Default orderId value

	  // Handle the click event of the "Update" button
	  $(document).on('click', '#update-button', function() {
	    orderId = $(this).data("order-id");
	    console.log("update button " + orderId);
	    loadOrderProductsContent(orderId);// Get the orderId from the clicked button
	   // $('#popup').show();
	  });

	 // Handle the click event of the "Close" button
	  $(document).on('click', '#popup .close-button', function() {
	    $('#popup').hide();
	  });

	  function loadOrderProductsContent(orderId) {
	    console.log("In viewing Order's Products specific to order ID: ", orderId);
	    openPopup()	;    $.ajax({
	      url: "displayProcessedOrderProductsToUpdateStatus",
	      method: 'GET',
	      data: {
	        orderId: orderId
	      }, // Pass the orderId as data
	      success: function(response) {
	        $('#load-content').html(response); // Set the response HTML as the inner HTML of the load-content div
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
	  }
	  function openPopup() {
		  document.getElementById("popup").style.display = "block";
		}

		function closePopup() {
		  document.getElementById("popup").style.display = "none";
		}

</script>
</body>
</html>

