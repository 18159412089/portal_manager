package com.fjzxdz.ams.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mongo/test")
public class MongoTestController {

	@RequestMapping("")
	public String index() {
		return "/mongo";
	}
}
