<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.output.stockSummaryModel,java.util.List" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="ISO-8859-1">
<title>Price Review</title>
<link rel="stylesheet" type="text/css" href="./css/editablePrice.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>

$(document).ready(function() {
  showCategoriesCatalog();

  $(document).on('change', '#categoryDropdown', function(event) {
    event.preventDefault();
    var catg = $("#categoryDropdown").val();
    console.log("selected categoryyyyyy" + catg);
    retrieveCategorySpecificRecords(catg);
  });

  $(document).on('click', '#editprice-button', function(event) {
    event.preventDefault();
    var $row = $(this).closest('tr');
    var prod_id = $(this).data('prod-id');
    var prod_gstc_id = $(this).data('gstc-id');

    var prod_mrp = parseFloat($(this).data('mrp-id'));
    var prod_price2 = parseFloat($(this).data('price-id'));
    var prod_price = parseFloat($('#prodPrice-input-' + prod_id).val());

    if (prod_price > prod_mrp) {
      toastr.error("Price cannot be greater than MRP!");
      console.log("price>mrp");
    } else {
      updatePriceReview(prod_id, prod_mrp, prod_price);
      console.log("price less than mrp");
    }
  });

  function showCategoriesCatalog() {
    $.ajax({
      url: "CategoriesDropdownList",
      method: 'GET',
      success: function(response) {
        $('#categoryDropdown').html(response);
        console.log('Categories are brought');
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
  }

  function retrieveCategorySpecificRecords(catg) {
    $.ajax({
      url: "CategorySpecificRecordsForPriceReview",
      method: "GET",
      data: { catg: catg },
      success: function(response) {
        $('#tableContent').html(response);
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
  }
  function updatePriceReview(prod_id, prod_mrp, prod_price) {
	  event.preventDefault();
	  
	  // Convert the price values to floats
	  var mrp = parseFloat(prod_mrp);
	  var price = parseFloat(prod_price);
	  
	  if (price > mrp) {
	    toastr.error("Price cannot be greater than MRP!");
	    console.log("price > mrp");
	  } else {
	    $.ajax({
	      url: "updatePriceReview",
	      method: 'GET',
	      data: {
	        id: prod_id,
	        price: price,
	        mrp: mrp
	      },
	      success: function(response) {
	        $('#tableContent').html(response);
	        console.log('In the updation of master entry function');
	        toastr.success('Updated Price Successfully');
	        showCategoriesCatalog();
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
	  }
	}



});


</script>
</head>
<body>

 <h3 style="text-align:center"><b>Price Review</b></h3>
    <div class="container mt-5">
      <div class="text-left mb-3">
        <select id="categoryDropdown" class="form-control">
          <!-- Options for categories -->
        </select>
      </div>
    </div>
<div id="tableContent">
<table id="tableData" class="table table-bordered table-hover">
    <thead class="thead-dark">
        <tr>
            <th style="text-align: center; vertical-align: middle;">Product ID</th>
            <th style="text-align: center; vertical-align: middle;">Product Title</th>
            <th style="text-align: center; vertical-align: middle;">Product Category ID</th>
            <th style="text-align: center; vertical-align: middle;">Product GST Category ID</th>
            <th style="text-align: center; vertical-align: middle;">Product Brand</th>
            <th style="text-align: center; vertical-align: middle;">Product MRP</th>
            <th style="text-align: center; vertical-align: middle;">Product Price</th>
            <th style="text-align: center; vertical-align: middle;">EDIT</th>
        </tr>
    </thead>
    <tbody>
        <% List<stockSummaryModel> stock2=(List<stockSummaryModel>)request.getAttribute("stocks1"); %>
        <% for (stockSummaryModel stock : stock2) { %>
         <tr <% if (stock.getPrice() > stock.getMrp()) { %>class="warning" <% } %>>
            <td name="prod_id"><%=stock.getId()%></td>
            <td><%= stock.getTitle() %></td>
            <td><%= stock.getProductCategory() %></td>
            <td id="prodGstcId-input" name="prod_gstc_id">
                <%= stock.getHsnCode() %>
            </td>
            <td><%= stock.getBrand() %></td>
            <td id="prodMrp-input"  name="prod_mrp">
               <%= stock.getMrp() %>
            </td>
             <td>
                <input type="text" id="prodPrice-input-<%= stock.getId() %>"  name="prod_price" value="<%= stock.getPrice() %>">
            </td>
            <td>
            	 <% if (stock.getPrice() < stock.getMrp()) { %>
                  <button id="editprice-button" class="btn btn-success"  
                        data-price-id="<%= stock.getPrice() %>"
                        data-prod-id="<%= stock.getId() %>"
                        data-mrp-id="<%= stock.getMrp() %>">UPDATE</button>
                        <%}
            	 else{
                        	%>
                        	     <button id="editprice-button" class="btn btn-danger"  
                        data-price-id="<%= stock.getPrice() %>"
                        data-prod-id="<%= stock.getId() %>"
                        data-mrp-id="<%= stock.getMrp() %>">UPDATE</button>

                      <%} %>  
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>



</body>
</html>
