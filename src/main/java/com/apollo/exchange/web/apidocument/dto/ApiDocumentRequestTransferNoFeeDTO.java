package com.apollo.exchange.web.apidocument.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ApiDocumentRequestTransferNoFeeDTO {

    @ApiModelProperty(value = "token name in the system, Max = 10, Min = 3", example = "BANI", required = true)
    private String symbol = "BANI";

    @ApiModelProperty(value = "clientCode to identify the wallet belonging to the client, Max = 50, Min = 3", example = "TEST_CODE", required = true)
    private String clientCode = "TEST_CODE";

    @ApiModelProperty(value = "quantity of transfer, Max = 50, Min = 1",
            example = "5", required = true)
    private Integer quantity = null;

    @ApiModelProperty(value = "fromWalletAddress of transfer, Max = 50, Min = 10", example = "0x8014cee0f6f494429f2e76b3add33d2842b6126a", required = true)
    private String fromWalletAddress = null;

    @ApiModelProperty(value = "toWalletAddress of transfer, Max = 50, Min = 10", example = "0x267b19e6566fb46525f59dfd5e9f93d4c37b8746", required = true)
    private String toWalletAddress = null;


}
