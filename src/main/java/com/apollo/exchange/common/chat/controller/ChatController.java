package com.apollo.exchange.common.chat.controller;

import com.apollo.exchange.common.chat.dto.ChatLineDTO;
import com.apollo.exchange.common.chat.dto.ChatLineSearchDTO;
import com.apollo.exchange.common.chat.dto.ChatSearchDTO;
import com.apollo.exchange.common.chat.service.ChatLineService;
import com.apollo.exchange.common.chat.service.ChatService;
import com.apollo.exchange.common.feedback.dto.FeedbackSearchDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@RestController
public class ChatController {

    @Autowired
    ChatService chatService;

    @Autowired
    ChatLineService chatLineService;


    @PostMapping(value = "/chat/addChatLine", produces = "application/json; charset=UTF-8")
    public ChatLineDTO doChatLine(HttpServletRequest session, @RequestBody ChatLineSearchDTO chatLineSearchDTO) {

        return chatLineService.insertChatLine(chatLineSearchDTO);
    }

    @PostMapping(value = "/chat/userListData", produces = "application/json; charset=UTF-8")
    public List<ChatSearchDTO> goUserListData(HttpServletRequest request) {
        try {
            WalletDTO walletSession = (WalletDTO) request.getSession().getAttribute(DataStatic.SESSION.WALLET);
            return chatService.selectChatByUserId(request);
        } catch (Exception ex) {
            log.error(ex.toString());
            return null;
        }



    }
    @PostMapping(value = "/chat/lineData", produces = "application/json; charset=UTF-8")
    public List<ChatSearchDTO> goLineData(HttpServletRequest request) {
        try {
            WalletDTO walletSession = (WalletDTO) request.getSession().getAttribute(DataStatic.SESSION.WALLET);
            return chatService.selectAllChatLineByUserId(request);
        } catch (Exception ex) {
            log.error(ex.toString());
            return null;
        }
    }
    @PostMapping(value = "/chat/updateCheckLine", produces = "application/json; charset=UTF-8")
    public boolean doUpdateCheckLine(HttpServletRequest request, @RequestBody ChatLineDTO ChatLineDTO) {
        try {
             chatLineService.updateCheckYn(ChatLineDTO);
            return true;
        } catch (Exception ex) {
            log.error(ex.toString());
            return false;
        }
    }


}
