package com.navalprabhakar.training.gcp.user;

import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@GetMapping("/{user-id}")
	public User findUserByUserId(@PathVariable("user-id") Long userId) {
		LOGGER.debug("New request for userid- {}", userId);
		return userService.findUserByUserId(userId);
	}

	@GetMapping("/all")
	public List<User> findUserByRequestParam(/* @RequestParam("user-ids") List<Long> userIds, */
			@RequestParam("email") String email) {
		List<User> users = null;
		if (email != null) {
			users = userService.findUsersByEmail(email);
		} else {
			users = Collections.emptyList();
		}
		if(CollectionUtils.isEmpty(users)) {
			throw new RuntimeException("No User found");
		}
		return users;
	}

}
