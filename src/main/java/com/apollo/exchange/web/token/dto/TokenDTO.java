package com.apollo.exchange.web.token.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
/**
 * @author ntt.dev
 * @apiNote TokenDTO Data transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TokenDTO {

    private Integer rownum = null;
    private String symbol = null;
    private String name = null;
    private String operator = null;
    private Integer unitPrice = null;
    private String useYn = null;
    private String walletAddress = null;
    private Double fee = null;
    private String role = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}