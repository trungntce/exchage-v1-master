package com.apollo.exchange.admin.buy.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminBuySafeService {

    final ICommonDao iCommonDao;

    @Autowired
    private AdminBuyService adminBuyService;

    @Autowired
    private AdminBuyTradeService adminBuyTradeService;

    public AdminBuySearchDTO initParam(WalletDTO walletLogin, AdminBuySearchDTO adminBuySearchDTO){
        adminBuySearchDTO.setWalletAddress(walletLogin.getWalletAddress());
        return adminBuySearchDTO;
    }

    public Integer count(AdminBuySearchDTO searchDTO){
        return iCommonDao.count("AdminBuySafe.selectCount", searchDTO);
    }

    public void confirmTxID(AdminBuyTradeDTO adminBuyTradeDTO){
        if(adminBuyTradeDTO.getTxid().trim().length() > 0){
            AdminBuyTradeDTO buyTradeDTO = adminBuyTradeService.selectOneByBuyId(new AdminBuyTradeDTO(adminBuyTradeDTO.getBuyId()));
            buyTradeDTO.setTxid(adminBuyTradeDTO.getTxid());
            adminBuyTradeService.updateOne(buyTradeDTO);
            AdminBuyDTO adminBuyDTO = adminBuyService.getBuy(new AdminBuySearchDTO(adminBuyTradeDTO.getBuyId()));
            adminBuyDTO.setState(2);
            adminBuyService.updateOne(adminBuyDTO);
        }
    }

    public void confirmCashDeposit(AdminBuyTradeDTO adminBuyTradeDTO){
        AdminBuyDTO adminBuyDTO = adminBuyService.getBuy(new AdminBuySearchDTO(adminBuyTradeDTO.getBuyId()));
        adminBuyDTO.setState(3);
        AdminBuyDTO adminPBuyDTO = adminBuyService.getByPBuyId(new AdminBuySearchDTO(0, adminBuyDTO.getBuyId()));
        adminPBuyDTO.setState(3);
        adminBuyService.updateOne(adminBuyDTO);
        adminBuyService.updateOne(adminPBuyDTO);
    }

    public List<AdminBuyDTO> selectList(AdminBuySearchDTO searchDTO){
        return iCommonDao.selectList("AdminBuySafe.selectList", searchDTO);
    }
}
