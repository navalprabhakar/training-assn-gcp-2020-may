package com.navalprabhakar.training.gcp.userorder;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

public class Order implements Serializable {

	private static final long serialVersionUID = 5426575085447465109L;

	private Long orderId;

	@JsonIgnoreProperties
	private Long userId;

	private Double amount;

	private String orderDate;

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

}
