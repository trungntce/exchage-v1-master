package com.apollo.exchange.admin.token.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminTokenSearchDTO extends PageDTO {
    private String langCode = LocaleContextHolder.getLocale().toString();
    private String symbol = null;
    private String name = null;
    private String operator = null;
    private BigDecimal unitPrice = null;
    private String useYn = null;
    private String walletAddress = null;
    private Double fee = null;
    private String role = null;
    private String keywordType = null;
    private String keyword = null;
    private String timeSearchKey = null;
    private String orderByColumn = "ROWNUM";
    private String orderByType = "DESC";
    private String searchDateStart = null;
    private String searchDateEnd = null;
    private String regDate = null;
}