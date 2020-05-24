package com.navalprabhakar.training.gcp.userorder;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class DefaultUserOrderService implements UserOrderService {

	private RestTemplate restTemplate;

	@Value("${external.url.service.user:localhost:9091}")
	private String urlUserService;

	@Value("${external.url.service.order:localhost:9092}")
	private String urlOrderService;

	@Autowired
	private ObjectMapper objectMapper;

	public DefaultUserOrderService(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	@Override
	public UserOrder findUserOrderByUserId(Long userId) {
		UserOrder userOrder;
		try {

			User user = restTemplate.getForEntity(urlUserService + "/" + userId, User.class).getBody();
			List<Order> orders = getOrders(userId);

			//List<Order> orders = (List<Order>) objectMapper.readValue(getOrdersString(userId), List.class);

			//String orders = restTemplate.getForEntity(urlOrderService + "?user-id=" + userId, String.class).getBody();
			
			//List<Order> ordersParsed = objectMapper.convertValue(orders, new TypeReference<List<Order>>() { });
			userOrder = new UserOrder();
			userOrder.setUserDetails(user);
			userOrder.setOrders(orders);
		} catch (RestClientException e) {
			throw new RuntimeException("Order detail can't be found");
		}
		return userOrder;
	}

	private String getOrdersString(Long userId) {
		return restTemplate.getForEntity(urlOrderService + "?user-id=" + userId, String.class).getBody();
	}

	private List<Order> getOrders(Long userId) {
		ParameterizedTypeReference<List<Order>> responseType = new ParameterizedTypeReference<List<Order>>() {
		};
		ResponseEntity<List<Order>> resp = restTemplate.exchange(urlOrderService + "?user-id=" + userId, HttpMethod.GET, null, responseType);
		return resp.getBody();
	}
}
