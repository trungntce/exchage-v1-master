package com.apollo.exchange.admin.wallet.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.web3j.crypto.WalletFile;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author hipo.dev
 * @apiNote WALLET Data Transfer Object
 */
@Data
@AllArgsConstructor
public class AdminWalletDTO {

    private Integer rownum = null;
    private Integer walletId = null;
    private String symbol = null;
    private String password;
    private String walletAddress = null;
    private String privateKey = null;
    private String walletPw = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    private String name = null;
    private String tel = null;
    private String email = null;
    private Double fee = null;
    private String clientCode;
    private Integer clientId;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

    private String role = null;
    private String roleName = null;
    private WalletFile walletFile = null;
    private String loginId = null;

    public AdminWalletDTO(){ }

}
