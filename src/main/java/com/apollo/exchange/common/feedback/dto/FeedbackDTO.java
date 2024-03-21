package com.apollo.exchange.common.feedback.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class FeedbackDTO {
    private Integer rowNum;
    private Integer feedbackId = null;
    private Integer refId = null;
    private Integer feedbackType = null;
    private String title = null;
    private String contents = null;
    private Integer state = null;
    private Integer pointEvaluation = null;
    private String checkYn = null;
    private String delYn = null;
    private String regUser = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private String ipAddress = null;
}
