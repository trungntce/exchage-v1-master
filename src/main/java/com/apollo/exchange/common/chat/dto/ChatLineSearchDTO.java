package com.apollo.exchange.common.chat.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class ChatLineSearchDTO {
    public Integer chatLineId = null;
    public Integer chatId = null;
    public String message = null;
    public Integer createId = null;
    public String checkYn = null;
    public String delYn = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date regDate = null;
    public String title = null;
    public Integer fromId = null;
    public String fromName = null;
    public Integer toId = null;
    public String toName = null;


}
