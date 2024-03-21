package com.apollo.exchange.admin.buy.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
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

/**
 * @author tuyen.dev
 * @apiNote buy request service
 * @sequence Trader -> Client -> OP
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminBuyRequestService {

    private final ICommonDao commonDao;
    private final AdminBuyTradeService adminBuyTradeService;
    private final AdminBuyService adminBuyService;
    private final AdminTokenService tokenService;
    private final AdminWalletService adminWalletService;
    private final ApiService apiService;

    public AdminBuySearchDTO initParam(WalletDTO walletLogin, AdminBuySearchDTO adminBuySearchDTO){

       adminBuySearchDTO.setWalletAddress(walletLogin.getWalletAddress());
       adminBuySearchDTO.setSymbol(walletLogin.getSymbol());
       if(walletLogin.getRole().equals(DataStatic.WALLET_ROLE.CLIENT)){
           Integer[] states = {1};
           adminBuySearchDTO.setStates(Arrays.asList(states));
       }
       return adminBuySearchDTO;
    }

    /**
     * @role CLIENT
     * @description CLIENT apply trade (orderState = 1)
     * @process
     * */
    public void clientApply(WalletDTO walletLogin, AdminBuyDTO buyDTO){

        AdminBuyTradeDTO buyTradeDTO = new AdminBuyTradeDTO();
        buyTradeDTO.setSellerWalletAddress(walletLogin.getWalletAddress());
        buyTradeDTO.setBuyId(buyDTO.getBuyId());
        buyTradeDTO.setTradeState(2);
        buyTradeDTO.setBankAccount(walletLogin.getBankAccount());
        buyTradeDTO.setBankName(walletLogin.getBankName());
        buyTradeDTO.setBankOwner(walletLogin.getBankOwner());
        adminBuyTradeService.insertOne(buyTradeDTO);

        AdminBuyDTO adminBuyDTO = new AdminBuyDTO();
        adminBuyDTO.setBuyId(buyDTO.getBuyId());
        adminBuyDTO.setState(2);
        adminBuyService.updateState(adminBuyDTO);
    }

    /**
     * @role CLIENT
     * @description CLIENT create request to OP
     * */
    public void clientRequest(WalletDTO walletLogin, AdminBuySearchDTO adminBuySearchDTO){
        //Buy order infor (Buy Parent)
        AdminBuyDTO adminBuyDTO = adminBuyService.getBuy(adminBuySearchDTO);

        //Get OP wallet address
        AdminTokenSearchDTO tokenSearchDTO = new AdminTokenSearchDTO();
        tokenSearchDTO.setSymbol(walletLogin.getSymbol());
        AdminTokenDTO tokenDTO = tokenService.getToken(tokenSearchDTO);
        AdminWalletSearchDTO walletSearchDTO = new AdminWalletSearchDTO();
        walletSearchDTO.setWalletAddress(tokenDTO.getWalletAddress());
        AdminWalletDTO walletOP = adminWalletService.getWallet(walletSearchDTO);

        //Create buy_order from CLIENT to OP (Buy Child)
        AdminBuyDTO adminBuyP = new AdminBuyDTO();
        adminBuyP.setPBuyId(adminBuyDTO.getBuyId());
        adminBuyP.setClientId(adminBuyDTO.getClientId());
        adminBuyP.setBuyType(adminBuyDTO.getBuyType());
        adminBuyP.setSymbol(adminBuyDTO.getSymbol());
        adminBuyP.setViewRole(adminBuyDTO.getViewRole());
        adminBuyP.setBuyerWalletAddress(adminBuyDTO.getSellerWalletAddress());
        adminBuyP.setQuantity(adminBuyDTO.getQuantity());
        adminBuyP.setUnitPrice(adminBuyDTO.getUnitPrice());
        adminBuyP.setTotalPrice(adminBuyDTO.getTotalPrice());
        adminBuyP.setState(2);
        adminBuyP.setDelYn("N");
        adminBuyP.setRegWalletAddress(walletLogin.getWalletAddress());
        adminBuyService.insertOne(adminBuyP);

        //Create buy_trade_order from CLIENT to OP
        AdminBuyTradeDTO adminBuyPTradeDTO = new AdminBuyTradeDTO();
        adminBuyPTradeDTO.setBuyId(adminBuyP.getBuyId());
        adminBuyPTradeDTO.setTradeState(2);
        adminBuyPTradeDTO.setSellerWalletAddress(tokenDTO.getWalletAddress());
        adminBuyPTradeDTO.setBankName(walletOP.getBankName());
        adminBuyPTradeDTO.setBankAccount(walletOP.getBankAccount());
        adminBuyPTradeDTO.setBankOwner(walletOP.getBankOwner());
        adminBuyTradeService.insertOne(adminBuyPTradeDTO);

        //Update ref_buy_id for buy parent
        adminBuyDTO.setPBuyId(adminBuyP.getBuyId());
        adminBuyService.updateOne(adminBuyDTO);
    }

    /**
     * @role OP
     * @param adminBuySearchDTO {buyId -> child}
     * @description OP apply request of CLIENT
     * */
    public void opApply(AdminBuySearchDTO adminBuySearchDTO){

        //TODO: Update order (OP - CLIENT) finish
        //Buy order info (Buy Child)
        AdminBuyDTO buyChild = adminBuyService.getBuy(adminBuySearchDTO);

        //TODO: OP Transfer token to CLIENT
        //Update txId + status for BUY_TRADE (Child)
        String from = buyChild.getSellerWalletAddress();
        String to = buyChild.getBuyerWalletAddress();
        ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
        apiTransferDTO.setSymbol(buyChild.getSymbol());
        apiTransferDTO.setFromWalletAddress(from);
        apiTransferDTO.setToWalletAddress(to);
        apiTransferDTO.setQuantity(buyChild.getQuantity());
        String txId = apiService.transferNoFee(apiTransferDTO);

        AdminBuyTradeDTO buyTradeChild = new AdminBuyTradeDTO();
        buyTradeChild.setBuyId(buyChild.getBuyId());
        buyTradeChild = adminBuyTradeService.selectOneByBuyId(buyTradeChild);
        buyTradeChild.setTxid(txId);
        buyTradeChild.setTradeState(4);
        adminBuyTradeService.updateOne(buyTradeChild);

        //Update status for BUY (Child)
        buyChild.setState(3);
        buyChild.setTradeCompletionDate(new Date());
        adminBuyService.updateState(buyChild);
    }

    /**
     * @role CLIENT
     * @param adminBuySearchDTO {buyId -> parent}
     * @description CLIENT transfer token to TRADER and finish order
     * */
    public void clientFinish(AdminBuySearchDTO adminBuySearchDTO){
        //TODO: Update order (CLIENT - TRADER) finish
        AdminBuyDTO buyParent = adminBuyService.getBuy(adminBuySearchDTO);
        AdminBuyTradeDTO buyTradeParent = new AdminBuyTradeDTO();
        buyTradeParent.setBuyId(buyParent.getBuyId());
        buyTradeParent = adminBuyTradeService.selectOneByBuyId(buyTradeParent);

        //TODO: CLIENT transfer to Trader
        String from = buyParent.getSellerWalletAddress();
        String to = buyParent.getBuyerWalletAddress();
        ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
        apiTransferDTO.setSymbol(buyParent.getSymbol());
        apiTransferDTO.setFromWalletAddress(from);
        apiTransferDTO.setToWalletAddress(to);
        apiTransferDTO.setQuantity(buyParent.getQuantity());
        String txId = apiService.transferNoFee(apiTransferDTO);

        buyTradeParent.setTxid(txId);
        buyTradeParent.setTradeState(4);
        adminBuyTradeService.updateOne(buyTradeParent);

        //Update status for BUY (Child)
        buyParent.setState(3);
        buyParent.setTradeCompletionDate(new Date());
        adminBuyService.updateState(buyParent);
    }

    public Integer count(AdminBuySearchDTO adminBuySearchDTO){
        return commonDao.count("AdminBuyRequest.count", adminBuySearchDTO);
    }

    public List<AdminBuyDTO> selectList(AdminBuySearchDTO adminBuySearchDTO){
        return commonDao.selectList("AdminBuyRequest.selectList", adminBuySearchDTO);
    }
}