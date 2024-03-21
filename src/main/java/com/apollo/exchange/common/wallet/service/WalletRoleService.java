package com.apollo.exchange.common.wallet.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletRoleDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author ionio.dev
 * @apiNote WalletRole entity business class
 */
@Service
@RequiredArgsConstructor
public class WalletRoleService {

    private final ICommonDao commonDao;

    public void add(WalletRoleDTO walletRoleDTO) {
        commonDao.insert("WalletRole.insertOne", walletRoleDTO);
    }

    public void update(WalletRoleDTO walletRoleDTO){
        commonDao.update("WalletRole.updateOne", walletRoleDTO);
    }
}
