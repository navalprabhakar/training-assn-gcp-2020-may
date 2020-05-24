package com.navalprabhakar.training.gcp.order;

import java.util.List;

public class DefaultOrderService implements OrderService {

	private OrderRepository orderRepository;

	public DefaultOrderService(OrderRepository orderRepository) {
		this.orderRepository = orderRepository;
	}

	@Override
	public Order findOrderByOrderId(Long orderId) {
		return orderRepository.findById(orderId).orElseThrow(() -> new RuntimeException("No order found"));
	}

	@Override
	public List<Order> findOrdersByUserId(Long userId) {
		return orderRepository.findAllByUserId(userId);
	}

}
