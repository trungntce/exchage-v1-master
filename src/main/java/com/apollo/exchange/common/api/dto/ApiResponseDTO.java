package com.apollo.exchange.common.api.dto;

import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class ApiResponseDTO {

    private WalletDTO createWalletResponse;

    private BigDecimal quantity;
    private List<ApiTransferEventDTO.Item> luniverseTransferEventList;
    private List<ApiHolderDTO.Item> luniverseWalletList;
    private ApiTransferDTO transferTokenResponse;
    private ApiPageDTO paging;
}
