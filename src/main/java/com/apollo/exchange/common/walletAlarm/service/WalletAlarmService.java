package com.apollo.exchange.common.walletAlarm.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.firebase.service.FcmService;
import com.apollo.exchange.common.message.MessageSupport;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.web.sell.dto.SellDTO;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.service.SellService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


@Slf4j
@Component
@RequiredArgsConstructor
public class WalletAlarmService {
    final ICommonDao commonDao;
    final private BuyService buyService;
    final private SellService sellService;

    @Autowired
    private FcmService fcmService;

    public void save(WalletAlarmDTO walletAlarmDTO) {
        walletAlarmDTO.setCheckYn("N");
        walletAlarmDTO.setDelYn("N");
        commonDao.insert("WalletAlarm.insertOne", walletAlarmDTO);
        fcmService.sendToWallet(0, walletAlarmDTO.getAlarmWalletAddress(), walletAlarmDTO.getBuyId(), walletAlarmDTO.getSellId(), walletAlarmDTO.getContents());
    }

    public void saveAllTrader(WalletAlarmDTO walletAlarmDTO) {
        commonDao.insert("WalletAlarm.insertAllTrader", walletAlarmDTO);
    }

    public List<WalletAlarmDTO> getListAlarmByWallet(HttpSession session, WalletAlarmDTO walletAlarmDTO) {
        WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
        walletAlarmDTO.setAlarmWalletAddress(walletSession.getWalletAddress());
        walletAlarmDTO.setCheckYn("N");
        List<WalletAlarmDTO> lstAlarm = commonDao.selectList("WalletAlarm.selectListByWalletAddress", walletAlarmDTO);
        if(lstAlarm.size()>0){
            for(WalletAlarmDTO item : lstAlarm){
                item.setTitle(MessageSupport.getMessage(item.getTitle()));
            }
        }
        return lstAlarm;
    }

    public Map<String, Object> alarmUpdate(HttpSession session, WalletAlarmDTO alarmDTO) {
        WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
        alarmDTO.setAlarmWalletAddress(walletSession.getWalletAddress());
        alarmDTO.setCheckYn("Y");
        commonDao.update("WalletAlarm.updateCheckYn", alarmDTO);
        return alarmDTO.toMap();
    }

