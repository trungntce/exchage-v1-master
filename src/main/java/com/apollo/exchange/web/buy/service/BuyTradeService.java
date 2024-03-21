package com.apollo.exchange.web.buy.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import com.apollo.exchange.web.buy.dto.*;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ntt.dev
 * @apiNote logic business class
 */


@Slf4j
@Service
@RequiredArgsConstructor
public class BuyTradeService {

    final ICommonDao iCommonDao;
    final private BuyService buyService;
    final private WalletService walletService;
    @Autowired
    @Lazy
    private WalletAlarmService walletAlarmService;


    public BuyTradeDTO getBuyTradeByBuyTradeHistoryId(BuyTradeDTO buyTradeDTO) {

        return iCommonDao.selectOne("TokenBuyTradeHistory.selectOneByBuyTradeHistoryId", buyTradeDTO);
    }

    public void updateByBuyId(BuyTradeDTO buyTradeDTO) {

        iCommonDao.update("TokenBuyTradeHistory.updateByBuyId", buyTradeDTO);
    }

    public void update(BuyTradeDTO buyTradeDTO) {

        iCommonDao.update("TokenBuyTradeHistory.updateOne", buyTradeDTO);
    }

    public void updateStateByIds(BuyTradeDTO buyTradeDTO) {

        iCommonDao.update("TokenBuyTradeHistory.updateStateByIds", buyTradeDTO);
    }


    public void buyTradeSave(BuyTradeDTO buyTradeDTO) {

        iCommonDao.insert("TokenBuyTradeHistory.insertOne", buyTradeDTO);
    }

    public boolean buyTradeCancel(HttpSession session, BuyTradeDTO buyTradeDTO) {

        try {

            if (buyTradeDTO == null
                    || buyTradeDTO.getBuyId() <= 0
                    || buyTradeDTO.getBuyTradeHistoryId() <= 0) {
                return false;
            }

            // Select buy detail
            BuySearchDTO buyDetail = new BuySearchDTO();
            buyDetail.setBuyId(buyTradeDTO.getBuyId());
            buyDetail = buyService.getBuyDetailByBuyId(buyDetail);

            // Select buyTrade detail
            BuyTradeDTO buyTradeDetail = getBuyTradeByBuyTradeHistoryId(buyTradeDTO);

            if (buyDetail == null || buyTradeDetail == null) {

                return false;
            }

            // Check owner
            WalletDTO walletDTO = walletService.CompareSessionWallet(session, buyDetail.getSellerWalletAddress());
            if (walletDTO == null) {

                return false;
            }
            if (buyDetail.getState() == 2
                    && buyTradeDetail.getTradeState() == 1) {

                // Update TokenBuy table where state = 5 and TradeState = 5
                buyDetail.setState(5);// Cancel
                buyService.updateOne(buyDetail);

                // Update TokenBuyTradeHistory tradeState = 5
                buyTradeDTO.setTradeState(5); // Cancel
                this.updateByBuyId(buyTradeDTO);

                return true;
            }

        } catch (Exception ex) {

            log.error(ex.toString());
        }
        return false;

    }

