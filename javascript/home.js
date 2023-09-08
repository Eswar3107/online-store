function showSpinner() {
	  var spinnerContainer = document.getElementById('spinner-container');
	  spinnerContainer.style.display = 'flex';
	}

	function hideSpinner() {
	  var spinnerContainer = document.getElementById('spinner-container');
	  spinnerContainer.style.display = 'none';
	}
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
    $(document).ready(function() {
      function loadCategories() {
        loadAllProducts();
        $.ajax({
          url: "CategoriesServlet",
          method: 'GET',
          success: function(response) {
            $('#catg').html(response);
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      var currentPage = 1; // Initialize the current page

      $(window).scroll(function() {
        // Check if the user has reached the bottom of the page
        if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
          loadAllProducts(); // Call the function to load more products
        }
      });

      function loadAllProducts() {
        // Show a loading indicator or spinner here if desired
        showSpinner();
		console.log("in load products");
        // Make an AJAX request to fetch the next set of products
        $.ajax({
          url: "productsDisplay",
          method: 'GET',
          data: { page: currentPage }, // Send the current page as a parameter
          success: function(response) {
            // Hide the loading indicator or spinner here if shown
        	  hideSpinner();
            // Append the fetched products to the existing product list on the page
            $('#productsdisplay').append(response);

            // Increment the current page
            currentPage++;

            
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
            // Handle the error condition here if necessary
          }
        });
      }

      /* function loadAllProducts() {
        console.log("loadallproducts");
    	  showSpinner();
        $.ajax({
          url: "productsDisplay",
          method: 'GET',
          success: function(response) {
            $('#productsdisplay').html(response);
            hideSpinner();
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      } */
  function showWishlist() {
      if (customerSession.customer == null) {
      alert("please signIn");
    window.location.href = "signIn";
  }
        else
        {
      
        $.ajax({
          url: "wishlistItems",
          method:'GET',
          success: function(response) {
        	  console.log("response of wishlist "+response);
            $('#payment').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
        }

      }
      function addToWishlist(productId) {
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
  if (customerSession.customer == null) {
  alert("please signIn");
    window.location.href = "signIn";
      } else {
    console.log("Add to wishlist called");
    $.ajax({
      url: "addToWishlist",
      method: 'GET',
      data: { productId: productId },
      success: function(response) {
        toastr.success(response);
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
  }
}
      function addToCart(productId,quantity) {
        $.ajax({
          url: "addToCart",
          method: 'GET',
          data: { productId: productId, qty:quantity },
          success: function(response) {
            /* window.alert(response); */
            if(response=="Added to cart"){
        	  toastr.success(response);
            }else{
            	toastr.info("Already added to cart");
            }
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

    

      function removeFromCart(productId) {
        console.log("Remove from cart called");
        $.ajax({
          url: "removeFromCart",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
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
        	  toastr.success(response);
              showCart(); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function removeFromWishlist(productId) {
        console.log("Remove from wishlist called");
        $.ajax({
          url: "removeFromWishlist",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
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
        	  toastr.success(response);
        	  showWishlist(); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function showCart() {
        $.ajax({
          url: "cartDisplay",
          method: 'GET',
          success: function(response) {
        	  $('#payment').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

     

     function loadProductsByCategory() {
    	 console.log("category selected");
    	 
    	  var category=document.getElementById("catg").value;
    	  console.log("category id when loading category "+category);
    	  $.ajax({
    	      url: "categoryProducts",
    	      method: 'post',
    	      data:{category_id:category},
    	      success: function(response) {    	      
    	        $('#payment').html(response); // Set the response HTML as the inner HTML of the select element
    	        
    	      },
    	      error: function(xhr, status, error) {
    	        console.log('AJAX Error: ' + error);
    	      }
    	    });}

      // Call the loadCategories function when the page loads
      loadCategories();

      // Call the loadAllProducts function when the page loads
     // loadAllProducts();

      // Add event listener for the "Add to Cart" button
      $(document).on('click', '.addToCartButton', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        var quantity=$(this).data('quantity');
        console.log(productId);
        console.log(quantity+" quantityyyyy");
        addToCart(productId,quantity);
      });

      $(document).on('click', '.removeFromCart', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        removeFromCart(productId);
      });

      $(document).on('click', '.addToWishlistButton', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        addToWishlist(productId);
      });

      $(document).on('click', '.removeFromWishlist', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        removeFromWishlist(productId);
      });

      $('#catg').change(function() {
        loadProductsByCategory();
      });

      $('#cart-button').click(function() {
        showCart();
      });

      $('#Wishlist-button').click(function() {
        showWishlist();
      });
      
      var slides = $('.slide');
      var currentSlide = 0;

      // Function to show the current slide
      function showSlide() {
        // Hide all slides
        slides.hide();
        // Show the current slide
        slides.eq(currentSlide).show();
      }

      // Function to move to the next slide
      function nextSlide() {
        currentSlide++;
        if (currentSlide >= slides.length) {
          currentSlide = 0;
        }
        showSlide();
      }

      // Start the slideshow
      setInterval(nextSlide, 3000); // Change slide every 3 seconds
    
    function showProductDetails(productId) {
    	console.log("showproduct");   
    	$.ajax({
            type: "POST",
            url: "prodDescription",
            data: { productId: productId },
            success: function(response) {
            	 $('#payment').html(response);
            },
            error: function() {
                alert("Error occurred while retrieving product details.");
            }
        });
    }
    function sortProducts() {
    	console.log("sort");  
    	var sort=document.getElementById("sortSelect").value;
    	$.ajax({
            type: "POST",
            url: "sortProducts",
            data: { sortOrder: sort },
            success: function(response) {
            	 $('#prod').html(response);
            },
            error: function() {
                alert("Error occurred while sorting product details.");
            }
        });
    }
    function filterProducts() {
    	console.log("filters");   
    	var filter=document.getElementById("filterSelect").value;
    	$.ajax({
            type: "POST",
            url: "filterProducts",
            data: { priceRange: filter },
            success: function(response) {
            	 $('#payment').html(response);
            },
            error: function() {
                alert("Error occurred while filtering product details.");
            }
        });
    }
    $('#searchbtn').on('click', function(event) {
  	  event.preventDefault();
  	  search();
  	});

  	$('#search').keypress(function(event) {
  	  if (event.which === 13) {
  	    event.preventDefault();
  	    search();
  	  }
  	});

  	$('#search').on('input', function() {
  	  var searchTerm = $(this).val();
  	  $.ajax({
  	    type: "GET",
  	    url: 'SearchSuggestions',
  	    data: { search: searchTerm },
  	    success: function(response) {
  	      var suggestions = $('#suggestions');
  	      suggestions.empty(); // Clear existing suggestions

  	      // Iterate over the response and add each suggestion as an <option> element
  	      response.forEach(function(suggestion) {
  	        suggestions.append('<option value="' + suggestion + '">' + suggestion + '</option>');
  	      });
  	    },
  	    error: function() {
  	      alert("Error occurred while retrieving search suggestions.");
  	    }
  	  });
  	});
  });
  function search() {
	  var searchTerm = document.getElementById("search").value;
	  $.ajax({
	    type: "GET",
	    url: 'searchProducts',
	    data: { search: searchTerm },
	    success: function(response) {
	      $('#payment').html(response);
	    },
	    error: function() {
	      alert("Error occurred while filtering product details.");
	    },
	    complete: function() {
	      // Clear the search input after the search is completed
	      $('#search').val('');
	    }
	  });
	}