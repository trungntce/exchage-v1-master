package com.apollo.exchange.web.apidocument.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

public class ApiDocumentResponseTransferNoFeeDTO {

    @ApiModelProperty(value = "Response object", required = true)
    private ApiTransferResponseDTO apiResponseDTO;

    @Data
    public class ApiTransferResponseDTO {

        @ApiModelProperty(value = "status of the request, Max = 20, Min = 3", example = "Success", required = true)
        private String state;

        @ApiModelProperty(value = "message of the request, Max = 100, Min = 3", example = "Required request value is missing", required = true)
        private String message;


        @ApiModelProperty(value = "response object of the wallet", required = true)
        private Response response;
    }
    @Data
    public class Response {
        @ApiModelProperty(value = "transferTokenResponse object of the transfer", required = true)
        private TransferTokenResponse transferTokenResponse;

        @Data
        public class TransferTokenResponse {
            @ApiModelProperty(value = "token name in the system, Type = String, Max = 10, Min = 3", example = "BANI", required = true)
            private String symbol = "BANI";

            @ApiModelProperty(value = "clientCode to identify the wallet belonging to the client, Type = String, Max = 50, Min = 3", example = "TEST_CODE", required = true)
            private String clientCode = "TEST_CODE";

            @ApiModelProperty(value = "quantity of transfer, Type = Integer, Max = 50, Min = 1",
                    example = "5", required = true)
            private Integer quantity = null;

            @ApiModelProperty(value = "fromWalletAddress of transfer, Type = String, Max = 50, Min = 10", example = "0x8014cee0f6f494429f2e76b3add33d2842b6126a", required = true)
            private String fromWalletAddress = null;

            @ApiModelProperty(value = "toWalletAddress of transfer, Type = String, Max = 50, Min = 10", example = "0x267b19e6566fb46525f59dfd5e9f93d4c37b8746", required = true)
            private String toWalletAddress = null;

            @ApiModelProperty(value = "txid of transfer when successful, Type = String, Max = 50, Min = 10", example = "0x3b60da77a3e3f5c81c84d98243c3a50db1235a5add6a15a062de78f5cff5d1d5", required = true)
            private String txid = null;
        }
    }

}
