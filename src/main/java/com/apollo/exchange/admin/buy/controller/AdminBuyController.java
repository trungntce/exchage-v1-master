package com.apollo.exchange.admin.buy.controller;

import com.apollo.exchange.admin.buy.dto.AdminBuyDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuyTradeDTO;
import com.apollo.exchange.admin.buy.service.AdminBuyMyTradeService;
import com.apollo.exchange.admin.buy.service.AdminBuyRequestService;
import com.apollo.exchange.admin.buy.service.AdminBuySafeService;
import com.apollo.exchange.admin.buy.service.AdminBuyService;
import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
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
import javax.servlet.http.HttpSession;

/**
 * @author hipo.dev
 * @apiNote Admin Buy ( information ) controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminBuyController {

    private final CommonCodeService commonCodeService;
    private final AdminBuyService adminBuyService;
    private final AdminBuyMyTradeService adminBuyMyTradeService;
    private final AdminBuyRequestService adminBuyRequestService;
    private final AdminBuySafeService adminBuySafeService;
    private final AdminTokenService adminTokenService;
    private final AdminClientService adminClientService;

    @GetMapping("/buy/general/list")
    public String goBuyGeneralList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminBuySearchDTO buySearchDTO) {
        buySearchDTO = adminBuyService.initParam(walletLogin, buySearchDTO);

        buySearchDTO.setTotal(adminBuyService.count(buySearchDTO,1, null));
        model.addAttribute("search", buySearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("buyDTOList", adminBuyService.getBuyList(buySearchDTO,1, null));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/buy/general/list";
    }

    @GetMapping("/buy/api/list")
    public String goBuyApiList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminBuySearchDTO buySearchDTO, HttpSession session) {
        buySearchDTO = adminBuyService.initParam(walletLogin, buySearchDTO);

        buySearchDTO.setTotal(adminBuyService.count(buySearchDTO,2,null));
        model.addAttribute("search", buySearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("buyDTOList", adminBuyService.getBuyList(buySearchDTO,2, null));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/buy/api/list";
    }

    @GetMapping("/buy/mytrade/list")
    public String goBuyMytradeList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AdminBuySearchDTO buySearchDTO) {
        buySearchDTO = adminBuyMyTradeService.initParam(walletLogin, buySearchDTO);
        buySearchDTO.setTotal(adminBuyMyTradeService.count(buySearchDTO));
        model.addAttribute("search", buySearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("buyDTOList", adminBuyMyTradeService.selectList(buySearchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/buy/mytrade/list";
    }

    @GetMapping("/buy/mytrade/write")
    public String goBuyMyTradeWrite(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin){
        model.addAttribute("tokens", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("sites", adminClientService.getClientSiteOwner());
        model.addAttribute("traders", adminClientService.getClientTraderOwner());
        return "/admin/buy/mytrade/write";
    }

    /**
     * @description Buy register
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param adminBuyDTO {sellerWalletAddress, clientId, unitPrice, totalPrice, quantity}
     *
     * */
    @PostMapping("/buy/mytrade/write")
    public String doBuyMyTradeWrite(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuyDTO adminBuyDTO){
        adminBuyMyTradeService.register(walletLogin, adminBuyDTO);
        return "redirect:/admin/buy/mytrade/list";
    }

    /**
     * @description Buy register
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param adminBuySearchDTO {buyId}
     *
     * */
    @PostMapping("/buy/mytrade/finish")
    public String doBuyMyTradeFinish(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuySearchDTO adminBuySearchDTO){
        adminBuyMyTradeService.finish(walletLogin, adminBuySearchDTO);
        return "redirect:/admin/buy/mytrade/list";
    }

    @GetMapping("/buy/request/list")
    public String goBuyRequestList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AdminBuySearchDTO buySearchDTO) {
        buySearchDTO = adminBuyService.initParam(walletLogin, buySearchDTO);
        buySearchDTO.setTotal(adminBuyRequestService.count(adminBuyRequestService.initParam(walletLogin, buySearchDTO)));
        model.addAttribute("search", buySearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("buyDTOList", adminBuyRequestService.selectList(adminBuyRequestService.initParam(walletLogin, buySearchDTO)));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/buy/request/list";
    }

    /**
     * @description Buy request client apply trade for Trader order
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param buyDTO {buyId}
     * @role CLIENT
     * */
    @PostMapping("/buy/request/client/apply")
    public String doRequestClientApply(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuyDTO buyDTO){
        adminBuyRequestService.clientApply(walletLogin, buyDTO);
        return "redirect:/admin/buy/request/list";
    }

    /**
     * @description Buy request client request to OP
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param buyDTO {buyId}
     * @role CLIENT
     * */
    @PostMapping("/buy/request/client/request")
    public String doRequestClientRequest(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuySearchDTO buyDTO){
        adminBuyRequestService.clientRequest(walletLogin, buyDTO);
        return "redirect:/admin/buy/request/list";
    }

    /**
     * @description OP apply order request of Client
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param buyDTO {buyId}
     * @role OP
     * */
    @PostMapping("/buy/request/op/apply")
    public String doRequestOpApply(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuySearchDTO buyDTO){
        adminBuyRequestService.opApply(buyDTO);
        return "redirect:/admin/buy/request/list";
    }

    /**
     * @description Client finish order
     * @author M.N.T.
     * @param walletLogin {walletLogin session}
     * @param buyDTO {buyId}
     * @role Client
     * */
    @PostMapping("/buy/request/client/finish")
    public String doRequestClientFinish(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuySearchDTO buyDTO){
        adminBuyRequestService.clientFinish(buyDTO);
        return "redirect:/admin/buy/request/list";
    }

    @GetMapping("/buy/safe/list")
    public String goBuySafeList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminBuySearchDTO searchDTO){
        searchDTO = adminBuySafeService.initParam(walletLogin, searchDTO);
        model.addAttribute("search", searchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("buyDTOList", adminBuySafeService.selectList(searchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/buy/safe/list";
    }

    @PostMapping("/buy/safe/confirm")
    public String doBuySafeConfirm(HttpServletRequest request, RedirectAttributes attributes, AdminBuyTradeDTO adminBuyTradeDTO){
        adminBuySafeService.confirmTxID(adminBuyTradeDTO);
        attributes.addFlashAttribute("mess", "Update successful");
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }

    @PostMapping("/buy/safe/finish")
    public String doBuySafeFinish(HttpServletRequest request, RedirectAttributes attributes, AdminBuyTradeDTO adminBuyTradeDTO){
        adminBuySafeService.confirmCashDeposit(adminBuyTradeDTO);
        attributes.addFlashAttribute("mess", "Update successful");
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }
}