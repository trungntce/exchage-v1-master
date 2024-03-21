package com.apollo.exchange.admin.buy.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author hipo.dev
 * @apiNote Buy Data Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminBuyDTO {
    private Integer rownum = null;
    private Integer buyId = null;
    private Integer pBuyId = null;
    private Integer clientId = null;
    private String clientName = null;
    private Integer buyType = null;
    private String symbol = null;
    private String viewRole = null;
    private String buyerWalletAddress = null;
    private String buyerName = null;
    private BigDecimal quantity = null;
    private BigDecimal unitPrice = null;
    private BigDecimal totalPrice = null;
    private Integer state = null;
    private String stateName = null;
    private String delYn = null;
    private Integer tradeState = null;
    private String tradeStateName = null;
    private String sellerWalletAddress = null;
    private String sellerName = null;
    private String txid = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeCompletionDate = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private String regWalletAddress;

    private Integer refBuyId;
    private Integer refBuyState;

}
