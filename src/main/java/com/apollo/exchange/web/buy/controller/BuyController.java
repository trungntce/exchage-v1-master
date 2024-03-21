package com.apollo.exchange.web.buy.controller;

import com.apollo.exchange.common.chat.service.ChatService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.web.buy.dto.*;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.web.buy.service.BuyTradeService;
import com.apollo.exchange.web.token.dto.TokenDTO;
import com.apollo.exchange.web.token.dto.TokenSearchDTO;
import com.apollo.exchange.web.token.service.TokenService;
import com.google.gson.Gson;
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

/**
 * @author ntt.dev
 * @apiNote Buy controller
 */
@Slf4j
@Controller
public class BuyController {

    @Autowired
    UserService userService;
    @Autowired
    ChatService chatService;
    @Autowired
    private BuyService buyService;
    @Autowired
    private TokenService tokenService;
    @Autowired
    private WalletService walletService;
    @Autowired
    private MessageSource messageSource;
    @Autowired
    private BuyTradeService buyTradeService;

    @GetMapping("/tradeBuyDetail")
    public String goTradeBuyDetail(Model model, HttpSession session, @ModelAttribute("search") BuySearchDTO buySearchDTO) {
        BuySearchDTO buyInfo = buyService.getBuyDetailByBuyId(buySearchDTO);
        BuySearchDTO buyPInfo = buyService.getBuyDetailByBuyId(new BuySearchDTO(buyInfo.getPBuyId()));
        if (DataStatic.VIEW_ROLE.OWNER_SAFE.equalsIgnoreCase(buyInfo.getViewRole()) && buyPInfo != null) {
            buyInfo.setBankAccount(buyPInfo.getBankAccount());
            buyInfo.setBankOwner(buyPInfo.getBankOwner());
            buyInfo.setBankName(buyPInfo.getBankName());
        }
        WalletDTO walletCurrent = walletService.getWalletCurrent(session, buySearchDTO.getWalletAddress());

        model.addAttribute("walletCurrent", walletCurrent);
        model.addAttribute("buyDetail", buyInfo);

//        UserDTO userCurrent = userService.selectUserByWalletAddress(walletCurrent.getWalletAddress());
//        model.addAttribute("userCurrent", userCurrent);

        UserDTO selectUserChat = new UserDTO();
        if (buyInfo.getRegWalletAddress().equals(walletCurrent.getWalletAddress())) {
            selectUserChat = userService.selectUserByWalletAddress(buyInfo.getSellerWalletAddress());
        } else {
            selectUserChat = userService.selectUserByWalletAddress(buyInfo.getRegWalletAddress());
        }

        model.addAttribute("userChat", selectUserChat);
        model.addAttribute("buyChildDetail", buyPInfo);
        model.addAttribute("tradeDepositForm", new BuyTradeConfirmDTO());
        return DataStatic.VIEW_RESOURCE.TRADE_BUY_DETAIL_WEB_NEW + "/tradeBuyDetail";
    }

    @GetMapping("/exTradeBuyDetail")
    public String goExTradeBuyDetail(Model model, HttpSession session, @ModelAttribute("search") BuySearchDTO buySearchDTO) {

        model.addAttribute("buyDetail", buyService.getBuyDetailByBuyId(buySearchDTO));
        model.addAttribute("tradeDepositForm", new BuyTradeConfirmDTO());
        return DataStatic.VIEW_RESOURCE.TRADE_BUY_DETAIL_WEB_NEW + "/ex/tradeBuyDetail";
    }

    @GetMapping("/buyRegister")
    public String goBuyRegister(Model model, BuyRequestDTO buyRequestDTO, HttpSession session) {
        List<TokenDTO> getTokenList = new ArrayList<>();
        WalletDTO walletCurrent = new WalletDTO();
        if (null == buyRequestDTO.getSymbol() || "".equals(buyRequestDTO.getSymbol())) {
            buyRequestDTO.setSymbol("BANI");
        }
        if (buyRequestDTO.getBuyerWalletAddress() == null) {
            walletCurrent = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
        } else {
            walletCurrent = walletService.getWalletCurrent(session, buyRequestDTO.getBuyerWalletAddress());
        }
        if (DataStatic.WALLET_ROLE.TRADER.equals(walletCurrent.getRole())
                || DataStatic.WALLET_ROLE.CLIENT_TRADER.equals(walletCurrent.getRole())
                || DataStatic.WALLET_ROLE.GUEST.equals(walletCurrent.getRole())) {
            List<String> operatorList = new ArrayList<>();
            operatorList.add("VIETKO");
            operatorList.add("BANI");
            TokenSearchDTO tokenSearchDTO = new TokenSearchDTO();
            tokenSearchDTO.setOperatorList(operatorList);
            getTokenList = tokenService.getTokenListByOperator(tokenSearchDTO);
        } else {
            getTokenList = tokenService.getTokenList();
        }

        model.addAttribute("tokens", getTokenList);
        model.addAttribute("buyRequest", buyRequestDTO);
        return DataStatic.VIEW_RESOURCE.TRADE_BUY_DETAIL_WEB_NEW + "/buyRegister";
    }

    @GetMapping("/exBuyRegister")
    public String goExBuyRegister(Model model, BuyRequestDTO buyRequestDTO, HttpSession session) {

        model.addAttribute("tokens", tokenService.getTokenList());
        model.addAttribute("buyRequest", buyRequestDTO);
        return DataStatic.VIEW_RESOURCE.TRADE_BUY_DETAIL_WEB_NEW + "/ex/buyRegister";
    }

