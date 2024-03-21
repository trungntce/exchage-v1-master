package com.apollo.exchange.web.buy.dto;

import com.apollo.exchange.common.dto.PageDTO;
import jnr.ffi.annotations.In;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;

/**
 * @author ntt.dev
 * @apiNote BuySearchDTO Data transfer Object
 */
@Data
public class BuySearchDTO extends PageDTO {
    private Integer buyId = null;
    private List<Integer> buyIds = null;
    private Integer pBuyId = null;
    private Integer clientId = null;
    private String domain = null;
    private Integer buyType = null;
    private List<String> buyTypes = null;
    private String symbol = null;
    private List<String> symbolList = null;
    private String viewRole = null;
    private List<String> viewRoles = null;
    private String buyerWalletAddress = null;
    private String regWalletAddress = null;
    private BigDecimal quantity = null;
    private BigInteger unitPrice = null;
    private BigInteger totalPrice = null;
    private Integer state = null;
    private String stateName = null;
    private String delYn = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeCompletionDate = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date buyRegDate = null;

    private Integer buyTradeHistoryId = null;
    private Integer tradeState = null;
    private String txid = null;
    private String sellerWalletAddress = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    private String clientTraderUseYn = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeRegDate = null;
    private Integer buyPage = 1;

    private String walletAddress = null;
    private String owner = null;
    private String alarmRole = null;

    //Temp
    private String idOrderStatus = null;
    private String langCode = LocaleContextHolder.getLocale().toString();
    private String type = null;

    public BuySearchDTO() {
    }

    public BuySearchDTO(Integer buyId) {
        this.buyId = buyId;
    }
}
