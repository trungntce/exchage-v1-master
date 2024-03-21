package com.apollo.exchange.web.sell.service;

import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.firebase.service.FcmService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import com.apollo.exchange.web.buy.dto.BuyDTO;
import com.apollo.exchange.web.buy.dto.BuyRequestDTO;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.sell.dto.SellDTO;
import com.apollo.exchange.web.sell.dto.SellRequestDTO;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
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
import java.util.ArrayList;
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
public class SellService {

    final ICommonDao iCommonDao;
    final TokenService tokenService;
    final WalletService walletService;
    private final ClientService clientService;

    @Lazy
    @Autowired
    private WalletAlarmService walletAlarmService;

    @Autowired
    private FcmService fcmService;

//    final WalletAlarmService walletAlarmService;

    /**
     * @param sellSearchDTO
     * @return
     * @author ntt.dev
     * @note get list sell
     */
    public List<SellDTO> getSellList(SellSearchDTO sellSearchDTO) {

        return iCommonDao.selectList("TokenSell.selectTokenSellHistory", sellSearchDTO);
    }


    public void updateOne(SellSearchDTO sellDTO) {

        iCommonDao.update("TokenSell.updateOne", sellDTO);
    }

    public void updateStateByIds(SellSearchDTO sellDTO) {

        iCommonDao.update("TokenSell.updateStateByIds", sellDTO);
    }


    /**
     * @param sellSearchDTO
     * @return
     * @author ntt.dev
     * @note get count
     */
    public int getCountSell(SellSearchDTO sellSearchDTO) {

        return iCommonDao.count("TokenSell.selectCount", sellSearchDTO);
    }

    public SellSearchDTO getSellDetailBySellId(SellSearchDTO sellSearchDTO) {

        return iCommonDao.selectOne("TokenSell.selectOneSellId", sellSearchDTO);
    }

    private void sellSave(SellDTO sellDTO) {

        iCommonDao.insert("TokenSell.insertOne", sellDTO);
    }

    public Map<String, Object> listSell(HttpSession session, SellSearchDTO sellSearchDTO) {

        Map<String, Object> mapResult = new HashMap<>();
        List<String> sellTypes = new ArrayList<>();
        List<String> symbolList = new ArrayList<>();
        try {

            sellSearchDTO.setPage(sellSearchDTO.getSellPage());
            sellSearchDTO.setDelYn("N");
//            WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
            WalletDTO walletCurrent = walletService.getWalletCurrent(session, sellSearchDTO.getWalletAddress());
            if (walletCurrent != null) {

                switch (walletCurrent.getRole()) {
                    case DataStatic.WALLET_ROLE.SYSTEM:
                        sellSearchDTO.setWalletAddress(null);
                        break;
                    case DataStatic.WALLET_ROLE.TRADER:
                        // Trader & Generate my trader & API
                        sellTypes.add("1"); // Generate
                        sellTypes.add("2"); // API
                        sellSearchDTO.setSellTypes(sellTypes);

                        symbolList.add("BANI");
                        symbolList.add("EGG");
                        sellSearchDTO.setSymbolList(symbolList);

                        sellSearchDTO.setWalletAddress(walletCurrent.getWalletAddress());
                        sellSearchDTO.setClientTraderUseYn("N");
                        break;
                    case DataStatic.WALLET_ROLE.CLIENT_TRADER:
                        sellTypes.add("1"); // Generate
                        sellTypes.add("2"); // API

                        symbolList.add("BANI");
                        symbolList.add("EGG");
                        sellSearchDTO.setSymbolList(symbolList);
                        sellSearchDTO.setClientTraderUseYn("Y");
                        break;
                    case DataStatic.WALLET_ROLE.USER:
                        sellSearchDTO.setSellType(1);
                        sellSearchDTO.setViewRole(DataStatic.WALLET_ROLE.USER);
                        sellSearchDTO.setWalletAddress(null);
                        break;
                    default:
                        // CENTRAL_BANK, OPERATOR, OPERATOR_FEE, CLIENT
                        sellSearchDTO.setSellType(1);
                        sellSearchDTO.setWalletAddress(null);
                        break;
                }
            }
            mapResult.put("sellList", getSellList(sellSearchDTO));
            mapResult.put("total", getCountSell(sellSearchDTO));
            return mapResult;

        } catch (Exception ex) {

            log.error(ex.toString());
            return mapResult;
        }

    }

