<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.output.stockSummaryModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Slam Store</title>
<link rel="stylesheet" type="text/css" href="./css/editableStocks.css">

      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="./js/editableStocks.js"></script>
</head>

<body>
<h3 style="text-align:center"><b>Manage Stocks</b></h3>
<table id="tableData" class="table table-bordered table-hover">
    <thead class="thead-dark">
        <tr>
            <th style="text-align: center; vertical-align: middle;">Product ID</th>
            <th style="text-align: center; vertical-align: middle;">Product Title</th>
            <th style="text-align: center; vertical-align: middle;">Product Category ID</th>
            <th style="text-align: center; vertical-align: middle;">Product GST Category ID</th>
            <th style="text-align: center; vertical-align: middle;">Product Brand</th>
            <th style="text-align: center; vertical-align: middle;">Image URL</th>
            <th style="text-align: center; vertical-align: middle;">Product Description</th>
            <th style="text-align: center; vertical-align: middle;">Reorder Level</th>
            <th style="text-align: center; vertical-align: middle;">Product Category Title</th>
            <th style="text-align: center; vertical-align: middle;">SGST</th>
            <th style="text-align: center; vertical-align: middle;">IGST</th>
            <th style="text-align: center; vertical-align: middle;">CGST</th>
            <th style="text-align: center; vertical-align: middle;">GST</th>
            <th style="text-align: center; vertical-align: middle;">Product Price</th>
            <th style="text-align: center; vertical-align: middle;">Product Stock</th>
            <th style="text-align: center; vertical-align: middle;">Product MRP</th>
            <th style="text-align: center; vertical-align: middle;">EDIT</th>
        </tr>
    </thead>
    <tbody>
    <% List<stockSummaryModel> stock2 = (List<stockSummaryModel>) request.getAttribute("stocks1"); %>
    <% for (stockSummaryModel stock : stock2) { %>
        <tr <% if (stock.getReorderLevel() > stock.getStock()) { %>class="warning"<% } %>>
            <td name="prod_id"><%= stock.getId() %></td>
            <td><%= stock.getTitle() %></td>
            <td><%= stock.getProductCategory() %></td>
            <td id="prodGstcId-input" name="prod_gstc_id">
                <%= stock.getHsnCode() %>
            </td>
            <td><%= stock.getBrand() %></td>
            <td>
                <input type="text" id="imageUrl-input-<%= stock.getId() %>" name="image_url" value="<%= stock.getImageUrl() %>">
            </td>
            <td>
                <input type="text" id="prodDesc-input-<%= stock.getId() %>" name="prod_desc" value="<%= stock.getDescription() %>">
            </td>
            <td>
                <input type="text" id="reorderlevel-input-<%= stock.getId() %>" name="reorderlevel" value="<%= stock.getReorderLevel() %>">
            </td>
            <td><%= stock.getPrct_title() %></td>
            <td><%= stock.getSgst() %></td>
            <td><%= stock.getIgst() %></td>
            <td><%= stock.getCgst() %></td>
            <td><%= stock.getGst() %></td>
            <td  type="text" name="prod_price"  id="prodPrice-input-<%= stock.getId() %>" >
  <%= stock.getPrice() %>
</td>            <td>
                <input type="text" id="prodStock-input-<%= stock.getId() %>" name="prod_stock" value="<%= stock.getStock() %>">
            </td>
            <td id="prodMrp-input" name="prod_mrp">
                <%= stock.getMrp() %>
            </td>
            <td>
                <button id="edit-button" class="btn btn-success" data-gstc-id="<%= stock.getHsnCode() %>"
                    data-desc-id="<%= stock.getDescription() %>" data-price-id="<%= stock.getPrice() %>"
                    data-imageurl-id="<%= stock.getImageUrl() %>" data-prod-id="<%= stock.getId() %>"
                    data-reorderlevel-id="<%= stock.getReorderLevel() %>" data-stock-id="<%= stock.getStock() %>"
                    data-mrp-id="<%= stock.getMrp() %>">UPDATE</button>
            </td>
        </tr>
    <% } %>
</tbody>
</table>
</div>

</body>
</html>