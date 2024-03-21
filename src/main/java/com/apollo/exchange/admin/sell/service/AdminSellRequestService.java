package com.apollo.exchange.admin.sell.service;

import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellTradeDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletSearchDTO;
import com.apollo.exchange.admin.wallet.service.AdminWalletService;
import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminSellRequestService {

    private final ICommonDao commonDao;
    private final AdminSellTradeService adminSellTradeService;
    private final AdminSellService adminSellService;
    private final AdminTokenService tokenService;
    private final AdminWalletService adminWalletService;
    private final ApiService apiService;

    public AdminSellSearchDTO initParam(WalletDTO walletLogin, AdminSellSearchDTO adminSellSearchDTO){

        adminSellSearchDTO.setWalletAddress(walletLogin.getWalletAddress());
        adminSellSearchDTO.setSymbol(walletLogin.getSymbol());
        if(walletLogin.getRole().equals(DataStatic.WALLET_ROLE.CLIENT)){
            Integer[] states = {1};
            adminSellSearchDTO.setStates(Arrays.asList(states));
        }
        return adminSellSearchDTO;
    }

    public Integer count(AdminSellSearchDTO adminSellSearchDTO){
        return commonDao.count("AdminSellRequest.count", adminSellSearchDTO);
    }

    public List<AdminSellDTO> selectList(AdminSellSearchDTO adminSellSearchDTO){
        return commonDao.selectList("AdminSellRequest.selectList", adminSellSearchDTO);
    }

    /**
     * @role CLIENT
     * @description CLIENT apply trade (orderState = 1)
     * @process
     * */
    public void clientApply(WalletDTO walletLogin, AdminSellDTO sellDTO){

        AdminSellTradeDTO sellTradeDTO = new AdminSellTradeDTO();
        sellTradeDTO.setSellId(sellDTO.getSellId());
        sellTradeDTO.setTradeState(2);
        sellTradeDTO.setBuyerWalletAddress(walletLogin.getWalletAddress());
        adminSellTradeService.insertOne(sellTradeDTO);

        AdminSellDTO adminSellDTO = new AdminSellDTO();
        adminSellDTO.setSellId(sellDTO.getSellId());
        adminSellDTO.setState(1);
        adminSellService.updateState(adminSellDTO);
    }

    /**
     * @role CLIENT
     * @description CLIENT create request to OP
     * */
    public void clientRequest(WalletDTO walletLogin, AdminSellSearchDTO adminSellSearchDTO){
        //Buy order infor (Buy Parent)
        AdminSellDTO adminSellDTO = adminSellService.getSell(adminSellSearchDTO);

        //Get OP wallet address
        AdminTokenSearchDTO tokenSearchDTO = new AdminTokenSearchDTO();
        tokenSearchDTO.setSymbol(walletLogin.getSymbol());
        AdminTokenDTO tokenDTO = tokenService.getToken(tokenSearchDTO);
        AdminWalletSearchDTO walletSearchDTO = new AdminWalletSearchDTO();
        walletSearchDTO.setWalletAddress(tokenDTO.getWalletAddress());
        AdminWalletDTO walletOP = adminWalletService.getWallet(walletSearchDTO);

        //Create sell_order from CLIENT to OP (Sell Child)
        AdminSellDTO adminSellP = new AdminSellDTO();
        adminSellP.setPSellId(adminSellDTO.getSellId());
        adminSellP.setClientId(adminSellDTO.getClientId());
        adminSellP.setSellType(adminSellDTO.getSellType());
        adminSellP.setSymbol(adminSellDTO.getSymbol());
        adminSellP.setViewRole(adminSellDTO.getViewRole());
        adminSellP.setSellerWalletAddress(adminSellDTO.getBuyerWalletAddress());
        adminSellP.setQuantity(adminSellDTO.getQuantity());
        adminSellP.setUnitPrice(adminSellDTO.getUnitPrice());
        adminSellP.setTotalPrice(adminSellDTO.getTotalPrice());
        adminSellP.setState(2);
        adminSellP.setBankAccount(walletLogin.getBankAccount());
        adminSellP.setBankName(walletLogin.getBankName());
        adminSellP.setBankOwner(walletLogin.getBankOwner());
        adminSellP.setDelYn("N");
        adminSellP.setRegWalletAddress(walletLogin.getWalletAddress());
        adminSellService.insertOne(adminSellP);

        //Create buy_trade_order from CLIENT to OP
        AdminSellTradeDTO adminSellTradePDTO = new AdminSellTradeDTO();
        adminSellTradePDTO.setSellId(adminSellP.getSellId());
        adminSellTradePDTO.setTradeState(2);
        adminSellTradePDTO.setBuyerWalletAddress(walletOP.getWalletAddress());
        adminSellTradeService.insertOne(adminSellTradePDTO);

        //Update ref_buy_id for buy parent
        adminSellDTO.setPSellId(adminSellP.getSellId());
        adminSellService.updateOne(adminSellDTO);
    }

    /**
     * @role OP
     * @param adminSellSerSearch {sellId -> child}
     * @description OP apply request of CLIENT
     * */
    public void opApply(AdminSellSearchDTO adminSellSerSearch){

        //TODO: Update order (OP - CLIENT) finish
        //Buy order info (Buy Child)
        AdminSellDTO sellChild = adminSellService.getSell(adminSellSerSearch);

        //TODO: OP Transfer token to CLIENT
        //Update txId + status for BUY_TRADE (Child)
        String from = sellChild.getSellerWalletAddress();
        String to = sellChild.getBuyerWalletAddress();
        ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
        apiTransferDTO.setSymbol(sellChild.getSymbol());
        apiTransferDTO.setFromWalletAddress(from);
        apiTransferDTO.setToWalletAddress(to);
        apiTransferDTO.setQuantity(sellChild.getQuantity());
        String txId = apiService.transferNoFee(apiTransferDTO);

        AdminSellSearchDTO sellSearchDTO = new AdminSellSearchDTO();
        sellSearchDTO.setSellId(sellChild.getSellId());
        AdminSellTradeDTO sellTradeChild = adminSellTradeService.selectOneBySellId(sellSearchDTO);
        sellTradeChild.setTxid(txId);
        sellTradeChild.setTradeState(4);
        adminSellTradeService.updateOne(sellTradeChild);

        //Update status for BUY (Child)
        sellChild.setState(3);
        sellChild.setTradeCompletionDate(new Date());
        adminSellService.updateState(sellChild);
    }

    /**
     * @role CLIENT
     * @param adminSellSearch {sellId -> parent}
     * @description CLIENT transfer token to TRADER and finish order
     * */
    public void clientFinish(AdminSellSearchDTO adminSellSearch){
        //TODO: Update order (CLIENT - TRADER) finish
        AdminSellDTO sellParent = adminSellService.getSell(adminSellSearch);
        AdminSellTradeDTO sellTradeParent = adminSellTradeService.selectOneBySellId(adminSellSearch);

        //TODO: CLIENT transfer to Trader
        sellTradeParent.setTradeState(4);
        adminSellTradeService.updateOne(sellTradeParent);

        //Update status for Sell (Child)
        sellParent.setState(3);
        sellParent.setTradeCompletionDate(new Date());
        adminSellService.updateState(sellParent);
    }
}
