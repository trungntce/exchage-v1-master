package com.apollo.exchange.common.user.service;

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
public class UserWalletService {

    private final ICommonDao commonDao;

    private final WalletService walletService;

    public boolean importWallet(WalletDTO walletLogin, String privateKey){
        WalletDTO walletImport = walletService.getWalletByPrivateKey(privateKey);
        if(walletImport.getWalletId() != null && walletLogin.getUserWalletId() != null){
            UserWalletDTO userWalletDTO = new UserWalletDTO();
            userWalletDTO.setWalletId(walletImport.getWalletId());

            // get USER_WALLET info by userWalletId
            UserWalletDTO mUserWallet = selectOneByUserWalletId(walletLogin.getUserWalletId());
            userWalletDTO.setUserId(mUserWallet.getUserId());
            this.add(userWalletDTO);
            return true;
        }
        return false;
    }

    public UserWalletDTO selectOneByUserWalletId(Integer userWalletId){
        return commonDao.selectOne("UserWallet.selectOneByUserWalletId", userWalletId);
    }

    public List<UserWalletDTO> selectByUserIdAndWalletId(UserWalletDTO userWalletDTO){
        return commonDao.selectList("UserWallet.selectByUserIdAndWalletId", userWalletDTO);
    }

    public void add(UserWalletDTO userWalletDTO) {
        List<UserWalletDTO> lstUserWallet = selectByUserIdAndWalletId(userWalletDTO);
        if(lstUserWallet.size() == 0){
            commonDao.insert("UserWallet.insertOne", userWalletDTO);
        }
    }
}
