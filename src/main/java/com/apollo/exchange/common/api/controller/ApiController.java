package com.apollo.exchange.common.api.controller;

import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * @author ntt.dev
 * @apiNote Api controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApiController {

    final ApiService apiService;

    @GetMapping(value = "/balance")
    public Object getBalance(HttpSession session, String walletAddress,@RequestParam(name = "symbol", required = false, defaultValue = "BANI") String symbol) {
        return ResponseEntity.status(HttpStatus.OK).body(apiService.getBalance(session, symbol, walletAddress).toString());
    }

    @PostMapping(value = "/transfer")
    public Object transfer(@RequestBody ApiTransferDTO apiTransferDTO){
        return ResponseEntity.status(HttpStatus.OK).body(apiService.transferWithFee(apiTransferDTO));
    }

}
