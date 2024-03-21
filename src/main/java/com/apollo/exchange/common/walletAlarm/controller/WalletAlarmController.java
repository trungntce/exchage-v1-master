package com.apollo.exchange.common.walletAlarm.controller;

import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.walletAlarm.dto.WalletAlarmDTO;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
public class WalletAlarmController {
    @Autowired
    private WalletAlarmService walletAlarmService;

    @GetMapping(value = "/alarm/order", produces = MediaType.APPLICATION_JSON_VALUE)
    public Object alarmOrder(HttpSession session, WalletAlarmDTO alarmDTO) {
        return walletAlarmService.getOrderAlarm(session);
//        WalletAlarmDTO walletAlarmDTO = new WalletAlarmDTO();
//        return walletAlarmService.getListAlarmByWallet(session, alarmDTO);
    }


    @GetMapping(value = "/alarm", produces = MediaType.APPLICATION_JSON_VALUE)
    public Object alarm(HttpSession session, WalletAlarmDTO alarmDTO) {
        return walletAlarmService.getListAlarmByWallet(session, alarmDTO);
    }

    @PostMapping(value = "/alarm/update", produces = MediaType.APPLICATION_JSON_VALUE)
    public Object alarmUpdate(@RequestBody WalletAlarmDTO alarmDTO, HttpSession session) {
        return walletAlarmService.alarmUpdate(session, alarmDTO);
    }

    @GetMapping(value = "/alarm/updateById", produces = MediaType.APPLICATION_JSON_VALUE)
    public Object alarmUpdateById(HttpServletRequest request, HttpSession session, WalletAlarmDTO alarmDTO) {
        if (alarmDTO.getWalletAlarmId() <= 0) {
            return UrlUtils.getPreviousPageByRequest(request).orElse("/");

        }
        walletAlarmService.alarmUpdate(session, alarmDTO);
        return new RedirectView(alarmDTO.getContents());

    }

}
