package com.navalprabhakar.training.gcp.user;

import java.util.List;

public class DefaultUserService implements UserService {

	private UserRepository userRepository;

	public DefaultUserService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public User findUserByUserId(Long userId) {
		return userRepository.findById(userId).orElseThrow(() -> new RuntimeException("No User found"));
	}

	@Override
	public List<User> findUsersByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	@Override
	public List<User> findUsersByUserId(List<Long> userIds) {
		return userRepository.findAllById(userIds);
	}

}
