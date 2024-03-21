package com.apollo.exchange.admin.feedback.controller;

import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.feedback.dto.FeedbackDTO;
import com.apollo.exchange.common.feedback.dto.FeedbackSearchDTO;
import com.apollo.exchange.common.feedback.service.FeedbackService;
import com.apollo.exchange.common.files.dto.FilesDTO;
import com.apollo.exchange.common.files.service.FilesService;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.NetworkUtils;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class FeedbackController {
    @Autowired
    FilesService filesService;
    @Autowired
    FeedbackService feedbackService;
    @Autowired
    MessageSource messageSource;
    @Autowired
    CommonCodeService commonCodeService;

    @GetMapping("/feedback/list")
    public String goList(Model model, HttpSession session, @SessionAttribute("wallet") WalletDTO walletLogin,
                         @ModelAttribute("search") FeedbackSearchDTO feedbackSearchDTO) {

        // GET FEEDBACK
        LoginDTO loginDTO = (LoginDTO) session.getAttribute(DataStatic.SESSION.LOGIN);
//        feedbackSearchDTO.setRegUser(loginDTO.getUsername());
        feedbackSearchDTO.setFeedbackType(DataStatic.FEEDBACK_TYPE.REQUEST);
        feedbackSearchDTO.setDelYn("N");
        List<FeedbackDTO> feedbacks = feedbackService.selectFeedback(feedbackSearchDTO);

        model.addAttribute("feedbackState", commonCodeService.getListByGroupName("FEEDBACK_STATE"));
        model.addAttribute("feedbacks", feedbacks);
//
//        sellSearchDTO = adminSellService.initParam(walletLogin, sellSearchDTO);
//        sellSearchDTO.setTotal(adminSellService.count(sellSearchDTO, 1, null));
//
//        model.addAttribute("search", sellSearchDTO);
//        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
//        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
//        model.addAttribute("sellDTOList", adminSellService.getSellList(sellSearchDTO, 1, null));
//        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/feedback/list";
    }

    @GetMapping("/feedback/edit")
    public String doEdit(Model model, HttpSession session, @SessionAttribute("wallet") WalletDTO walletLogin,
                         @ModelAttribute("search") FeedbackSearchDTO feedbackSearchDTO) {

        // Get list detail
        FeedbackSearchDTO feedbackGetDetail = new FeedbackSearchDTO();
        feedbackGetDetail.setGetDetail("Y");
        feedbackGetDetail.setFeedbackId(feedbackSearchDTO.getFeedbackId());
        feedbackGetDetail.setRefId(feedbackSearchDTO.getFeedbackId());
        feedbackGetDetail.setDelYn("N");
        feedbackGetDetail.setOrderByColumn("FEEDBACK_ID");
        feedbackGetDetail.setOrderByType("ASC");


        List<FeedbackDTO> feedbackDetail = feedbackService.selectFeedback(feedbackGetDetail);
        // Get Files
        List<FilesDTO> feedbackFiles = filesService.selectFeedbackFiles(feedbackGetDetail.getFeedbackId());

        model.addAttribute("feedbackDetail", feedbackDetail);
        model.addAttribute("feedbackFiles", feedbackFiles);
        return "/admin/feedback/edit";
    }

    @PostMapping("/feedback/updateStatus")
    public String doFeedbackUpdate(HttpServletRequest request, Model model, RedirectAttributes attributes, HttpSession session,
                                    @ModelAttribute("feedbackRequest") FeedbackSearchDTO feedbackSearchDTO) {

        String ipAddress = NetworkUtils.getClientIpAddressIfServletRequestExist(request);
        feedbackSearchDTO.setIpAddress(ipAddress);
        log.info("POST: REQUEST: {}", new Gson().toJson(feedbackSearchDTO));

        FeedbackDTO res = feedbackService.feedbackUpdateStatus(session, feedbackSearchDTO);

        if (null == res) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("feedback.request.message.failed",
                    null, LocaleContextHolder.getLocale()));

            return "redirect:/admin/feedback/edit?feedbackId=" + feedbackSearchDTO.getFeedbackId();

        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("feedback.request.message.success",
                    null, LocaleContextHolder.getLocale()));
                return "redirect:/admin/feedback/edit?feedbackId=" + feedbackSearchDTO.getFeedbackId();

        }
    }
    @PostMapping("/feedback/reply")
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
                return "redirect:/myRoom?targetView=%23feedback";
            }
        }


    }

}
