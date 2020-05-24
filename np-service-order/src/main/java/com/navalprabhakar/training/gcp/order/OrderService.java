package com.navalprabhakar.training.gcp.order;

import java.util.List;

public interface OrderService {

	Order findOrderByOrderId(Long orderId);
	List<Order> findOrdersByUserId(Long userId);

}
