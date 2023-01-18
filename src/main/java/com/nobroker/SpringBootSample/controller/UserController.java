package com.nobroker.SpringBootSample.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.nobroker.SpringBootSample.Entity.User;
import com.nobroker.SpringBootSample.dto.UserCreationReq;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.web.server.ResponseStatusException;


import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController{
    Map<String, User> userMap = new HashMap<>() ;

    ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();


    @GetMapping("/{name}")
    public String getUser(@PathVariable String name) throws JsonProcessingException {
        if(!userMap.containsKey(name)){
            throw  new ResponseStatusException(HttpStatus.NOT_FOUND,"User Not Found");
        }
        return ow.writeValueAsString(userMap.get(name));
    }

    @PostMapping(value = "/create")
    public String createUser( @Valid @RequestBody UserCreationReq userReq){
        User newUser =  new User(userReq.getName(), userReq.getEmail(), userReq.getPhone());
        userMap.put(userReq.getName(),newUser) ;
        return "User created Successfully" ;
    }

    @DeleteMapping("/delete/{name}")
    public String deleteUser(@PathVariable String name)  {
        if(!userMap.containsKey(name)){
            throw  new ResponseStatusException(HttpStatus.BAD_REQUEST, "User Not present");
        }
        userMap.remove(name) ;
        return "User deleted Successfully" ;
    }
}

