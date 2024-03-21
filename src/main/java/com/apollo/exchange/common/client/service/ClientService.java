package com.apollo.exchange.common.client.service;

import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletClientService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote CommonCode entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ClientService {

    final ICommonDao iCommonDao;
    final UserService userService;
    final WalletClientService walletClientService;

    public List<ClientDTO> getClientSiteOwner(){
        ClientSearchDTO clientSearchDTO = new ClientSearchDTO();
        clientSearchDTO.setRole("CLIENT");
        return selectClientOwner(clientSearchDTO);
    }

    public List<ClientDTO> getClientTraderOwner(){
        ClientSearchDTO clientSearchDTO = new ClientSearchDTO();
        clientSearchDTO.setRole("TRADER");
        return selectClientOwner(clientSearchDTO);
    }

    public List<ClientDTO> getListByRole(WalletDTO walletLogin){
        ClientSearchDTO clientSearchDTO = new ClientSearchDTO();
        clientSearchDTO.setRows(1000);
        switch (walletLogin.getRole()){
            case DataStatic.WALLET_ROLE.SYSTEM:
            case DataStatic.WALLET_ROLE.CENTRAL_BANK:

                break;
            case DataStatic.WALLET_ROLE.OPERATOR:
                clientSearchDTO.setSymbol(walletLogin.getSymbol());
                break;
            case DataStatic.WALLET_ROLE.CLIENT:
                clientSearchDTO.setClientCode(walletLogin.getClientCode());
                break;
            default:
                break;
        }
        return getClientList(clientSearchDTO);
    }

    public int count(ClientSearchDTO clientSearchDTO) {
        return iCommonDao.count("Client.selectCount", clientSearchDTO);
    }

    public List<ClientDTO> getClientList(ClientSearchDTO clientSearchDTO) {
        return iCommonDao.selectList("Client.selectClientList", clientSearchDTO);
    }

    public List<ClientDTO> selectClientOwner(ClientSearchDTO clientSearchDTO){
        return iCommonDao.selectList("Client.selectClientOwner", clientSearchDTO);
    }

    /**
     * @param clientSearchDTO select by {clientId || clientCode || apiKey}
     * */
    public ClientDTO selectOne(ClientSearchDTO clientSearchDTO) {
        return iCommonDao.selectOne("Client.selectOne", clientSearchDTO);
    }

    public Boolean isExists(ClientSearchDTO clientSearchDTO){
        List<ClientDTO> clients = getClientList(clientSearchDTO);
        return clients.size() > 0;
    }

    public void register(UserDTO userDTO, ClientDTO clientDTO){
        //Create Client
        insertOne(clientDTO);

        //Create user
        userDTO.setRole(DataStatic.WALLET_ROLE.CLIENT);
        userDTO.setClientCode(clientDTO.getClientCode());
        userDTO = userService.userRegistrationProcess(userDTO);
    }

    public void insertOne(ClientDTO clientDTO){
        iCommonDao.insert("Client.insertOne", clientDTO);
    }

    public void updateOne(ClientDTO clientDTO){
        iCommonDao.update("Client.updateOne", clientDTO);
    }

    public ClientDTO getDataByApiKey(String apiKey) {
        return iCommonDao.selectOne("Client.selectOneByApiKey", apiKey);
    }
    public List<ClientDTO> getClientAndClientTraderByClientId(String clientId) {
        return iCommonDao.selectList("Client.selectClientAndClientTraderByClientId", clientId);
    }
//

}
