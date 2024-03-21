package com.apollo.exchange.common.chat.service;

import com.apollo.exchange.common.chat.dto.ChatDTO;
import com.apollo.exchange.common.chat.dto.ChatLineDTO;
import com.apollo.exchange.common.chat.dto.ChatLineSearchDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatLineService {

    private final ICommonDao commonDao;
    private final UserService userService;
    private final ChatService chatService;

    public void insertOne(ChatLineDTO chatLineDTO) {
        commonDao.insert("ChatLine.insertOne", chatLineDTO);
    }

    public void updateOne(ChatLineDTO chatLineDTO) {
        commonDao.update("ChatLine.updateOne", chatLineDTO);
    }

    public void updateCheckYn(ChatLineDTO chatLineDTO) {
        commonDao.update("ChatLine.updateCheckYn", chatLineDTO);
    }

    public ChatLineDTO insertChatLine(ChatLineSearchDTO chatLineSearchDTO) {
        try {
            UserDTO userDTO = userService.selectUserByUserId(chatLineSearchDTO.getFromId());
            if (null == chatLineSearchDTO.getChatId() || chatLineSearchDTO.getChatId().longValue() <= 0) {
                // Chat Insert
                ChatDTO chatDTO = new ChatDTO();
                chatDTO.setChatType(DataStatic.CHAT_TYPE.SEND);
                chatDTO.setTitle(chatLineSearchDTO.getTitle());
                chatDTO.setFromId(userDTO.getUserId());
                chatDTO.setFromName(userDTO.getLoginId());
                chatDTO.setToId(chatLineSearchDTO.getToId());
                chatDTO.setToName(chatLineSearchDTO.getToName());
                chatDTO.setDelYn("N");
                this.chatService.insertOne(chatDTO);

                // ChatLine Insert
                ChatLineDTO chatLineDTO = new ChatLineDTO();
                chatLineDTO.setChatId(chatDTO.getChatId());
                chatLineDTO.setMessage(chatLineSearchDTO.getMessage());
                chatLineDTO.setCreateId(userDTO.getUserId());
                chatLineDTO.setCheckYn("N");
                chatLineDTO.setDelYn("N");
                this.insertOne(chatLineDTO);
                chatLineDTO.setIsUpdate("N");
                return chatLineDTO;

            } else {

                // ChatLine Insert
                ChatLineDTO chatLineDTO = new ChatLineDTO();
                chatLineDTO.setChatId(chatLineSearchDTO.getChatId());
                chatLineDTO.setMessage(chatLineSearchDTO.getMessage());
                chatLineDTO.setCreateId(userDTO.getUserId());
                chatLineDTO.setCheckYn("N");
                chatLineDTO.setDelYn("N");
                this.insertOne(chatLineDTO);
                chatLineDTO.setIsUpdate("Y");
                return chatLineDTO;
            }


        } catch (Exception ex) {
            log.error(ex.toString());
            return null;
        }
    }
}
