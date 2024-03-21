package com.apollo.exchange.web.sell.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;

/**
 * @author ntt.dev
 * @apiNote SellDTO Data transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SellDTO {

    private Integer sellId = null;
    private Integer pSellId = null;
    private String clientId = null;
    private String domain = null;
    private Integer sellType = null;
    private String symbol = null;
    private String viewRole = null;
    private String sellerWalletAddress = null;
    private BigDecimal quantity = null;
    private BigInteger unitPrice = null;
    private BigInteger totalPrice = null;
    private Integer state = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    private String delYn = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeCompletionDate = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private String regWalletAddress = null;
}
