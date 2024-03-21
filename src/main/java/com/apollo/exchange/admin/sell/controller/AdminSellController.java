package com.apollo.exchange.admin.sell.controller;

import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.sell.dto.AdminSellTradeDTO;
import com.apollo.exchange.admin.sell.service.AdminSellSafeService;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellDTO;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.sell.service.AdminSellMyTradeService;
import com.apollo.exchange.admin.sell.service.AdminSellRequestService;
import com.apollo.exchange.admin.sell.service.AdminSellService;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.message.MessageSupport;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @author hipo.dev
 * @apiNote Admin Sell ( information ) controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AdminSellController {

    private final CommonCodeService commonCodeService;
    private final AdminSellService adminSellService;
    private final AdminSellMyTradeService adminSellMyTradeService;
    private final AdminSellRequestService adminSellRequestService;
    private final AdminTokenService adminTokenService;
    private final AdminClientService adminClientService;
    private final AdminSellSafeService adminSellSafeService;

    @GetMapping("/sell/general/list")
    public String goSellGeneralList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminSellSearchDTO sellSearchDTO) {
        sellSearchDTO = adminSellService.initParam(walletLogin, sellSearchDTO);
        sellSearchDTO.setTotal(adminSellService.count(sellSearchDTO,1, null));

        model.addAttribute("search", sellSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("sellDTOList", adminSellService.getSellList(sellSearchDTO,1, null));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/sell/general/list";
    }

    @GetMapping("/sell/api/list")
    public String goSellApiList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminSellSearchDTO sellSearchDTO) {
        sellSearchDTO = adminSellService.initParam(walletLogin, sellSearchDTO);
        sellSearchDTO.setTotal(adminSellService.count(sellSearchDTO,2, null));

        model.addAttribute("search", sellSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("sellDTOList", adminSellService.getSellList(sellSearchDTO,2, null));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/sell/api/list";
    }

    @GetMapping("/sell/mytrade/list")
    public String goSellMytradeList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminSellSearchDTO sellSearchDTO) {
        sellSearchDTO = adminSellMyTradeService.initParam(walletLogin, sellSearchDTO);
        sellSearchDTO.setTotal(adminSellMyTradeService.count(sellSearchDTO));
        model.addAttribute("search", sellSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("sellDTOList", adminSellMyTradeService.selectList(sellSearchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/sell/mytrade/list";
    }

    @GetMapping("/sell/mytrade/write")
    public String goSellMyTradeWrite(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin){
        model.addAttribute("tokens", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("sites", adminClientService.getClientSiteOwner());
        model.addAttribute("traders", adminClientService.getClientTraderOwner());
        return "/admin/sell/mytrade/write";
    }

    /**
     * @description Sell register
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param adminSellDTO {buyerWalletAddress, clientId, unitPrice, totalPrice, quantity}
     *
     * */
    @PostMapping("/sell/mytrade/write")
    public String doSellMyTradeWrite(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminSellDTO adminSellDTO){
        adminSellMyTradeService.register(walletLogin, adminSellDTO);
        return "redirect:/admin/sell/mytrade/list";
    }

    /**
     * @description Sell register
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param adminSellSearchDTO {sellId}
     *
     * */
    @PostMapping("/sell/mytrade/finish")
    public String doSellMyTradeFinish(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminSellSearchDTO adminSellSearchDTO){
        adminSellMyTradeService.finish(walletLogin, adminSellSearchDTO);
        return "redirect:/admin/sell/mytrade/list";
    }

    @GetMapping("/sell/request/list")
    public String goSellRequestList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AdminSellSearchDTO sellSearchDTO) {
        sellSearchDTO = adminSellService.initParam(walletLogin, sellSearchDTO);
        sellSearchDTO.setTotal(adminSellRequestService.count(adminSellRequestService.initParam(walletLogin, sellSearchDTO)));
        model.addAttribute("search", sellSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("sellDTOList", adminSellRequestService.selectList(adminSellRequestService.initParam(walletLogin, sellSearchDTO)));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/sell/request/list";
    }

    /**
     * @description Sell request client apply trade for Trader order
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param sellDTO {sellId}
     * @role CLIENT
     * */
    @PostMapping("/sell/request/client/apply")
    public String doRequestClientApply(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminSellDTO sellDTO){
        adminSellRequestService.clientApply(walletLogin, sellDTO);
        return "redirect:/admin/sell/request/list";
    }

    /**
     * @description Buy request client request to OP
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param sellDTO {sellId}
     * @role CLIENT
     * */
    @PostMapping("/sell/request/client/request")
    public String doRequestClientRequest(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminSellSearchDTO sellDTO){
        adminSellRequestService.clientRequest(walletLogin, sellDTO);
        return "redirect:/admin/sell/request/list";
    }

    /**
     * @description OP apply order request of Client
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param sellDTO {sellId}
     * @role OP
     * */
    @PostMapping("/sell/request/op/apply")
    public String doRequestOpApply(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminSellSearchDTO sellDTO){
        adminSellRequestService.opApply(sellDTO);
        return "redirect:/admin/sell/request/list";
    }

    /**
     * @description Client finish order
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param sellDTO {sellId}
     * @role Client
     * */
    @PostMapping("/sell/request/client/finish")
    public String doRequestClientFinish(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminSellSearchDTO sellDTO){
        adminSellRequestService.clientFinish(sellDTO);
        return "redirect:/admin/sell/request/list";
    }

    @GetMapping("/sell/safe/list")
    public String goSellSafeList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AdminSellSearchDTO sellSearchDTO) {
        sellSearchDTO = adminSellSafeService.initParam(walletLogin, sellSearchDTO);
        sellSearchDTO.setTotal(adminSellSafeService.count(sellSearchDTO));
        model.addAttribute("search", sellSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("sellDTOList", adminSellSafeService.selectList(sellSearchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/sell/safe/list";
    }

    @PostMapping("/sell/safe/confirm")
    public String doSellSafeConfirm(HttpServletRequest request, RedirectAttributes attributes, AdminSellTradeDTO adminSellTradeDTO){
        adminSellSafeService.confirmTxID(adminSellTradeDTO);
        attributes.addFlashAttribute("mess", MessageSupport.getMessage("common.message.update.success.title"));
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }

    @PostMapping("/sell/safe/finish")
    public String doSellSafeFinish(HttpServletRequest request, RedirectAttributes attributes, AdminSellTradeDTO adminSellTradeDTO){
        adminSellSafeService.confirmCashDeposit(adminSellTradeDTO);
        attributes.addFlashAttribute("mess", MessageSupport.getMessage("common.message.update.success.title"));
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }
}