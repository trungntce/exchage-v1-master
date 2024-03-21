package com.apollo.exchange.common.feedback.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.feedback.dto.FeedbackDTO;
import com.apollo.exchange.common.feedback.dto.FeedbackFileDTO;
import com.apollo.exchange.common.feedback.dto.FeedbackSearchDTO;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;


@Service
public class FeedbackService {

    @Autowired
    private ICommonDao commonDao;
    @Autowired
    FeedbackFileService feedbackFileService;


    public void insertOne(FeedbackDTO feedbackDTO) {
        commonDao.insert("Feedback.insertOne", feedbackDTO);
    }

    public void updateOne(FeedbackDTO feedbackDTO) {
        commonDao.update("Feedback.updateOne", feedbackDTO);
    }


    public List<FeedbackDTO> selectFeedback(FeedbackSearchDTO feedbackSearchDTO) {

        return commonDao.selectList("Feedback.selectFeedback", feedbackSearchDTO);
    }

    public FeedbackDTO selectOne(FeedbackSearchDTO feedbackSearchDTO) {

        return commonDao.selectOne("Feedback.selectOne", feedbackSearchDTO);
    }

    /*
      1. REQUEST
      2. CHECKING
      3. PROCESSING
      4. FINISHED
       */
    public FeedbackDTO feedbackRequest(HttpSession session, FeedbackSearchDTO feedbackSearchDTO) {

        try {
            LoginDTO loginDTO = (LoginDTO) session.getAttribute(DataStatic.SESSION.LOGIN);
            FeedbackDTO feedbackDTO = new FeedbackDTO();

            feedbackDTO.setTitle(feedbackSearchDTO.getTitle());
            feedbackDTO.setContents(feedbackSearchDTO.getContents());

            feedbackDTO.setPointEvaluation(feedbackSearchDTO.getPointEvaluation());
            feedbackDTO.setRegUser(loginDTO.getUsername());
            feedbackDTO.setIpAddress(feedbackSearchDTO.getIpAddress());
            if (null != feedbackSearchDTO.getFeedbackId() && feedbackSearchDTO.getFeedbackId() > 0) {
                feedbackDTO.setState(feedbackSearchDTO.getState());
                feedbackDTO.setFeedbackType(DataStatic.FEEDBACK_TYPE.REPLY);
                feedbackDTO.setRefId(feedbackSearchDTO.getFeedbackId());

                // Update state
                FeedbackSearchDTO fb = new FeedbackSearchDTO();
                fb.setFeedbackId(feedbackSearchDTO.getFeedbackId());
                fb.setState(feedbackSearchDTO.getState());
                feedbackUpdateStatus(session, fb);

            } else {
                feedbackDTO.setState(1);
                feedbackDTO.setFeedbackType(DataStatic.FEEDBACK_TYPE.REQUEST);
            }

            this.insertOne(feedbackDTO);

            // Insert file attach
            if (feedbackSearchDTO.getFileIds() != null) {

                String[] arrFileId = feedbackSearchDTO.getFileIds().split(",");
                for (int i = 0; i < arrFileId.length; i++) {
                    if (arrFileId[i] != null) {

                        FeedbackFileDTO feedbackFileDTO = new FeedbackFileDTO();
                        feedbackFileDTO.setFeedbackId(feedbackDTO.getFeedbackId());
                        feedbackFileDTO.setFileId(Integer.parseInt(arrFileId[i]));

                        feedbackFileService.insertOne(feedbackFileDTO);
                    }
                }

            }

            return feedbackDTO;

        } catch (Exception ex) {
            return null;
        }
    }

    public FeedbackDTO feedbackUpdateStatus(HttpSession session, FeedbackSearchDTO feedbackDTO) {
        try {
            if (null != feedbackDTO.getFeedbackId() && null != feedbackDTO.getState()) {
                feedbackDTO.setFeedbackType(DataStatic.FEEDBACK_TYPE.REQUEST);
                FeedbackDTO fbDetail = selectOne(feedbackDTO);
                fbDetail.setState(feedbackDTO.getState());
                updateOne(fbDetail);
                return fbDetail;
            }

        } catch (Exception ex) {
        }
        return null;
    }
}
