package com.apollo.exchange.web.feedback.controller;

import com.apollo.exchange.common.feedback.dto.FeedbackDTO;
import com.apollo.exchange.common.feedback.dto.FeedbackSearchDTO;
import com.apollo.exchange.common.feedback.service.FeedbackService;
import com.apollo.exchange.common.utils.NetworkUtils;
import com.apollo.exchange.common.utils.UrlUtils;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class FeedbackController {

    @Autowired
    FeedbackService feedbackService;
    @Autowired
    MessageSource messageSource;

    @PostMapping("/feedback/request")
    public String doFeedbackRequest(HttpServletRequest request, Model model, RedirectAttributes attributes, HttpSession session,
                                    @ModelAttribute("feedbackRequest") FeedbackSearchDTO feedbackSearchDTO) {

        String ipAddress = NetworkUtils.getClientIpAddressIfServletRequestExist(request);
        feedbackSearchDTO.setIpAddress(ipAddress);
        log.info("POST: REQUEST: {}", new Gson().toJson(feedbackSearchDTO));

        FeedbackDTO res = feedbackService.feedbackRequest(session, feedbackSearchDTO);

        if (null == res) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("feedback.request.message.failed",
                    null, LocaleContextHolder.getLocale()));

            return UrlUtils.getPreviousPageByRequest(request).orElse("/");

        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("feedback.request.message.success",
                    null, LocaleContextHolder.getLocale()));
            if ("admin".equals(feedbackSearchDTO.getAuthRequest())) {
                return "redirect:/admin/feedback/edit?feedbackId=" + feedbackSearchDTO.getFeedbackId();
            }else {
//                return "redirect:/myRoom?targetView=%23feedback";
                return UrlUtils.getPreviousPageByRequest(request).orElse("/");
            }
        }


    }
}
