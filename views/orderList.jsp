<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%@ page import="eStoreProduct.model.admin.entities.orderModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order List</title>

<link rel="stylesheet" type="text/css" href="./css/orderList.css">

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


   <!--  <script src="./js/orderList.js"></script> -->
   
   <script>
   


   function applyDateFilter() {
             console.log("Filter orders through dates");
               var startDate = document.getElementById("startDate").value;
               var endDate = document.getElementById("endDate").value;
               $.ajax({
                   url: "FilterOrdersThroughDates",
                   method: 'POST',
                   data: { startDate: startDate,
                   		endDate: endDate
                   	 }, // Pass the orderId as data
                   success: function (response) {
                       $('#content').html(response); // Set the response HTML as the inner HTML of the orderproducts container
                   },
                   error: function (xhr, status, error) {
                       console.log('AJAX Error: ' + error);
                   }
               });

             
           }
       function setMinEndDate() {
       var startDate = document.getElementById("startDate").value;
       document.getElementById("endDate").min = startDate;
   }


   var tokenElement = document.getElementById("tokenHolder");
   var token = tokenElement.innerText;
   // Use the "token" variable in your JavaScript code
   console.log("Token: " + token);

   var tokenElement1 = document.getElementById("tokenHolder1");
   var token1 = tokenElement1.innerText;
   // Use the "token" variable in your JavaScript code
   console.log("Token1: " + token1);


   var pageElement = document.getElementById("pageHolder");
   var page = pageElement.innerText;
   // Use the "page" variable in your JavaScript code
   console.log("page: " + page);


   var isProcessing = false;
   $(document).ready(function() {
     // Bind the click event to the #red-button element
     $(document).on('click', '#red-button', function(event) {
       event.preventDefault();
       var orderId = $(this).data('order-id');
       console.log('Clicked button with order ID:', orderId);
       if (!isProcessing) {
       isProcessing = true; // Set the flag to true before making the AJAX call
   }
       processOrder(orderId, token, page);
     });
   });
   	 
   	 function processOrder(orderId,token,page){
   	    toastr.options = {
   		  "closeButton": false,
   		  "debug": false,
   		  "newestOnTop": false,
   		  "progressBar": false,
   		  "positionClass": "toast-bottom-right",
   		  "preventDuplicates": false,
   		  "onclick": null,
   		  "showDuration": "300",
   		  "hideDuration": "1000",
   		  "timeOut": "5000",
   		  "extendedTimeOut": "1000",
   		  "showEasing": "swing",
   		  "hideEasing": "linear",
   		  "showMethod": "fadeIn",
   		  "hideMethod": "fadeOut"
   		}; 
   	 //showSpinner();
   	 	 $.ajax({ 	 
   		      url: "processOrders",
   		      method: 'GET',
   		      data: { orderId: orderId,
   		    	  adminId:1,
   		    	  token:token,
   		    	  page:page
   		    	 },
   		      success: function(response) {
   		     // //hideSpinner();
   		    	  $('#content').html(response);
   		    	  console.log('orders processing nowwww');
   		    	  //toastr.success('Order has been processed');
   		    	  isProcessing = false; 
   		      },
       error: function(xhr, status, error) {
         console.log('AJAX Error: ' + error);
         isProcessing = false; // Reset the flag to false in case of an error
       }
   		    });
   	 	}
   	 
   	 






   function processedStatusFilter() {
     var processedStatusFilter = $('#processedStatusFilter').val();
   	console.log('im here in status filtering');
     if (processedStatusFilter === 'unprocessed') {
       getUnprocessedOrders();
     } else if (processedStatusFilter === 'processed') {
       getProcessedOnlyOrders();
     } else {
       getAllOrders();
     }
   }


   function getAllOrders() {
   //showSpinner();
     // Send an AJAX request to retrieve unprocessed orders
     $.ajax({
       url: 'listOrders',
       method: 'GET',
       success: function(response) {
         // Handle the response and update the order list
        // hideSpinner();
         $('#content').html(response);
       },
       error: function(xhr, status, error) {
         console.log('AJAX Error: ' + error);
       }
     });
   }

   function getUnprocessedOrders() {
   //showSpinner();
     // Send an AJAX request to retrieve unprocessed orders
     $.ajax({
       url: 'unprocessedOrders',
       method: 'GET',
       success: function(response) {
         // Handle the response and update the order list
        // hideSpinner();
         $('#content').html(response);
       },
       error: function(xhr, status, error) {
         console.log('AJAX Error: ' + error);
       }
     });
   }



   function getProcessedOnlyOrders() {
   //showSpinner();
     // Send an AJAX request to retrieve processed orders
     $.ajax({
       url: 'processedOnlyOrders',
       method: 'GET',
       success: function(response) {
         // Handle the response and update the order list
         //hideSpinner();
         $('#content').html(response);
       },
       error: function(xhr, status, error) {
         console.log('AJAX Error: ' + error);
       }
     });
   }

   var tokenElement = document.getElementById("tokenHolder");
   var token = tokenElement.innerText;
   // Use the "token" variable in your JavaScript code
   console.log("Token: " + token);


   var tokenElement1 = document.getElementById("tokenHolder1");
   var token1 = tokenElement1.innerText;
   // Use the "token" variable in your JavaScript code
   console.log("Token1: " + token1);

   var pageElement = document.getElementById("pageHolder");
   var page = pageElement.innerText;
   // Use the "page" variable in your JavaScript code
   console.log("page: " + page);



   function navigateToPage(page) {
   //showSpinner();
     var nextPage = parseInt(page) + 1;
     nextPage -= 1;
     console.log('in navigation next', nextPage);
     /*window.location.href = "/listOrders?page=" + nextPage;*/

     $.ajax({
       url: "listOrdersForPagination",
       method: 'GET',
       data: { nextPage: nextPage,
       token:token,
       token1:token1 },
       success: function(response) {
        // hideSpinner();
         $('#content').html(response);
       },
       error: function(xhr, status, error) {
         console.log('AJAX Error: ' + error);
       }
     });
   }




   $(document).on('click', '#viewStatisticsBtn', function() {
     // Retrieve the order data from the server
     $.ajax({
       url: 'ordersForStatistics', // Replace with your actual server endpoint URL
       method: 'GET',
       success: function(data) {
         // Create the order statistics
         console.log('statistics inside');
         createOrderChart(data);

         // Show the statistics modal
         $('#statisticsModal').modal('show');
       },
       error: function(xhr, status, error) {
         console.log('AJAX Error: ' + error);
       }
     });
   });

   function createOrderChart(data) {
     const orderDates = data.map(order => order.orderDate);
     const orderCounts = countOrdersByDate(data);

     const formattedDates = orderDates.map(date => formatDateLabel(date));

     const orderChartCtx = document.getElementById('orderChart').getContext('2d');
     const orderChart = new Chart(orderChartCtx, {
       type: 'line',
       data: {
         labels: formattedDates,
         datasets: [
           {
             label: 'Number of Orders',
             data: orderCounts,
             backgroundColor: 'rgba(75, 192, 192, 0.5)',
             borderColor: 'rgba(75, 192, 192, 1)',
             borderWidth: 1
           }
         ]
       },
       options: {
         scales: {
           x: {
             ticks: {
               maxTicksLimit: 10
             }
           },
           y: {
             beginAtZero: true
           }
         }
       }
     });
   }
   function formatDateLabel(value, format) {
     const date = new Date(value);
     let day = date.getDate().toString();
     let month = (date.getMonth() + 1).toString();
     const year = date.getFullYear().toString();

     if (format === 'mm/dd/yy') {
       // Swap day and month
       [day, month] = [month, day];
     }

     // Pad with leading zero if needed
     if (day.length === 1) {
       day = '0' + day;
     }
     if (month.length === 1) {
       month = '0' + month;
     }

     return `${day}/${month}/${year}`;
   }

   function countOrdersByDate(data) {
     const orderCounts = {};
     data.forEach(order => {
       const orderDate = order.orderDate;
       if (orderCounts[orderDate]) {
         orderCounts[orderDate]++;
       } else {
         orderCounts[orderDate] = 1;
       }
     });
     return Object.values(orderCounts);
   }

   
   </script>
   
   
