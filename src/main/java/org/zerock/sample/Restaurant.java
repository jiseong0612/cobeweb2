package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import lombok.Data;

@Controller
@Data
public class Restaurant {
	@Autowired
	private  Chef chef;

	public String hi() {
		return "im a restaurant";
	}
}
