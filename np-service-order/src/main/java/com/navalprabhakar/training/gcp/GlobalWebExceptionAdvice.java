package com.navalprabhakar.training.gcp;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
public class GlobalWebExceptionAdvice extends ResponseEntityExceptionHandler {

	/**
	 * On exception.
	 *
	 * @param exception the exception
	 * @return the response entity
	 */
	@org.springframework.web.bind.annotation.ExceptionHandler({ Exception.class })
	public ResponseEntity<String> onException(final Exception exception) {
        return new ResponseEntity<>("Sorry, your request couldn't be processed or has no valid values", new HttpHeaders(), HttpStatus.NOT_FOUND);
	}

}
