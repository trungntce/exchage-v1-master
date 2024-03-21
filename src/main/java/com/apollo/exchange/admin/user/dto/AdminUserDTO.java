package com.apollo.exchange.admin.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminUserDTO {
    private Integer rownum = null;
    private Integer userId = null;
    private Integer walletId;
    private String loginId = null;
    private String loginPw = null;
    private String name = null;
    private Integer state = null;
    private String symbol;
    private String clientCode;
    private String walletAddress;
    private String bankName;
    private String bankOwner;
    private String bankAccount;
    private String email;
    private String tel;
    private Double fee;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

    private Integer walletCount = null;
}
