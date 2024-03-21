package com.apollo.exchange.web.sell.service;

import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.message.MessageSupport;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import com.apollo.exchange.web.buy.dto.BuyTradeDTO;
import com.apollo.exchange.web.sell.dto.SellDTO;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.dto.SellTradeConfirmDTO;
import com.apollo.exchange.web.sell.dto.SellTradeDTO;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

/**
 * @author ntt.dev
 * @apiNote logic business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class SellTradeService {
    final ICommonDao iCommonDao;
    private final ApiService apiService;
    final private SellService sellService;
    final private WalletService walletService;
    final private ClientService clientService;

    @Lazy
    @Autowired
    private WalletAlarmService walletAlarmService;

    public void sellTradeSave(SellTradeDTO sellTradeDTO) {
        iCommonDao.insert("TokenSellTradeHistory.insertOne", sellTradeDTO);
    }

    public SellTradeDTO getSellTradeByBuyTradeHistoryId(SellTradeDTO sellTradeDTO) {
        return iCommonDao.selectOne("TokenSellTradeHistory.selectOneBySellTradeHistoryId", sellTradeDTO);
    }

    public List<SellTradeDTO> selectOutOfDateList(SellTradeDTO tokenSellTradeHistoryDTO) {
        return iCommonDao.selectList("TokenSellTradeHistory.selectOutOfDateList", tokenSellTradeHistoryDTO);
    }

    public void update(SellTradeDTO sellTradeDTO) {
        iCommonDao.update("TokenSellTradeHistory.updateOne", sellTradeDTO);
    }

    public void updateStateByIds(SellTradeDTO sellTradeDTO) {
        iCommonDao.update("TokenSellTradeHistory.updateStateByIds", sellTradeDTO);
    }

    @Transactional
    public boolean sellTradeApply(HttpSession session, SellTradeDTO sellTradeDTO) {

        log.info("sellTradeDTO Apply {}", new Gson().toJson(sellTradeDTO));
        try {

            // Check Role
            WalletDTO walletDTO = walletService.CompareSessionWallet(session, sellTradeDTO.getBuyerWalletAddress());
            if (walletDTO == null) {
                log.error("Compare wallet is null.");
                return false;
            }
            if (!walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.USER)
                    && !walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.TRADER)
                    && !walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.CLIENT_TRADER)) {
                log.error("You are not permission.");
                return false;
            }
            // Get SellId
            SellSearchDTO sellDTO = new SellSearchDTO();
            sellDTO.setSellId(sellTradeDTO.getSellId());
            sellDTO = sellService.getSellDetailBySellId(sellDTO);
            if (sellDTO == null || sellDTO.getState() != 1) {
                log.error("sellId is null or sellState not equals {}", sellDTO);
                return false;
            }

            // Update Sell
            sellDTO.setState(2);

            sellService.updateOne(sellDTO);

            // Insert data to TokenSellTradeHistory
            sellTradeDTO.setTradeState(1);
            this.sellTradeSave(sellTradeDTO);
            log.error("Insert is successful, SELL ID: , BUY_TRADE_HISTORY_ID: {}", sellTradeDTO.getSellTradeHistoryId());
            //Add alarm to buyer
            WalletAlarmDTO alarmDTO = new WalletAlarmDTO(sellDTO.getSellType(),
                    "alarm.order.your.order.has.been.subscribed",
                    "/tradeSellDetail?sellId=" + sellDTO.getSellId(), sellDTO.getRegWalletAddress(), 0, sellDTO.getSellId());
            walletAlarmService.save(alarmDTO);

            // Update USER_SAFE
            if (DataStatic.VIEW_ROLE.OWNER_SAFE.equalsIgnoreCase(sellDTO.getViewRole()) && sellDTO.getPSellId() > 0) {
                // Get SellId
                SellSearchDTO sellSafe = new SellSearchDTO();
                sellSafe.setSellId(sellDTO.getPSellId());
                sellSafe = sellService.getSellDetailBySellId(sellSafe);

                // Update Sell
                sellSafe.setState(4);
                sellService.updateOne(sellSafe);

                // Insert data to TokenSellTradeHistory
                SellTradeDTO tradeSafe = new SellTradeDTO();
                tradeSafe.setSellId(sellSafe.getSellId());
                tradeSafe.setTradeState(4);
                tradeSafe.setBuyerWalletAddress(sellTradeDTO.getBuyerWalletAddress());
                this.sellTradeSave(tradeSafe);
            }
            // add chat to seller

            return true;
        } catch (Exception ex) {
            log.error(ex.toString());
            return false;
        }

    }

    @Transactional
    public int applyWithTransfer(HttpSession session, SellTradeConfirmDTO sellTradeConfirmDTO) {

        try {
            // Get SellId
            SellSearchDTO sellDetail = new SellSearchDTO();
            sellDetail.setSellId(sellTradeConfirmDTO.getSellId());
            sellDetail = sellService.getSellDetailBySellId(sellDetail);

            // Get SellTradeHistory
            SellTradeDTO sellTradeDetail = new SellTradeDTO();
            sellTradeDetail.setSellTradeHistoryId(sellDetail.getSellTradeHistoryId());
            sellTradeDetail = getSellTradeByBuyTradeHistoryId(sellTradeDetail);

            WalletDTO walletDTO = walletService.CompareSessionWallet(session, sellDetail.getBuyerWalletAddress());

            if (sellDetail == null
                    || sellTradeDetail == null
                    || sellDetail.getTradeState() == 4
                    || sellDetail.getTradeState() == 5
                    || sellTradeDetail.getTradeState() == 4
                    || sellTradeDetail.getTradeState() == 5) {
                log.error("Input is incorrect");
                return -101;
            }

            // Check Balance
            BigDecimal totalTransfer = sellDetail.getQuantity().add((sellDetail.getQuantity().multiply(walletDTO.getFee()).divide(BigDecimal.valueOf(100))));

            BigDecimal sellerBalance = apiService.getBalance(session, sellDetail.getSymbol(), sellDetail.getSellerWalletAddress());
            if (sellerBalance.compareTo(totalTransfer) < 0) {
                log.error("sellerBalance is not enough");
                return -102;
            }


            String txId = "";
            if (DataStatic.WALLET_ROLE.CLIENT_TRADER.equalsIgnoreCase(sellDetail.getViewRole())
                    || "api".equalsIgnoreCase(sellDetail.getViewRole())) {
                // TransferTokenWithFee
                ClientSearchDTO clientSearchDTO = new ClientSearchDTO();
                clientSearchDTO.setClientId(sellDetail.getClientId());
                ClientDTO clientDTO = clientService.selectOne(clientSearchDTO);
                BigDecimal clientFee = sellDetail.getQuantity().multiply(BigDecimal.valueOf(Double.valueOf(clientDTO.getSellFee()))).divide(BigDecimal.valueOf(100));
                // Check Balance client
//                BigDecimal clientBalance = apiService.getBalance(session, clientDTO.getWalletAddress());
//                if (clientBalance.compareTo(clientFee) <= 0) {
//
//                    log.error("clientBalance is not enough");
//                    return -104;
//                }
                // Transfer token to buyer
                String from = sellDetail.getSellerWalletAddress();
                String to = sellDetail.getBuyerWalletAddress();
                ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
                apiTransferDTO.setSymbol(sellDetail.getSymbol());
                apiTransferDTO.setFromWalletAddress(from);
                apiTransferDTO.setToWalletAddress(to);
                apiTransferDTO.setQuantity(sellDetail.getQuantity());
                txId = apiService.transferNoFee(apiTransferDTO);
                if ("".equalsIgnoreCase(txId)) {
                    return -103;
                }
                // Transfer client fee to client_trader
//                ApiTransferDTO apiTransferClientDTO = new ApiTransferDTO();
//                apiTransferClientDTO.setSymbol(sellDetail.getSymbol());
//                apiTransferClientDTO.setFromWalletAddress(clientDTO.getWalletAddress());
//                apiTransferClientDTO.setToWalletAddress(sellDetail.getBuyerWalletAddress());
//                apiTransferClientDTO.setQuantity(clientFee);
//                apiService.transferNoFee(apiTransferClientDTO);


            } else {
                // Coming transfer
                ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
                apiTransferDTO.setFromWalletAddress(sellDetail.getSellerWalletAddress());
                apiTransferDTO.setToWalletAddress(sellDetail.getBuyerWalletAddress());
                apiTransferDTO.setQuantity(sellDetail.getQuantity());
                txId = apiService.transferNoFee(apiTransferDTO);
            }

            if (txId == null || "".equalsIgnoreCase(txId)) {
                log.error("Transfer error");
                return -103;
            }
            // Update txid
            sellTradeDetail.setTxid(txId);
//            sellTradeDetail.setTradeState(4);
            sellTradeDetail.setTradeState(3);
            this.update(sellTradeDetail);

            sellDetail.setState(4);
            sellService.updateOne(sellDetail);

            return 100;
        } catch (Exception ex) {
            log.error(ex.toString());
            return -99;
        }
    }

    @Transactional
    public boolean sellTradeConfirmStatus(HttpSession session, SellTradeConfirmDTO sellTradeConfirmDTO) {
        try {
            // Get SellId
            SellSearchDTO sellDetail = new SellSearchDTO();
            sellDetail.setSellId(sellTradeConfirmDTO.getSellId());
            sellDetail = sellService.getSellDetailBySellId(sellDetail);

            // Get SellTradeHistory
            SellTradeDTO sellTradeDetail = new SellTradeDTO();
            sellTradeDetail.setSellTradeHistoryId(sellDetail.getSellTradeHistoryId());
            sellTradeDetail = getSellTradeByBuyTradeHistoryId(sellTradeDetail);
            WalletDTO walletDTO = null;
            WalletDTO walletRgDTO = null;
            // If confirm txid then compare sellerWalletAddress
            if (sellTradeConfirmDTO.getTradeState() == 3) {
                walletDTO = walletService.CompareSessionWallet(session, sellDetail.getSellerWalletAddress());
                walletRgDTO = walletService.CompareSessionWallet(session, sellDetail.getRegWalletAddress());
            }
            // other using buyerWalletAddress
            else {
                walletDTO = walletService.CompareSessionWallet(session, sellDetail.getBuyerWalletAddress());
            }
            if (walletDTO == null && walletRgDTO == null) {
                return false;
            }
            if (sellTradeConfirmDTO.getTradeState() == 2
                    && sellTradeDetail.getTradeState() == 1) {

                // If role = TRADER then update status = 4 (finish) ann Sell status = 3 (finish)
//                if (walletDTO.getRole().equalsIgnoreCase(DataStatic.WALLET_ROLE.TRADER)
//                        && sellTradeConfirmDTO.getTradeState() == 2) {
//                    sellTradeDetail.setTradeState(4); // Finish
//                    this.update(sellTradeDetail);
//
//                    sellDetail.setState(3); // Finish
//                    sellService.updateOne(sellDetail);
//
//                    return true;
//                }
                // Update sellTrade status = 2 with USER
                sellTradeDetail.setTradeState(2);
                this.update(sellTradeDetail);

                // Update USER_SAFE
                if (DataStatic.VIEW_ROLE.OWNER_SAFE.equals(sellDetail.getViewRole()) && sellDetail.getPSellId() > 0) {
                    SellSearchDTO sellDetailSafe = new SellSearchDTO();
                    sellDetailSafe.setSellId(sellDetail.getPSellId());
                    sellDetailSafe = sellService.getSellDetailBySellId(sellDetailSafe);

                    // Get SellTradeHistory
                    SellTradeDTO sellTradeSafe = new SellTradeDTO();
                    sellTradeSafe.setSellTradeHistoryId(sellDetailSafe.getSellTradeHistoryId());
                    sellTradeSafe = getSellTradeByBuyTradeHistoryId(sellTradeSafe);
                    sellTradeSafe.setTradeState(2);

                    this.update(sellTradeSafe);
                }

                //Add alarm to Seller
                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(sellDetail.getSellType(),
                        "alarm.order.buyer.sent.you.cash.please.check.it",
                        "/tradeSellDetail?sellId=" + sellDetail.getSellId(), sellDetail.getRegWalletAddress(), 0, sellDetail.getSellId());
                walletAlarmService.save(alarmDTO);
                return true;

            }
            // Confirm txId and set sellTradeState = 3
            else if (sellTradeConfirmDTO.getTradeState() == 3
                    && sellTradeConfirmDTO.getTxId() != null
                    && sellTradeDetail.getTradeState() == 2
            ) {
                sellTradeDetail.setTxid(sellTradeConfirmDTO.getTxId());
//                if ("OWNER_SAFE".equals(sellDetail.getViewRole()) && sellDetail.getPSellId() > 0) {
//                    sellTradeDetail.setTradeState(4);
//                }else{
                sellTradeDetail.setTradeState(3);
//                }
                this.update(sellTradeDetail);


                //Add alarm to Buyer
                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(sellDetail.getSellType(),
                        "alarm.order.the.seller.has.transferred.the.token.to.you.please.check.it",
                        "/tradeSellDetail?sellId=" + sellDetail.getSellId(), sellTradeDetail.getBuyerWalletAddress(), 0, sellDetail.getSellId());
                walletAlarmService.save(alarmDTO);
                return true;
            } else if (sellTradeConfirmDTO.getTradeState() == 4
                    && sellDetail.getState() == 2
                    && (sellTradeDetail.getTradeState() == 2 || sellTradeDetail.getTradeState() == 3)) {

                // Update SellTrade = 4 (finish)
                sellTradeDetail.setTradeState(4);
                this.update(sellTradeDetail);

                if (DataStatic.VIEW_ROLE.OWNER_SAFE.equalsIgnoreCase(sellDetail.getViewRole()) && sellDetail.getPSellId() > 0) {
                    sellDetail.setState(4);
                } else {
                    //Update Sell = 3
                    sellDetail.setState(3);
                }

                sellService.updateOne(sellDetail);


                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(sellDetail.getSellType(),
                        "alarm.order.your.order.was.successful",
                        "/tradeSellDetail?sellId=" + sellDetail.getSellId(), sellDetail.getRegWalletAddress(), 0, sellDetail.getSellId());
                walletAlarmService.save(alarmDTO);
                return true;

            }
//        else if (sellTradeConfirmDTO.getTradeState() == 4
//                && sellTradeDetail.getTradeState() == 2
//                && sellDetail.getTradeState() == 2
//        ) {
//
//            // Update sell
//            sellTradeDetail.setTradeState(4);
//            this.update(sellTradeDetail);
//            // Update sellTrade
//            sellDetail.setState(3);
//            sellService.updateOne(sellDetail);
//            return true;
//
//        }
        } catch (Exception ex) {
            log.error(ex.toString());
        }
        return false;
    }
}
