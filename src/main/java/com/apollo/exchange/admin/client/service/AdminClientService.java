package com.apollo.exchange.admin.client.service;

import com.apollo.exchange.admin.client.dto.AdminClientDTO;
import com.apollo.exchange.admin.client.dto.AdminClientSearchDTO;
import com.apollo.exchange.admin.user.dto.AdminUserDTO;
import com.apollo.exchange.admin.user.service.AdminUserService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author tuyen.dev
 * @apiNote Client entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminClientService {

    final ICommonDao iCommonDao;

    /**
     * if using [final]: error bean
     * AdminUserService (final AdminClientService) + AdminClientService (final AdminUserService)
     * can't use final
     * */
    @Autowired
    private AdminUserService adminUserService;

    public List<AdminClientDTO> getClientSiteOwner(){
        AdminClientSearchDTO adminClientSearchDTO = new AdminClientSearchDTO();
        adminClientSearchDTO.setRole("CLIENT");
        return selectClientOwner(adminClientSearchDTO);
    }

    public List<AdminClientDTO> getClientTraderOwner(){
        AdminClientSearchDTO adminClientSearchDTO = new AdminClientSearchDTO();
        adminClientSearchDTO.setRole("TRADER");
        return selectClientOwner(adminClientSearchDTO);
    }

    public AdminClientSearchDTO initParam(AdminClientSearchDTO adminClientSearchDTO, WalletDTO walletLogin){
        adminClientSearchDTO.setRows(1000);
        switch (walletLogin.getRole()){
            case DataStatic.WALLET_ROLE.OPERATOR:
                adminClientSearchDTO.setSymbol(walletLogin.getSymbol());
                break;
            case DataStatic.WALLET_ROLE.CLIENT:
                adminClientSearchDTO.setClientCode(walletLogin.getClientCode());
                break;
            default:
                break;
        }
        return adminClientSearchDTO;
    }

    public List<AdminClientDTO> getListByRole(WalletDTO walletLogin){
        AdminClientSearchDTO adminClientSearchDTO = new AdminClientSearchDTO();
        adminClientSearchDTO.setRows(1000);
        switch (walletLogin.getRole()){
            case DataStatic.WALLET_ROLE.OPERATOR:
                adminClientSearchDTO.setSymbol(walletLogin.getSymbol());
                break;
            case DataStatic.WALLET_ROLE.CLIENT:
                adminClientSearchDTO.setClientCode(walletLogin.getClientCode());
                break;
            default:
                break;
        }
        return getClientList(adminClientSearchDTO);
    }

    public int count(AdminClientSearchDTO adminClientSearchDTO) {
        return iCommonDao.count("AdminClient.selectCount", adminClientSearchDTO);
    }

    public List<AdminClientDTO> getClientList(AdminClientSearchDTO adminClientSearchDTO) {
        return iCommonDao.selectList("AdminClient.selectClientList", adminClientSearchDTO);
    }

    public List<AdminClientDTO> selectList(AdminClientSearchDTO adminClientSearchDTO) {
        return iCommonDao.selectList("AdminClient.selectList", adminClientSearchDTO);
    }

    public List<AdminClientDTO> selectClientOwner(AdminClientSearchDTO adminClientSearchDTO){
        return iCommonDao.selectList("AdminClient.selectClientOwner", adminClientSearchDTO);
    }

    /**
     * @param adminClientSearchDTO select by {clientId || clientCode || apiKey}
     * */
    public AdminClientDTO selectOne(AdminClientSearchDTO adminClientSearchDTO) {
        return iCommonDao.selectOne("AdminClient.selectOne", adminClientSearchDTO);
    }

    public Boolean isExists(AdminClientSearchDTO adminClientSearchDTO){
        List<AdminClientDTO> clients = selectList(adminClientSearchDTO);
        return clients.size() > 0;
    }

    public void register(AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO, AdminClientDTO clientDTO){
        //Create Client
        insertOne(clientDTO);

        //Create user
        adminWalletDTO.setRole(DataStatic.WALLET_ROLE.CLIENT);
        adminWalletDTO.setClientCode(clientDTO.getClientCode());
        adminWalletDTO.setClientId(clientDTO.getClientId());
        adminUserService.register(adminUserDTO, adminWalletDTO);
    }

    public void insertOne(AdminClientDTO adminClientDTO){
        iCommonDao.insert("AdminClient.insertOne", adminClientDTO);
    }

    public void updateOne(AdminClientDTO adminClientDTO){
        iCommonDao.update("AdminClient.updateOne", adminClientDTO);
    }
}
