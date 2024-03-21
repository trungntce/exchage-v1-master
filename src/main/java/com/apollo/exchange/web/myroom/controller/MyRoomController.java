package com.apollo.exchange.web.myroom.controller;

import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.feedback.dto.FeedbackDTO;
import com.apollo.exchange.common.feedback.dto.FeedbackSearchDTO;
import com.apollo.exchange.common.feedback.service.FeedbackService;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.common.walletAlarm.dto.TraderAlarmSettingDTO;
import com.apollo.exchange.common.walletAlarm.service.TraderAlarmSettingService;
import com.apollo.exchange.common.walletAlarm.service.WalletAlarmService;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.common.files.dto.FilesDTO;
import com.apollo.exchange.common.files.service.FilesService;
import com.apollo.exchange.web.sell.dto.SellDTO;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.service.SellService;
import com.apollo.exchange.web.token.service.TokenService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class MyRoomController {

    @Autowired
    private BuyService buyService;
    @Autowired
    private SellService sellService;
    @Autowired
    FeedbackService feedbackService;
    @Autowired
    FilesService filesService;
    @Autowired
    private TokenService tokenService;
    @Autowired
    private MessageSource messageSource;
    @Autowired
    private WalletService walletService;
    @Autowired
    CommonCodeService commonCodeService;
    @Autowired
    private WalletAlarmService walletAlarmService;
    @Autowired
    private TraderAlarmSettingService traderAlarmSettingService;

    @GetMapping("/myRoom")
    public String goMyRoom(Model model, HttpSession session, RedirectAttributes attributes, BuySearchDTO buySearchDTO, SellSearchDTO sellSearchDTO,
                           FeedbackSearchDTO feedbackSearchDTO) {

        WalletDTO walletSession = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
        try {

            String walletCurrent = (null == buySearchDTO.getWalletAddress()) ? walletSession.getWalletAddress() : buySearchDTO.getWalletAddress();

            // BUY
            List<String> buyTypes = new ArrayList<>();
            buyTypes.add("1");
            buyTypes.add("2");
            buySearchDTO.setPage(buySearchDTO.getBuyPage());
            buySearchDTO.setBuyTypes(buyTypes);
            buySearchDTO.setOwner("true");
            buySearchDTO.setWalletAddress(walletCurrent);
            List<BuySearchDTO> lstBuy = buyService.getBuyList(buySearchDTO);
            Integer buyCount = buyService.getCountBuy(buySearchDTO);
            buySearchDTO.setTotal(buyCount);

            // SELL
            List<String> sellTypes = new ArrayList<>();
            sellTypes.add("1");
            sellTypes.add("2");
            sellSearchDTO.setPage(sellSearchDTO.getSellPage());
            sellSearchDTO.setSellTypes(sellTypes);
            sellSearchDTO.setOwner("true");
            sellSearchDTO.setWalletAddress(walletCurrent);
            List<SellDTO> lstSell = sellService.getSellList(sellSearchDTO);
            Integer sellCount = sellService.getCountSell(sellSearchDTO);
            sellSearchDTO.setTotal(sellCount);

            //WALLET INFO
            Map<String, Object> walletAlarmInfo = walletService.getData(walletCurrent).toMap();
            WalletDTO walletForm = new WalletDTO(walletAlarmInfo);

            // GET FEEDBACK
            LoginDTO loginDTO = (LoginDTO) session.getAttribute(DataStatic.SESSION.LOGIN);
            feedbackSearchDTO.setRegUser(loginDTO.getUsername());
            feedbackSearchDTO.setFeedbackType(DataStatic.FEEDBACK_TYPE.REQUEST);
            feedbackSearchDTO.setDelYn("N");
//            feedbackSearchDTO.setPage(feedbackSearchDTO.getPage());
            List<FeedbackDTO> feedbacks = feedbackService.selectFeedback(feedbackSearchDTO);
            if ("Y".equals(feedbackSearchDTO.getShowDetail()) && !feedbackSearchDTO.getRefId().equals(null)) {

                // Get list detail
                FeedbackSearchDTO feedbackGetDetail = new FeedbackSearchDTO();
                feedbackGetDetail.setGetDetail("Y");
                feedbackGetDetail.setFeedbackId(feedbackSearchDTO.getRefId());
                feedbackGetDetail.setRefId(feedbackSearchDTO.getRefId());
                feedbackGetDetail.setDelYn("N");
                feedbackGetDetail.setOrderByColumn("FEEDBACK_ID");
                feedbackGetDetail.setOrderByType("ASC");


                List<FeedbackDTO> feedbackDetail = feedbackService.selectFeedback(feedbackGetDetail);
                // Get Files
                List<FilesDTO> feedbackFiles = filesService.selectFeedbackFiles(feedbackGetDetail.getFeedbackId());

                model.addAttribute("feedbackDetail", feedbackDetail);
                model.addAttribute("feedbackFiles", feedbackFiles);

            }

            model.addAttribute("feedbackState", commonCodeService.getListByGroupName("FEEDBACK_STATE"));
            model.addAttribute("buyList", lstBuy);
            model.addAttribute("sellList", lstSell);
            model.addAttribute("feedbacks", feedbacks);
            model.addAttribute("tokens", tokenService.getTokenList());

            model.addAttribute("buySearch", buySearchDTO);
            model.addAttribute("sellSearch", sellSearchDTO);
            model.addAttribute("feedbackSearch", feedbackSearchDTO);
            model.addAttribute("walletInfo", walletAlarmInfo);
            model.addAttribute("walletForm", walletForm);

            model.addAttribute("alarmForm", traderAlarmSettingService.getAlarmSettingByWalletId(walletForm.getWalletId()));
            return DataStatic.VIEW_RESOURCE.MY_ROOM_WEB + "info";

        } catch (Exception ex) {

            log.error(ex.toString());
        }
        attributes.addFlashAttribute("mess", messageSource.getMessage("login.message.fail.unauthorized.access",
                null, LocaleContextHolder.getLocale()));
        return "/";

    }

    @PostMapping("/myRoom/walletUpdate")
    public String doWalletUpdate(HttpServletRequest request, RedirectAttributes attributes,
                                 HttpSession session, @ModelAttribute("walletForm") WalletDTO walletDTO) {

        boolean res = walletService.updateByMyRoom(session, walletDTO);
        if (res == false) attributes.addFlashAttribute("mess", messageSource.getMessage("myroom.information.save.false",
                null, LocaleContextHolder.getLocale()));
        else attributes.addFlashAttribute("mess", messageSource.getMessage("myroom.information.save.success",
                null, LocaleContextHolder.getLocale()));
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }

    @PostMapping("/myRoom/alarmUpdate")
    public String doAlarmUpdate(HttpServletRequest request, RedirectAttributes attributes,
                                HttpSession session, @ModelAttribute("alarmForm") TraderAlarmSettingDTO traderAlarmSettingDTO) {

        Boolean res = traderAlarmSettingService.updateData(request, traderAlarmSettingDTO);

        if (res == false) attributes.addFlashAttribute("mess", messageSource.getMessage("myroom.information.save.false",
                null, LocaleContextHolder.getLocale()));
        else attributes.addFlashAttribute("mess", messageSource.getMessage("myroom.information.save.success",
                null, LocaleContextHolder.getLocale()));
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }
}
