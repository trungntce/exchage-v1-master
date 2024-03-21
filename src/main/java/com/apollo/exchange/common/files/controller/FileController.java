package com.apollo.exchange.common.files.controller;

import com.apollo.exchange.common.files.dto.FilesDTO;
import com.apollo.exchange.common.files.service.FilesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@RestController
public class FileController {
    @Autowired
    FilesService filesService;

    @PostMapping(value = "/files/upload", produces = "application/json; charset=UTF-8")
    public FilesDTO uploadFile(HttpServletRequest request, @RequestParam("file") MultipartFile file){
        return filesService.upload(request, file);
    }
}
