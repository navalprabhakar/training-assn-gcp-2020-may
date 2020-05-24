package com.navalprabhakar.training.gcp.order;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(exported = false)
public interface OrderRepository extends JpaRepository<Order, Long> {

	List<Order> findAllByUserId(Long userId);
}
