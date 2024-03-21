package com.apollo.exchange.common.files.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class FilesDTO {
    private Integer fileId;
    private String fileType;
    private String filePath;
    private String fileName;
    private String fileHashName;
    private String fileExt;
    private String fileSize;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDT;
    private String fileStatus;
    private Integer refId;
}
