package com.apollo.exchange.common.webSocket.dto;

import com.apollo.exchange.common.chat.dto.ChatLineSearchDTO;
import com.apollo.exchange.common.chat.dto.ChatSearchDTO;
import lombok.Data;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Data
public class SocketMessageDTO {
    private Integer chatId;
    private Integer chatLineId;
    private String from;
    private String to;
    private String toName;
    private MessageType type;
    private String content;
    private ChatLineSearchDTO chatContent;
    private String sender;
    private String isUpdate;
    private List<ChatSearchDTO> chatListRecipient;
    private List<ChatSearchDTO> chatListSender;



    public SocketMessageDTO() {
    }

    public SocketMessageDTO(String from, String content, String to, MessageType type,
                            Integer chatId, Integer chatLineId, String isUpdate, List<ChatSearchDTO> chatListRecipient, List<ChatSearchDTO> chatListSender) {
        this.from = from;
        this.content = content;
        this.to = to;
        this.type = type;
        this.chatId = chatId;
        this.chatLineId = chatLineId;
        this.isUpdate = isUpdate;
        this.chatListRecipient = chatListRecipient;
        this.chatListSender = chatListSender;
    }

    public enum MessageType {
        SEND, RECIPIENT, CHAT_LIST, CHAT_LINE, JOIN, LEAVE
    }
}
