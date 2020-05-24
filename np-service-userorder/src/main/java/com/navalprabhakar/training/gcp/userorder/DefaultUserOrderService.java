package com.navalprabhakar.training.gcp.userorder;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

public class DefaultUserOrderService implements UserOrderService {

	private RestTemplate restTemplate;

	@Value("${external.url.service.user:localhost:9091}")
	private String urlUserService;

	@Value("${external.url.service.order:localhost:9092}")
	private String urlOrderService;
	
	public DefaultUserOrderService(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	@Override
	public UserOrder findUserOrderByUserId(Long userId) {
		UserOrder userOrder;
		try {
			User user = restTemplate.getForEntity(urlUserService + "/" + userId, User.class).getBody();
			List<Order> orders = (List<Order>) restTemplate.getForEntity(urlUserService + "?user-id=" + userId, Order.class).getBody();
			
			userOrder = new UserOrder();
			userOrder.setUserDetails(user);
			userOrder.setOrders(orders);
		} catch (RestClientException e) {
			throw new RuntimeException("Order detail can't be found");
		}
        return userOrder;
	}

}
