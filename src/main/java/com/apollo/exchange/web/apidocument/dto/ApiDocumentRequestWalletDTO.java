package com.apollo.exchange.web.apidocument.dto;

import com.apollo.exchange.common.api.dto.ApiResponseDTO;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ApiDocumentRequestWalletDTO {
//    private CreateWalletRequest CreateWalletRequest;
//
//    @Data
//    public class CreateWalletRequest {
@ApiModelProperty(value = "token name in the system, Type = String, Max = 10, Min = 3", example = "BANI", required = true)
private String symbol = "BANI";

        @ApiModelProperty(value = "clientCode to identify the wallet belonging to the client,Type = String, Max = 50, Min = 3", example = "TEST_CODE", required = true)
        private String clientCode = "TEST_CODE";

        @ApiModelProperty(value = "password of wallet, Type = String, Max = 50, Min = 3", example = "1234", required = true)
        private String password = null;

        @ApiModelProperty(value = "bankName of owner, Type = String, Max = 50, Min = 3", example = "SHINHANBANK", required = true)
        private String bankName = null;

        @ApiModelProperty(value = "bankOwner of owner, Type = String, Max = 50, Min = 3", example = "LEE MIN-HO", required = true)
        private String bankOwner = null;

        @ApiModelProperty(value = "bankAccount of owner, Type = String, Max = 50, Min = 3", example = "999999999", required = true)
        private String bankAccount = null;

        @ApiModelProperty(value = "name of owner, Type = String, Max = 50, Min = 3", example = "LEE MIN-HO", required = false)
        private String name = null;

        @ApiModelProperty(value = "tel of owner, Type = String, Max = 50, Min = 3", example = "8489584525555", required = false)
        private String tel = null;
//    }
}

