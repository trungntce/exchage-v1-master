package com.apollo.exchange.admin.sell.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminSellTradeDTO {

    private Integer sellTradeHistoryId;
    private Integer sellId;
    private Integer tradeState;
    private String txid;
    private String buyerWalletAddress;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate;

}
