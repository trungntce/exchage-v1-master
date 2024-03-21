package com.apollo.exchange.config.scheduler;

import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import com.apollo.exchange.web.buy.dto.BuyDTO;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.buy.dto.BuyTradeDTO;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.web.buy.service.BuyTradeService;
import com.apollo.exchange.web.sell.dto.SellDTO;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.dto.SellTradeDTO;
import com.apollo.exchange.web.sell.service.SellService;
import com.apollo.exchange.web.sell.service.SellTradeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ntt.dev
 * @description Automatically update results and handle transactions, error transactions automatically re call
 */
@Slf4j
@Configuration
@EnableAsync
@EnableScheduling
public class schedulerConfig implements SchedulingConfigurer {
    @Autowired
    private BuyService tokenBuyService;

    @Autowired
    private SellService tokenSellService;

    @Autowired
    private BuyTradeService tokenBuyTradeHistoryService;

    @Autowired
    private SellTradeService tokenSellTradeHistoryService;

    @Autowired
    private WalletAlarmService walletAlarmService;

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {

        ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(20);
        taskScheduler.setThreadNamePrefix("Scheduler-Tread");
        taskScheduler.initialize();
        taskRegistrar.setTaskScheduler(taskScheduler);
        traderNotChangeStatus();
    }

    @Scheduled(fixedDelay = 60000, initialDelay = 10000)
    @Transactional(rollbackFor = {RuntimeException.class, Error.class})
    private void traderNotChangeStatus() {
        try {
            List<Integer> lstTradeStatus = new ArrayList<>();
            // GET LIST NOT CHANGE > 10 MINUTE
            BuyTradeDTO tokenBuyTradeHistoryDTO = new BuyTradeDTO();
            lstTradeStatus.add(1);
            lstTradeStatus.add(2);

            tokenBuyTradeHistoryDTO.setTradeStates(lstTradeStatus);
            tokenBuyTradeHistoryDTO.setMinute((10));
            List<BuyTradeDTO> lstBuyTradeOutDate = tokenBuyTradeHistoryService.selectOutOfDateList(tokenBuyTradeHistoryDTO);
            if (lstBuyTradeOutDate.size() > 0) {

                List<Integer> tradeBuyHistoryIds = new ArrayList<>();
                List<Integer> buyIds = new ArrayList<>();
                for (BuyTradeDTO tb : lstBuyTradeOutDate) {
                    if (null == tb.getTxid() || "".equals(tb.getTxid())) {
                        tradeBuyHistoryIds.add(tb.getBuyTradeHistoryId());
                        buyIds.add(tb.getBuyId());
                        //Add alarm to buyer
                        WalletAlarmDTO alarmDTO = new WalletAlarmDTO(tb.getBuyType(),
                                "alarm.order.your.order.has.been.cancel",
                                "/tradeBuyDetail?buyId=" + tb.getBuyId(), tb.getSellerWalletAddress(), tb.getBuyId(), 0);
                        walletAlarmService.save(alarmDTO);
                    }
                }
                // UPDATE TOKEN_BUY_TRADE_HISTORY TO (5) CANCEL STATUS
                BuyTradeDTO updateTradeDTO = new BuyTradeDTO();
                updateTradeDTO.setBuyTradeHistoryIds(tradeBuyHistoryIds);
                updateTradeDTO.setTradeState(5);
                tokenBuyTradeHistoryService.updateStateByIds(updateTradeDTO);

                // UPDATE TOKEN_BUY TO (1) Wait STATUS
                BuySearchDTO tokenBuyDTO = new BuySearchDTO();
                tokenBuyDTO.setBuyIds(buyIds);
                tokenBuyDTO.setState(1);
                tokenBuyService.updateStateByIds(tokenBuyDTO);
            }
            // GET LIST NOT CHANGE > 10 MINUTE
            SellTradeDTO tokenSellTradeHistoryDTO = new SellTradeDTO();
            tokenSellTradeHistoryDTO.setTradeStates(lstTradeStatus);
            tokenSellTradeHistoryDTO.setMinute(10);
            List<SellTradeDTO> lstSellTradeOutDate = tokenSellTradeHistoryService.selectOutOfDateList(tokenSellTradeHistoryDTO);
            if (lstSellTradeOutDate.size() > 0) {

                List<Integer> tradeSellHistoryIds = new ArrayList<>();
                List<Integer> sellIds = new ArrayList<>();
                for (SellTradeDTO tb : lstSellTradeOutDate) {
                    if (null == tb.getTxid() || "".equals(tb.getTxid())) {
                        tradeSellHistoryIds.add(tb.getSellTradeHistoryId());
                        sellIds.add(tb.getSellId());
                        //Add alarm to buyer
                        WalletAlarmDTO alarmDTO = new WalletAlarmDTO(tb.getSellType(),
                                "alarm.order.your.order.has.been.cancel",
                                "/tradeSellDetail?sellId=" + tb.getSellId(), tb.getBuyerWalletAddress(), 0, tb.getSellId());
                        walletAlarmService.save(alarmDTO);
                    }
                }
                // UPDATE TOKEN_SELL_TRADE_HISTORY TO (5) CANCEL STATUS
                SellTradeDTO updateTradeDTO = new SellTradeDTO();
                updateTradeDTO.setSellTradeHistoryIds(tradeSellHistoryIds);
                updateTradeDTO.setTradeState(5);
                tokenSellTradeHistoryService.updateStateByIds(updateTradeDTO);

                // UPDATE TOKEN_SELL TO (1) Wait STATUS
                SellSearchDTO tokenSellDTO = new SellSearchDTO();
                tokenSellDTO.setSellIds(sellIds);
                tokenSellDTO.setState(1);
                tokenSellService.updateStateByIds(tokenSellDTO);
            }
        } catch (Exception ex) {
            log.info(ex.toString());
        }

    }
}
