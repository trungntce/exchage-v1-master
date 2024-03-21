package com.apollo.exchange.admin.wallet.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author ionio.dev
 * @apiNote WALLET_ROLE Data Transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminWalletRoleDTO {

    private Integer walletId = null;
    private String role = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}
