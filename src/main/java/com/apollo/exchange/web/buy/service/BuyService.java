package com.apollo.exchange.web.buy.service;

import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.firebase.service.FcmService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import com.apollo.exchange.web.buy.dto.*;
import com.apollo.exchange.web.token.dto.TokenDTO;
import com.apollo.exchange.web.token.dto.TokenSearchDTO;
import com.apollo.exchange.web.token.service.TokenService;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.*;

/**
 * @author ntt.dev
 * @apiNote logic business class
 */

@Slf4j
@Service
@RequiredArgsConstructor
public class BuyService {

    final ICommonDao iCommonDao;
    private final ApiService apiService;
    private final TokenService tokenService;
    private final WalletService walletService;
    private final ClientService clientService;
    @Lazy
    @Autowired
    private WalletAlarmService walletAlarmService;

    private final FcmService fcmService;

    @Autowired
    private BuyTradeService buyTradeService;

    /**
     * @param buySearchDTO
     * @return
     * @author ntt.dev
     * @note get list buy
     */
    public List<BuySearchDTO> getBuyList(BuySearchDTO buySearchDTO) {

        return iCommonDao.selectList("TokenBuy.selectTokenBuyHistory", buySearchDTO);
    }

    /**
     * @param buySearchDTO
     * @return
     * @author ntt.dev
     * @note get count
     */
    public int getCountBuy(BuySearchDTO buySearchDTO) {

        return iCommonDao.count("TokenBuy.selectCount", buySearchDTO);
    }

    public BuySearchDTO getBuyDetailByBuyId(BuySearchDTO buySearchDTO) {

        return iCommonDao.selectOne("TokenBuy.selectOneBuyId", buySearchDTO);
    }

    public BuySearchDTO getByPBuyId(Integer pBuyId) {
        return iCommonDao.selectOne("TokenBuy.selectByPBuyId", pBuyId);
    }

    public void updateOne(BuySearchDTO buySearchDTO) {

        iCommonDao.update("TokenBuy.updateOne", buySearchDTO);
    }

    public void updateStateByIds(BuySearchDTO buySearchDTO) {

        iCommonDao.update("TokenBuy.updateStateByIds", buySearchDTO);
    }


    private void buySave(BuyDTO buyDTO) {

        iCommonDao.insert("TokenBuy.insertOne", buyDTO);
    }


    /**
     * @param session
     * @param buySearchDTO
     * @return
     * @author ntt.dev
     * @note controller call listBuy
     */
    public Map<String, Object> listBuy(HttpSession session, BuySearchDTO buySearchDTO) {

        Map<String, Object> mapResult = new HashMap<>();
        List<String> buyTypes = new ArrayList<>();
        List<String> symbolList = new ArrayList<>();
        try {

            if (buySearchDTO == null) {

                buySearchDTO = new BuySearchDTO();
                buySearchDTO.setLimit(10);
                buySearchDTO.setPage(1);
            }
            buySearchDTO.setDelYn("N");
            buySearchDTO.setPage(buySearchDTO.getBuyPage());

//            WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
            WalletDTO walletCurrent = walletService.getWalletCurrent(session, buySearchDTO.getWalletAddress());
//            if (walletCurrent != null) {
            switch (walletCurrent.getRole()) {
                case DataStatic.WALLET_ROLE.SYSTEM:

                    break;
                case DataStatic.WALLET_ROLE.TRADER:
                    // Trader & generate my trader & api
                    buyTypes.add("1"); // Generate
                    buyTypes.add("2"); // API
                    symbolList.add("BANI");
                    symbolList.add("EGG");
                    buySearchDTO.setSymbolList(symbolList);
                    buySearchDTO.setBuyTypes(buyTypes);
                    buySearchDTO.setWalletAddress(walletCurrent.getWalletAddress());
                    buySearchDTO.setClientTraderUseYn("N");
                    break;
                case DataStatic.WALLET_ROLE.CLIENT_TRADER:
                    buyTypes.add("1"); // Generate
                    buyTypes.add("2"); // API
                    symbolList.add("BANI");
                    symbolList.add("EGG");
                    buySearchDTO.setSymbolList(symbolList);
//                        buySearchDTO.setBuyTypes(buyTypes);
//                        buySearchDTO.setViewRole(DataStatic.WALLET_ROLE.CLIENT_TRADER);
//                        buySearchDTO.setWalletAddress(null);
                    buySearchDTO.setClientTraderUseYn("Y");
                    break;

                case DataStatic.WALLET_ROLE.USER:
                    // User
                    buySearchDTO.setBuyType(1);
                    buySearchDTO.setViewRoles(Arrays.asList(DataStatic.VIEW_ROLE.USER, DataStatic.VIEW_ROLE.OWNER_SAFE));
                    buySearchDTO.setWalletAddress(walletCurrent.getWalletAddress());
                    break;

                default:
                    // CENTRAL_BANK, OPERATOR, OPERATOR_FEE, CLIENT
                    buySearchDTO.setBuyType(1);
                    buySearchDTO.setWalletAddress(null);
                    break;
            }
//            }

            mapResult.put("buyList", getBuyList(buySearchDTO));
            mapResult.put("total", getCountBuy(buySearchDTO));
            return mapResult;

        } catch (Exception ex) {

            log.error(ex.toString());
            return mapResult;
        }
    }

