package com.apollo.exchange.admin.wallet.service;

import com.apollo.exchange.admin.wallet.dto.AdminWalletClientDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletClientDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author tuyen.dev
 * @apiNote WalletClient service
 */
@Service
@RequiredArgsConstructor
public class AdminWalletClientService {

    private final ICommonDao commonDao;

    public void updateOne(AdminWalletClientDTO adminWalletClientDTO){
        commonDao.update("AdminWalletClient.updateOne", adminWalletClientDTO);
    }

    public void insertOne(AdminWalletClientDTO adminWalletClientDTO){
        commonDao.insert("AdminWalletClient.insertOne", adminWalletClientDTO);
    }
}
