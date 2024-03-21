package com.apollo.exchange.common.api.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ApiTransferTokenDTO {

    private String symbol;
    private String clientCode;
    private BigDecimal quantity;
    private String fromWalletAddress;
    private String toWalletAddress;
    private String txid;
}
