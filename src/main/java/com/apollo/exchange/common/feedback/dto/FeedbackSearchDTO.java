package com.apollo.exchange.common.feedback.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.lang.reflect.Array;
import java.util.Date;
import java.util.List;

@Data
public class FeedbackSearchDTO extends PageDTO {
    private Integer feedbackId = null;
    private Integer refId = null;
    private List<Integer> refIds = null;
    private Integer feedbackType = null;
    private String title = null;
    private String contents = null;
    private Integer state = null;
    private List<Integer> states = null;
    private Integer pointEvaluation = null;
    private String checkYn = null;
    private String delYn = null;
    private String regUser = null;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
    private String ipAddress = null;
    //    private Integer fileId = null;
    private String fileIds = null;
    private String removeFileIds = null;
    private String showDetail = null;
    private String getDetail = null;
    private String authRequest = null;
}
