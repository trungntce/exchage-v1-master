package com.apollo.exchange.common.walletAlarm.dto;

import com.apollo.exchange.common.utils.ObjectUtils;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.Map;

@Data
public class WalletAlarmDTO {
    private Integer id = null;
    private Integer walletAlarmId = null;
    private Integer alarmType = null;
    private String alarmWalletAddress = null;
    private String title = null;
    private String contents = null;
    private String checkYn = null;
    private String delYn = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private Integer lastedId = null;
    private Integer buyId;
    private Integer sellId;

    public Map<String, Object> toMap() {
        return ObjectUtils.parameters(this);
    }

    public WalletAlarmDTO() {
    }


    public WalletAlarmDTO(Integer alarmType, String title, String contents, String alarmWalletAddress) {
        this.alarmType = alarmType;
        this.title = title;
        this.contents = contents;
        this.alarmWalletAddress = alarmWalletAddress;

    }

    public WalletAlarmDTO(Integer alarmType, String title, String contents, String alarmWalletAddress, Integer buyId, Integer sellId) {
        this.alarmType = alarmType;
        this.title = title;
        this.contents = contents;
        this.alarmWalletAddress = alarmWalletAddress;
        this.buyId = buyId;
        this.sellId = sellId;
    }
}
