package com.apollo.exchange.admin.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author ionio.dev
 * @apiNote USER_WALLET Data Transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminUserWalletDTO {

    private Integer userWalletId = null;
    private Integer userId = null;
    private Integer walletId = null;
    private String walletAddress = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}
