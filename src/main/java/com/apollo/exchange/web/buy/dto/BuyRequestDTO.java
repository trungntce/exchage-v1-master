package com.apollo.exchange.web.buy.dto;


import com.apollo.exchange.common.utils.ObjectUtils;
import lombok.Data;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Map;

@Data
public class BuyRequestDTO {
    private String clientId = null;
    private Integer buyType = null;
    private String symbol = null;
    private String buyerWalletAddress = null;
    private BigDecimal quantity = null;
    private String type = null;
    private String viewRole = null;
    private String bankOwner = null;
    private String bankName = null;
    private String bankAccount = null;
    private Integer tradeType;

    //other token
    private BigInteger unitPrice = null;
    private String otherWallet = null;

    public Map<String, Object> toMap(){
        return ObjectUtils.parameters(this);
    }
}