    @Transactional
    public BuyDTO postBuyRequest(HttpSession session, BuyRequestDTO buyRequestDTO) {

        try {

            WalletDTO walletDTO = walletService.CompareSessionWallet(session, buyRequestDTO.getBuyerWalletAddress());
            // Check validation request
            if (validationRequestBuy(buyRequestDTO) || walletDTO == null) {

                return null;
            }

            // Save data to token_buy
            BuyDTO buyDTO = new BuyDTO();
            buyDTO.setClientId(buyRequestDTO.getClientId() == null ? "1" : buyRequestDTO.getClientId());
            buyDTO.setBuyType(DataStatic.ORDER_TYPE.GENERAL);
            buyDTO.setSymbol(buyRequestDTO.getSymbol());

            if (null != buyRequestDTO.getTradeType() && buyRequestDTO.getTradeType().equals(2)) {
                buyDTO.setViewRole(DataStatic.VIEW_ROLE.USER_SAFE);
            } else {
                buyDTO.setViewRole((buyRequestDTO.getType() == null) ? "USER" : buyRequestDTO.getType());
            }
            buyDTO.setBuyerWalletAddress(buyRequestDTO.getBuyerWalletAddress());
            buyDTO.setQuantity(buyRequestDTO.getQuantity());
            buyDTO.setRegWalletAddress(buyRequestDTO.getBuyerWalletAddress());

            // Get token and Setting Price
            TokenSearchDTO tokenSearchDTO = new TokenSearchDTO();
            tokenSearchDTO.setSymbol(buyDTO.getSymbol());
            TokenDTO tokenDTO = tokenService.getToken(tokenSearchDTO);
            BigDecimal unitPrice = BigDecimal.valueOf(tokenDTO.getUnitPrice().longValue()).multiply(buyDTO.getQuantity());

//            BigDecimal fee = unitPrice.multiply(walletDTO.getFee()).divide(BigDecimal.valueOf(100));
            BigDecimal fee = BigDecimal.ZERO;
            if (unitPrice.compareTo(BigDecimal.valueOf(100000)) > 0) {
                fee = unitPrice.multiply(BigDecimal.valueOf(1)).divide(BigDecimal.valueOf(100));
            } else {
                fee = BigDecimal.valueOf(1000);
            }
            buyDTO.setUnitPrice(unitPrice.toBigInteger());
            BigDecimal totalPrice = unitPrice.add(fee);
            buyDTO.setTotalPrice(totalPrice.toBigInteger());
            buyDTO.setState(1);
            // Check client_id have client_trader
            if (null != buyRequestDTO.getClientId()
                    && "api".equalsIgnoreCase(buyRequestDTO.getViewRole())) {

                buyDTO.setBuyType(DataStatic.ORDER_TYPE.API);
                List<ClientDTO> clientDTO = clientService.getClientAndClientTraderByClientId(buyRequestDTO.getClientId());

                if ("Y".equalsIgnoreCase(clientDTO.get(0).getClientTraderUseYn())) {

                    buyDTO.setViewRole(DataStatic.WALLET_ROLE.CLIENT_TRADER);
                } else {

                    buyDTO.setViewRole(buyRequestDTO.getViewRole());
                }
            } else if ("trader".equalsIgnoreCase(buyRequestDTO.getViewRole())) {

                buyDTO.setViewRole(buyRequestDTO.getViewRole());
            }
            // Check other token
            if (!DataStatic.SYMBOL.BANI.equals(buyRequestDTO.getSymbol()) && !DataStatic.SYMBOL.EGG.equals(buyRequestDTO.getSymbol())) {
                buyDTO.setBuyerWalletAddress(buyRequestDTO.getOtherWallet());
                buyDTO.setUnitPrice(buyRequestDTO.getUnitPrice().multiply(buyRequestDTO.getQuantity().toBigInteger()));
                buyDTO.setTotalPrice(buyRequestDTO.getQuantity().multiply(BigDecimal.valueOf(buyRequestDTO.getUnitPrice().longValue())).toBigInteger());
            }

            this.buySave(buyDTO);
            // Trade type = 2 (safe) OWNER_SAFE
            // Save token owner information
            if (null != buyRequestDTO.getTradeType() && buyRequestDTO.getTradeType() == 2) {

                // Get Operator token//
                WalletDTO walletOp = new WalletDTO();
                walletOp.setRole(DataStatic.WALLET_ROLE.OPERATOR);
                walletOp.setSymbol(buyRequestDTO.getSymbol());
                walletOp = walletService.selectWalletByRoleAndSymbol(walletOp);

                buyDTO.setPBuyId(buyDTO.getBuyId());
                buyDTO.setBuyId(null);
                buyDTO.setViewRole(DataStatic.VIEW_ROLE.OWNER_SAFE);
                buyDTO.setBuyerWalletAddress(walletOp.getWalletAddress());
                this.buySave(buyDTO);

//
//                BuyTradeDTO buyTradeTmp = new BuyTradeDTO();
//                buyTradeTmp.setBuyId(buyDTO.getPBuyId());
//                buyTradeTmp.setSellerWalletAddress(walletDTO.getWalletAddress());
//                buyTradeTmp.setBankName(walletOp.getBankName());
//                buyTradeTmp.setBankOwner(walletOp.getBankOwner());
//                buyTradeTmp.setBankAccount(walletOp.getBankAccount());
//                buyTradeTmp.setTradeState(4);
//                buyTradeService.buyTradeSave(buyTradeTmp);
            }

            //Insert alarm to all Trader
            if ("api".equalsIgnoreCase(buyRequestDTO.getViewRole())) {
                fcmService.sendToAllTrader(buyRequestDTO.getSymbol(), buyDTO.getBuyId(), 0, "BUY ORDER NOTIFY");
            }

            //Add alarm to create order
            WalletAlarmDTO alarmDTO = new WalletAlarmDTO(buyDTO.getBuyType(),
                    "alarm.order.your.order.create.success",
                    "/tradeBuyDetail?buyId=" + buyDTO.getBuyId(), buyDTO.getRegWalletAddress(), buyDTO.getBuyId(), 0);
            walletAlarmService.save(alarmDTO);
            return buyDTO;

        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }
    }

