package com.apollo.exchange.admin.wallet.service;

import com.apollo.exchange.admin.wallet.dto.AdminWalletRoleDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletRoleDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author tuyen.dev
 * @apiNote WalletRole entity business class
 */
@Service
@RequiredArgsConstructor
public class AdminWalletRoleService {

    private final ICommonDao commonDao;

    public void add(AdminWalletRoleDTO adminWalletRoleDTO) {
        commonDao.insert("AdminWalletRole.insertOne", adminWalletRoleDTO);
    }

    public void update(AdminWalletRoleDTO adminWalletRoleDTO){
        commonDao.update("AdminWalletRole.updateOne", adminWalletRoleDTO);
    }
}
