package com.apollo.exchange.web.sell.controller;

import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.web.buy.dto.*;
import com.apollo.exchange.web.sell.dto.*;
import com.apollo.exchange.web.sell.service.SellService;
import com.apollo.exchange.web.sell.service.SellTradeService;
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
 * @apiNote Sell controller
 */
@Slf4j
@Controller
public class SellController {
    @Autowired
    UserService userService;
    @Autowired
    private SellService sellService;
    @Autowired
    private TokenService tokenService;
    @Autowired
    private MessageSource messageSource;
    @Autowired
    private WalletService walletService;
    @Autowired
    private SellTradeService sellTradeService;

    @GetMapping("/tradeSellDetail")
    public String goTradeSellDetail(Model model, HttpSession session, @ModelAttribute("search") SellSearchDTO sellSearchDTO) {

        WalletDTO walletCurrent = walletService.getWalletCurrent(session, sellSearchDTO.getWalletAddress());
        SellSearchDTO sellInfo = sellService.getSellDetailBySellId(sellSearchDTO);
        model.addAttribute("walletCurrent", walletCurrent);
        model.addAttribute("sellDetail", sellInfo);
        model.addAttribute("tradeDepositForm", new SellTradeConfirmDTO());

        UserDTO selectUserChat = new UserDTO();
        if (sellInfo.getRegWalletAddress().equals(walletCurrent.getWalletAddress())) {
            selectUserChat = userService.selectUserByWalletAddress(sellInfo.getBuyerWalletAddress());
        } else {
            selectUserChat = userService.selectUserByWalletAddress(sellInfo.getRegWalletAddress());
        }

        model.addAttribute("userChat", selectUserChat);
        return DataStatic.VIEW_RESOURCE.TRADE_SELL_DETAIL_WEB_NEW + "/tradeSellDetail";
    }

    @GetMapping("/sellRegister")
    public String goSellRegister(Model model, SellRequestDTO sellRequestDTO, HttpSession session) {

        List<TokenDTO> getTokenList = new ArrayList<>();
        WalletDTO walletCurrent = new WalletDTO();
        if (null == sellRequestDTO.getSymbol() || "".equals(sellRequestDTO.getSymbol())) {
            sellRequestDTO.setSymbol("BANI");
        }
        if (sellRequestDTO.getSellerWalletAddress() == null) {
            walletCurrent = (WalletDTO) session.getAttribute(DataStatic.SESSION.WALLET);
        } else {
            walletCurrent = walletService.getWalletCurrent(session, sellRequestDTO.getSellerWalletAddress());
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
        model.addAttribute("sellRequest", sellRequestDTO);
        return DataStatic.VIEW_RESOURCE.TRADE_SELL_DETAIL_WEB_NEW + "/sellRegister";
    }

    @GetMapping("/exSellRegister")
    public String goExSellRegister(Model model, SellRequestDTO sellRequestDTO, HttpSession session) {

        model.addAttribute("tokens", tokenService.getTokenList());
        model.addAttribute("sellRequest", sellRequestDTO);
        return DataStatic.VIEW_RESOURCE.TRADE_SELL_DETAIL_WEB_NEW + "/ex/sellRegister";
    }

    @GetMapping("/exTradeSellDetail")
    public String goExTradeSellDetail(Model model, HttpSession session, @ModelAttribute("search") SellSearchDTO sellSearchDTO) {

        model.addAttribute("sellDetail", sellService.getSellDetailBySellId(sellSearchDTO));
        model.addAttribute("tradeDepositForm", new SellTradeConfirmDTO());
        return DataStatic.VIEW_RESOURCE.TRADE_SELL_DETAIL_WEB_NEW + "/ex/tradeSellDetail";
    }

    @PostMapping("/sellRequest")
    public String doSellRequest(HttpServletRequest request, Model model,
                                RedirectAttributes attributes, HttpSession session, @ModelAttribute("sellRequest") SellRequestDTO sellRequestDTO) {

        log.info("POST: SELL/REQUEST: {}", new Gson().toJson(sellRequestDTO));

        SellDTO res = sellService.sellRequest(session, sellRequestDTO);
        if (res == null) {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.register.message.fail",
                    null, LocaleContextHolder.getLocale()));
            return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        } else {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.register.message.success",
                    null, LocaleContextHolder.getLocale()));
        }