    @Transactional
    public SellDTO sellRequest(HttpSession session, SellRequestDTO sellRequestDTO) {

        try {

            WalletDTO walletDTO = walletService.CompareSessionWallet(session, sellRequestDTO.getSellerWalletAddress());
            // Check validation request
            if (validationRequestBuy(sellRequestDTO) || walletDTO == null) {

                return null;
            }

            // Setting Price
            // Get token
            TokenSearchDTO tokenSearchDTO = new TokenSearchDTO();
            tokenSearchDTO.setSymbol(sellRequestDTO.getSymbol());
            TokenDTO tokenDTO = tokenService.getToken(tokenSearchDTO);
            BigDecimal unitPrice = BigDecimal.valueOf(tokenDTO.getUnitPrice().longValue()).multiply(sellRequestDTO.getQuantity());
            BigDecimal fee = BigDecimal.ZERO;
            if (unitPrice.compareTo(BigDecimal.valueOf(100000)) > 0) {
                fee = unitPrice.multiply(BigDecimal.valueOf(1)).divide(BigDecimal.valueOf(100));
            } else {
                fee = BigDecimal.valueOf(1000);
            }
            ;
            // Save data to token_sell
            SellDTO sellDTO = new SellDTO();

            sellDTO.setClientId(sellRequestDTO.getClientId() == null ? "1" : sellRequestDTO.getClientId());
            sellDTO.setSellType(DataStatic.ORDER_TYPE.GENERAL);
            sellDTO.setSymbol(sellRequestDTO.getSymbol());
            if (null != sellRequestDTO.getTradeType() && sellRequestDTO.getTradeType() == 2) {
                sellDTO.setViewRole(DataStatic.VIEW_ROLE.USER_SAFE);
            } else {
                sellDTO.setViewRole((sellRequestDTO.getType() == null) ? "USER" : sellRequestDTO.getType());
            }
            sellDTO.setSellerWalletAddress(sellRequestDTO.getSellerWalletAddress());
            sellDTO.setQuantity(sellRequestDTO.getQuantity());

//            sellDTO.setUnitPrice(BigInteger.valueOf(tokenDTO.getUnitPrice()));
            sellDTO.setUnitPrice(unitPrice.toBigInteger());
            BigDecimal totalPrice = unitPrice.subtract(fee);
            sellDTO.setTotalPrice(totalPrice.toBigInteger());
            sellDTO.setState(1);
            sellDTO.setBankName(walletDTO.getBankName());
            sellDTO.setBankOwner(walletDTO.getBankOwner());
            sellDTO.setBankAccount(walletDTO.getBankAccount());
            sellDTO.setRegWalletAddress(sellRequestDTO.getSellerWalletAddress());
            // Check client_id have client_trader
            if (null != sellRequestDTO.getClientId()
                    && "api".equalsIgnoreCase(sellRequestDTO.getViewRole())) {

                sellDTO.setSellType(DataStatic.ORDER_TYPE.API);

                List<ClientDTO> clientDTO = clientService.getClientAndClientTraderByClientId(sellRequestDTO.getClientId());

                if ("Y".equalsIgnoreCase(clientDTO.get(0).getClientTraderUseYn())) {

                    sellDTO.setViewRole(DataStatic.WALLET_ROLE.CLIENT_TRADER);
                } else {

                    sellDTO.setViewRole(sellRequestDTO.getViewRole());
                }

            } else if ("trader".equalsIgnoreCase(sellRequestDTO.getViewRole())) {

                sellDTO.setViewRole(sellRequestDTO.getViewRole());
            }
            // Check other token
            if (!DataStatic.SYMBOL.BANI.equals(sellRequestDTO.getSymbol()) && !DataStatic.SYMBOL.EGG.equals(sellRequestDTO.getSymbol())) {
                sellDTO.setSellerWalletAddress(sellRequestDTO.getOtherWallet());
                sellDTO.setUnitPrice(sellRequestDTO.getUnitPrice().multiply(sellRequestDTO.getQuantity().toBigInteger()));
                sellDTO.setTotalPrice(sellRequestDTO.getQuantity().multiply(BigDecimal.valueOf(sellRequestDTO.getUnitPrice().longValue())).toBigInteger());
            }
            this.sellSave(sellDTO);

            WalletAlarmDTO alarmDTO = new WalletAlarmDTO(sellDTO.getSellType(),
                    "alarm.order.your.order.create.success",
                    "/tradeSellDetail?sellId=" + sellDTO.getSellId(), sellDTO.getRegWalletAddress(), 0, sellDTO.getSellId());
            walletAlarmService.save(alarmDTO);

            if ("api".equalsIgnoreCase(sellRequestDTO.getViewRole())) {
                fcmService.sendToAllTrader(sellRequestDTO.getSymbol(), 0, sellDTO.getSellId(), "SELL ORDER NOTIFY");
            }

            // Trade type = 2 (safe) OWNER_SAFE
            // Save token owner information
            if (null != sellRequestDTO.getTradeType() && sellRequestDTO.getTradeType() == 2) {
                // Get Operator token//
                WalletDTO walletOp = new WalletDTO();
                sellDTO.setPSellId(sellDTO.getSellId());
                sellDTO.setSellId(null);
                walletOp.setRole(DataStatic.WALLET_ROLE.OPERATOR);
                walletOp.setSymbol(sellRequestDTO.getSymbol());
                walletOp = walletService.selectWalletByRoleAndSymbol(walletOp);
                sellDTO.setViewRole(DataStatic.VIEW_ROLE.OWNER_SAFE);
                sellDTO.setSellerWalletAddress(walletOp.getWalletAddress());
                sellDTO.setBankName(walletOp.getBankName());
                sellDTO.setBankOwner(walletOp.getBankOwner());
                sellDTO.setBankAccount(walletOp.getBankAccount());
//                sellDTO.setRegWalletAddress(walletOp.getWalletAddress());
                this.sellSave(sellDTO);

            }

            return sellDTO;

        } catch (Exception ex) {

            log.error(ex.toString());
            return null;
        }
    }

