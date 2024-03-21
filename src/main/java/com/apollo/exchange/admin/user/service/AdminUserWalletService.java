package com.apollo.exchange.admin.user.service;

import com.apollo.exchange.admin.user.dto.AdminUserWalletDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.user.dto.UserWalletDTO;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ntt.dev
 * @serviceNote UserWalletService entity business class
 */
@Service
@RequiredArgsConstructor
public class AdminUserWalletService {

    private final ICommonDao commonDao;

    public void insert(AdminUserWalletDTO adminUserWalletDTO) {
        commonDao.insert("UserWallet.insertOne", adminUserWalletDTO);
    }
}