    @Transactional(rollbackFor = {Exception.class})
    public boolean buyTradeApply(HttpSession session, BuyTradeDTO buyTradeDTO) {

        try {

            log.info("BUY TRADE APPLY: {}", new Gson().toJson(buyTradeDTO));
            // Check Role
            WalletDTO walletDTO = walletService.CompareSessionWallet(session, buyTradeDTO.getSellerWalletAddress());
            if (walletDTO == null) {

                log.error("COMPARE WALLET IS NULL.");
                return false;
            }
            if (!walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.USER)
                    && !walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.TRADER)
                    && !walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CLIENT_TRADER)) {

                log.error("YOU ARE NOT PERMISSION.");
                return false;
            }

            // Get BuyId
            BuySearchDTO buyDTO = new BuySearchDTO();
            buyDTO.setBuyId(buyTradeDTO.getBuyId());
            buyDTO = buyService.getBuyDetailByBuyId(buyDTO);
            if (buyDTO == null || buyDTO.getState() != 1) {

                log.error("BUY ID IS NULL OR BUY STATE NOT EQUALS {}", buyDTO);
                return false;
            }
            // Update Buy
            buyDTO.setState(2);// Update status trading
            buyService.updateOne(buyDTO);

            // Insert data to TokenBuyTradeHistory
            if ((walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.TRADER) ||
                    walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CLIENT_TRADER))
                    && buyDTO.getBuyType() == 2) {
                buyTradeDTO.setBuyId(buyDTO.getBuyId());
                buyTradeDTO.setBankName(buyTradeDTO.getBankName());
                buyTradeDTO.setBankOwner(buyTradeDTO.getBankOwner());
                buyTradeDTO.setBankAccount(buyTradeDTO.getBankAccount());
                buyTradeDTO.setTradeState(2);
            } else {
                buyTradeDTO.setTradeState(1);
                buyTradeDTO.setBuyId(buyDTO.getBuyId());
                buyTradeDTO.setBankName(walletDTO.getBankName());
                buyTradeDTO.setBankOwner(walletDTO.getBankOwner());
                buyTradeDTO.setBankAccount(walletDTO.getBankAccount());
            }

            this.buyTradeSave(buyTradeDTO);
            log.info("INSERT IS SUCCESSFUL, BUY ID: , BUY_TRADE_HISTORY_ID: {}", buyTradeDTO.getBuyTradeHistoryId());

            if (DataStatic.VIEW_ROLE.OWNER_SAFE.equalsIgnoreCase(buyDTO.getViewRole())) {

                BuySearchDTO buySafeDTO = new BuySearchDTO();
                buySafeDTO.setBuyId(buyDTO.getPBuyId());
                buySafeDTO = buyService.getBuyDetailByBuyId(buySafeDTO);
                buySafeDTO.setState(4);
                buyService.updateOne(buySafeDTO);

                // Get Operator token//
                WalletDTO walletOp = new WalletDTO();
                walletOp.setRole(DataStatic.WALLET_ROLE.OPERATOR);
                walletOp.setSymbol(buyDTO.getSymbol());
                walletOp = walletService.selectWalletByRoleAndSymbol(walletOp);

                // Insert data to TokenBuyTradeHistory, OWNER_SAFE
                BuyTradeDTO buyTradeSafeDTO = new BuyTradeDTO();
                buyTradeSafeDTO.setBuyId(buySafeDTO.getBuyId());
                buyTradeSafeDTO.setSellerWalletAddress(walletOp.getWalletAddress());
                buyTradeSafeDTO.setBankAccount(walletOp.getBankAccount());
                buyTradeSafeDTO.setBankName(walletOp.getBankName());
                buyTradeSafeDTO.setBankOwner(walletOp.getBankOwner());
                buyTradeSafeDTO.setTradeState(4);
                this.buyTradeSave(buyTradeSafeDTO);
            }

            //Add alarm to buyer
            WalletAlarmDTO alarmDTO = new WalletAlarmDTO(buyDTO.getBuyType(),
                    "alarm.order.your.order.has.been.subscribed",
                    "/tradeBuyDetail?buyId=" + buyDTO.getBuyId(), buyDTO.getRegWalletAddress(), buyDTO.getBuyId(), 0);
            walletAlarmService.save(alarmDTO);
            return true;
        } catch (
                Exception ex) {

            log.error(ex.toString());
            return false;
        }

    }

    @Transactional
    public boolean buyTradeConfirmStatus(HttpSession session, BuyTradeConfirmDTO buyTradeConfirmDTO) {

        try {

            log.info("BUY TRADE APPLY {}", new Gson().toJson(buyTradeConfirmDTO));
            // Get BuyId
            BuySearchDTO buyDTO = new BuySearchDTO();
            buyDTO.setBuyId(buyTradeConfirmDTO.getBuyId());
            buyDTO = buyService.getBuyDetailByBuyId(buyDTO);

            // Get BuyTradeHistoryId
            BuyTradeDTO buyTradeDTO = new BuyTradeDTO();
            buyTradeDTO.setBuyTradeHistoryId(buyTradeConfirmDTO.getBuyTradeHistoryId());
            buyTradeDTO = getBuyTradeByBuyTradeHistoryId(buyTradeDTO);

            if (buyTradeConfirmDTO.getTradeState() == 2
                    && buyTradeConfirmDTO.getTxId() != null
                    && buyDTO.getState() == 2
                    && buyTradeDTO.getTradeState() == 1) {

                // Update txId and tradeStatus = 2
                buyTradeDTO.setTxid(buyTradeConfirmDTO.getTxId());
                buyTradeDTO.setTradeState(2);
                this.update(buyTradeDTO);

                //Add alarm to buyer
                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(buyDTO.getBuyType(),
                        "alarm.order.the.seller.has.transferred.the.token.to.you.please.check.it",
                        "/tradeBuyDetail?buyId=" + buyDTO.getBuyId(), buyDTO.getRegWalletAddress(), buyDTO.getBuyId(), 0);
                walletAlarmService.save(alarmDTO);

            } else if (buyTradeConfirmDTO.getTradeState() == 2
                    && buyDTO.getState() == 2
                    && buyTradeDTO.getTradeState() == 2) {

                // Update txId and tradeStatus = 3
                buyTradeDTO.setTxid(buyTradeConfirmDTO.getTxId());
                buyTradeDTO.setTradeState(3);
                this.update(buyTradeDTO);
                //Add alarm to buyer
                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(buyDTO.getBuyType(),
                        "alarm.order.the.seller.has.transferred.the.token.to.you.please.check.it" + buyDTO.getBuyId(),
                        "/tradeBuyDetail?buyId=" + buyDTO.getBuyId(), buyDTO.getRegWalletAddress(), buyDTO.getBuyId(), 0);
                walletAlarmService.save(alarmDTO);

            } else if (buyTradeConfirmDTO.getTradeState() == 4
                    && buyTradeDTO.getTradeState() == 3) {

                // Update buyState = 3
                buyDTO.setState(3); // (Finish Buy)
                buyService.updateOne(buyDTO);

                // And Update TradeState = 4 (Finish Trade)
                buyTradeDTO.setTradeState(4);
                this.update(buyTradeDTO);
                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(buyDTO.getBuyType(),
                        "alarm.order.your.order.was.successful",
                        "/tradeBuyDetail?buyId=" + buyDTO.getBuyId(), buyDTO.getRegWalletAddress(), buyDTO.getBuyId(), 0);
                walletAlarmService.save(alarmDTO);
            } else {
                return false;
            }
            return true;
        } catch (Exception ex) {

            log.error(ex.toString());
        }

        return false;
    }

    public List<BuyTradeDTO> selectOutOfDateList(BuyTradeDTO buyTradeDTO) {
        return iCommonDao.selectList("TokenBuyTradeHistory.selectOutOfDateList", buyTradeDTO);
    }
}
