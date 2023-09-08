<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPriceForCust" %>
<%@ page import="eStoreProduct.model.customer.input.custCredModel" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
       <!--  <link rel="stylesheet" type="text/css" href="./css/cart.css"> -->
       <style>
        /*  body {
            font-family: Arial, sans-serif;
      		margin: 0;
      		padding: 0;
            background-color: #f2f2f2;
        } */

        .container {
            margin-top: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .product-card {
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: box-shadow 0.3s;
            cursor: pointer;
            margin-bottom: 20px;
            display: flex;
        }

        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            width: 200px;
            height: 200px;
            object-fit: cover;
        }

        .product-details {
            padding: 20px;
            flex-grow: 1;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        .product-description {
            font-size: 14px;
            margin-bottom: 10px;
            color: #666;
        }
		/* #pcd{
		  flex: 0 0 auto;
		  width: 25%;
		} */
		#btn{
		  flex: 0 0 auto;
		  width: 25%;
		}
        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #e91e63;
        }
         .input-button-container {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		  }
		
		  .input-button-container .form-control {
		    margin-right: -10px; /* Adjust the margin as needed */
		  }
		   .not-available {
        color: red;
        font-style: italic;
    }

    .available {
        color: green;
    }
    .input-width{
    width: 50px; /* Adjust the width as per your preference */
}
       </style>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="./js/cart.js"></script>
     
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            <%-- Iterate over the products and render the HTML content --%>
            <%		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
           			 List<ProductStockPriceForCust> products;
    		if (cust1 != null) {
               products = (List<ProductStockPriceForCust>) request.getAttribute("products");
    		} else {
                products = (List<ProductStockPriceForCust>) request.getAttribute("alist");
			}
    		if(products==null){ %>
    			<div>No Cart Items</div> <%
            }else{
        
				double totalcost=0.0;
                for (ProductStockPriceForCust product : products) {
            %>
             <div class="product-card">
                            <a href="javascript:void(0)" onclick="showProductDetails('<%= product.getProd_id() %>')">
                                <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                            </a>
                            <div class="product-details">
			                   <h5 class="card-title"><%= product.getProd_title() %></h5>
							   <%-- <p class="card-text"><%= product.getProd_desc() %></p> --%>
		                       <% if (product.getProduct_stock() <= 5 && product.getProduct_stock() > 0) { %>
								    <input type="hidden" id="stockval" value="<%= product.getProduct_stock() %>">
								    <p class="card-text"><i><b>Only <%= product.getProduct_stock() %> are left..Hurry Up!! </b></i></p>
								<% }else if(product.getProduct_stock()>5){
			                    	
			                    }  else { %>
								    <b><p class="stockp">Out of Stock</p></b>
								    <script>
								    	disableBuyNow();
								    </script>
								<% } %>

					            <p class="card-text"><%= product.getPrice() %></p>
					            <label>Qty:</label>

    <span class="input-group-btn">
        <button class="btn btn-primary btn-minus" type="button" onclick="decreaseQuantity(this)">
            <i class="fa fa-minus"></i>
        </button>
    </span>
    <input type="text" class="btn btn-primary qtyinp input-width" id="qtyinp" value="<%=product.getQuantity() %>" min="1" onchange="updateQuantity(this)" data-product-id="<%= product.getProd_id() %>">
    <span class="input-group-btn">
        <button class="btn btn-primary btn-plus" type="button" onclick="increaseQuantity(this)">
            <i class="fa fa-plus"></i>
        </button>
    </span>
<br>
<br>
                        <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                </div>
                
            </div>
            <%
                }
            %>
        </div>
    </div>
    
 <div align="center" class="container mt-3">
  <div id="checkpincode" class="row justify-content-center">
   <div>
        <p id="availability"></p>

        <form id="shipment-form">
            <p id="ship"></p>
            <table class="shipment-table">
                <tr>
                    <td>Delivery Location:</td>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td><input type="text" id="custName" name="custName" value="${cust != null ? cust.custName : ""}"></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><input type="text" id="custSAddress" name="custSAddress" value="${cust != null ? cust.custSAddress : ""}"></td>
                </tr>
                <tr>
                    <td>Pincode:</td>
                    <td>
<input type="number" class="custPincode" id="custPincode" name="custPincode" value="${cust != null ? cust.custSpincode: ""}"  oninput="checkPincodeAvailability(this.value);">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button class="btn btn-primary changeaddress" type="submit">Change Address</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
  </div>
  <br/>
  <div id="tcost"></div>
  <b><p id="outOfStockMsg"></p></b>
  <button class="btn btn-primary BuyNow" id="BuyNow" onclick="buynow()">Place Order</button>
</div>
 <%
                }
    		
   %>
   <br/>
<br/>
      <br/>
</body>
</html>
 
 
