package com.apollo.exchange.web.apidocument.dto;


import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;

@Data
public class ApiDocumentResponseCheckBuyDTO {

    @ApiModelProperty(value = "Response object", required = true)
    private ApiBuyResponseDTO apiResponseDTO;

    @Data
    public static class ApiBuyResponseDTO {

        @ApiModelProperty(value = "status of the request, Max = 20, Min = 3", example = "Success", required = true)
        private String state;

        @ApiModelProperty(value = "message of the request, Max = 100, Min = 3", example = "Required request value is missing", required = true)
        private String message;


        @ApiModelProperty(value = "Buy object of the buyId", required = true)
        private BuyCheck buyCheck;

        @Data
        public static class BuyCheck{

            @ApiModelProperty(value = "buyId of transaction buy, Type Integer, Max = 10, Min = 3", example = "111", required = true)
            private Integer buyId = null;

            @ApiModelProperty(value = "clientId of transaction buy, Type Integer, Max = 10, Min = 3", example = "1", required = true)
            private Integer clientId = null;

            @ApiModelProperty(value = "symbol of transaction buy, Type String, Max = 50, Min = 3", example = "BANI", required = true)
            private String symbol = null;

            @ApiModelProperty(value = "buyerWalletAddress of transaction buy, Type String, Max = 100, Min = 50",
                    example = "0x01f1bac212ec31bfd8c00f551da2ba482c35fb50", required = true)
            private String buyerWalletAddress = null;

            @ApiModelProperty(value = "quantity of transaction buy, Type BigDecimal, Max = 60, Min = 1",
                    example = "1.2", required = true)
            private BigDecimal quantity = null;

            @ApiModelProperty(value = "unitPrice of transaction buy, Type BigInteger, Max = 60, Min = 1",
                    example = "10", required = true)
            private BigInteger unitPrice = null;

            @ApiModelProperty(value = "totalPrice of transaction buy, Type BigInteger, Max = 60, Min = 1",
                    example = "10", required = true)
            private BigInteger totalPrice = null;

            @ApiModelProperty(value = "stateName of transaction buy, Type String, Max = 60, Min = 1",
                    example = "Finish", required = true)
            private String stateName = null;

            @ApiModelProperty(value = "tradeCompletionDate of transaction buy, Type Date, Max = 60, Min = 1",
                    example = "2022-10-01", required = true)
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
            private Date tradeCompletionDate = null;

            @ApiModelProperty(value = "buyRegDate of transaction buy, Type Date, Max = 60, Min = 1",
                    example = "2022-10-01", required = true)
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
            private Date buyRegDate = null;

            @ApiModelProperty(value = "txid of transaction buy, Type String, Max = 100, Min = 50",
                    example = "0xae81dce7b47ae73816f236cc9b7d2b5dd5b2506b845215d4aaad2d2c49a22b62", required = true)
            private String txid = null;

            @ApiModelProperty(value = "sellerWalletAddress of transaction buy, Type String, Max = 100, Min = 50",
                    example = "0x01f1bac212ec31bfd8c00f551da2ba482c35fb50", required = false)
            private String sellerWalletAddress = null;

            @ApiModelProperty(value = "bankName of owner, Max = 50, Min = 3", example = "SHINHANBANK", required = true)
            private String bankName = null;

            @ApiModelProperty(value = "bankOwner of owner, Max = 50, Min = 3", example = "LEE MIN-HO", required = true)
            private String bankOwner = null;
            @ApiModelProperty(value = "bankAccount of owner, Max = 50, Min = 3", example = "999999999", required = true)
            private String bankAccount = null;

            @ApiModelProperty(value = "tradeRegDate of transaction buy, Type Date, Max = 60, Min = 1",
                    example = "2022-10-01", required = false)
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
            private Date tradeRegDate = null;

            @ApiModelProperty(value = "langCode using, Type String, Max = 60, Min = 1",
                    example = "en_US", required = false)
            private String langCode = LocaleContextHolder.getLocale().toString();
        }

    }
}
