package com.apollo.exchange.web.buy.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
/**
 * @author ntt.dev
 * @apiNote Buy Data transfer Object
 */
@Data
public class BuyDTO {
    private Integer buyId = null;
    private Integer pBuyId = null;
    private String clientId = null;
    private String domain = null;
    private Integer buyType = null;
    private String symbol = null;
    private String viewRole = null;
    private String buyerWalletAddress = null;
    private BigDecimal quantity = null;
    private BigInteger unitPrice = null;
    private BigInteger totalPrice = null;
    private Integer state = null;
    private String delYn = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date tradeCompletionDate = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private String regWalletAddress = null;

    public BuyDTO(){}
    public BuyDTO(BuySearchDTO buySearchDTO){
        this.buyId = buySearchDTO.getBuyId();
        this.pBuyId = buySearchDTO.getPBuyId();
        this.clientId = buySearchDTO.getClientId()+"";
        this.domain = buySearchDTO.getDomain();
        this.buyType = buySearchDTO.getBuyType();
        this.symbol = buySearchDTO.getSymbol();
        this.viewRole = buySearchDTO.getViewRole();
        this.buyerWalletAddress = buySearchDTO.getBuyerWalletAddress();
        this.quantity = buySearchDTO.getQuantity();
        this.unitPrice = buySearchDTO.getUnitPrice();
        this.totalPrice = buySearchDTO.getTotalPrice();
        this.state = buySearchDTO.getState();
        this.delYn = buySearchDTO.getDelYn();
        this.regWalletAddress = buySearchDTO.getRegWalletAddress();
    }
}
