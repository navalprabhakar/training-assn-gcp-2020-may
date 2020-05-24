package com.navalprabhakar.training.gcp.userorder;

import java.io.Serializable;
import java.util.List;

public class UserOrder implements Serializable {

	private static final long serialVersionUID = 6127692657694296363L;

	private User userDetails;

	private List<Order> orders;

	public User getUserDetails() {
		return userDetails;
	}

	public void setUserDetails(User userDetails) {
		this.userDetails = userDetails;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

}
