package com.apollo.exchange.common.login.dto;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class LoginDTO {
    private String walletAddress;
    private String walletPassword;
    private String apiKey;
    private String tradeType;
    private String buyType;
    private String clientCode;

    private String username;
    private String password;
    private String grantType;
    private String siteName;
    private String clientId;
    private String clientSecret;
    private String refreshToken;
    private String loginId;
    private String loginPw;

    private String tokenSymbol;
    private String type;


    public Map<String, Object> toMap(){
        Map<String, Object> m = new HashMap<>();
        if(this.username != null) m.put("username", this.username);
        if(this.password != null) m.put("password", this.password);
        if(this.grantType != null) m.put("grant_type", this.grantType);
        if(this.siteName != null) m.put("site_name", this.siteName);
        if(this.clientId != null) m.put("client_id", this.clientId);
        if(this.refreshToken != null) m.put("refresh_token", this.refreshToken);
        if(this.clientSecret != null) m.put("client_secret", this.clientSecret);
        return m;
    }
}
