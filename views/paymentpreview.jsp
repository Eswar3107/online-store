<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPriceForCust" %>
<%@ page import="eStoreProduct.model.customer.input.custCredModel" %>
<%@ page import="eStoreProduct.model.customer.input.productqty" %>
<%@ page import="eStoreProduct.model.customer.input.wallet" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order Summary</title>
 <style>
        /* Add the customized Toastr styles */
        .toastr-strong {
            font-weight: bold;
            color: #fff;
            background-color: #ff0000; /* Customize the background color */
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        .container {
            margin-top: 20px;
        }

        h3 {
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
            flex: 0 0 auto; /* Image should not grow or shrink */
        }

        .product-details {
            padding: 20px;
            flex-grow: 1; /* Allow the details section to grow and fill the available space */
            display: flex;
            flex-direction: column; /* Display details vertically */
            justify-content: space-between; /* Align details to top and bottom */
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

        .input-width {
            width: 50px; /* Adjust the width as per your preference */
        }
        #cont {
    background-color: #f9f9f9;
    padding: 20px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-align: center;
    margin: 0 auto;
    max-width: 700px;
}

/* Styles for the checkbox and wallet input */
#wallet {
    width: 100px;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}

#tid {
    width: 100px;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}

/* Styles for the "Proceed to Pay" button */
.pay {
    margin-top: 20px;
    background-color: #007bff;
    color: #fff;
    border-color: #007bff;
    padding: 0.5rem 1rem;
    font-size: 1rem;
    cursor: pointer;
}

.pay:hover {
    background-color: #0069d9;
    border-color: #0062cc;
}
        
    </style>
    
    <!-- <link rel="stylesheet" type="text/css" href="./css/paymentpreview.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./css/cart.css"> -->
    <script src="./js/paymentpreview.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
<br/>
   <b><h3 align="center">Order Summary</h3></b><br/>
   <div id="id1">
         <div class="container mt-5">
            <div>
                <% custCredModel cust1 = (custCredModel) session.getAttribute("customer");
               
                List<ProductStockPriceForCust> products = (List<ProductStockPriceForCust>) request.getAttribute("products");
                 wallet Wallet=(wallet) request.getAttribute("Wallet");
                for (ProductStockPriceForCust product : products) {
                %>
                <span class="product-card">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <span class="product-details">
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text">Quantity: <%= product.getQuantity() %></p>
                        <p class="card-text">Price: <%= product.getPrice() %></p>
                        <p class="card-text">Subtotal: <%= product.getQtyprice() %></p>
                        <p class="card-text">gst: <%= product.getGst() %></p>
                    </span>
                </span>
                <% } %>
            </div>
        </div>
        </div>
        <div id="cont" class="text-center">
		    <form id="shipment-form">
		        <table align="center">
		            <tr>
		                <td class="table-col2"><b>Delivery Location:</b></td>
		                <td class="table-col2"></td>
		            </tr>
		            <tr>
		                <td class="table-col1"><b>Name:</b></td>
		                <td class="table-col2"><%=cust1.getCustName()%></td>
		            </tr>
		            <tr>
		                <td class="table-col1"><b>Address:</b></td>
		                <td class="table-col2"><%=cust1.getCustSAddress()%></td>
		            </tr>
		            <tr>
		                <td class="table-col1"><b>Pincode:</b></td>
		                <td class="table-col2"><%=cust1.getCustPincode()%></td>
		            </tr>
		        </table>
		    </form>
		</div>
<br/>
       <div style="text-align: center;">
		    <label for="wallet">Use Wallet:</label>
		    
		    <input type="hidden" id="actualamt" value="<%=Wallet.getAmount()%>">
		    <input type="number" id="wallet" name="wallet" value="<%=Wallet.getAmount()%>" onchange="checkWalletAmount()">
		    <input type="checkbox" id="walletAmount" name="walletAmount" onclick="checkWalletAmount()">
		</div>
		<br/>
		<div style="text-align: center;">
		    <div style="display: inline-block; text-align: center;">
		        <label for="tid">Total Order Cost:</label>
		        <input type="number" id="tid" value="<%=ProductStockPriceForCust.getTotal()%>"  >
		    </div>
		    <br/>
		    <br/>
<!-- 		    <button class="btn btn-primary back">Back</button> -->
		    <button class="btn btn-primary pay" id="rzp-button1" onclick="openCheckout()">Proceed to Pay</button>
		</div>
		</div>


    <script>

    const tid=document.getElementById("tid").value;
    function checkWalletAmount() {
    	var useWallet = document.getElementById("walletAmount").checked;
        var amt = parseFloat(document.getElementById("actualamt").value);
        var walletInput = document.getElementById("wallet");
        var walletValue = parseFloat(walletInput.value);
       if(!useWallet){
            document.getElementById("tid").value=tid;    	   	   
       }
        if (walletValue > amt) {
            walletInput.value = amt;
            alert("Insufficient wallet amount");
        }
        else if(useWallet){
        	document.getElementById("tid").value=tid-walletValue;
        }
    }
 


 
    </script>
     <form action="invoiceLoading" method="POST" name="razorpayForm">
    
        <input id="paymentReference" type="hidden" name="paymentReference" />
        <input id="razorpay_order_id" type="hidden" name="billNumber" />
		<input id="razorpay_amount" type="hidden" name="total" />

		<input id="shippingAddress" type="hidden" name="shippingAddress" value="<%=cust1.getCustSAddress()%>" />
		<input id="customerId" type="hidden" name="ordr_cust_id" value="<%=cust1.getCustId()%>" />
		<input id="shippingPincode" type="hidden" name="shippingPincode" value="<%=cust1.getCustSpincode() %>">
    </form>
    <br/>
     <br/>
</body>
</html>
 