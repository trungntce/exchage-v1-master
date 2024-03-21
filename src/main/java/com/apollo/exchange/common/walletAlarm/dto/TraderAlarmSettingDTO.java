package com.apollo.exchange.common.walletAlarm.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TraderAlarmSettingDTO {

    private Integer traderAlarmSettingId = null;
    private Integer walletId = null;
    private Integer repeatSeconds;
    private String useYn = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String regDate = null;
    private String walletAddress = null;
    private String path;
}
