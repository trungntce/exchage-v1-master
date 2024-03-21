package com.apollo.exchange.admin.client.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminClientSearchDTO extends PageDTO {
    private Integer clientId;
    private String symbol = null;
    private String keywordType = null;
    private String keyword = null;
    private String useYn = null;
    private String timeSearchKey = null;
    private String role;
    private String clientCode;
    private String apiKey;
    private String orderByColumn = "ROWNUM";
    private String orderByType = "DESC";
    private String searchDateStart = null;
    private String searchDateEnd = null;
}
