$(document).ready(function() {
	// Function to display the modal
	$('.notifications-container').hide();
	function displayModal(modalId) {
		var modal = $('#' + modalId);
		modal.css('display', 'block');
	}


	function showNotification() {
		console.log("show notif");
		$('.notifications-container').show();
	}



	// Function to close the modal
	function closeModal(modalId) {
		var modal = $('#' + modalId);
		modal.css('display', 'none');
	}

	// Function to hide cancel and track order buttons
	function hideButtons(orderproId, orderId) {
		$('.cancel-order-btn[data-orderproid="' + orderproId + '"][data-orderid="' + orderId + '"]').hide();
		$('.track-order-btn[data-orderproid="' + orderproId + '"][data-orderid="' + orderId + '"]').hide();
		$('.view-bill-btn[data-productid="' + orderproId + '"][data-orderid="' + orderId + '"]').hide();
	}


	$('.view-bill-btn').click(function() {
		var orderId = $(this).data('orderid');
		var productId = $(this).data('productid');

		var viewBillButton = $(this);

		$.ajax({

			url: 'viewInvoice',
			type: 'GET',
			data: {
				orderId: orderId,
				productId: productId

			},

			success: function(response) {
				console.log(response)
				var dataString = response.replace('Invoice ', '');

				// Remove the brackets [ ]
				dataString = dataString.slice(1, -1);

				// Split the string into key-value pairs
				var keyValuePairs = dataString.split(', ');

				// Create an object to store the extracted values
				var invoiceData = {};

				// Iterate over the key-value pairs and extract the values
				for (var i = 0; i < keyValuePairs.length; i++) {
					var pair = keyValuePairs[i].split('=');
					var key = pair[0];
					var value = pair[1];

					// Remove any leading or trailing whitespace
					key = key.trim();
					value = value.trim();
					console.log(value + "keyyy")

					// Assign the value to the corresponding key in the invoiceData object
					invoiceData[key] = value;
				}
				$('#billNo').text(invoiceData.billNo);
				$('#orderId').text(invoiceData.orderId);
				$('#orderDate').text(invoiceData.orderDate);
				$('#paymentMode').text(invoiceData.paymentMode);
				$('#shippingAddress').text(invoiceData.shippingAddress);
				$('#shipmentDate').text(invoiceData.shipmentDate);
				$('#quantity').text(invoiceData.quantity);
				$('#gst').text(invoiceData.gst);
				$('#price').text(invoiceData.price);



				 Swal.fire({
          title: 'Invoice',
          html: '<table>' +
            '<tr><th>Pay Reference:</th><td>' + invoiceData.billNo + '</td></tr>' +
            '<tr><th>Order Date:</th><td>' +invoiceData.orderDate + '</td></tr>' +
            '<tr><th>Payment Mode:</th><td>' + invoiceData.paymentMode + '</td></tr>' +
            '<tr><th>Shipping Address:</th><td>' + invoiceData.shippingAddress + '</td></tr>' +
            '<tr><th>Shipment Date:</th><td>' +invoiceData.shipmentDate + '</td></tr>' +
           
            '<tr><th>GST:</th><td>' + invoiceData.gst + '</td></tr>' +
            '<tr><th>Price:</th><td>' + invoiceData.price + '</td></tr>' +
            '</table>',
          showConfirmButton: true,
          confirmButtonText: 'Close',
          confirmButtonColor: '#22bb33',
        });
				/*hideButtons(orderproId, orderId);*/
			},
			error: function(xhr, status, error) {
				console.log(this.url)
				// Handle any errors or display error message
			}
		});
	});

	// Event listener for cancel order button click
	$('.cancel-order-btn').click(function () {
    var orderproId = $(this).data('orderproid');
    var orderId = $(this).data('orderid');
    var cancelButton = $(this);

    // Show a confirmation dialog before canceling the order
    Swal.fire({
        title: 'Confirm Order Cancellation',
        text: 'Are you sure you want to cancel this order?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#22bb33',
        cancelButtonColor: '#cc0000',
        confirmButtonText: 'Yes, Cancel Order',
        cancelButtonText: 'No, Keep Order'
    }).then((result) => {
        if (result.isConfirmed) {
            // User clicked on "Yes, Cancel Order"
            // Send an AJAX request to the server to cancel the order
            $.ajax({
                url: 'cancelOrder',
                type: 'POST',
                data: {
                    orderproId: orderproId,
                    orderId: orderId
                },
                success: function (response) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Order Cancelled',
                        html: '<p>Your order has been cancelled successfully.</p>',
                        showConfirmButton: true,
                        confirmButtonText: 'Close',
                        confirmButtonColor: '#22bb33',
                    });

                    // Hide the cancel and track order buttons
                    hideButtons(orderproId, orderId);
                },
                error: function (xhr, status, error) {
                    // Handle any errors or display error message
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while cancelling the order. Please try again later.',
                        showConfirmButton: true,
                        confirmButtonText: 'Close',
                        confirmButtonColor: '#22bb33',
                    });
                }
            });
        }
    });
});

	// Event listener for track order button click
	$('.track-order-btn').click(function() {
		var orderproId = $(this).data('orderproid');
		var orderId = $(this).data('orderid');
		console.log("orderId:", orderId);

		$.ajax({
			url: 'trackOrder',
			type: 'GET',
			data: {
				orderproId: orderproId,
				orderId: orderId
			},
			success: function(response) {
				Swal.fire({
					title: 'Order Tracking',
					html: '<div class="shipment-status-line">' +
						'<div class="dot" style="background-color: ' + (response === 'Order_Placed' ? 'green' : 'gray') + ';"></div>' +
						'<div class="dot" style="background-color: ' + (response === 'Order Processed' ? 'green' : 'gray') + ';"></div>' +
						'<div class="dot" style="background-color: ' + (response === 'dispatched' ? 'green' : 'gray') + ';"></div>' +
						'<div class="dot" style="background-color: ' + (response === 'Out for Delivery' ? 'green' : 'gray') + ';"></div>' +
						'<div class="dot" style="background-color: ' + (response === 'delivered' ? 'green' : 'gray') + ';"></div>' +
						'</div>' +
						'<div class="shipment-status-text">' +
						'<div class="status">Order Placed</div>' +
						'<div class="status">Order Processed</div>' +
						'<div class="status">Dispatched</div>' +
						'<div class="status">Out for Delivery</div>' +
						'<div class="status">Delivered</div>' +
						'</div>',
					showConfirmButton: true,
					confirmButtonText: 'Dismiss',
					confirmButtonColor: '#22bb33',
				});
			},
			error: function(xhr, status, error) {
				// Handle the error case
			}
		});
	});


	// Function to update shipment status dots
	function updateShipmentStatus(shipmentStatus) {
		$('.dot').css('background-color', 'gray');
		console.log("track");

		var statusIndex;
		switch (shipmentStatus) {
			case 'Order_Placed':
				statusIndex = 0;
				break;
			case 'Order Processed':
				statusIndex = 1;
				break;
			case 'dispatched':
				statusIndex = 2;
				break;
			case 'Out for Delivery':
				statusIndex = 3;
				break;
			case 'delivered':
				statusIndex = 4;
				break;
			default:
				statusIndex = -1;
				break;
		}

		if (statusIndex >= 0) {
			$('.dot').eq(statusIndex).css('background-color', 'green');
		}
	}


	// Close the modal when the close button is clicked
	$('.close').click(function() {
		var modalId = $(this).closest('.modal').attr('id');
		closeModal(modalId);
	});
});