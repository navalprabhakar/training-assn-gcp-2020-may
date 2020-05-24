package com.navalprabhakar.training.gcp.order;

import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/orders")
public class OrderController {

	private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService userService;

	@GetMapping("/{order-id}")
	public Order findOrderByOrderId(@PathVariable("order-id") Long orderId) {
		LOGGER.debug("New request for userid- {}", orderId);
		return userService.findOrderByOrderId(orderId);
	}

	@GetMapping("/all")
	public List<Order> findOrderByRequestParam(@RequestParam("user-id") Long userId) {
		List<Order> orders = null;
		if (userId != null) {
			orders = userService.findOrdersByUserId(userId);
		} else {
			orders = Collections.emptyList();
		}
		if(CollectionUtils.isEmpty(orders)) {
			throw new RuntimeException("No Orders found");
		}
		return orders;
	}
}
