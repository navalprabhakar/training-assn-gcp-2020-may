package com.navalprabhakar.training.gcp.user;

import java.util.List;

public interface UserService {

	User findUserByUserId(Long userId);
	
	List<User> findUsersByUserId(List<Long> userIds);

	List<User> findUsersByEmail(String email);
}
