package com.apollo.exchange.admin.user.service;

import com.apollo.exchange.admin.user.dto.AdminUserDTO;
import com.apollo.exchange.admin.user.dto.AdminUserSearchDTO;
import com.apollo.exchange.admin.user.dto.AdminUserWalletDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.admin.wallet.service.AdminWalletService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
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
public class AdminUserService {

    final ICommonDao iCommonDao;
    private final AdminUserWalletService adminUserWalletService;

    @Autowired
    private AdminWalletService adminWalletService;

    public AdminUserSearchDTO initParam(WalletDTO walletLogin, AdminUserSearchDTO userSearchDTO){
        if("OPERATOR".equalsIgnoreCase(walletLogin.getRole())) {
            userSearchDTO.setSymbol(walletLogin.getSymbol());
        }else if("CLIENT".equalsIgnoreCase(walletLogin.getRole())){
            userSearchDTO.setClientCode(walletLogin.getClientCode());
        }
        return userSearchDTO;
    }

    public int count(AdminUserSearchDTO userSearchDTO) {
        return iCommonDao.count("AdminUser.selectCount", userSearchDTO);
    }

    public List<AdminUserDTO> getUserList(AdminUserSearchDTO userSearchDTO) {
        return iCommonDao.selectList("AdminUser.selectUserList", userSearchDTO);
    }

    public List<AdminUserDTO> getByLoginId(AdminUserSearchDTO userSearchDTO) {
        return iCommonDao.selectList("AdminUser.selectByLoginId", userSearchDTO);
    }

    public AdminUserDTO getUser(AdminUserSearchDTO userSearchDTO) {
        return iCommonDao.selectOne("AdminUser.selectOne", userSearchDTO);
    }

    public Boolean isExists(AdminUserSearchDTO userSearchDTO){
        List<AdminUserDTO> users = getByLoginId(userSearchDTO);
        return users.size() > 0;
    }

    public Boolean register(AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO) {
        //Check loginId is exists
        AdminUserSearchDTO adminUserSearchDTO = new AdminUserSearchDTO();
        adminUserSearchDTO.setLoginId(adminUserDTO.getLoginId());
        if(isExists(adminUserSearchDTO)) return false;

        //Insert user
        insert(adminUserDTO);

        //Insert wallet
        adminWalletDTO.setWalletPw(adminUserDTO.getLoginPw());
        adminWalletService.register(adminWalletDTO);

        //Insert UserWallet
        AdminUserWalletDTO adminUserWalletDTO = new AdminUserWalletDTO();
        adminUserWalletDTO.setUserId(adminUserDTO.getUserId());
        adminUserWalletDTO.setWalletId(adminWalletDTO.getWalletId());
        adminUserWalletService.insert(adminUserWalletDTO);
        return true;
    }

    public void insert(AdminUserDTO adminUserDTO){
        iCommonDao.insert("AdminUser.insertOne", adminUserDTO);
    }

    public void update(AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO){
        iCommonDao.update("AdminUser.updateOne", adminUserDTO);
        adminWalletService.update(adminWalletDTO);
    }
}