    @Transactional
    public boolean sellCancel(HttpSession session, SellSearchDTO sellSearchDTO) {
        try {

            if (sellSearchDTO == null) {
                return false;
            }
            // Get BuyId
            SellSearchDTO sellDetail = getSellDetailBySellId(sellSearchDTO);
            if (sellDetail == null
                    || sellDetail.getState() != 1) {
                return false;
            }

            WalletDTO walletDTO = walletService.CompareSessionWallet(session, sellDetail.getSellerWalletAddress());
            WalletDTO walletRgDTO = walletService.CompareSessionWallet(session, sellDetail.getRegWalletAddress());
            if (walletDTO == null && walletRgDTO == null) {
                return false;
            }
            // Update TokenBuy table where state = 5
            sellDetail.setState(5);// Cancel
            this.updateOne(sellDetail);
            return true;

        } catch (Exception ex) {

            log.error(ex.toString());
            return false;
        }

    }

    private boolean validationRequestBuy(SellRequestDTO sellRequestDTO) {

        if (sellRequestDTO.getClientId() == null
                || "".equals(sellRequestDTO.getClientId())) {

            log.error("ClientId is null {}", new Gson().toJson(sellRequestDTO));
            return false;
        }
        if (sellRequestDTO.getBuyType() == null) {

            log.error("BuyType is null {}", new Gson().toJson(sellRequestDTO));
            return false;
        }
        if (sellRequestDTO.getSymbol() == null
                || "".equals(sellRequestDTO.getSymbol())) {

            log.error("Symbol is null {}", new Gson().toJson(sellRequestDTO));
            return false;
        }
        if (sellRequestDTO.getSellerWalletAddress() == null
                || "".equals(sellRequestDTO.getSellerWalletAddress())) {

            log.error("BuyerWalletAddress is null {}", new Gson().toJson(sellRequestDTO));
            return false;
        }
        if (sellRequestDTO.getQuantity() == null) {
            log.error("Quantity is null {}", new Gson().toJson(sellRequestDTO));
            return false;
        }
        if (sellRequestDTO.getType() == null || "".equals(sellRequestDTO.getType())) {
            log.error("Type is null {}", new Gson().toJson(sellRequestDTO));
            return false;
        }
        return true;
    }
}
