package com.apollo.exchange.common.user.dto;

import java.security.Principal;

public class UserModel implements Principal {
 
    String name;
 
    public UserModel(String name) {
        this.name = name;
    }
 
    @Override
    public String getName() {
        return name;
    }
}