package com.apollo.exchange.admin.sell.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellTradeDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminSellTradeService {

    private final ICommonDao commonDao;

    public AdminSellTradeDTO selectOneBySellId(AdminSellSearchDTO adminSellSearchDTO){
        return commonDao.selectOne("AdminSellTrade.selectOneBySellId", adminSellSearchDTO);
    }

    /***/
    public void updateState(AdminSellTradeDTO adminSellTradeDTO){
        commonDao.update("AdminSellTrade.updateState", adminSellTradeDTO);
    }

    public void updateOne(AdminSellTradeDTO adminSellTradeDTO){
        commonDao.update("AdminSellTrade.updateOne", adminSellTradeDTO);
    }

    public void insertOne(AdminSellTradeDTO adminSellTradeDTO){
        commonDao.insert("AdminSellTrade.insertOne", adminSellTradeDTO);
    }

}
