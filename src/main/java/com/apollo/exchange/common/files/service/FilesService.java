package com.apollo.exchange.common.files.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.file.FileService;
import com.apollo.exchange.common.file.IFileUpload;
import com.apollo.exchange.common.files.dto.FilesDTO;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class FilesService {
    @Autowired
    private ICommonDao commonDao;
    @Autowired
    private FileService fileService;

    public void insertOne(FilesDTO filesDTO) {
        commonDao.insert("Files.insertOne", filesDTO);
    }

    public FilesDTO upload(HttpServletRequest request, MultipartFile file) {
//        EmpDTO empDTO = empService.getSessionUserLogin(request);
        FilesDTO filesDTO = new FilesDTO();

        fileService.uploadFile(file, new IFileUpload() {
            @Override
            public void processUpload(MultipartFile file, String realName, String path) {
                filesDTO.setFileType("file");
                filesDTO.setFilePath(path);
                filesDTO.setFileName(file.getOriginalFilename());
                filesDTO.setFileHashName(realName);
                filesDTO.setFileExt(FilenameUtils.getExtension(realName));
                filesDTO.setFileSize(file.getSize() + "");
                filesDTO.setFileStatus("real");
                insertOne(filesDTO);
            }
        });

        return filesDTO;
    }

    public List<FilesDTO> selectFeedbackFiles(int feedbackId) {
        return commonDao.selectList("Files.selectFeedbackFiles", feedbackId);
    }
}
