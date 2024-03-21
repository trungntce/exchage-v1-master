package com.apollo.exchange.web.apidocument.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;


@Data
public class ApiDocumentResponseBalanceDTO {

    @ApiModelProperty(value = "Response object", required = true, name = "ApiResponseDTO")
    private ApiBalanceResponseDTO apiResponseDTO;

    @Data
    public class ApiBalanceResponseDTO {

        @ApiModelProperty(value = "status of the request, Max = 20, Min = 3", example = "Success", required = true)
        private String state;

        @ApiModelProperty(value = "message of the request, Max = 100, Min = 3", example = "Required request value is missing", required = true)
        private String message;


        @ApiModelProperty(value = "response object of the balance", required = true)
        private Response response;
    }

    @Data
    public class Response {

        @ApiModelProperty(value = "luniverseWalletList object of the balance", required = true)
        private List<LuniverseWalletList> luniverseWalletList;

        @Data
        public class LuniverseWalletList {
            @ApiModelProperty(value = "WalletAddress, Max = 100, Min = 60", example = "0x8014cee0f6f494429f2e76b3add33d2842b6126a", required = true)
            private String address = null;

            @ApiModelProperty(value = "balance of walletAddress, Max = 50, Min = 3", example = "99999928999605.5", required = true)
            private BigDecimal balance = null;
        }
    }
}
