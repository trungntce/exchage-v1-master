package com.apollo.exchange.admin.sell.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote Sell Search Data Object
 */
@Data
@AllArgsConstructor
public class AdminSellSearchDTO extends PageDTO {
    private String langCode = LocaleContextHolder.getLocale().toString();
    private String symbol = null;
    private Integer clientId = null;
    private String clientCode = null;
    private Integer sellId = null;
    private Integer pSellId = null;
    private Integer sellType = null;
    private String viewRole = null;
    private String walletAddress = null;
    private List<Integer> states;
    private Integer state = null;
    private String keywordType = null;
    private String keyword = null;
    private String useYn = null;
    private String timeSearchKey = null;
    private String orderByColumn = "ROWNUM";
    private String orderByType = "DESC";
    private String searchDateStart = null;
    private String searchDateEnd = null;

    public AdminSellSearchDTO(){
        super();
    }

    public AdminSellSearchDTO(Integer sellId) {
        this.sellId = sellId;
    }

    public AdminSellSearchDTO(Integer sellId, Integer pSellId) {
        this.sellId = sellId;
        this.pSellId = pSellId;
    }

    public AdminSellSearchDTO(String walletAddress, Integer ...state){
        super();
        this.walletAddress = walletAddress;
        this.states = Arrays.asList(state);
    }

    public AdminSellSearchDTO(String walletAddress, String viewRole, Integer ...state){
        super();
        this.viewRole = viewRole;
        this.walletAddress = walletAddress;
        this.states = Arrays.asList(state);
    }
}
