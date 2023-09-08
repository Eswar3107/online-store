<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" 
    import="eStoreProduct.model.admin.entities.orderModel,eStoreProduct.model.customer.input.custCredModel"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<meta charset="ISO-8859-1">
<%orderModel om=(orderModel)request.getAttribute("om");
custCredModel cust=(custCredModel) session.getAttribute("customer");
%>

<script>
$(document).ready(function() {
   var billNum="<%=om.getBillNumber()%>";
   var paymentReference="<%=om.getPaymentReference()%>";
   var total="<%=om.getTotal()%>";
   

    	$.ajax({
            type: "POST",
            url: "invoice",
            data: { paymentReference:paymentReference,
            	billNumber:billNum,
            	total:total
            	},
            success: function(response) {
            	 $('#invoiceDisp').html(response);
            },
            error: function() {
                alert("Error occurred while retrieving product details.");
            }
        });
    });
</script>
<style>
		body {
			text-align: center;
			font-family: Arial, sans-serif;
		}

		#invoiceDisp {
			margin-top: 50px;
		}

		h1 {
			color: #007bff;
		}

		h3 {
			color: #333;
		}
	</style>
</head>
<body style="text-align:center">
<div id="invoiceDisp">
	<h1>Invoice is generating..</h1>
	<h3>Invoice will be mailed to you</h3><br/>
	<img src="https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.foxite.com%2Farchives%2Fprocessing-gif-0000440907.htm&psig=AOvVaw11CxT78aZ4rVDBpZnonzSx&ust=1690447667053000&source=images&cd=vfe&opi=89978449&ved=0CA0QjRxqFwoTCOir3_79q4ADFQAAAAAdAAAAABAg" alt="Processing..." />
</div>
</body>
</html>
