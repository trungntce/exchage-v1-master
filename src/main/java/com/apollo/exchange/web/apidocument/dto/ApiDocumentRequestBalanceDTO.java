package com.apollo.exchange.web.apidocument.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
public class ApiDocumentRequestBalanceDTO {
    @ApiModelProperty(value = "Input walletAddressList",
            example = "walletAddressList=0x8014cee0f6f494429f2e76b3add33d2842b6126a&walletAddressList=0x267b19e6566fb46525f59dfd5e9f93d4c37b8746"
            , required = true)
    private List<String> walletAddressList;

}