</head>
<body>
<%String s=(String)request.getAttribute("token"); %>
 <p id="tokenHolder" style="display: none;"><%=s %></p>
 <%String s1=(String)request.getAttribute("token1"); %>
 <p id="tokenHolder1" style="display: none;"><%=s1 %></p>
 <% 
   int p = 0;
   Integer pageAttr = (Integer)request.getAttribute("page");
   if (pageAttr != null && pageAttr instanceof Integer) {
       p = (int) pageAttr;
   }
%>
<p id="pageHolder" style="display: none;"><%= p %></p>
 </p>

<div id="spinner-container">
  <div id="spinner"></div>
</div>
<div class="container mt-5">
    <br/>
    <h3 style="text-align:center"><b>Orders</b></h3><br/>
    <div class="filters">
      
        <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" onchange="setMinEndDate()">
            <label for="endDate">End Date:</label>
        <input type="date" id="endDate" name="endDate">
        <button onclick="applyDateFilter()">Apply Filters</button>
        
  
        <label for="processedStatusFilter">Processed Status Filter:</label>
        <% if (s != null && s.equals("All")){ %>
        <select id="processedStatusFilter" onchange="processedStatusFilter()">
            <option id="All" value="All">All</option>
            <option id="processed" value="processed">Processed</option>
            <option id="unprocessed" value="unprocessed">Unprocessed</option>
        </select>
        <%} %>
        <%if(s != null && s.equals("ProcessedPaginationToken")){ %>
        <select id="processedStatusFilter" onchange="processedStatusFilter()">
        <option id="processed" value="processed">Processed</option>
            <option id="All" value="All">All</option>
            <option id="unprocessed" value="unprocessed">Unprocessed</option>
        </select>
        <%} %>
        <%if(s != null && s.equals("UnProcessedPaginationToken")){ %>
        <select id="processedStatusFilter" onchange="processedStatusFilter()">
        	 <option id="unprocessed" value="unprocessed">Unprocessed</option>
            <option id="All" value="All">All</option>
            <option id="processed" value="processed">Processed</option>
        </select>
        <%} %>
        
       
    </div>
    <div class="container mt-5">
    <!-- Existing code -->
    
    <button id="viewStatisticsBtn" class="btn btn-primary">View Statistics</button>
    
