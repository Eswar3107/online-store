<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.output.stockSummaryModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updated Price</title>
</head>
   
<body>
 


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

</body>
</html>