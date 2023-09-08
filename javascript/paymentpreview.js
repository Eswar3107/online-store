function cancelPayment(){
	 $.ajax({
         url: "cancelPayment",
         method: 'GET',
         success: function(response) {
             console.log("cancelPayment successful");
             // Handle the response if needed
         },
         error: function(xhr, status, error) {
             console.error("AJAX call error:", error);
             // Handle the error if needed
         }
     });
}

var rzp;
    var timer;

    var orderId;
    var amt;
    function showCart() {
        $.ajax({
          url: "cartDisplay",
          method: 'GET',
          success: function(response) {
        	 // window.location.href = "cart.jsp";
        	  $('#payment').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }
      
function showSpinner() {
	  var spinnerContainer = document.getElementById('spinner-container');
	  spinnerContainer.style.display = 'flex';
	}

	function hideSpinner() {
	  var spinnerContainer = document.getElementById('spinner-container');
	  spinnerContainer.style.display = 'none';
	}
	
    function openCheckout() {
		
        amt = document.getElementById("tid").value;
        console.log("amount in payment options jsp " + amt);
            function handleOrder(orderId) {
            var expirationTime = 2.5 * 60 * 1000;
            if(expirationTime<60000){
            	alert("payment page will expire in "+expirationTime/1000+" seconds");
            }else{
				alert("payment page will expire in "+expirationTime/60000+" minutes");
			}
            console.log("time started" + expirationTime);
            var options = {
                key: "rzp_test_Eu94k5nuplVQzA",
                name: "E-Cart",
                description: "SLAM payments",
                image: "https://s29.postimg.org/r6dj1g85z/daft_punk.jpg",
                prefill: {
                    name: "Adithya",
                    email: "adithya.thandra@gmail.com",
                    contact: "9290005690"
                },
                notes: {
                    address: "India",
                    merchant_order_id: orderId
                },
                theme: {
                    color: "#F37254"
                },
                order_id: orderId,
                handler: function(response) {
                	clearTimeout(timer);
                    document.getElementById('paymentReference').value = response.razorpay_payment_id;
                    document.getElementById('razorpay_order_id').value = orderId;
                    document.getElementById('razorpay_amount').value = amt;
                    // Make an AJAX request to the server-side endpoint
                    document.razorpayForm.submit();
                    
                },
                modal: {
                    ondismiss: function() {
                    	cancelPayment();
                        console.log("This code runs when the popup is closed");
                    },
                    escape: true,
                    backdropclose: false
                }
            };
           
            // Start the timer
             timer = setTimeout(function() {
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
                // Handle the expiration, e.g., display a message or take necessary action
                console.log("Payment expired.");
                //toastr.error("Payment session expired.");
                alert("Payment session expired");
                clearTimeout(timer); // Clear the timer to prevent further execution
                cancelPayment(); 
                console.log("failed");
                //alert("Restart the payment!!");
                rzp.close();
                location.reload();
              	//  window.location="/onlineStoreFinal/cartItems";
                //showCart();             
            }, expirationTime);

            rzp = new Razorpay(options);
            rzp.open();
            rzp.on('payment.failed', function(response) {
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
                console.log(response.error.code);
                console.log(response.error.description);
                console.log(response.error.source);
                console.log(response.error.step);
                console.log(response.error.reason);
                console.log(response.error.metadata.order_id);
                console.log(response.error.metadata.payment_id);
                toastr.error("Failed");
                clearTimeout(timer);
                cancelPayment();
                rzp.close();
                location.reload();
               showCart();
              
            });
        }

        /*$.ajax({
            url: "handleStockUpdation",
            method: 'GET',
            data: { amt: amt },
            success: function(response) {
            	console.log("response == " + response);
                if(response=="error"){
                	//toastr.info("stock is less than quantity ");
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
        	  
                	toastr.success("Quantity is more than stock");
                	return;
                }
                orderId = response;
                
               
                handleOrder(orderId);
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });*/
		$.ajax({
		  url: "handleStockUpdation",
		  method: 'GET',
		  data: { amt: amt },
		  success: function(response) {
		    console.log("response == " + response);
		    if (response == "error") {
		      toastr.options = {
		        closeButton: false,
		        debug: false,
		        newestOnTop: false,
		        progressBar: false,
		        positionClass: "toast-bottom-right",
		        preventDuplicates: false,
		        onclick: null,
		        showDuration: "300",
		        hideDuration: "1000",
		        timeOut: "5000",
		        extendedTimeOut: "1000",
		        showEasing: "swing",
		        hideEasing: "linear",
		        showMethod: "fadeIn",
		        hideMethod: "fadeOut"
		      };
		
		     // toastr.error("Out of stock");
		      return;
		    }
		    orderId = response;
		    handleOrder(orderId);
		  },
		  error: function(xhr, status, error) {
		    console.log('AJAX Error: ' + error);
		  }
		});

        
    }