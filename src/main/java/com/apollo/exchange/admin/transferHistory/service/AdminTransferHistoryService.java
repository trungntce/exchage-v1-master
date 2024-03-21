package com.apollo.exchange.admin.transferHistory.service;

import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.transferHistory.dto.AdminTransferHistorySearchDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author hipo.dev
 * @apiNote Sell entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminTransferHistoryService {
    final ICommonDao iCommonDao;

    public AdminTransferHistorySearchDTO initParam(WalletDTO walletInfo, AdminTransferHistorySearchDTO searchDTO){
        if(walletInfo.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CLIENT)){
            searchDTO.setClientCode(walletInfo.getClientCode());
        }
        return searchDTO;
    }

    public int count(AdminTransferHistorySearchDTO adminTransferHistorySearchDTO) {
        return iCommonDao.count("AdminTransferHistory.selectCount", adminTransferHistorySearchDTO);
    }

    public List<AdminSellDTO> selectList(AdminTransferHistorySearchDTO adminTransferHistorySearchDTO) {
        return iCommonDao.selectList("AdminTransferHistory.selectList", adminTransferHistorySearchDTO);
    }

}