</div>
</div>

<div class="container mt-5">
    <table id="tableData" class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr  class="order-row" >
                <th style="text-align: center; vertical-align: middle;">Order ID</th>
                <th style="text-align: center; vertical-align: middle;">Customer ID</th>
                <th style="text-align: center; vertical-align: middle;">Payment Id</th>
                <th style="text-align: center; vertical-align: middle;">Order Date</th>
                <th style="text-align: center; vertical-align: middle;">Total</th>
                <th style="text-align: center; vertical-align: middle;">GST</th>
                <th style="text-align: center; vertical-align: middle;">Payment Reference</th>
                <th style="text-align: center; vertical-align: middle;">Payment Mode</th>
                <th style="text-align: center; vertical-align: middle;">Payment Status</th>
                <th style="text-align: center; vertical-align: middle;">Shipment Status</th>
                <th style="text-align: center; vertical-align: middle;">Shipping Address</th>
                <th style="text-align: center; vertical-align: middle;">Shipping Pincode</th>
         
                <th style="text-align: center; vertical-align: middle;">Shipment Date</th>
                <th style="text-align: center; vertical-align: middle;">Processed By</th>
            </tr>
        </thead>
        <tbody>
         <% List<orderModel> orders=(List<orderModel>)request.getAttribute("orders"); %>
            <% for (orderModel order : orders) {%>
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
                 <td><%= order.getShipment_status() %></td>
                <td><%= order.getShippingAddress() %></td>
                <td><%= order.getShippingPincode() %></td>
           
                <td><%= order.getShipmentDate() %></td>
                <td>
                    <% if (order.getOrdr_processedby() == null) { %>
                        <button id="red-button"  class="btn btn-danger" data-order-id="<%= order.getId() %>">Unprocessed</button>
                    <% } else { %>
                        <button class="btn <%= (order.getOrdr_processedby() == null) ? "btn-danger" : "btn-success" %>" data-order-id="<%= order.getId() %>"><%= order.getOrdr_processedby() %></button>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
        
    </table>
    
    <div class="pagination">
    <c:if test="${page > 0}">
        <a href="javascript:navigateToPage(${page - 1})">Previous</a>
    </c:if>
    
    <c:forEach var="pageNumber" begin="0" end="${totalPages - 1}">
        <c:choose>
            <c:when test="${pageNumber == page}">
                <span class="current-page">${pageNumber + 1}</span>
            </c:when>
            <c:otherwise>
                <a href="javascript:navigateToPage(${pageNumber})">${pageNumber + 1}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <c:if test="${page < totalPages - 1}">
        <a href="javascript:navigateToPage(${page + 1})">Next</a>
    </c:if>
</div>
</div>


<!-- Modal -->
<div id="statisticsModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Orders Statistics</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <canvas id="orderChart" width="400" height="200"></canvas>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>



 


</body>
</html>