package com.apollo.exchange.common.user.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.dto.UserWalletDTO;
import com.apollo.exchange.common.utils.CryptoUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.dto.WalletRoleDTO;
import com.apollo.exchange.common.wallet.service.WalletRoleService;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author ntt.dev
 * @serviceNote User service logic class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final ICommonDao commonDao;
    private final WalletService walletService;
    private final UserWalletService userWalletService;
    private final WalletRoleService walletRoleService;


    public void update(UserDTO userDTO) {
        commonDao.update("User.updateOne", userDTO);
    }

    private void register(UserDTO userDTO) {
        commonDao.insert("User.insertOne", userDTO);
    }

    public UserDTO userRegistrationProcess(UserDTO userDTO) {

        try {
            // Check exists user
            WalletDTO walletExists = walletService.getFirstDataByLoginId(userDTO.getLoginId());
            if (null != walletExists) {

                return null;
            }

            // Implementation of the process of creating a new wallet if there is no wallet
            // (using apollo-api /v1 /api /create /wallet)
            WalletDTO walletDTO = new WalletDTO(userDTO);
            WalletDTO walletInfo = walletService.createWallet(walletDTO);
            walletInfo = walletService.getData(walletInfo.getWalletAddress());
            walletInfo.setEmail(userDTO.getMail());

            WalletRoleDTO walletRoleDTO = new WalletRoleDTO();
            walletRoleDTO.setWalletId(walletInfo.getWalletId());
            walletRoleDTO.setRole(walletInfo.getRole());
            walletRoleService.update(walletRoleDTO);

            // Insert user to database
            String oldPw = userDTO.getLoginPw();
            String encryptedPassword = CryptoUtils.SHA256encryptor(userDTO.getLoginPw());
            userDTO.setLoginPw(encryptedPassword);
            this.register(userDTO);
            log.info("UserRegister: {}", userDTO);

            // Insert USER_WALLET
            UserWalletDTO userWalletDTO = new UserWalletDTO();
            userWalletDTO.setUserId(userDTO.getUserId());
            userWalletDTO.setWalletId(walletInfo.getWalletId());
            userWalletService.add(userWalletDTO);

            userDTO.setLoginPw(oldPw);
            userDTO.setWalletId(walletInfo.getWalletId());
            return userDTO;
        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }
    }

    public UserDTO selectUserByWalletAddress(String walletAddress) {
        return commonDao.selectOne("User.selectUserByWalletAddress", walletAddress);
    }
    public UserDTO selectUserByUserId(Integer userId) {
        return commonDao.selectOne("User.selectUserByUserId", userId);
    }


}