    @Transactional
    public boolean buyCancel(HttpSession session, BuySearchDTO buySearchDTO) {

        try {
            if (buySearchDTO == null) {
                return false;
            }
            // Get BuyId
            BuySearchDTO buyDetail = getBuyDetailByBuyId(buySearchDTO);
            if (buyDetail == null
                    || buyDetail.getState() != 1) {

                return false;
            }

            WalletDTO walletDTO = walletService.CompareSessionWallet(session, buyDetail.getBuyerWalletAddress());
            WalletDTO walletRgDTO = walletService.CompareSessionWallet(session, buyDetail.getRegWalletAddress());
            if (walletDTO == null && walletRgDTO == null) {

                return false;
            }

            // Update TokenBuy table where state = 5 and TradeState = 5
            buyDetail.setState(5);// Cancel
            this.updateOne(buyDetail);

//        // Update TokenBuyTradeHistory tradeState = 5
//        BuyTradeDTO buyTradeDTO = new BuyTradeDTO();
//        buyTradeDTO.setBuyId(buyDetail.getBuyId());
//        buyTradeDTO.setTradeState(5); // Cancel
//        buyTradeService.updateByBuyId(buyTradeDTO);
            return true;
        } catch (Exception ex) {

            log.error(ex.toString());
            return false;
        }
    }

