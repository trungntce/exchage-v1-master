package com.apollo.exchange.common.wallet.service;

import com.apollo.exchange.common.api.dto.ApiDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.api.service.RestApiService;
import com.apollo.exchange.common.utils.CryptoUtils;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.web3j.crypto.Wallet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author ionio.dev
 * @apiNote Wallet entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class WalletService {

    private final ICommonDao commonDao;
    private final RestApiService restApiService;

    @Value("${api.balance}")
    private String apiBalance;

    @Value("${api.create.wallet}")
    private String apiCreateWallet;

    public WalletDTO getOne(WalletDTO walletDTO) {
        return commonDao.selectOne("Wallet.selectOne", walletDTO);
    }

    public WalletDTO getData(String walletAddress) {
        return commonDao.selectOne("Wallet.selectOneByWalletAddress", walletAddress);
    }

    public WalletDTO getFirstDataByLoginId(String walletAddress) {
        return commonDao.selectOne("Wallet.selectOneFirstByLoginId", walletAddress);
    }

    public WalletDTO getWalletByPrivateKey(String privateKey) {
        return commonDao.selectOne("Wallet.selectOneByPrivateKey", privateKey);
    }

    /***
     * @author ntt.dev
     * @note get list wallets by loginId
     * @param walletAddress
     * @return
     */
    public List<Map<String, Object>> getListWalletsByLoginId(String walletAddress) {
        return commonDao.selectList("Wallet.selectListWalletsByLoginId", walletAddress);
    }

    public WalletDTO createWallet(WalletDTO walletDTO) {
        try {
            //Request to Api Service
            ApiDTO res = restApiService.post(apiCreateWallet, walletDTO.toMap(), HttpMethod.POST, ApiDTO.class);
            log.info("createWallet ----- {}", res);
            return res.getResponse().getCreateWalletResponse();
        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }

    }

    public void update(WalletDTO walletDTO) {

        try {
            String encryptedPassword = CryptoUtils.SHA256encryptor(walletDTO.getWalletPw());
            walletDTO.setWalletPw(encryptedPassword);
            commonDao.update("Wallet.updateOne", walletDTO);
        } catch (Exception ex) {
            log.error(ex.toString());
        }
    }

    public boolean updateByMyRoom(HttpSession session, WalletDTO walletDTO) {

        WalletDTO walletSession;
        if (walletDTO.getWalletAddress() != null && !"".equals(walletDTO.getWalletAddress())) {
            walletSession = CompareSessionWallet(session, walletDTO.getWalletAddress());
        } else {
            walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
        }
        if (walletDTO.getWalletPw() != null) {
            String encryptedPassword = CryptoUtils.SHA256encryptor(walletDTO.getWalletPw());
            walletDTO.setWalletPw(encryptedPassword);
        }
        WalletDTO dataUpdate = getData(walletSession.getWalletAddress());
        dataUpdate.setBankAccount(walletDTO.getBankAccount());
        dataUpdate.setBankName(walletDTO.getBankName());
        dataUpdate.setBankOwner(walletDTO.getBankOwner());
        commonDao.update("Wallet.updateOne", dataUpdate);
        return true;
    }

    /**
     * @param session
     * @param wallet
     * @return
     * @author ntt.dev
     * @note Compare session with string wallet
     */
    public WalletDTO CompareSessionWallet(HttpSession session, String wallet) {

        try {
            ObjectMapper mapper = new ObjectMapper();
            // Check Wallet
            WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
            for (int i = 0; i < walletSession.getWallets().size(); i++) {
                Object objWallet = (Object) walletSession.getWallets().get(i);
                if (objWallet instanceof WalletDTO) {
                    WalletDTO wl = (WalletDTO) walletSession.getWallets().get(i);
                    if (wl.getWalletAddress().equalsIgnoreCase(wallet)) {
                        return wl;
                    }

                } else {
                    Map<String, Object> map = walletSession.getWallets().get(i);
                    if (map.get("walletAddress").equals(wallet)) {
                        return new WalletDTO(map);
                    }
                }
            }
        } catch (Exception ex) {
            log.error(ex.toString());
        }
        return null;
    }

    public WalletDTO getWalletCurrent(HttpSession session, String walletCurrent) {
        WalletDTO walletDTO = new WalletDTO();
        walletDTO.setRole("guest");
        try {
            WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
            if (null != walletSession) {
                for (int i = walletSession.getWallets().size() - 1; i >= 0; i--) {
                    Object objWallet = (Object) walletSession.getWallets().get(i);
                    if (objWallet instanceof WalletDTO) {
                        walletDTO = (WalletDTO) walletSession.getWallets().get(i);
                    } else {
                        Map<String, Object> map = walletSession.getWallets().get(i);
                        walletDTO = new WalletDTO(map);
                    }
                    if (walletDTO.getWalletAddress().equalsIgnoreCase(walletCurrent)) {
                        return walletDTO;
                    }
                }
            }
        } catch (Exception ex) {
            log.error("ERROR GET WALLET CURRENT: " + ex);
        }
        return walletDTO;
    }

    public boolean updateDeviceId(WalletDTO walletDTO) {
        WalletDTO walletInfo = getOne(walletDTO);
        if (walletInfo != null) {
            walletInfo.setTokenDeviceId(walletDTO.getTokenDeviceId());
            commonDao.update("Wallet.updateOne", walletInfo);
            return true;
        }
        return false;
    }

    public List<String> selectTokenDeviceId(WalletDTO walletDTO) {
        return commonDao.selectList("Wallet.selectTokenDeviceId", walletDTO);
    }

    public WalletDTO selectOwnerWalletFee(WalletDTO walletDTO) {
        WalletDTO search = new WalletDTO();
        if (walletDTO == null) return null;
        if (walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CENTRAL_BANK)) {
            search.setSymbol(null);
            search.setRole(DataStatic.WALLET_ROLE.VIETKO_FEE);
        } else if (walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.OPERATOR)
                || walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CLIENT)) {
            search.setSymbol(walletDTO.getSymbol());
            search.setRole(DataStatic.WALLET_ROLE.OPERATOR_FEE);
        } else {
            return null;
        }
        return commonDao.selectOne("Wallet.selectOwnerWalletFee", search);
    }

    public WalletDTO selectWalletByRoleAndSymbol(WalletDTO walletDTO) {
        return commonDao.selectOne("Wallet.selectWalletByRoleAndSymbol", walletDTO);
    }


}
