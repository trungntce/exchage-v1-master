package com.apollo.exchange.common.api.dto;

import com.apollo.exchange.common.utils.ObjectUtils;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApiTransferDTO {
    private String walletAddress = null;
    private String fromWalletAddress = null;
    private String toWalletAddress = null;
    private String symbol = "BANI";
    private String clientCode = "TEST_CODE";
    private BigDecimal quantity = null;
    private String txid = null;

    public ApiTransferDTO(String fromWalletAddress){
        this.fromWalletAddress = fromWalletAddress;
    }

    public ApiTransferDTO(Map<String, Object> mapData) {
        this.symbol = (String) mapData.get("symbol");
        this.clientCode = (String) mapData.get("clientCode");
        this.quantity = (BigDecimal) mapData.get("quantity");
        this.fromWalletAddress = (String) mapData.get("fromWalletAddress");
        this.toWalletAddress = (String) mapData.get("toWalletAddress");
        this.txid = (String) mapData.get("txid");
    }

    public Map<String, Object> toMap() {
        return ObjectUtils.parameters(this);
    }

}
