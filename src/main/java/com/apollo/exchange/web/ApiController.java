package com.apollo.exchange.web;

import com.apollo.exchange.admin.user.dto.AdminUserSearchDTO;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.service.SellService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.web3j.abi.datatypes.Int;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class ApiController {

    private final BuyService buyService;
    private final SellService sellService;
    private final WalletService walletService;

    @GetMapping("/sell/detail")
    public Object sellDetail(SellSearchDTO sellSearchDTO){
        return sellService.getSellDetailBySellId(sellSearchDTO);
    }

    @GetMapping("/buy/detail")
    public Object buyDetail(BuySearchDTO buySearchDTO){
        return buyService.getBuyDetailByBuyId(buySearchDTO);
    }

    @PostMapping("/wallet/deviceId")
    public boolean updateWalletDeviceId(WalletDTO walletDTO){
        return walletService.updateDeviceId(walletDTO);
    }
}
