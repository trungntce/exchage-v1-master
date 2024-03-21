package com.apollo.exchange.common.feedback.dto;

import lombok.Data;
import org.web3j.abi.datatypes.Int;

@Data
public class FeedbackFileDTO {
    private Integer feedbackId = null;
    private Integer fileId = null;

}
