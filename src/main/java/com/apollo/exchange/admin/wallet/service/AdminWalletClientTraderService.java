package com.apollo.exchange.admin.wallet.service;

import com.apollo.exchange.admin.wallet.dto.AdminWalletClientDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletClientTraderDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author tuyen.dev
 * @apiNote WalletClient service
 */
@Service
@RequiredArgsConstructor
public class AdminWalletClientTraderService {

    private final ICommonDao commonDao;

    public void insertOne(AdminWalletClientTraderDTO adminWalletClientTraderDTO){
        commonDao.insert("AdminWalletClientTrader.insertOne", adminWalletClientTraderDTO);
    }
}
