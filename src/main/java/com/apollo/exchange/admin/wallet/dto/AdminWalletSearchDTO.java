package com.apollo.exchange.admin.wallet.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;
import org.web3j.crypto.WalletFile;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote WALLET Data Transfer Object
 */
@Data
@AllArgsConstructor
public class AdminWalletSearchDTO extends PageDTO {
    private String symbol = null;
    private String clientCode = null;
    private String loginId = null;
    private Integer clientId = null;
    private Integer walletId = null;
    private String walletAddress;
    private String keywordType = null;
    private String keyword = null;
    private String useYn = null;
    private String timeSearchKey = null;
    private String orderByColumn = null;
    private String orderByType = null;
    private String searchDateStart = null;
    private String searchDateEnd = null;
    private List<String> roles = null;
    private List<String> symbols = null;

    public AdminWalletSearchDTO(){}

    public AdminWalletSearchDTO(Integer walletId){
        this.walletId = walletId;
    }

    public AdminWalletSearchDTO(List<String> symbols, List<String> roles){
        this.roles = roles;
        this.symbols = symbols;
    }
}
