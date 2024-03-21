package com.apollo.exchange.common.api.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Map;

@Data
public class ApiTokenQuantityDTO {
    private BigDecimal quantity;

    public ApiTokenQuantityDTO(Map<String, Object> mapData) {
        this.quantity = BigDecimal.valueOf((Double) mapData.get("quantity"));
    }
}
