package com.navalprabhakar.training.gcp.userorder;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = 7854206085447465109L;

	private Long userId;

	private String name;

	private Integer age;

	private String email;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

}
