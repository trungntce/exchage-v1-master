package com.apollo.exchange.web.sell.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Data
public class SellTradeDTO {
    private Integer sellTradeHistoryId = null;
    private List<Integer> sellTradeHistoryIds = null;
    private Integer sellId = null;
    private Integer tradeState = null;
    private List<Integer> tradeStates = null;
    private String txid = null;
    private String buyerWalletAddress = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private Integer minute = null;
    private Integer sellType = null;

}
