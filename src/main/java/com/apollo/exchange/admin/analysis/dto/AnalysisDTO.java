package com.apollo.exchange.admin.analysis.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnalysisDTO {
    private String title = null;
    private String symbol = null;
    private String clientName = null;
    private String walletAddress;
    private BigDecimal buyQuantity = new BigDecimal(0);
    private BigDecimal sellQuantity = new BigDecimal(0);
    private BigDecimal buyTotalPrice = new BigDecimal(0);
    private BigDecimal sellTotalPrice = new BigDecimal(0);
    private BigDecimal totalItem = new BigDecimal(0);
    private Double totalQuantity = 0.0;
    private Double transferFee = 0.0;
    private Double benefitFee = 0.0;
    private BigDecimal totalPrice = new BigDecimal(0);
    private Integer walletCount = 0;
    private Integer tradeCnt = 0;
}
