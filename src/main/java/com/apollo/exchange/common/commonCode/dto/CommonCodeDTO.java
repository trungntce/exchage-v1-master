package com.apollo.exchange.common.commonCode.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.Locale;

/**
 * @author ionio.dev
 * @apiNote COMMON_CODE Data Transfer Object
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommonCodeDTO {

    private Integer commonCodeId = null;
    private String langCode = LocaleContextHolder.getLocale().toString();
    private String groupName = null;
    private String codeName = null;
    private String codeValue = null;
    private String useYn = "Y";
    private Integer orderNo = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

}
