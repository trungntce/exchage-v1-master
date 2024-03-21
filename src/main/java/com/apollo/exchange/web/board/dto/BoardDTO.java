package com.apollo.exchange.web.board.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author hipo.dev
 * @apiNote Board Data DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDTO {
    private Integer boardId = null;
    private String langCode = LocaleContextHolder.getLocale().toString();
    private Integer boardType = null;
    private Integer boardKind = null;
    private String title = null;
    private String subTitle = null;
    private String contents = null;
    private Integer sort = null;
    private String imgSrc  = null;
    private String faqTitleYn = null;
    private String useYn = null;

    private String prevPage = null;
    private String nextPage = null;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;
}