    @Transactional
    public boolean buyConfirmStatus(HttpSession session, BuyDTO buyConfirmDTO) {

        try {

            // Get BuyId
            BuySearchDTO buyDetail = new BuySearchDTO();
            buyDetail.setBuyId(buyConfirmDTO.getBuyId());
            buyDetail = getBuyDetailByBuyId(buyDetail);

            // Get BuyTradeHistory
            BuyTradeDTO buyTradeDTO = new BuyTradeDTO();
            buyTradeDTO.setBuyTradeHistoryId(buyDetail.getBuyTradeHistoryId());
            buyTradeDTO = buyTradeService.getBuyTradeByBuyTradeHistoryId(buyTradeDTO);
            if (buyDetail.getState() == 2
                    && buyTradeDTO.getTradeState() == 2) {

                if (DataStatic.VIEW_ROLE.OWNER_SAFE.equalsIgnoreCase(buyDetail.getViewRole())) {
                    buyDetail.setState(4);
                    updateOne(buyDetail);
                    buyTradeDTO.setTradeState(4);
                    buyTradeService.update(buyTradeDTO);

                } else {
                    buyTradeDTO.setTradeState(3);
                    buyTradeService.update(buyTradeDTO);
                }
                //Add alarm to Seller
                WalletAlarmDTO alarmDTO = new WalletAlarmDTO(buyDetail.getBuyType(),
                        "alarm.order.buyer.sent.you.cash.please.check.it",
                        "/tradeBuyDetail?buyId=" + buyDetail.getBuyId(), buyTradeDTO.getSellerWalletAddress(), buyDetail.getBuyId(), 0);
                walletAlarmService.save(alarmDTO);

                return true;
            }

        } catch (Exception ex) {

            log.error(ex.toString());
        }

        return false;

    }

