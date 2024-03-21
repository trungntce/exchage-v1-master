package com.apollo.exchange.admin.sell.service;

import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.web3j.protocol.admin.Admin;

import java.util.List;

/**
 * @author hipo.dev
 * @apiNote Sell entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminSellService {
    final ICommonDao iCommonDao;

    public AdminSellSearchDTO initParam(WalletDTO walletLogin, AdminSellSearchDTO sellSearchDTO){
        sellSearchDTO.setSymbol(null);
        sellSearchDTO.setClientCode(null);
        if("OPERATOR".equalsIgnoreCase(walletLogin.getRole())) {
            sellSearchDTO.setSymbol(walletLogin.getSymbol());
        }else if("CLIENT".equalsIgnoreCase(walletLogin.getRole())){
            sellSearchDTO.setClientCode(walletLogin.getClientCode());
        }
        return sellSearchDTO;
    }

    public int count(AdminSellSearchDTO sellSearchDTO, Integer sellType, String walletAddress) {
        sellSearchDTO.setSellType(sellType);
        sellSearchDTO.setWalletAddress(walletAddress);
        return iCommonDao.count("AdminSell.selectCount", sellSearchDTO);
    }

    public List<AdminSellDTO> getSellList(AdminSellSearchDTO sellSearchDTO, Integer sellType, String walletAddress) {
        sellSearchDTO.setSellType(sellType);
        sellSearchDTO.setWalletAddress(walletAddress);
        return iCommonDao.selectList("AdminSell.selectSellList", sellSearchDTO);
    }

    public AdminSellDTO getSell(AdminSellSearchDTO sellSearchDTO) {
        return iCommonDao.selectOne("AdminSell.selectOne", sellSearchDTO);
    }

    public AdminSellDTO getByPSellId(AdminSellSearchDTO sellSearchDTO){
        return iCommonDao.selectOne("AdminSell.selectByPSellId", sellSearchDTO);
    }

    /***/
    public void updateState(AdminSellDTO adminSellDTO){
        iCommonDao.update("AdminSell.updateState", adminSellDTO);
    }

    public void updateOne(AdminSellDTO adminSellDTO){
        iCommonDao.update("AdminSell.updateOne", adminSellDTO);
    }

    public void insertOne(AdminSellDTO adminSellDTO){
        iCommonDao.insert("AdminSell.insertOne", adminSellDTO);
    }
}