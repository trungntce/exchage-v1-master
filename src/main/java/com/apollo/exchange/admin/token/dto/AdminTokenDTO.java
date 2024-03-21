package com.apollo.exchange.admin.token.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminTokenDTO {

    private Integer rownum = null;
    private String symbol = null;
    private String name = null;
    private String operator = "VIETKO";
    private BigDecimal unitPrice = null;
    private String useYn = null;
    private String walletAddress = null;
    private Double fee = null;
    private String role = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}
