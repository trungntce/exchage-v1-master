package com.apollo.exchange.common.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private Integer rownum = null;
    private Integer userId = null;
    private String loginId = null;
    private String loginPw = null;
    private String name = null;
    private Integer state = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    private String mail;
    private String symbol = "BANI";
    private String clientCode = "TEST_CODE";
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

    private Integer walletId;
    private Integer walletCount = null;
    private String tel = null;
    private String role = null;
}
