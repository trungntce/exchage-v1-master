package com.apollo.exchange.common.webSocket.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.http.HttpServletRequest;

import com.apollo.exchange.common.aop.SaveRequestProcessor;
import com.apollo.exchange.common.chat.dto.ChatLineDTO;
import com.apollo.exchange.common.chat.dto.ChatLineSearchDTO;
import com.apollo.exchange.common.chat.dto.ChatSearchDTO;
import com.apollo.exchange.common.chat.service.ChatLineService;
import com.apollo.exchange.common.chat.service.ChatService;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.webSocket.dto.SocketMessageDTO;
import com.apollo.exchange.common.webSocket.service.ActiveUserChangeListener;

import com.apollo.exchange.common.webSocket.service.ActiveUserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


@Controller
public class WebSocketChatController implements ActiveUserChangeListener {
    @Autowired
    ChatService chatService;

    @Autowired
    ChatLineService chatLineService;

    @Autowired
    private SimpMessagingTemplate webSocket;

    @Autowired
    private ActiveUserManager activeUserManager;


    @PostConstruct
    private void init() {
        activeUserManager.registerListener(this);
    }

    @PreDestroy
    private void destroy() {
        activeUserManager.removeListener(this);
    }

    @GetMapping("/sockjs-message")
    public String getWebSocketWithSockJs() {
        return "sockjs-message";
    }


    @MessageMapping("/chat")
    public void send(SimpMessageHeaderAccessor sha, @Payload SocketMessageDTO chatMessage) throws Exception {
        String sender = sha.getUser().getName();

        // Insert database
        ChatLineSearchDTO chatLineSearchDTO = new ChatLineSearchDTO();
        chatLineSearchDTO.setChatId(chatMessage.getChatId());
        chatLineSearchDTO.setFromId(Integer.parseInt(chatMessage.getFrom()));
        chatLineSearchDTO.setToId(Integer.parseInt(chatMessage.getTo()));
        chatLineSearchDTO.setToName(chatMessage.getToName());
        chatLineSearchDTO.setMessage(chatMessage.getContent());


        ChatLineDTO chatLineDTO = chatLineService.insertChatLine(chatLineSearchDTO);
        List<ChatSearchDTO> chatListSender = new ArrayList<>();
        List<ChatSearchDTO> chatListRecipient = new ArrayList<>();
        if (!"Y".equals(chatLineDTO.getIsUpdate())) {
            ChatSearchDTO chatSearchDTO = new ChatSearchDTO();
            chatSearchDTO.setCurrentUserId(chatLineSearchDTO.getFromId());
            chatSearchDTO.groupBy = "CHAT_ID";
            chatSearchDTO.setOrderByColumn("REG_DATE_LINE");
            chatSearchDTO.setOrderByType("DESC");

            chatListSender = chatService.selectAllChat(chatSearchDTO);

            chatSearchDTO.setCurrentUserId(chatLineSearchDTO.getToId());
            chatListRecipient = chatService.selectAllChat(chatSearchDTO);

        }
        if (!sender.equals(chatMessage.getTo())) {
            SocketMessageDTO message = new SocketMessageDTO(chatMessage.getFrom(), chatMessage.getContent(), chatMessage.getTo(), SocketMessageDTO.MessageType.SEND,
                    chatLineDTO.getChatId(), chatLineDTO.getChatLineId(), chatLineDTO.getIsUpdate(), chatListRecipient, chatListSender);
            webSocket.convertAndSendToUser(sender, "/queue/messages", message);
        }
        SocketMessageDTO message = new SocketMessageDTO(chatMessage.getFrom(), chatMessage.getContent(), chatMessage.getTo(), SocketMessageDTO.MessageType.RECIPIENT,
                chatLineDTO.getChatId(), chatLineDTO.getChatLineId(), chatLineDTO.getIsUpdate(), chatListRecipient, chatListSender);
        webSocket.convertAndSendToUser(chatMessage.getTo(), "/queue/messages", message);

    }


    @Override
    public void notifyActiveUserChange() {
        Set<String> activeUsers = activeUserManager.getAll();
        webSocket.convertAndSend("/topic/active", activeUsers);

    }

}
