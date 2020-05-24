package com.navalprabhakar.training.gcp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.navalprabhakar.training.gcp.order.DefaultOrderService;
import com.navalprabhakar.training.gcp.order.OrderRepository;
import com.navalprabhakar.training.gcp.order.OrderService;

@SpringBootApplication
@Configuration
@EnableJpaRepositories(basePackages = { "com.navalprabhakar.training.gcp" })
public class NpServiceOrderApplication {

	public static void main(String[] args) {
		SpringApplication.run(NpServiceOrderApplication.class, args);
	}

	@Bean
	public OrderService orderService(OrderRepository orderRepository) {
		return new DefaultOrderService(orderRepository);
	}
}
