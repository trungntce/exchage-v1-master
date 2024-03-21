package com.apollo.exchange.admin.buy.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author hipo.dev
 * @apiNote Buy Data Object
 */
@Data
public class AdminBuyTradeDTO {
    private Integer rownum = null;
    private Integer buyTradeHistoryId = null;
    private Integer buyId = null;
    private Integer tradeState = null;
    private String txid;
    private String sellerWalletAddress;
    private String bankName;
    private String bankOwner;
    private String bankAccount;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

    public AdminBuyTradeDTO() {
    }

    public AdminBuyTradeDTO(Integer buyId) {
        this.buyId = buyId;
    }
}
