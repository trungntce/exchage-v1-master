package com.apollo.exchange.common.chat.service;

import com.apollo.exchange.common.chat.dto.ChatDTO;
import com.apollo.exchange.common.chat.dto.ChatSearchDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatService {

    private final ICommonDao commonDao;
    private final UserService userService;

    public void insertOne(ChatDTO chatDTO) {
        commonDao.insert("Chat.insertOne", chatDTO);
    }

    public void updateOne(ChatDTO chatDTO) {
        commonDao.update("Chat.updateOne", chatDTO);
    }

    public List<ChatSearchDTO> selectAllChat(ChatSearchDTO chatSearchDTO) {
        return commonDao.selectList("Chat.selectAllChat", chatSearchDTO);
    }

    public List<ChatSearchDTO> selectChatByUserId(HttpServletRequest session) {
        try {
            ChatSearchDTO chatSearchDTO = new ChatSearchDTO();
            WalletDTO walletCurrentSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET_CURRENT);
            if (null != walletCurrentSession) {
                UserDTO userDTO = userService.selectUserByWalletAddress(walletCurrentSession.getWalletAddress());
                chatSearchDTO.setCurrentUserId(userDTO.getUserId());
                chatSearchDTO.groupBy = "CHAT_ID";
                chatSearchDTO.setOrderByColumn("REG_DATE_LINE");
                chatSearchDTO.setOrderByType("DESC");

                return selectAllChat(chatSearchDTO);
            }

        } catch (Exception ex) {
            log.error(ex.toString());
        }
        return null;
    }

    public List<ChatSearchDTO> selectAllChatLineByUserId(HttpServletRequest session) {
        try {
            ChatSearchDTO chatSearchDTO = new ChatSearchDTO();
            WalletDTO walletCurrentSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET_CURRENT);
            if (null != walletCurrentSession) {
                UserDTO userDTO = userService.selectUserByWalletAddress(walletCurrentSession.getWalletAddress());
                chatSearchDTO.setCurrentUserId(userDTO.getUserId());
                chatSearchDTO.setLimit(1000);
                chatSearchDTO.setOrderByColumn("REG_DATE_LINE");
                chatSearchDTO.setOrderByType("ASC");
                return selectAllChat(chatSearchDTO);
            }

        } catch (Exception ex) {
            log.error(ex.toString());
        }
        return null;
    }

}