    public Object getOrderAlarm(HttpSession session) {
        try {
            Date date = Calendar.getInstance().getTime();
            List<String> symbolList = new ArrayList<>();
            symbolList.add("BANI");
            symbolList.add("EGG");

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            String strDate = dateFormat.format(date.getTime() - (1000 * 60 * 60 * 168));

            BuySearchDTO buySearchDTO = new BuySearchDTO();
            buySearchDTO.setPage(1);
            buySearchDTO.setLimit(1000);
            buySearchDTO.setIdOrderStatus("1");
            buySearchDTO.setStartDateSearch(strDate);
            buySearchDTO.setSymbolList(symbolList);

            SellSearchDTO sellSearchDTO = new SellSearchDTO();
            sellSearchDTO.setPage(1);
            sellSearchDTO.setLimit(1000);
            sellSearchDTO.setIdOrderStatus("1");
            sellSearchDTO.setStartDateSearch(strDate);
            sellSearchDTO.setSymbolList(symbolList);

            BuySearchDTO buyClientTraderDTO = new BuySearchDTO();
            buyClientTraderDTO.setIdOrderStatus("1");
            buyClientTraderDTO.setSymbolList(symbolList);

            SellSearchDTO sellClientTraderDTO = new SellSearchDTO();
            sellClientTraderDTO.setIdOrderStatus("1");
            sellClientTraderDTO.setSymbolList(symbolList);


            // CHECK ROLE, ONLY ROLE TRADE AND USER
            WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
            WalletDTO walletDTO = new WalletDTO();
            Boolean isTraderRole = false;
            Boolean isClientTraderRole = false;
            if (null != walletSession) {

                for (int i = 0; i < walletSession.getWallets().size(); i++) {
                    Object objWallet = (Object) walletSession.getWallets().get(i);
                    if (objWallet instanceof WalletDTO) {

                        walletDTO = (WalletDTO) walletSession.getWallets().get(i);
                    } else {

                        Map<String, Object> map = walletSession.getWallets().get(i);
                        walletDTO = new WalletDTO(map);
                    }
                    if (DataStatic.WALLET_ROLE.TRADER.equalsIgnoreCase(walletDTO.getRole())
                            || DataStatic.WALLET_ROLE.CLIENT_TRADER.equalsIgnoreCase(walletDTO.getRole())) {

                        switch (walletDTO.getRole()) {
                            case DataStatic.WALLET_ROLE.TRADER:
                                isTraderRole = true;
                                buySearchDTO.setAlarmRole(DataStatic.WALLET_ROLE.TRADER);
                                buySearchDTO.setWalletAddress(walletDTO.getWalletAddress());
//                                buySearchDTO.setBuyType(2); //Trader
//                                sellSearchDTO.setSellType(2);
                                sellSearchDTO.setAlarmRole(DataStatic.WALLET_ROLE.TRADER);
                                sellSearchDTO.setWalletAddress(walletDTO.getWalletAddress());
                                break;
                            case DataStatic.WALLET_ROLE.CLIENT_TRADER:
                                isClientTraderRole = true;
//                                buyClientTraderDTO.setViewRole(DataStatic.WALLET_ROLE.CLIENT_TRADER);
//                                sellClientTraderDTO.setViewRole(DataStatic.WALLET_ROLE.CLIENT_TRADER);
                                buyClientTraderDTO.setAlarmRole(DataStatic.WALLET_ROLE.TRADER);
                                buyClientTraderDTO.setWalletAddress(walletDTO.getWalletAddress());
//                                buyClientTraderDTO.setBuyType(2);
                                buyClientTraderDTO.setClientTraderUseYn("Y");

                                sellClientTraderDTO.setAlarmRole(DataStatic.WALLET_ROLE.TRADER);
                                sellClientTraderDTO.setWalletAddress(walletDTO.getWalletAddress());
//                                sellClientTraderDTO.setSellType(2);
                                sellClientTraderDTO.setClientTraderUseYn("Y");
                                break;
                        }
                    }
                }
            }
            List<Object> lst = new ArrayList<>();
            List<BuySearchDTO> getBuyList = new ArrayList<>();
            List<SellDTO> getSellList = new ArrayList<>();
            List<BuySearchDTO> getBuyClientTraderList = new ArrayList<>();
            List<SellDTO> getSellClientTraderList = new ArrayList<>();

            if (isTraderRole) {

                getBuyList = buyService.getBuyList(buySearchDTO);
                getSellList = sellService.getSellList(sellSearchDTO);
            }
            if (isClientTraderRole) {

                getBuyClientTraderList = buyService.getBuyList(buyClientTraderDTO);
                getSellClientTraderList = sellService.getSellList(sellClientTraderDTO);
            }
            int total = getBuyList.size() + getSellList.size() + getBuyClientTraderList.size() + getSellClientTraderList.size();
            lst.addAll(Collections.singleton(total));
            List<Object> buyRes = Collections.singletonList(getBuyList);
            List<Object> sellRes = Collections.singletonList(getSellList);
            List<Object> buyClientTraderRes = Collections.singletonList(getBuyClientTraderList);
            List<Object> sellClientTraderRes = Collections.singletonList(getSellClientTraderList);

            lst.addAll(buyRes.isEmpty() ? null : buyRes);
            lst.addAll((sellRes.isEmpty()) ? null : sellRes);
            lst.addAll((buyClientTraderRes.isEmpty()) ? null : buyClientTraderRes);
            lst.addAll((sellClientTraderRes.isEmpty()) ? null : sellClientTraderRes);


            return lst;
        } catch (Exception ex) {
            return null;
        }

    }


}
