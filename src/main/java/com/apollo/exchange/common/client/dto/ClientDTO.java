package com.apollo.exchange.common.client.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClientDTO {
    private Integer rownum = null;
    private Integer clientId = null;
    private String symbol = null;
    private String clientCode = null;
    private String apiKey = null;
    private String name = null;
    private String walletName = null;
    private String useYn = "Y";
    private String fee = null;
    private BigDecimal unitPrice = null;
    private String walletAddress = null;
    private String phone;
    private String bankName;
    private String bankOwner;
    private String bankAccount;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

    private String walletClientId = null;
    private String buyFee = null;
    private String sellFee = null;
    private String clientTraderUseYn = null;
    private String buyBenifitUseYn = null;
    private String sellBenifitUseYn = null;
    private String walletClientTraderId = null;
    private String clientTraderWallet = null;
    private String useYnFeeOp = null;

}
