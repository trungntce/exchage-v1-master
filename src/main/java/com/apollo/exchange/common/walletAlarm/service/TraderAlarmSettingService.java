package com.apollo.exchange.common.walletAlarm.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.common.walletAlarm.dto.TraderAlarmSettingDTO;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Component
@RequiredArgsConstructor
public class TraderAlarmSettingService {
    final ICommonDao commonDao;
    final private WalletService walletService;

    public TraderAlarmSettingDTO getAlarmSettingByWalletId(int walletId) {
        return commonDao.selectOne("TraderAlarmSetting.selectOneByWalletId", walletId);
    }

    public void save(TraderAlarmSettingDTO traderAlarmSettingDTO) {
        commonDao.insert("TraderAlarmSetting.insertOne", traderAlarmSettingDTO);
    }

    public void update(TraderAlarmSettingDTO traderAlarmSettingDTO) {
        commonDao.update("TraderAlarmSetting.updateOne", traderAlarmSettingDTO);
    }

    public boolean updateData(HttpServletRequest session, TraderAlarmSettingDTO traderAlarmSettingDTO) {
        WalletDTO walletSession = walletService.CompareSessionWallet(session.getSession(), traderAlarmSettingDTO.getWalletAddress());
        traderAlarmSettingDTO.setWalletId(walletSession.getWalletId());
        // If exists then update
        TraderAlarmSettingDTO settingData = getAlarmSettingByWalletId(walletSession.getWalletId());
        if (null != settingData && 0 < settingData.getTraderAlarmSettingId()) {
            // Update
            traderAlarmSettingDTO.setTraderAlarmSettingId(settingData.getTraderAlarmSettingId());
            this.update(traderAlarmSettingDTO);

            WalletDTO walletCurrentSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET_CURRENT);
            walletCurrentSession.setRepeatSeconds(traderAlarmSettingDTO.getRepeatSeconds());
            walletCurrentSession.setPath((traderAlarmSettingDTO.getPath() != null) ? traderAlarmSettingDTO.getPath() : settingData.getPath());
            walletCurrentSession.setUseYn((traderAlarmSettingDTO.getUseYn() != null) ? traderAlarmSettingDTO.getUseYn() : settingData.getUseYn());
            session.setAttribute(DataStatic.SESSION.WALLET_CURRENT, walletCurrentSession);

        } else {
            // Insert
            this.save(traderAlarmSettingDTO);
        }
        return true;
    }

}
