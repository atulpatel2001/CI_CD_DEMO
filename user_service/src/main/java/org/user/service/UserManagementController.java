package org.user.service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserManagementController {

    @GetMapping("/create")
    public String addUser(){
        return "User Create SuccessFully";
    }

    @GetMapping("/update")
    public String updateUser(){
        return "User Update SuccessFully";
    }
}
