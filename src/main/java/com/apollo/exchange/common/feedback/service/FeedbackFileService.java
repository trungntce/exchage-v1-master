package com.apollo.exchange.common.feedback.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.feedback.dto.FeedbackFileDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FeedbackFileService {
    @Autowired
    private ICommonDao commonDao;
    public void insertOne(FeedbackFileDTO feedbackFileDTO){
        commonDao.insert("FeedbackFile.insertOne", feedbackFileDTO);
    }

}
