package com.apollo.exchange.common.api.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author tuyen.dev
 * @description Data Transfer in Luniverse api
 */
@Data
public class ApiTransferEventDTO {

    private List<Item> items;
    private ApiPageDTO paging;

    @Data
    public static class Item{
        private String txHash;
        private String from;
        private String to;
        private BigDecimal value;
        private Long timestamp;
        private String tokenContractAddress;
    }
}