    @PostMapping("/buyRequest")
    public String doBuyRequest(HttpServletRequest request, Model model, RedirectAttributes attributes, HttpSession session,
                               @ModelAttribute("buyRequest") BuyRequestDTO buyRequestDTO) {

        log.info("POST: BUY/REQUEST: {}", new Gson().toJson(buyRequestDTO));

        BuyDTO res = buyService.postBuyRequest(session, buyRequestDTO);

        if (res == null) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.register.message.fail",
                    null, LocaleContextHolder.getLocale()));
            return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.register.message.success",
                    null, LocaleContextHolder.getLocale()));
        }

        Integer orderId = res.getBuyId();
        if (buyRequestDTO.getType() != null && buyRequestDTO.getType().equals("ex"))
            return "redirect:/exTradeBuyDetail?buyId=".concat(orderId.toString());

        return "redirect:/tradeBuyDetail?buyId=".concat(orderId.toString());
    }

    @GetMapping("/buyCancel")
    public String doBuyCancel(HttpServletRequest request, Model model, HttpSession session, BuySearchDTO buySearchDTO) {

        boolean res = buyService.buyCancel(session, buySearchDTO);
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        if (buySearchDTO.getType() != null && buySearchDTO.getType().equals("ex"))
            return "redirect:/exTradeBuyDetail?buyId=".concat(buySearchDTO.getBuyId().toString());

        return "redirect:/tradeBuyDetail?buyId=".concat(buySearchDTO.getBuyId().toString());
    }

    @GetMapping("/buyTradeApply")
    public String doBuyApply(HttpServletRequest request, RedirectAttributes attributes, HttpSession session, BuyTradeDTO buyTradeDTO) {

        boolean res = buyTradeService.buyTradeApply(session, buyTradeDTO);
        if (!res) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("register.register.message.fail.title",
                    null, LocaleContextHolder.getLocale()));
        } else {
            attributes.addFlashAttribute("mess",
                    messageSource.getMessage("buy.request.message.success",
                            null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeBuyDetail?buyId=".concat(buyTradeDTO.getBuyId().toString());
    }

    @PostMapping("/confirmTxId")
    public String doBuyDeposit(HttpServletRequest request, RedirectAttributes attributes, HttpSession session,
                               @ModelAttribute("buyDeposit") BuyTradeConfirmDTO buyTradeConfirmDTO) {

        buyTradeConfirmDTO.setTradeState(2);
        boolean res = buyTradeService.buyTradeConfirmStatus(session, buyTradeConfirmDTO);
        if (res == false) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeBuyDetail?buyId=".concat(buyTradeConfirmDTO.getBuyId().toString());
    }

    @GetMapping("/buy/confirmCashDeposit")
    public String doBuyCashDeposit(HttpServletRequest request, RedirectAttributes attributes, HttpSession session, BuyDTO buyConfirmDTO) {

        boolean res = buyService.buyConfirmStatus(session, buyConfirmDTO);
        if (res == false) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeBuyDetail?buyId=".concat(buyConfirmDTO.getBuyId().toString());
    }

    @GetMapping("/tradeConfirmFinish")
    public String doBuyFinish(HttpServletRequest request, RedirectAttributes attributes, HttpSession session, BuyTradeConfirmDTO buyTradeConfirmDTO) {

        buyTradeConfirmDTO.setTradeState(4);// Finish
        boolean res = buyTradeService.buyTradeConfirmStatus(session, buyTradeConfirmDTO);
        if (res == false) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeBuyDetail?buyId=".concat(buyTradeConfirmDTO.getBuyId().toString());
    }

    @GetMapping("/buy/applyWithTransfer")
    public String doApplyWithTransfer(HttpServletRequest request, RedirectAttributes attributes, HttpSession session, BuyTradeConfirmDTO buyTradeConfirmDTO) {

        buyTradeConfirmDTO.setTradeState(4);// Finish
        int res = buyService.applyWithTransfer(session, buyTradeConfirmDTO);
        switch (res) {
            case 100:
                attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.success",
                        null, LocaleContextHolder.getLocale()));
                break;
            case -102:
                attributes.addFlashAttribute("mess", messageSource.getMessage("common.not.enough.token",
                        null, LocaleContextHolder.getLocale()));
                break;
            case -104:
                attributes.addFlashAttribute("mess", messageSource.getMessage("common.client.not.enough.token",
                        null, LocaleContextHolder.getLocale()));
                break;

            default:
                attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.fail",
                        null, LocaleContextHolder.getLocale()));
                break;
        }

//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeBuyDetail?buyId=".concat(buyTradeConfirmDTO.getBuyId().toString());
    }

    @GetMapping("/traderConfirmStatus")
    public String doTraderConfirmStatus(HttpServletRequest request, RedirectAttributes attributes, HttpSession session, BuyTradeConfirmDTO buyTradeConfirmDTO) {

        buyTradeConfirmDTO.setTradeState(2);
        boolean res = buyTradeService.buyTradeConfirmStatus(session, buyTradeConfirmDTO);
        if (!res) {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {
            attributes.addFlashAttribute("mess", messageSource.getMessage("buy.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeBuyDetail?buyId=".concat(buyTradeConfirmDTO.getBuyId().toString());
    }


}
