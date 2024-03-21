package com.apollo.exchange.web.buy.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * @author ntt.dev
 * @apiNote BuyTradeDTO Data Transfer Object
 */
@Data
public class BuyTradeDTO {
    private Integer buyTradeHistoryId = null;
    private List<Integer> buyTradeHistoryIds = null;
    private Integer buyId = null;
    private Integer tradeState = null;
    private List<Integer> tradeStates = null;
    private String txid = null;
    private String sellerWalletAddress = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private Integer minute = null;
    private Integer buyType = null;

}
