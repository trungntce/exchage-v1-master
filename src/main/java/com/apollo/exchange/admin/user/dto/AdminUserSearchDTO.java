package com.apollo.exchange.admin.user.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminUserSearchDTO extends PageDTO {
    private String loginId;
    private Integer userId = null;
    private String keywordType = null;
    private String keyword = null;
    private String orderByColumn = "ROWNUM";
    private String orderByType = "DESC";
    private String useYn = null;
    private String timeSearchKey = null;
    private String searchDateStart = null;
    private String searchDateEnd  = null;
    private String regDate = null;
    private String role = null;
    private String symbol;
    private Integer clientId;
    private String clientCode;
}