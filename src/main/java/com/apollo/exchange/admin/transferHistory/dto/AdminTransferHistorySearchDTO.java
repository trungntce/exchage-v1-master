package com.apollo.exchange.admin.transferHistory.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminTransferHistorySearchDTO extends PageDTO {
    private Integer transferHistoryId;
    private String transferFromType;
    private String transferToType;
    private String symbol;
    private String clientCode;
    private String txid;
    private Integer state;
    private String walletAddress;
    private String toWalletAddress;
    private String fromWalletAddress;
    private BigDecimal quantity;
    private Date regDate;
    private String orderByColumn = "REG_DATE";
    private String orderByType = "DESC";
    private String timeSearchKey = null;
    private String searchDateStart = null;
    private String searchDateEnd = null;
}
