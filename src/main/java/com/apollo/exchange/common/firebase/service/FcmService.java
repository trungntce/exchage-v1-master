package com.apollo.exchange.common.firebase.service;

import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.google.firebase.messaging.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class FcmService {

    @Autowired
    private WalletService walletService;

    public void sendToAllTrader(String symbol, Integer buyId, Integer sellId, String content) {
        List<String> registrationTokens = walletService.selectTokenDeviceId(new WalletDTO(symbol, DataStatic.WALLET_ROLE.TRADER));
        if (registrationTokens.size() > 0) {
            send(registrationTokens, buyId, sellId, content);
        }
    }

    public void sendToWallet(Integer walletId, String walletAddress, Integer buyId, Integer sellId, String content) {
        List<String> registrationTokens = walletService.selectTokenDeviceId(new WalletDTO(walletId, walletAddress));
        if (registrationTokens.size() > 0) {
            send(registrationTokens, buyId, sellId, content);
        }
    }

    public void send(List<String> registrationTokens, Integer buyId, Integer sellId, String content) {
        String url = "";
        if (buyId.equals(0)) {
            url = "http://101.101.209.212:9007/tradeSellDetail?sellId=" + sellId;
        } else {
            url = "http://101.101.209.212:9007/tradeBuyDetail?buyId=" + buyId;
        }
        MulticastMessage message = MulticastMessage.builder()
                .setNotification(Notification.builder().setTitle("구매등록").setBody(content).build())
                .putData("buyId", String.valueOf(buyId))
                .putData("sellId", String.valueOf(sellId))
                .putData("userId", "")
                .putData("password", "1hour")
                .putData("type", (buyId.equals(0)) ? "SELL" : "BUY")
                .putData("URL", url)
                .addAllTokens(registrationTokens)
                .build();
        BatchResponse response = null;
        try {
            response = FirebaseMessaging.getInstance().sendMulticast(message);
            if (response.getFailureCount() > 0) {
                List<SendResponse> responses = response.getResponses();
                List<String> failedTokens = new ArrayList<>();
                for (int i = 0; i < responses.size(); i++) {
                    if (!responses.get(i).isSuccessful()) {
                        failedTokens.add(registrationTokens.get(i));
                    }
                }
                System.out.println("List of tokens that caused failures: " + failedTokens);
            }
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }
    }

}
