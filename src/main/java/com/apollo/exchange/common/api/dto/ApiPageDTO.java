package com.apollo.exchange.common.api.dto;

import lombok.Data;

/**
 * @author tuyen.dev
 * @description Paging in luniverse api
 */
@Data
public class ApiPageDTO {

    private Cursor cursors;

    @Data
    public static class Cursor{
        private String after;
        private String before;
    }
}
