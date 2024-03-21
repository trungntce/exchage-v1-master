package com.apollo.exchange.web.sell.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
/**
 * @author ntt.dev
 * @apiNote SellSearchDTO Data transfer Object
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SellSearchDTO extends PageDTO {
    private Integer sellId = null;
    private List<Integer> sellIds = null;
    private Integer pSellId = null;
    private Integer clientId = null;
    private String domain = null;
    private Integer sellType = null;
    private List<String> sellTypes = null;
    private String symbol = null;
    private List<String> symbolList = null;
    private String viewRole = null;
    private String sellerWalletAddress = null;
    private String regWalletAddress = null;
    private BigDecimal quantity = null;
    private BigInteger unitPrice = null;
    private BigInteger totalPrice = null;
    private Integer state = null;
    private String stateName = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    private String clientTraderUseYn = null;
    private String delYn = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeCompletionDate = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date sellRegDate = null;

    private Integer sellTradeHistoryId = null;
    private Integer tradeState = null;
    private String txid = null;
    private String buyerWalletAddress = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeRegDate = null;
    private String walletAddress = null;
    //Temp
    private String owner = null;
    private String idOrderStatus = null;
    private String langCode = LocaleContextHolder.getLocale().toString();
    private Integer sellPage = 1;

    private String alarmRole = null;
    private String type = null;
}
