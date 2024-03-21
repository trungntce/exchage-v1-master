package com.apollo.exchange.web.apidocument.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ApiDocumentResponseWalletDTO {
    @ApiModelProperty(value = "Response object", required = true)
    private ApiWalletResponseDTO apiWalletResponseDTO;

    @Data
    public class ApiWalletResponseDTO {
        @ApiModelProperty(value = "status of the request, Max = 20, Min = 3", example = "Success", required = true)
        private String state;

        @ApiModelProperty(value = "message of the request, Max = 100, Min = 3", example = "Required request value is missing", required = true)
        private String message;


        @ApiModelProperty(value = "response object of the wallet", required = true)
        private ResponseCreateWalletResponse response;
    }


    @Data
    public class ResponseCreateWalletResponse {
        @ApiModelProperty(value = "CreateWalletResponse object of the wallet", required = true)
        private CreateWalletResponse createWalletResponse;

        @Data
        public class CreateWalletResponse {
            @ApiModelProperty(value = "token name in the system, Max = 10, Min = 3", example = "BANI", required = true)
            private String symbol = "BANI";

            @ApiModelProperty(value = "clientCode to identify the wallet belonging to the client, Max = 50, Min = 3", example = "TEST_CODE", required = true)
            private String clientCode = "TEST_CODE";

            @ApiModelProperty(value = "walletAddress of owner, Max = 50, Min = 3",
                    example = "0xc217f1d186d749f55f479a2e9becceb0e4822015", required = true)
            private String walletAddress = null;
            @ApiModelProperty(value = "privateKey of wallet, Max = 100, Min = 3",
                    example = "f9aba114ad0999743fba005d619ffdaf75992685673b9776aad31eb801b978c5", required = true)
            private String privateKey = "TEST_CODE";

            @ApiModelProperty(value = "password of wallet, Max = 50, Min = 3", example = "1234", required = true)
            private String password = null;

            @ApiModelProperty(value = "bankName of owner, Max = 50, Min = 3", example = "SHINHANBANK", required = true)
            private String bankName = null;

            @ApiModelProperty(value = "bankOwner of owner, Max = 50, Min = 3", example = "LEE MIN-HO", required = true)
            private String bankOwner = null;

            @ApiModelProperty(value = "bankAccount of owner, Max = 50, Min = 3", example = "999999999", required = true)
            private String bankAccount = null;

            @ApiModelProperty(value = "name of owner, Max = 50, Min = 3", example = "LEE MIN-HO", required = false)
            private String name = null;

            @ApiModelProperty(value = "tel of owner, Max = 50, Min = 3", example = "8489584525555", required = false)
            private String tel = null;
        }
    }

}
