package com.apollo.exchange.admin.buy.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.Arrays;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote Buy Search Data Object
 */
@Data
@AllArgsConstructor
public class AdminBuySearchDTO extends PageDTO {
    private String langCode = LocaleContextHolder.getLocale().toString();
    private String symbol = null;
    private String clientCode;
    private String viewRole;
    private Integer clientId = null;
    private Integer buyId = null;
    private Integer pBuyId = null;
    private Integer buyType = null;
    private List<Integer> states;
    private Integer state = null;
    private String walletAddress = null;
    private String keywordType = null;
    private String keyword = null;
    private String useYn = null;
    private String timeSearchKey = null;
    private String orderByColumn = "ROWNUM";
    private String orderByType = "DESC";
    private String searchDateStart = null;
    private String searchDateEnd = null;

    public AdminBuySearchDTO(){
        super();
    }

    public AdminBuySearchDTO(Integer buyId) {
        this.buyId = buyId;
    }

    public AdminBuySearchDTO(Integer buyId, Integer pBuyId) {
        this.buyId = buyId;
        this.pBuyId = pBuyId;
    }

    public AdminBuySearchDTO(String walletAddress, Integer ...state){
        super();
        this.walletAddress = walletAddress;
        this.states = Arrays.asList(state);
    }

    public AdminBuySearchDTO(String walletAddress, String viewRole, Integer ...state){
        super();
        this.viewRole = viewRole;
        this.walletAddress = walletAddress;
        this.states = Arrays.asList(state);
    }
}
