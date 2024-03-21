package com.apollo.exchange.admin.sell.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellTradeDTO;
import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminSellMyTradeService {

    private final ICommonDao commonDao;
    private final WalletService walletService;
    private final AdminSellService adminSellService;
    private final AdminSellTradeService adminSellTradeService;
    private final ApiService apiService;

    public AdminSellSearchDTO initParam(WalletDTO walletLogin, AdminSellSearchDTO adminSellSearchDTO){
        adminSellSearchDTO.setWalletAddress(walletLogin.getWalletAddress());
        return adminSellSearchDTO;
    }

    public Integer count(AdminSellSearchDTO adminSellSearchDTO){
        return commonDao.count("AdminSellMyTrade.count", adminSellSearchDTO);
    }

    public List<AdminSellDTO> selectList(AdminSellSearchDTO adminSellSearchDTO){
        return commonDao.selectList("AdminSellMyTrade.selectList", adminSellSearchDTO);
    }

    public AdminSellDTO register(WalletDTO walletLogin, AdminSellDTO adminSellDTO){
        WalletDTO buyWallet = walletService.getData(adminSellDTO.getBuyerWalletAddress());
        String viewRole = DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), buyWallet.getRole());
        log.info("VIEW_ROLE {} - {} - {}", viewRole, walletLogin.getRole(), buyWallet.getRole());
        if(viewRole == null) return null;

        adminSellDTO.setSymbol(buyWallet.getSymbol());
        adminSellDTO.setViewRole(viewRole);
        adminSellDTO.setSellType(1);
        adminSellDTO.setSellerWalletAddress(walletLogin.getWalletAddress());
        adminSellDTO.setState(2);
        adminSellDTO.setDelYn("N");
        adminSellDTO.setBankOwner(walletLogin.getBankOwner());
        adminSellDTO.setBankName(walletLogin.getBankName());
        adminSellDTO.setBankAccount(walletLogin.getBankAccount());
        adminSellDTO.setRegWalletAddress(walletLogin.getWalletAddress());
        adminSellService.insertOne(adminSellDTO);

        AdminSellTradeDTO sellTradeDTO = new AdminSellTradeDTO();
        sellTradeDTO.setSellId(adminSellDTO.getSellId());
        sellTradeDTO.setTradeState(2);
        sellTradeDTO.setBuyerWalletAddress(buyWallet.getWalletAddress());
        adminSellTradeService.insertOne(sellTradeDTO);
        return adminSellDTO;
    }

    public AdminSellDTO finish(WalletDTO walletLogin, AdminSellSearchDTO sellSearchDTO){
        AdminSellDTO sellDTO = adminSellService.getSell(sellSearchDTO);
        if(sellDTO.getState() == 2){

            if(walletLogin.getWalletAddress().equalsIgnoreCase(sellDTO.getBuyerWalletAddress())){
                String from = sellDTO.getSellerWalletAddress();
                String to = sellDTO.getBuyerWalletAddress();
                ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
                apiTransferDTO.setSymbol(sellDTO.getSymbol());
                apiTransferDTO.setFromWalletAddress(from);
                apiTransferDTO.setToWalletAddress(to);
                apiTransferDTO.setQuantity(sellDTO.getQuantity());
                String txId = apiService.transferNoFee(apiTransferDTO);
                //TODO: Change function transfer -> get transaction information
                if(txId.length() == 0) return null;

                //Update sell trade history
                AdminSellTradeDTO adminSellTradeDTO = new AdminSellTradeDTO();
                adminSellTradeDTO.setSellId(sellDTO.getSellId());
                adminSellTradeDTO = adminSellTradeService.selectOneBySellId(sellSearchDTO);
                adminSellTradeDTO.setTxid(txId);
                adminSellTradeDTO.setTradeState(4);
                adminSellTradeService.updateOne(adminSellTradeDTO);

                //Update buy state
                sellDTO.setState(3);
                sellDTO.setTradeCompletionDate(new Date());
                adminSellService.updateState(sellDTO);
            } else {
                //TODO: Error message (Not permission)
            }
        } else {
            //TODO: Error message (Order can't apply)
        }
        return sellDTO;
    }
}
