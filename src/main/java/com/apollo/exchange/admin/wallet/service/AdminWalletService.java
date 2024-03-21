package com.apollo.exchange.admin.wallet.service;

import com.apollo.exchange.admin.client.dto.AdminClientDTO;
import com.apollo.exchange.admin.client.dto.AdminClientSearchDTO;
import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.wallet.dto.*;
import com.apollo.exchange.common.api.dto.ApiDTO;
import com.apollo.exchange.common.api.service.RestApiService;
import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.CryptoUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote CommonCode entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminWalletService {

    final ICommonDao iCommonDao;
    private final RestApiService restApiService;
    private final AdminWalletRoleService adminWalletRoleService;
    private final AdminWalletClientService adminWalletClientService;
    private final AdminWalletClientTraderService adminWalletClientTraderService;

    @Autowired
    private AdminClientService adminClientService;

    @Value("${api.admin.create.wallet}")
    private String apiAdminCreateWallet;

    public AdminWalletSearchDTO initParam(WalletDTO walletLogin, AdminWalletSearchDTO adminWalletSearchDTO){
        adminWalletSearchDTO.setSymbol(null);
        adminWalletSearchDTO.setClientCode(null);
        if("OPERATOR".equalsIgnoreCase(walletLogin.getRole())) {
            adminWalletSearchDTO.setSymbol(walletLogin.getSymbol());
        }else if("CLIENT".equalsIgnoreCase(walletLogin.getRole())){
            adminWalletSearchDTO.setClientCode(walletLogin.getClientCode());
        }
        return adminWalletSearchDTO;
    }

    public int count(AdminWalletSearchDTO adminWalletSearchDTO) {
        return iCommonDao.count("AdminWallet.selectCount", adminWalletSearchDTO);
    }

    public List<AdminWalletDTO> selectList(AdminWalletSearchDTO adminWalletSearchDTO) {
        return iCommonDao.selectList("AdminWallet.selectList", adminWalletSearchDTO);
    }

    public List<AdminWalletDTO> selectListNoLimit(AdminWalletSearchDTO adminWalletSearchDTO) {
        return iCommonDao.selectList("AdminWallet.selectListNoLimit", adminWalletSearchDTO);
    }

    /**
     * @param adminWalletSearchDTO {walletId / walletAddress}
     * */
    public AdminWalletDTO getWallet(AdminWalletSearchDTO adminWalletSearchDTO) {
        return iCommonDao.selectOne("AdminWallet.selectOne", adminWalletSearchDTO);
    }

    /**
     * @return {walletAddress, privateKey}
     * */
    public AdminWalletDTO createWallet(AdminWalletDTO adminWalletDTO) {

        try {
            //Request to Api Service
            ApiDTO res = restApiService.post(apiAdminCreateWallet, adminWalletDTO, HttpMethod.POST, ApiDTO.class);
            AdminWalletDTO walletInfo = new AdminWalletDTO();
            walletInfo.setWalletAddress(res.getResponse().getCreateWalletResponse().getWalletAddress());
            walletInfo.setPrivateKey(res.getResponse().getCreateWalletResponse().getPrivateKey());
            return walletInfo;
        } catch (Exception ex) {
            log.error(ex.toString());
            return null;
        }
    }

    public AdminWalletDTO register(AdminWalletDTO adminWalletDTO){
        //Create wallet
        adminWalletDTO.setPassword(adminWalletDTO.getWalletPw());
        AdminWalletDTO adminWalletRes = createWallet(adminWalletDTO);

        //Insert wallet
        adminWalletDTO.setWalletAddress(adminWalletRes.getWalletAddress());
        adminWalletDTO.setPrivateKey(adminWalletRes.getPrivateKey());
        adminWalletDTO.setWalletPw(CryptoUtils.SHA256encryptor(adminWalletDTO.getWalletPw()));
        adminWalletDTO.setFee(0.1);
        insert(adminWalletDTO);

        //Insert role
        AdminWalletRoleDTO adminWalletRoleDTO = new AdminWalletRoleDTO();
        adminWalletRoleDTO.setWalletId(adminWalletDTO.getWalletId());
        adminWalletRoleDTO.setRole(adminWalletDTO.getRole());
        adminWalletRoleService.add(adminWalletRoleDTO);


        //Insert Wallet Client
        if (adminWalletDTO.getClientCode() != null && adminWalletDTO.getClientCode().length() > 0){
            AdminClientSearchDTO adminClientSearchDTO = new AdminClientSearchDTO();
            adminClientSearchDTO.setClientCode(adminWalletDTO.getClientCode());
            //Select client ID
            List<AdminClientDTO> clients = adminClientService.selectList(adminClientSearchDTO);
            Integer clientId = 0;
            if(clients.size() > 0){
                clientId = clients.get(0).getClientId();
            }

            AdminWalletClientDTO adminWalletClientDTO = new AdminWalletClientDTO();
            adminWalletClientDTO.setWalletId(adminWalletDTO.getWalletId());
            adminWalletClientDTO.setClientId(clientId);
            adminWalletClientService.insertOne(adminWalletClientDTO);

            //Check role wallet and insert WALLET_CLIENT_TRADER
            if(adminWalletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CLIENT_TRADER)){
                AdminWalletClientTraderDTO adminWalletClientTraderDTO = new AdminWalletClientTraderDTO();
                adminWalletClientTraderDTO.setSymbol(adminWalletDTO.getSymbol());
                adminWalletClientTraderDTO.setWalletId(adminWalletDTO.getWalletId());
                adminWalletClientTraderDTO.setClientId(clientId);
                adminWalletClientTraderService.insertOne(adminWalletClientTraderDTO);
            }
        }

        return adminWalletDTO;
    }

    public void insert(AdminWalletDTO adminWalletDTO){
        iCommonDao.insert("AdminWallet.insertOne", adminWalletDTO);
    }

    public void update(AdminWalletDTO adminWalletDTO){
        if(adminWalletDTO.getWalletPw() != null && adminWalletDTO.getWalletPw().length() > 0){
            adminWalletDTO.setWalletPw(CryptoUtils.SHA256encryptor(adminWalletDTO.getWalletPw()));
        }
        iCommonDao.update("AdminWallet.updateOne", adminWalletDTO);
    }
}
