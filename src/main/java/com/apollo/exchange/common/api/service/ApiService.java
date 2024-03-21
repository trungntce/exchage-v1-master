package com.apollo.exchange.common.api.service;

import com.apollo.exchange.common.api.dto.ApiDTO;
import com.apollo.exchange.common.api.dto.ApiResponseDTO;
import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ApiService {
    @Value("${api.transfer}")
    private String apiTransfer;

    @Value("${api.transferWithFee}")
    private String apiTransferWithFee;

    @Value("${api.balance}")
    private String apiBalance;

    @Value("${api.history}")
    private String apiHistory;

    private final RestApiService restApiService;

    public String transferNoFee(ApiTransferDTO transferDTO) {
        ApiDTO res = restApiService.post(apiTransfer, transferDTO.toMap(), HttpMethod.POST, ApiDTO.class);
        System.out.println("Data Test "+new Gson().toJson(res));
        System.out.println("Data Param "+new Gson().toJson(transferDTO));
        return ("Success.".equalsIgnoreCase(res.getState())) ? res.getResponse().getTransferTokenResponse().getTxid() : "";
    }

    public String transferWithFee(ApiTransferDTO transferDTO) {
        ApiDTO res = restApiService.post(apiTransferWithFee, transferDTO.toMap(), HttpMethod.POST, ApiDTO.class);
        return ("Success.".equalsIgnoreCase(res.getState())) ? res.getResponse().getTransferTokenResponse().getTxid() : "";
    }

    public BigDecimal getBalance(HttpSession session, String symbol, String walletAddress) {
        String wallet = walletAddress;
        if (walletAddress == null || walletAddress.trim().length() == 0) {
//            WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
//            wallet = walletSession.getWalletAddress();
            return new BigDecimal(0);
        }

        Map<String, Object> mapParam = new HashMap<>();
        mapParam.put("walletAddressList", wallet);
        mapParam.put("symbol", symbol);
        String buildUrl = UrlUtils.build(apiBalance, mapParam);
        ApiDTO res = restApiService.get(buildUrl, mapParam, ApiDTO.class);
        if (res.getResponse().getLuniverseWalletList().size() > 0) {
            return res.getResponse().getLuniverseWalletList().get(0).getBalance();
        } else {
            return new BigDecimal(0);
        }
    }

    public ApiResponseDTO getMyTransactionHistory(WalletDTO walletDTO, ApiTransferDTO apiTransferDTO){
        if(apiTransferDTO.getFromWalletAddress() == null) apiTransferDTO.setFromWalletAddress(walletDTO.getWalletAddress());
        String urlApi = UrlUtils.build(apiHistory, apiTransferDTO.toMap());
        ApiDTO res = restApiService.get(urlApi, new HashMap<>(), ApiDTO.class);
        return res.getResponse();
    }

}
