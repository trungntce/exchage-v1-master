package com.apollo.exchange.admin.buy.service;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author tuyen.dev
 * @apiNote BuySellTrade service for entity
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminBuyTradeService {

    final ICommonDao iCommonDao;

    public AdminBuyTradeDTO selectOneByBuyId(AdminBuyTradeDTO adminBuyTradeDTO){
        return iCommonDao.selectOne("AdminBuyTrade.selectOneByBuyId", adminBuyTradeDTO);
    }

    public void updateOne(AdminBuyTradeDTO adminBuyTradeDTO){
        iCommonDao.update("AdminBuyTrade.updateOne", adminBuyTradeDTO);
    }

    /**
     * @param adminBuyTradeDTO {buyId, tradeStatus}
     * */
    public void updateState(AdminBuyTradeDTO adminBuyTradeDTO){
        iCommonDao.update("AdminBuyTrade.updateState", adminBuyTradeDTO);
    }

    public void insertOne(AdminBuyTradeDTO adminBuyTradeDTO){
        iCommonDao.insert("AdminBuyTrade.insertOne", adminBuyTradeDTO);
    }
}
