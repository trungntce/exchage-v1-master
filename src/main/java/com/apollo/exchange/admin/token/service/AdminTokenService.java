package com.apollo.exchange.admin.token.service;

import com.apollo.exchange.admin.client.dto.AdminClientDTO;
import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.token.dto.AdminTokenDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.user.dto.AdminUserDTO;
import com.apollo.exchange.admin.user.service.AdminUserService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.admin.wallet.service.AdminWalletClientService;
import com.apollo.exchange.admin.wallet.service.AdminWalletService;
import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletClientService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author hipo.dev
 * @apiNote CommonCode entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminTokenService {

    final ICommonDao iCommonDao;

    @Autowired
    private AdminUserService adminUserService;

    @Autowired
    private AdminWalletClientService adminWalletClientService;

    @Autowired
    private AdminClientService adminClientService;

    @Autowired
    private AdminWalletService adminWalletService;

    public List<AdminTokenDTO> getListByRole(WalletDTO walletLogin){
        AdminTokenSearchDTO tokenSearchDTO = new AdminTokenSearchDTO();
        tokenSearchDTO.setRows(1000);
        if(walletLogin.getOperator() != null) tokenSearchDTO.setOperator(walletLogin.getOperator());
        switch (walletLogin.getRole()){
            case DataStatic.WALLET_ROLE.OPERATOR:
            case DataStatic.WALLET_ROLE.CLIENT:
                tokenSearchDTO.setSymbol(walletLogin.getSymbol());
                break;
            default:
                break;
        }
        return getTokenList(tokenSearchDTO);
    }

    public int count(AdminTokenSearchDTO tokenSearchDTO) {
        return iCommonDao.count("AdminToken.selectCount", tokenSearchDTO);
    }

    public List<AdminTokenDTO> getTokenList(AdminTokenSearchDTO tokenSearchDTO) {
        return iCommonDao.selectList("AdminToken.selectTokenList", tokenSearchDTO);
    }

    public AdminTokenDTO getToken(AdminTokenSearchDTO tokenSearchDTO) {
        return iCommonDao.selectOne("AdminToken.selectOne", tokenSearchDTO);
    }

    public Boolean isExists(AdminTokenSearchDTO tokenSearchDTO){
        AdminTokenDTO tokenDTO = getToken(tokenSearchDTO);
        return tokenDTO != null;
    }

    public AdminWalletDTO selectWalletOpByToken(AdminTokenSearchDTO adminTokenSearchDTO){
        return iCommonDao.selectOne("AdminToken.selectWalletOpByToken", adminTokenSearchDTO);
    }

    public void insertOne(AdminTokenDTO tokenDTO){
        iCommonDao.insert("AdminToken.insertOne", tokenDTO);
    }

    public void updateOne(AdminTokenDTO tokenDTO){
        iCommonDao.update("AdminToken.updateOne", tokenDTO);
    }

    public Integer register(AdminTokenDTO tokenDTO, AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO){
        //Create token
        AdminTokenSearchDTO tokenSearchDTO = new AdminTokenSearchDTO();
        tokenSearchDTO.setSymbol(tokenDTO.getSymbol());
        AdminTokenDTO tokenCheck = getToken(tokenSearchDTO);

        //Symbol is exists
        if(tokenCheck != null) return 1;

        insertOne(tokenDTO);

        //Create user + wallet
        adminWalletDTO.setRole(DataStatic.WALLET_ROLE.OPERATOR);
        adminUserService.register(adminUserDTO, adminWalletDTO);

        adminWalletDTO.setName(adminWalletDTO.getName().concat("-fee"));
        adminWalletDTO.setRole(DataStatic.WALLET_ROLE.OPERATOR_FEE);
        adminWalletService.register(adminWalletDTO);

        //Change symbol in userDTO
        //Request create wallet
        //Finish
        return 0;
    }
}