    @Transactional
    public int applyWithTransfer(HttpSession session, BuyTradeConfirmDTO buyConfirmDTO) {

        try {

            // Get BuyId
            BuySearchDTO buyDetail = new BuySearchDTO();
            buyDetail.setBuyId(buyConfirmDTO.getBuyId());
            buyDetail = getBuyDetailByBuyId(buyDetail);

            // Get BuyTradeHistory
            BuyTradeDTO buyTradeDTO = new BuyTradeDTO();
            buyTradeDTO.setBuyTradeHistoryId(buyDetail.getBuyTradeHistoryId());
            buyTradeDTO = buyTradeService.getBuyTradeByBuyTradeHistoryId(buyTradeDTO);

            WalletDTO walletDTO = walletService.CompareSessionWallet(session, buyTradeDTO.getSellerWalletAddress());

            if (buyDetail == null
                    || buyTradeDTO == null
                    || buyDetail.getState() == 4
                    || buyDetail.getState() == 5
                    || buyTradeDTO.getTradeState() == 4
                    || buyTradeDTO.getTradeState() == 5
                    || walletDTO == null) {
                log.error("Input is incorrect");
                return -101;
            }

            // Check Balance
            BigDecimal sellerBalance = apiService.getBalance(session, buyDetail.getSymbol(), buyTradeDTO.getSellerWalletAddress());
            if (sellerBalance.compareTo(buyDetail.getQuantity()) < 0) {

                log.error("sellerBalance is not enough");
                return -102;

            }

            String txId = "";
            if (DataStatic.WALLET_ROLE.CLIENT_TRADER.equalsIgnoreCase(buyDetail.getViewRole())
                    || "api".equalsIgnoreCase(buyDetail.getViewRole())) {

                // TransferTokenWithFee
                ClientSearchDTO clientSearchDTO = new ClientSearchDTO();
                clientSearchDTO.setClientId(buyDetail.getClientId());
                ClientDTO clientDTO = clientService.selectOne(clientSearchDTO);
                BigDecimal clientFee = buyDetail.getQuantity().multiply(BigDecimal.valueOf(Double.valueOf(clientDTO.getBuyFee()))).divide(BigDecimal.valueOf(100));
                // Check Balance client
//                BigDecimal clientBalance = apiService.getBalance(session, clientDTO.getWalletAddress());
//                if (clientBalance.compareTo(clientFee) <= 0) {
//
//                    log.error("clientBalance is not enough");
//                    return -104;
//                }
                // Transfer token to buyer
                String from = buyDetail.getSellerWalletAddress();
                String to = buyDetail.getBuyerWalletAddress();
                ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
                apiTransferDTO.setSymbol(buyDetail.getSymbol());
                apiTransferDTO.setFromWalletAddress(from);
                apiTransferDTO.setToWalletAddress(to);
                apiTransferDTO.setQuantity(buyDetail.getQuantity());
                txId = apiService.transferNoFee(apiTransferDTO);
                if ("".equalsIgnoreCase(txId)) {
                    return -103;
                }
                // Transfer client fee to client_trader
//                ApiTransferDTO apiTransferClientDTO = new ApiTransferDTO();
//                apiTransferClientDTO.setSymbol(buyDetail.getSymbol());
//                apiTransferClientDTO.setFromWalletAddress(clientDTO.getWalletAddress());
//                apiTransferClientDTO.setToWalletAddress(buyDetail.getSellerWalletAddress());
//                apiTransferClientDTO.setQuantity(clientFee);
//                apiService.transferNoFee(apiTransferClientDTO);

            } else {
                // Transfer fee
                String from = buyDetail.getSellerWalletAddress();
                String to = buyDetail.getBuyerWalletAddress();
                ApiTransferDTO apiTransferDTO = new ApiTransferDTO();
                apiTransferDTO.setSymbol(buyDetail.getSymbol());
                apiTransferDTO.setFromWalletAddress(from);
                apiTransferDTO.setToWalletAddress(to);
                apiTransferDTO.setQuantity(buyDetail.getQuantity());
                txId = apiService.transferNoFee(apiTransferDTO);

            }
            if (txId == null || "".equalsIgnoreCase(txId)) {
                log.error("txId null");
                return -103;
            }

            //  Buy = 3
//            buyDetail.setState(3);
            buyDetail.setState(4);
            this.updateOne(buyDetail);
            // Update BuyTrade = 4
            buyTradeDTO.setTradeState(3);
            buyTradeDTO.setTxid(txId);
            buyTradeService.update(buyTradeDTO);

            return 100;
        } catch (Exception ex) {

            log.error(ex.toString());
            return -99;
        }

    }

    private boolean validationRequestBuy(BuyRequestDTO buyRequestDTO) {

        if (buyRequestDTO.getClientId() == null || "".equals(buyRequestDTO.getClientId())) {

            log.error("ClientId is null {}", new Gson().toJson(buyRequestDTO));
            return false;

        }
        if (buyRequestDTO.getBuyType() == null) {

            log.error("BuyType is null {}", new Gson().toJson(buyRequestDTO));
            return false;
        }
        if (buyRequestDTO.getSymbol() == null || "".equals(buyRequestDTO.getSymbol())) {

            log.error("Symbol is null {}", new Gson().toJson(buyRequestDTO));
            return false;
        }
        if (buyRequestDTO.getBuyerWalletAddress() == null || "".equals(buyRequestDTO.getBuyerWalletAddress())) {
            log.error("BuyerWalletAddress is null {}", new Gson().toJson(buyRequestDTO));

            return false;
        }
        if (buyRequestDTO.getQuantity() == null) {
            log.error("Quantity is null {}", new Gson().toJson(buyRequestDTO));

            return false;
        }
        if (buyRequestDTO.getType() == null || "".equals(buyRequestDTO.getType())) {

            log.error("Type is null {}", new Gson().toJson(buyRequestDTO));
            return false;
        }

        return true;
    }


}
