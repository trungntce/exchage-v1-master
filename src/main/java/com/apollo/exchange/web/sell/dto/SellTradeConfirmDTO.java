package com.apollo.exchange.web.sell.dto;

import lombok.Data;

@Data
public class SellTradeConfirmDTO {
    private Integer sellId;
    private Integer sellTradeHistoryId;
    private Integer tradeState;
    private String txId = "";
    private String orderKind = null;
}
