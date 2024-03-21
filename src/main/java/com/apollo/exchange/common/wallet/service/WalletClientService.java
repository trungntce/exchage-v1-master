package com.apollo.exchange.common.wallet.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletClientDTO;
import com.apollo.exchange.common.wallet.dto.WalletRoleDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author tuyen.dev
 * @apiNote WalletClient service
 */
@Service
@RequiredArgsConstructor
public class WalletClientService {

    private final ICommonDao commonDao;

    public void updateOne(WalletClientDTO walletClientDTO){
        commonDao.update("WalletClient.updateOne", walletClientDTO);
    }

    public void insertOne(WalletClientDTO walletClientDTO){
        commonDao.insert("WalletClient.insertOne", walletClientDTO);
    }
}
