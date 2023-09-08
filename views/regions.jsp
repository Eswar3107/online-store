<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="eStoreProduct.model.admin.output.RegionsOutput, java.util.List" %>
    
<!DOCTYPE html>
<html>

<head>
<!-- <link rel="stylesheet" type="text/css" href="./css/regions.css"> -->
    <meta charset="ISO-8859-1">
    <title>Region List</title>
    
    <style>
    body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        margin: 20px;
    }

    h1 {
        text-align: center;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #f5f5f5;
    }

    .add-button {
        margin-bottom: 10px;
        text-align: center;
    }

    .add-button a {
        display: inline-block;
        padding: 8px 12px;
        background-color: #4CAF50;
        color: #fff;
        text-decoration: none;
        border-radius: 4px;
    }

    .add-button a:hover {
        background-color: #45a049;
    }

    form {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 30px;
    }

    form input[type="text"], form input[type="button"] {
        padding: 8px;
        margin-right: 10px;
    }

    form input[type="button"] {
        background-color: #4CAF50;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    form input[type="button"]:hover {
        background-color: #45a049;
    }

    /* Additional styles for the 'remove' button */
    .removereg {
        background-color: #f44336;
        color: #fff;
        border: none;
        padding: 6px 12px;
        border-radius: 4px;
        cursor: pointer;
    }

    .removereg:hover {
        background-color: #d32f2f;
    }

    /* Optional: Center the table */
    table {
        margin: 0 auto;
    }
</style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
  /*   $(document).on('click', '.add-region', function(event) {
	    event.preventDefault();
	   console.log("enteredadd-region");
	    addRegion();
 }); */
 function add(){
	 console.log("enteredadd-region");
	    addRegion();
 }
 
function addRegion(){
	console.log("in displayShippingConfig");
	var regionName = document.getElementById("name").value;
		var regionPinFrom = document.getElementById("pinFrom").value;
		var regionPinTo = document.getElementById("pinTo").value;
		var regionSurcharge = document.getElementById("surCharge").value;
		var regionPriceWaiver = document.getElementById("priceWavier").value;
	  $.ajax({
	      url: "addRegion",
	      method: 'POST',
	      data:{
	    	 regionId:1,
	  		regionName: regionName,
	  		regionPinFrom : regionPinFrom,
	  		regionPinTo : regionPinTo,
	  		regionSurcharge : regionSurcharge,
	  		regionPriceWaiver : regionPriceWaiver
	      },
	      success: function(response) {
	      console.log(response) ;
	      dis();// Set the response HTML as the inner HTML of the select element
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    }); 
}
/* $(document).on('click', '.removereg', function(event) {
    event.preventDefault();
   console.log("enteredadd-region");
    remRegion();
}); */
function removereg(id){
	//var regionName = document.getElementById("name").value;
	 console.log(id);
	 $.ajax({
	      url: "remRegion",
	      method: 'POST',
	      data:{
	    	 regionId:id
	      },
	      success: function(response) {
	      console.log(response);
	      	// Set the response HTML as the inner HTML of the select element
	      dis();
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    }); 
}
function dis(){
	 $.ajax({
	      url: "ShippingRedirect",
	      method: 'GET',
	      success: function(response) {
	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
}

    </script>
</head>
<div id="content">
<body>
<br/>
<h3 style="text-align:center"><b>Regions List</b></h3><br/>
<form>
<input id="name" placeholder="Name" type="text">
<input id="pinFrom" placeholder="Pin-From" type="text">
<input id="pinTo" placeholder="Pin-To" type="text">
<input id="surCharge" placeholder="Surcharge" type="text">
<input id="priceWavier" placeholder="Price Wavier" type="text">
<input type="button" value="   Add   " onclick="addRegion()">
</form>

    <table>
        <tr>
            <th>Region Name</th>
            <th>Pin From</th>
            <th>Pin To</th>
            <th>Surcharge</th>
            <th>Price Waiver</th>
            <th>          </th>
        </tr>
        <%-- Iterate over the list of regions and generate table rows --%>
        <%
            List<RegionsOutput> regions = (List<RegionsOutput>) request.getAttribute("regionList");

            for (RegionsOutput region : regions) {
        %>
        <tr>
            <td><%= region.getRegionName() %></td>
            <td><%= region.getRegionPinFrom() %></td>
            <td><%= region.getRegionPinTo() %></td>
            <td><%= region.getRegionSurcharge() %></td>
            <td><%= region.getRegionPriceWaiver() %></td>
            <td><button onclick='removereg("<%= region.getRegionId() %>")' class="removereg">remove</button></td>
        </tr>
        <%-- End of loop --%>
        <% } %>
    </table>
</body>
</div>
</html>















<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="eStoreProduct.model.admin.output.RegionsOutput, java.util.List" %>
    
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Region List</title>
    
    
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" type="text/css" href="./css/regions.css">

 
    <script src="./js/regions.js"></script>
   
</head>
<div id="content">
<body>
<br/>
<h3 style="text-align:center"><b>Shipping Area Configuration</b></h3>
<br/>
<form>
<input id="name" placeholder="name" type="text">
<input id="pinFrom" placeholder="pinFrom" type="text">
<input id="pinTo" placeholder="pinTo" type="text">
<input id="surCharge" placeholder="surCharge" type="text">
<input id="priceWavier" placeholder="priceWavier" type="text">
</form>
<div class="add-button">
        <a class="add-region">Add Region</a>
    </div>
    <table>
        <tr>
            <!-- <th style="text-align: center; vertical-align: middle;">Region ID</th> -->
            <th style="text-align: center; vertical-align: middle;">Region Name</th>
            <th style="text-align: center; vertical-align: middle;">Pin From</th>
            <th style="text-align: center; vertical-align: middle;">Pin To</th>
            <th style="text-align: center; vertical-align: middle;">Surcharge</th>
            <th style="text-align: center; vertical-align: middle;">Price Waiver</th>
            <th >         </th>
        </tr>
        Iterate over the list of regions and generate table rows
        <%
            List<RegionsOutput> regions = (List<RegionsOutput>) request.getAttribute("regionList");

            for (RegionsOutput region : regions) {
        %>
        <tr>
            <td><%= region.getRegionId() %></td>
            <td><%= region.getRegionName() %></td>
            <td><%= region.getRegionPinFrom() %></td>
            <td><%= region.getRegionPinTo() %></td>
            <td><%= region.getRegionSurcharge() %></td>
            <td><%= region.getRegionPriceWaiver() %></td>
            <td><button onclick='removereg("<%= region.getRegionId() %>")' class="removereg">remove</button></td>
        </tr>
        End of loop
        <% } %>
    </table>
</body>
</div>
</html> --%>