package com.apollo.exchange.web.buy.dto;

import com.apollo.exchange.common.utils.ObjectUtils;
import lombok.Data;

import java.util.Map;

@Data
public class BuyTradeRequestDTO {
    private Integer buyOrderId;
    private String walletAddress;

    public Map<String, Object> toMap(){
        Map<String, Object> m = ObjectUtils.parameters(this);
        return m;
    }
}
