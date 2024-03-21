package com.apollo.exchange.admin.transferHistory.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminTransferHistoryDTO {
    private Integer rownum;
    private Integer transferHistoryId;
    private String transferFromType;
    private String transferToType;
    private String symbol;
    private String clientCode;
    private String txid;
    private Integer state;
    private String toWalletAddress;
    private String fromWalletAddress;
    private BigDecimal quantity;
    private Date regDate;
}
