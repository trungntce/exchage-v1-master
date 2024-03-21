package com.apollo.exchange.admin.buy.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletSearchDTO;
import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote Buy entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminBuyService {

    final ICommonDao iCommonDao;
    private final WalletService walletService;
    private final AdminBuyTradeService adminBuyTradeService;
    private final ApiService apiService;

    public AdminBuySearchDTO initParam(WalletDTO walletLogin, AdminBuySearchDTO adminBuySearchDTO){
        adminBuySearchDTO.setSymbol(null);
        adminBuySearchDTO.setClientCode(null);
        if("OPERATOR".equalsIgnoreCase(walletLogin.getRole())) {
            adminBuySearchDTO.setSymbol(walletLogin.getSymbol());
        }else if("CLIENT".equalsIgnoreCase(walletLogin.getRole())){
            adminBuySearchDTO.setClientCode(walletLogin.getClientCode());
        }
        return adminBuySearchDTO;
    }

    public int count(AdminBuySearchDTO buySearchDTO, Integer buyType, String walletAddress) {
        buySearchDTO.setBuyType(buyType);
        buySearchDTO.setWalletAddress(walletAddress);
        return iCommonDao.count("AdminBuy.selectCount", buySearchDTO);
    }

    public List<AdminBuyDTO> getBuyList(AdminBuySearchDTO buySearchDTO, Integer buyType, String walletAddress) {
        buySearchDTO.setBuyType(buyType);
        buySearchDTO.setWalletAddress(walletAddress);
        return iCommonDao.selectList("AdminBuy.selectBuyList", buySearchDTO);
    }

    public AdminBuyDTO getBuy(AdminBuySearchDTO buySearchDTO) {
        return iCommonDao.selectOne("AdminBuy.selectOne", buySearchDTO);
    }

    public AdminBuyDTO getByPBuyId(AdminBuySearchDTO buySearchDTO){
        return iCommonDao.selectOne("AdminBuy.selectByPBuyId", buySearchDTO);
    }

    public void updateState(AdminBuyDTO adminBuyDTO){
        iCommonDao.update("AdminBuy.updateState", adminBuyDTO);
    }

    public void updateOne(AdminBuyDTO adminBuyDTO){
        adminBuyDTO.setTradeCompletionDate(new Date());
        iCommonDao.update("AdminBuy.updateOne", adminBuyDTO);
    }

    public void insertOne(AdminBuyDTO adminBuyDTO){
        iCommonDao.insert("AdminBuy.insertOne", adminBuyDTO);
    }
}