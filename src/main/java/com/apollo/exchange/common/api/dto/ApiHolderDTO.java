package com.apollo.exchange.common.api.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author tuyen.dev
 * @description Data Holders in Luniverse api
 */
@Data
public class ApiHolderDTO {

    private List<Item> items;
    private ApiPageDTO paging;

    @Data
    public static class Item{
        private String address;
        private BigDecimal balance;

    }
}
