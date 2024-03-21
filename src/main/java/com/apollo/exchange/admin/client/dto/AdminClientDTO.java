package com.apollo.exchange.admin.client.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminClientDTO {
    private Integer rownum = null;
    private Integer clientId = null;
    private String symbol = null;
    private String clientCode = null;
    private String apiKey = null;
    private String name = null;
    private String walletName = null;
    private String useYn = "Y";
    private Double fee = 0.0;
    private Double sellFee = 0.0;
    private Double buyFee = 0.0;
    private String clientTraderUseYn = null;
    private String buyBenifitUseYn = null;
    private String sellBenifitUseYn = null;
    private BigDecimal unitPrice = null;
    private String walletAddress = null;
    private String phone;
    private String bankName;
    private String bankOwner;
    private String bankAccount;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

}
