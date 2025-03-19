package org.thehackersplaybook.api.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello-world")
    public String hello() {
        String message = "RIOS API: Hello World!";
        System.out.println(message);
        return message;
    }
}
