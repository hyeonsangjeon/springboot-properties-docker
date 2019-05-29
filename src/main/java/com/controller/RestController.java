package com.controller;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@org.springframework.web.bind.annotation.RestController

@RequestMapping("/")
public class RestController {

    @Value("${dynamic.value}")
    private String dyVal;

    @RequestMapping(value = "/dynamicvalue", method = RequestMethod.GET)
    public String get() {
        return dyVal;
    }
}
