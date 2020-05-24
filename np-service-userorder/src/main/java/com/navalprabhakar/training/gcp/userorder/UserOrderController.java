package com.navalprabhakar.training.gcp.userorder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/userorder")
public class UserOrderController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserOrderController.class);

	@Autowired
	private UserOrderService userOrderService;

	@GetMapping("/{user-id}")
	public UserOrder findUserByUserId(@PathVariable("user-id") Long userId) {
		LOGGER.debug("New request for userid- {}", userId);
		return userOrderService.findUserOrderByUserId(userId);
	}

}
