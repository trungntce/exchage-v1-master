package com.apollo.exchange.web.buy.dto;

import lombok.Data;

import java.util.LinkedHashMap;
import java.util.Map;

@Data
public class BuyTradeConfirmDTO {
    private Integer buyId;
    private Integer buyTradeHistoryId;
    private Integer tradeState;
    private String txId = "";

    public BuyTradeConfirmDTO(){}

    public BuyTradeConfirmDTO(Integer buyId, Integer buyTradeHistoryId, Integer tradeState, String txId){
        this.buyId = buyId;
        this.buyTradeHistoryId = buyTradeHistoryId;
        this.tradeState = tradeState;
        this.txId = txId;
    }

    public Map<String, Object> toMap(){
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("buyOrderId", this.buyId);
        m.put("buySellTradeId", this.buyTradeHistoryId);
        m.put("buyTradeStatus", this.tradeState);
        m.put("txId", this.txId);
        return m;
    }
}
