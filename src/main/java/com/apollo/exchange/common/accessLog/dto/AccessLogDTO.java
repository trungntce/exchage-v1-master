package com.apollo.exchange.common.accessLog.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author ionio.dev
 * @apiNote ACCESS_LOG Data Transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AccessLogDTO {

    private Integer accessLogId = null;
    private Integer walletId = null;
    private Integer tracking = null;
    private Integer loginType = null;
    private String os = null;
    private String browser = null;
    private String device = null;
    private String ip = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}
