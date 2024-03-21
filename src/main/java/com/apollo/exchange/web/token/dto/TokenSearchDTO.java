package com.apollo.exchange.web.token.dto;


import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * @author ntt.dev
 * @apiNote TokenSearchDTO Data transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TokenSearchDTO extends PageDTO {

    private String symbol = null;
    private String name = null;
    private String operator = null;
    private List<String> operatorList = null;
    private Integer unitPrice = null;
    private String useYn = null;
    private String walletAddress = null;
    private Double fee = null;
    private String role = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}