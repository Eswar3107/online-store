package eStoreProduct.controller.admin;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import eStoreProduct.DAO.admin.orderProductDAO;
import eStoreProduct.DAO.common.OrderDAO;
import eStoreProduct.model.admin.entities.orderModel;
import eStoreProduct.model.admin.input.orderProductInput;
import eStoreProduct.model.admin.output.orderProductsModel;

@Controller
public class adminShipmentsController {
	private static final Logger logger = LoggerFactory.getLogger(adminShipmentsController.class);
	private OrderDAO od;
	private orderModel om;
	// private orderProductsModel opm;
	private orderProductDAO opd;
	// orderProductsModel opmd = opm;

	@Autowired
	adminShipmentsController(OrderDAO ord, orderModel omd, orderProductDAO orderproductdao) {
		od = ord;
		om = omd;
		opd = orderproductdao;
	}

	// displayed only the orders that are processed from the orders page and not all the ordersProducts in the order is
	// not delivred or canclled .It is shipments progress page
	@GetMapping("/displayProcessedOrdersInShipments")
	public String showProcessedOrders(Model model) {
		logger.info(
				"displayed only the orders that are processed from the orders page and not all the ordersProducts in the order is not delivred or canclled .It is shipments progress page");
		List<orderModel> orders = od.getAllOrders();
		model.addAttribute("orders", orders);
		return "shipmentProgressPage";
	}

	// displaying the OrderProducts of that specfic order selected and can update its status from dropdown
	@GetMapping("/displayProcessedOrderProductsToUpdateStatus")
	public String showProcessedOrderProducts(@RequestParam(value = "orderId") int o_id, Model model) {
		System.out.println("show OrderProducts");
		logger.info(
				"displaying the OrderProducts of that specfic order selected and can update its status from dropdown");
		List<orderProductsModel> orderproducts = opd.getOrderWiseOrderProducts(o_id);
		model.addAttribute("orderproducts", orderproducts);
		return "orderProductsListPage";
	}

	// on clicking update button in model content to update shipment status of product
	@PostMapping("/updateOrderProductStatus")
	public String updateStatusOrderProducts(@Validated orderProductInput opm1, Model model) {
		System.out.println(
				"show update OrderProducts orderId" + opm1.getOrdr_id() + " product id:" + opm1.getProd_id() + "\n");
		logger.info("on clicking update button in model content to update shipment status of product");
		opd.updateOrderProductStatus(opm1);
		System.out.print("updated Op Status");
		List<orderProductsModel> orderproducts = opd.getOrderWiseOrderProducts(opm1.getOrdr_id());
		model.addAttribute("orderproducts", orderproducts);
		return "orderProductsListPage";
	}

	// displaying the orders that are shipped
	@GetMapping("/displayShippedOrders")
	public String showShippedOrders(Model model) {
		logger.info("displaying the orders that are shipped");
		List<orderModel> orders = od.getAllOrders();
		model.addAttribute("orders", orders);
		return "shipmentsShippedPage";
	}

	@PostMapping("/ShipmentsFilter")
	public String ShipmentsFilter(@RequestParam(value = "filterVal") String filter, Model model) {
		List<orderModel> orders = od.getAllOrders();
		if (filter.equals("Price")) {
			Collections.sort(orders, new Comparator<orderModel>() {
				@Override
				public int compare(orderModel o1, orderModel o2) {
					// Compare by total_gst
					return Double.compare(o1.getTotal(), o2.getTotal());
				}
			});
		} else if (filter.equals("Order_date")) {
			Collections.sort(orders, new Comparator<orderModel>() {
				@Override
				public int compare(orderModel o1, orderModel o2) {
					// Compare by total_gst
					return o1.getOrderDate().compareTo(o2.getOrderDate());
				}
			});
		}
		model.addAttribute("orders", orders);
		return "shipmentProgressPage";
	}
}
