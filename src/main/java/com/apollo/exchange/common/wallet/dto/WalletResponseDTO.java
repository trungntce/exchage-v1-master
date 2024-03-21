package com.apollo.exchange.common.wallet.dto;

import lombok.Data;

import java.util.Map;
@Data
public class WalletResponseDTO {


    private Map<String, Object> createWalletResponse;

    public WalletResponseDTO(Map<String, Object> mapDate) {
        this.createWalletResponse = (Map<String, Object>) mapDate.get("createWalletResponse");
    }

}
