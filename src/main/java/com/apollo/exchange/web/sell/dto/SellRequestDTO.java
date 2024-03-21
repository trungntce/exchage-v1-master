package com.apollo.exchange.web.sell.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.math.BigInteger;

@Data
public class SellRequestDTO {
    private String clientId = null;
    private Integer buyType = null;
    private String symbol = null;
    private String sellerWalletAddress = null;
    private BigDecimal quantity = null;
    private String type = null;
    private String viewRole = null;

    //other token
    private BigInteger unitPrice = null;
    private String otherWallet = null;
    private Integer tradeType = null;
}
