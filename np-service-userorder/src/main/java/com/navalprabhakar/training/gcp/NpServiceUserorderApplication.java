package com.navalprabhakar.training.gcp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.rest.RepositoryRestMvcAutoConfiguration;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.navalprabhakar.training.gcp.userorder.DefaultUserOrderService;
import com.navalprabhakar.training.gcp.userorder.UserOrderService;

@Configuration
@SpringBootApplication(exclude = RepositoryRestMvcAutoConfiguration.class)
public class NpServiceUserorderApplication {

	public static void main(String[] args) {
		SpringApplication.run(NpServiceUserorderApplication.class, args);
	}

	@Bean
	public ObjectMapper objectMapper() {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		mapper.configure(DeserializationFeature.FAIL_ON_INVALID_SUBTYPE, false);
		return mapper;
	}

	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		return builder.build();
	}

	@Bean
	public UserOrderService userOrderService(RestTemplate restTemplate) {
		return new DefaultUserOrderService(restTemplate);
	}
}
