package com.apollo.exchange.admin.wallet.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author ionio.dev
 * @apiNote WALLET_ROLE Data Transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminWalletClientDTO {

    private Integer walletId = null;
    private Integer clientId = null;
}
