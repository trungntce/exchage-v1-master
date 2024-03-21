package com.apollo.exchange.admin.sell.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.admin.buy.service.AdminBuyService;
import com.apollo.exchange.admin.buy.service.AdminBuyTradeService;
import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellTradeDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminSellSafeService {

    final ICommonDao iCommonDao;

    @Autowired
    private AdminSellService adminSellService;

    @Autowired
    private AdminSellTradeService adminSellTradeService;

    public AdminSellSearchDTO initParam(WalletDTO walletLogin, AdminSellSearchDTO searchDTO){
        searchDTO.setWalletAddress(walletLogin.getWalletAddress());
        return searchDTO;
    }

    public Integer count(AdminSellSearchDTO searchDTO){
        return iCommonDao.count("AdminSellSafe.selectCount", searchDTO);
    }

    public void confirmTxID(AdminSellTradeDTO adminSellTradeDTO){
        if(adminSellTradeDTO.getTxid().trim().length() > 0){
            AdminSellTradeDTO sellTradeDTO = adminSellTradeService.selectOneBySellId(new AdminSellSearchDTO(adminSellTradeDTO.getSellId()));
            sellTradeDTO.setTxid(adminSellTradeDTO.getTxid());
            sellTradeDTO.setTradeState(4);
            adminSellTradeService.updateOne(sellTradeDTO);
        }
    }

    public void confirmCashDeposit(AdminSellTradeDTO adminSellTradeDTO){
        AdminSellDTO adminSellDTO = adminSellService.getSell(new AdminSellSearchDTO(adminSellTradeDTO.getSellId()));
        adminSellDTO.setState(3);
        AdminSellDTO adminPSell = adminSellService.getByPSellId(new AdminSellSearchDTO(0, adminSellTradeDTO.getSellId()));
        adminPSell.setState(3);
        adminSellService.updateOne(adminPSell);
        adminSellService.updateOne(adminSellDTO);
    }

    public List<AdminBuyDTO> selectList(AdminSellSearchDTO searchDTO){
        return iCommonDao.selectList("AdminSellSafe.selectList", searchDTO);
    }
}
