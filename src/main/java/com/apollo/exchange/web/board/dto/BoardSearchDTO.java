package com.apollo.exchange.web.board.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author hipo.dev
 * @apiNote Board Search Data DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardSearchDTO extends PageDTO {
    private Integer boardId = null;
    private String langCode = LocaleContextHolder.getLocale().toString();
    private Integer boardType = null;
    private Integer boardKind = null;
    private String title = null;
    private String subTitle = null;
    private Integer sort = null;
    private String contents = null;
    private String faqTitleYn = null;
    private String useYn = null;

    private String searchType = null;
    private String keyword = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}
