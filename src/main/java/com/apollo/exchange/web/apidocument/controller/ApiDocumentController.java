package com.apollo.exchange.web.apidocument.controller;


import com.apollo.exchange.common.api.service.RestApiService;
import com.apollo.exchange.common.utils.ObjectUtils;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.web.apidocument.dto.*;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.service.SellService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
public class ApiDocumentController {
    private final RestApiService restApiService;
    private final BuyService buyService;
    private final SellService sellService;

    @Value("${api.balance}")
    private String apiBalance;

    @Value("${api.create.wallet}")
    private String apiCreateWallet;

    @Value("${api.transfer}")
    private String apiTransfer;

    @Value("${api.transferWithFee}")
    private String apiTransferWithFee;

    @ApiOperation(value = "Create a new wallet", notes = "Create a new wallet",
            response = ApiDocumentResponseWalletDTO.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200,
                    message = "<b><span data-sw-translate>Successfully request." +
                            "<ul>" +
                            "<li><b>state = Success (<span data-sw-translate>Create a new wallet successful</span>).</b></li>" +
                            "<li><b><b>state = failed (<span data-sw-translate>please check response info message</span>):</b></li>" +
                            "</ul>" +
                            "<ul>" +
                            "<li><b> message = <span data-sw-translate>Required request value is missing.</span></b></li>" +
                            "<li><b> message = <span data-sw-translate>The wallet creation failed.</span</b></li>" +
                            "<li><b> message = <span data-sw-translate>The wallet private key not decrypt.</span></b></li>" +
                            "</ul>"

            ), @ApiResponse(code = 500, message = "Internal Server Error")})
    @ApiImplicitParam(name = "Authorization", value = "Access Token", required = true, paramType = "header", example = "Bearer access_token")
    @PostMapping(value = "/api/v1/create/wallet",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ApiDocumentResponseWalletDTO.ApiWalletResponseDTO createWallet(HttpServletRequest request, @RequestBody ApiDocumentRequestWalletDTO apiRequestDTO) {

        try {
            String authorization = request.getHeader("authorization");
            //Request to Api Service
            ApiDocumentResponseWalletDTO.ApiWalletResponseDTO res = restApiService.post(authorization, apiCreateWallet,
                    ObjectUtils.parameters(apiRequestDTO), HttpMethod.POST, ApiDocumentResponseWalletDTO.ApiWalletResponseDTO.class);
            log.info("createWallet ----- {}", res);
            return res;
        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }

    }

    @ApiOperation(value = "Transfer token at no fee", notes = "Transfer token at no fee", response = ApiDocumentResponseWalletDTO.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200,
                    message = "<b><span data-sw-translate>Successfully request." +
                            "<ul>" +
                            "<li><b>state = Success (<span data-sw-translate>The transfer token is successful</span>).</b></li>" +
                            "<li><b><b>state = failed (<span data-sw-translate>please check response info message</span>):</b></li>" +
                            "</ul>" +
                            "<ul>" +
                            "<li><b> message = <span data-sw-translate>The transfer is failed.</span></b></li>" +
                            "<li><b> message = <span data-sw-translate>The sending wallet address ( formWalletAddress ) does not exist.</span</b></li>" +
                            "<li><b> message = <span data-sw-translate>Incoming wallet address ( toWalletAddress ) does not exist.</span></b></li>" +
                            "<li><b> message = <span data-sw-translate>The token quantity in the wallet is currently insufficient.</span></b></li>" +
                            "</ul>"

            ), @ApiResponse(code = 500, message = "Internal Server Error")})
    @ApiImplicitParam(name = "Authorization", value = "Access Token", required = true, paramType = "header", example = "Bearer access_token")
    @PostMapping(value = "/api/v1/transfer/token",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ApiDocumentResponseTransferNoFeeDTO.ApiTransferResponseDTO transferTokenNoFee(HttpServletRequest request,
                                                                                         @RequestBody ApiDocumentRequestTransferNoFeeDTO apiRequestDTO) {

        try {
            String authorization = request.getHeader("authorization");
            //Request to Api Service
            ApiDocumentResponseTransferNoFeeDTO.ApiTransferResponseDTO res = restApiService.post(authorization, apiTransfer,
                    ObjectUtils.parameters(apiRequestDTO), HttpMethod.POST, ApiDocumentResponseTransferNoFeeDTO.ApiTransferResponseDTO.class);
            log.info("Transfer no fee ----- {}", res);
            return res;
        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }

    }


    @ApiOperation(value = "Get balance by walletAddress", notes = "Get balance by walletAddress", response = ApiDocumentResponseBalanceDTO.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200,
                    message = "<b><span data-sw-translate>Successfully request." +
                            "<ul>" +
                            "<li><b>state = Success (<span data-sw-translate>Get balance is successful.</span>).</b></li>" +
                            "<li><b><b>state = failed (<span data-sw-translate>please check response info message</span>):</b></li>" +
                            "</ul>" +
                            "<ul>" +
                            "<li><b> message = <span data-sw-translate>An invalid wallet address exists.</span></b></li>" +
                            "<li><b> message = <span data-sw-translate>Failed to Luniverse response.</span</b></li>" +
                            "</ul>"

            ), @ApiResponse(code = 500, message = "Internal Server Error")})
    @ApiImplicitParam(name = "Authorization", value = "Access Token", required = true, paramType = "header", example = "Bearer access_token")
    @GetMapping(value = "/api/v1/luniverse/balance",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ApiDocumentResponseBalanceDTO.ApiBalanceResponseDTO getBalance(HttpServletRequest request,
                                                                          @RequestParam String walletAddress) {
        try {

            String authorization = request.getHeader("authorization");
            Map<String, Object> mapParam = new HashMap<>();
            mapParam.put("walletAddressList", walletAddress);
            String buildUrl = UrlUtils.build(apiBalance, mapParam);

            //Request to Api Service
            ApiDocumentResponseBalanceDTO.ApiBalanceResponseDTO res = restApiService.get(authorization, buildUrl, mapParam, ApiDocumentResponseBalanceDTO.ApiBalanceResponseDTO.class);

            log.info("Balance response ----- {}", res);
            return res;
        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }

    }

    @ApiOperation(value = "Check token buy state", notes = "Check token buy state", response = ApiDocumentResponseCheckBuyDTO.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200,
                    message = "<b><span data-sw-translate>Successfully request." +
                            "<ul>" +
                            "<li><b>state = Success (<span data-sw-translate>Get data is successful.</span>).</b></li>" +
                            "<li><b><b>state = failed (<span data-sw-translate>please check response info message</span>):</b></li>" +
                            "</ul>" +
                            "<ul>" +
                            "<li><b> message = <span data-sw-translate>Get data is failed.</span></b></li>" +
                            "</ul>"

            ), @ApiResponse(code = 500, message = "Internal Server Error")})
    @GetMapping(value = "/api/v1/check/tokenBuy",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ApiDocumentResponseCheckBuyDTO.ApiBuyResponseDTO checkTokenBuy(HttpServletRequest request,
                                                                          @RequestParam int buyId) {

        ApiDocumentResponseCheckBuyDTO apiDocumentResponseCheckBuyDTO = new ApiDocumentResponseCheckBuyDTO();
        ApiDocumentResponseCheckBuyDTO.ApiBuyResponseDTO apiResponseDTO = new ApiDocumentResponseCheckBuyDTO.ApiBuyResponseDTO();
        try {

//            String authorization = request.getHeader("authorization");
            BuySearchDTO buySearchDTO = new BuySearchDTO();
            buySearchDTO.setBuyId(buyId);
            BuySearchDTO buyDTO = buyService.getBuyDetailByBuyId(buySearchDTO);
            if (null != buyDTO) {
                switch (buyDTO.getState()) {
                    case 1:
                        buyDTO.setStateName("Waiting");
                        break;
                    case 2:
                        buyDTO.setStateName("Trading");
                        break;
                    case 3:
                        buyDTO.setStateName("Finish");
                        break;
                }
            }
            ApiDocumentResponseCheckBuyDTO.ApiBuyResponseDTO.BuyCheck response = new ApiDocumentResponseCheckBuyDTO.ApiBuyResponseDTO.BuyCheck();
            response.setBuyId(buyDTO.getBuyId());
            response.setClientId(buyDTO.getClientId());
            response.setLangCode(buyDTO.getLangCode());
            response.setBuyerWalletAddress(buyDTO.getBuyerWalletAddress());
            response.setQuantity(buyDTO.getQuantity());
            response.setUnitPrice(buyDTO.getUnitPrice());
            response.setTotalPrice(buyDTO.getTotalPrice());
            response.setStateName(buyDTO.getStateName());
            response.setTradeCompletionDate(buyDTO.getTradeCompletionDate());
            response.setBuyRegDate(buyDTO.getBuyRegDate());
            response.setTxid(buyDTO.getTxid());
            response.setSellerWalletAddress(buyDTO.getSellerWalletAddress());
            response.setBankName(buyDTO.getBankName());
            response.setBankOwner(buyDTO.getBankOwner());
            response.setBankAccount(buyDTO.getBankAccount());
            response.setTradeRegDate(buyDTO.getTradeRegDate());

            apiResponseDTO.setState("Success.");
            apiResponseDTO.setMessage("Success.");
            apiResponseDTO.setBuyCheck(response);
            apiDocumentResponseCheckBuyDTO.setApiResponseDTO(apiResponseDTO);
            return apiDocumentResponseCheckBuyDTO.getApiResponseDTO();

        } catch (Exception ex) {

            log.error(ex.toString());
            apiResponseDTO.setState("Failed.");
            apiResponseDTO.setMessage("Get data is failed.");
            apiResponseDTO.setBuyCheck(null);
            apiDocumentResponseCheckBuyDTO.setApiResponseDTO(apiResponseDTO);
            return apiDocumentResponseCheckBuyDTO.getApiResponseDTO();
        }


    }


    @ApiOperation(value = "Check token sell state", notes = "Check token sell state", response = ApiDocumentResponseCheckSellDTO.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200,
                    message = "<b><span data-sw-translate>Successfully request." +
                            "<ul>" +
                            "<li><b>state = Success (<span data-sw-translate>Get data is successful.</span>).</b></li>" +
                            "<li><b><b>state = failed (<span data-sw-translate>please check response info message</span>):</b></li>" +
                            "</ul>" +
                            "<ul>" +
                            "<li><b> message = <span data-sw-translate>Get data is failed.</span></b></li>" +
                            "</ul>"

            ), @ApiResponse(code = 500, message = "Internal Server Error")})
    @GetMapping(value = "/api/v1/check/tokenSell",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ApiDocumentResponseCheckSellDTO.ApiSellResponseDTO checkTokenSell(HttpServletRequest request,
                                                                             @RequestParam int sellId) {

        ApiDocumentResponseCheckSellDTO apiDocumentResponseCheckSellDTO = new ApiDocumentResponseCheckSellDTO();
        ApiDocumentResponseCheckSellDTO.ApiSellResponseDTO apiResponseDTO = new ApiDocumentResponseCheckSellDTO.ApiSellResponseDTO();
        try {

//            String authorization = request.getHeader("authorization");
            SellSearchDTO sellSearchDTO = new SellSearchDTO();
            sellSearchDTO.setSellId(sellId);
            SellSearchDTO sellDTO = sellService.getSellDetailBySellId(sellSearchDTO);
            if (null != sellDTO) {
                switch (sellDTO.getState()) {
                    case 1:
                        sellDTO.setStateName("Waiting");
                        break;
                    case 2:
                        sellDTO.setStateName("Trading");
                        break;
                    case 3:
                        sellDTO.setStateName("Finish");
                        break;
                }
            }
            ApiDocumentResponseCheckSellDTO.ApiSellResponseDTO.SellCheck response = new ApiDocumentResponseCheckSellDTO.ApiSellResponseDTO.SellCheck();
            response.setSellId(sellDTO.getSellId());
            response.setClientId(sellDTO.getClientId());
            response.setLangCode(sellDTO.getLangCode());
            response.setBuyerWalletAddress(sellDTO.getBuyerWalletAddress());
            response.setQuantity(sellDTO.getQuantity());
            response.setUnitPrice(sellDTO.getUnitPrice());
            response.setTotalPrice(sellDTO.getTotalPrice());
            response.setStateName(sellDTO.getStateName());
            response.setTradeCompletionDate(sellDTO.getTradeCompletionDate());
            response.setSellRegDate(sellDTO.getSellRegDate());
            response.setTxid(sellDTO.getTxid());
            response.setSellerWalletAddress(sellDTO.getSellerWalletAddress());
            response.setBankName(sellDTO.getBankName());
            response.setBankOwner(sellDTO.getBankOwner());
            response.setBankAccount(sellDTO.getBankAccount());
            response.setTradeRegDate(sellDTO.getTradeRegDate());

            apiResponseDTO.setState("Success.");
            apiResponseDTO.setMessage("Success.");
            apiResponseDTO.setSellCheck(response);
            apiDocumentResponseCheckSellDTO.setApiSellResponseDTO(apiResponseDTO);
            return apiDocumentResponseCheckSellDTO.getApiSellResponseDTO();

        } catch (Exception ex) {

            log.error(ex.toString());
            apiResponseDTO.setState("Failed.");
            apiResponseDTO.setMessage("Get data is failed.");
            apiResponseDTO.setSellCheck(null);
            apiDocumentResponseCheckSellDTO.setApiSellResponseDTO(apiResponseDTO);
            return apiDocumentResponseCheckSellDTO.getApiSellResponseDTO();

        }

    }

}

