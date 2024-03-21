package com.apollo.exchange.admin.buy.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
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

/**
 * @author tuyen.dev
 * @apiNote My buy service
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminBuyMyTradeService {

    private final ICommonDao commonDao;
    private final AdminBuyService adminBuyService;
    private final ApiService apiService;
    private final AdminBuyTradeService adminBuyTradeService;
    private final WalletService walletService;

    public AdminBuySearchDTO initParam(WalletDTO walletLogin, AdminBuySearchDTO adminBuySearchDTO){
        adminBuySearchDTO.setWalletAddress(walletLogin.getWalletAddress());
        return adminBuySearchDTO;
    }

    public Integer count(AdminBuySearchDTO adminBuySearchDTO){
        return commonDao.count("AdminBuyMyTrade.count", adminBuySearchDTO);
    }

    public List<AdminBuyDTO> selectList(AdminBuySearchDTO adminBuySearchDTO){
        return commonDao.selectList("AdminBuyMyTrade.selectList", adminBuySearchDTO);
    }

    public AdminBuyDTO finish(WalletDTO walletLogin, AdminBuySearchDTO buySearchDTO){
        AdminBuyDTO buyDTO = adminBuyService.getBuy(buySearchDTO);
        if(buyDTO.getState() == 2){

            if(walletLogin.getWalletAddress().equalsIgnoreCase(buyDTO.getSellerWalletAddress())){
                String from = buyDTO.getSellerWalletAddress();
                String to = buyDTO.getBuyerWalletAddress();
                ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
                apiTransferDTO.setSymbol(buyDTO.getSymbol());
                apiTransferDTO.setFromWalletAddress(from);
                apiTransferDTO.setToWalletAddress(to);
                apiTransferDTO.setQuantity(buyDTO.getQuantity());
                String txId = apiService.transferNoFee(apiTransferDTO);
                //TODO: Change function transfer -> get transaction information
                if(txId.length() == 0) return null;

                //Update buy trade history
                AdminBuyTradeDTO adminBuyTradeSearch = new AdminBuyTradeDTO();
                adminBuyTradeSearch.setBuyId(buyDTO.getBuyId());
                adminBuyTradeSearch = adminBuyTradeService.selectOneByBuyId(adminBuyTradeSearch);
                adminBuyTradeSearch.setTxid(txId);
                adminBuyTradeSearch.setTradeState(4);
                adminBuyTradeService.updateOne(adminBuyTradeSearch);

                //Update buy state
                buyDTO.setState(3);
                buyDTO.setTradeCompletionDate(new Date());
                adminBuyService.updateState(buyDTO);
            } else {
                //TODO: Error message (Not permission)
            }
        } else {
            //TODO: Error message (Order can't apply)
        }
        return buyDTO;
    }

    public AdminBuyDTO register(WalletDTO walletLogin, AdminBuyDTO adminBuyDTO){
        WalletDTO sellWallet = walletService.getData(adminBuyDTO.getSellerWalletAddress());
        String viewRole = DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), sellWallet.getRole());
        if(viewRole == null) return null;

        adminBuyDTO.setSymbol(sellWallet.getSymbol());
        adminBuyDTO.setViewRole(viewRole);
        adminBuyDTO.setBuyType(1);
        adminBuyDTO.setBuyerWalletAddress(walletLogin.getWalletAddress());
        adminBuyDTO.setState(2);
        adminBuyDTO.setDelYn("N");
        adminBuyDTO.setRegWalletAddress(walletLogin.getWalletAddress());
        adminBuyService.insertOne(adminBuyDTO);

        AdminBuyTradeDTO adminBuyTradeDTO = new AdminBuyTradeDTO();
        adminBuyTradeDTO.setBuyId(adminBuyDTO.getBuyId());
        adminBuyTradeDTO.setTradeState(2);
        adminBuyTradeDTO.setSellerWalletAddress(sellWallet.getWalletAddress());
        adminBuyTradeDTO.setBankName(sellWallet.getBankName());
        adminBuyTradeDTO.setBankOwner(sellWallet.getBankOwner());
        adminBuyTradeDTO.setBankAccount(sellWallet.getBankAccount());
        adminBuyTradeService.insertOne(adminBuyTradeDTO);
        return adminBuyDTO;
    }

}