//        attributes.addFlashAttribute("sellOrderId", res.get("result"));
        Integer orderId = (Integer) res.getSellId();
        if (sellRequestDTO.getType() != null
                && sellRequestDTO.getType().equals("ex")) {

            return "redirect:/exTradeSellDetail?sellId=".concat(orderId.toString());
        }

        return "redirect:/tradeSellDetail?sellId=".concat(orderId.toString());
    }

    @GetMapping("/sellCancel")
    public String doBuyCancel(HttpServletRequest request, Model model, HttpSession session, SellSearchDTO sellSearchDTO) {

        boolean res = sellService.sellCancel(session, sellSearchDTO);

//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        if (sellSearchDTO.getType() != null
                && sellSearchDTO.getType().equals("ex")) {

            return "redirect:/exTradeSellDetail?sellId=".concat(sellSearchDTO.getSellId().toString());
        }
        return "redirect:/tradeSellDetail?sellId=".concat(sellSearchDTO.getSellId().toString());
    }

    @GetMapping("/sellTradeApply")
    public String doSellApply(HttpServletRequest request, RedirectAttributes attributes, HttpSession session, SellTradeDTO sellTradeDTO) {

        boolean res = sellTradeService.sellTradeApply(session, sellTradeDTO);
        if (res == false) {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeSellDetail?sellId=".concat(sellTradeDTO.getSellId().toString());
    }

    // Trader click transfer token seller to buyer
    @GetMapping("/sell/applyWithTransfer")
    public String doApplyWithTransfer(HttpServletRequest request, RedirectAttributes attributes,
                                      HttpSession session, SellTradeConfirmDTO sellTradeConfirmDTO) {

        int res = sellTradeService.applyWithTransfer(session, sellTradeConfirmDTO);
        switch (res) {
            case 100:
                attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.success",
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
                attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.fail",
                        null, LocaleContextHolder.getLocale()));
                break;
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeSellDetail?sellId=".concat(sellTradeConfirmDTO.getSellId().toString());
    }


    @GetMapping("/sell/confirmCashDeposit")
    public String doBuyCashDeposit(HttpServletRequest request, RedirectAttributes attributes,
                                   HttpSession session, SellTradeConfirmDTO sellTradeConfirmDTO) {

        sellTradeConfirmDTO.setTradeState(2);
        boolean res = sellTradeService.sellTradeConfirmStatus(session, sellTradeConfirmDTO);
        if (res == false) {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeSellDetail?sellId=".concat(sellTradeConfirmDTO.getSellId().toString());
    }

    @PostMapping("/sell/confirmTxId")
    public String doConfirmTxId(HttpServletRequest request, RedirectAttributes attributes,
                                HttpSession session, SellTradeConfirmDTO sellTradeConfirmDTO) {

        sellTradeConfirmDTO.setTradeState(3);
        boolean res = sellTradeService.sellTradeConfirmStatus(session, sellTradeConfirmDTO);
        if (res == false) {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeSellDetail?sellId=".concat(sellTradeConfirmDTO.getSellId().toString());
    }

    @GetMapping("/sell/confirmFinish")
    public String doConfirmFinish(HttpServletRequest request, RedirectAttributes attributes,
                                  HttpSession session, SellTradeConfirmDTO sellTradeConfirmDTO) {

        sellTradeConfirmDTO.setTradeState(4);
        boolean res = sellTradeService.sellTradeConfirmStatus(session, sellTradeConfirmDTO);
        if (res == false) {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.fail",
                    null, LocaleContextHolder.getLocale()));
        } else {

            attributes.addFlashAttribute("mess", messageSource.getMessage("sell.request.message.success",
                    null, LocaleContextHolder.getLocale()));
        }
//        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
        return "redirect:/tradeSellDetail?sellId=".concat(sellTradeConfirmDTO.getSellId().toString());
    }


}
