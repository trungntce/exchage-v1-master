package com.apollo.exchange.common.chat.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class ChatSearchDTO extends PageDTO {
    public Integer chatId = null;
    public Integer chatType = null;
    public String title = null;
    public Integer fromId = null;
    public String fromName = null;
    public Integer toId = null;
    public String toName = null;
    public String delYn = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date regDate = null;
    private Integer currentUserId = null;
    public Integer chatLineId = null;
    public String message = null;
    public Integer createId = null;
    public String checkYn = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date regDateLine = null;
    public String delYnLine = null;
    public String groupBy = null;
    public String loginId = null;
    private Integer userId = null;

}
