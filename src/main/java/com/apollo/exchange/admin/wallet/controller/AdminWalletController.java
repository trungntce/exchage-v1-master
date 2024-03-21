package com.apollo.exchange.admin.wallet.controller;

import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletSearchDTO;
import com.apollo.exchange.admin.wallet.service.AdminWalletService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * @author hipo.dev
 * @apiNote Admin User ( information ) controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AdminWalletController {

    private final CommonCodeService commonCodeService;
    private final AdminTokenService adminTokenService;
    private final AdminClientService adminClientService;
    private final AdminWalletService adminWalletService;

    @GetMapping("/wallet/list")
    public String goWalletList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminWalletSearchDTO adminWalletSearchDTO) {
        adminWalletSearchDTO = adminWalletService.initParam(walletLogin, adminWalletSearchDTO);

        adminWalletSearchDTO.setTotal(adminWalletService.count(adminWalletSearchDTO));
        model.addAttribute("search", adminWalletSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("walletDTOList", adminWalletService.selectList(adminWalletSearchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/wallet/list";
    }

    @GetMapping("/wallet/detail")
    public String goWalletDetail(Model model, @ModelAttribute("search") AdminWalletSearchDTO adminWalletSearchDTO) {
        model.addAttribute("walletDTO", adminWalletService.getWallet(adminWalletSearchDTO));
        return "/admin/wallet/detail";
    }

    @GetMapping("/wallet/write")
    public String goWalletWrite(Model model, @SessionAttribute("wallet") WalletDTO walletLogin) {
        model.addAttribute("tokens", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clients", adminClientService.getListByRole(walletLogin));
        model.addAttribute("walletForm", new WalletDTO());
        model.addAttribute("roles", commonCodeService.getListByGroupName("ROLE"));
        model.addAttribute("rolePermission", DataStatic.WALLET_ROLE.getWriteByRoleUser(walletLogin.getRole()));
        return "/admin/wallet/write";
    }

    @PostMapping("/wallet/write")
    public String doWalletWrite(@ModelAttribute("walletForm") AdminWalletDTO adminWalletDTO) {
        adminWalletService.register(adminWalletDTO);
        return "redirect:/admin/wallet/list";
    }

    @GetMapping("/wallet/edit")
    public String goWalletEdit(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, @ModelAttribute("search") AdminWalletSearchDTO adminWalletSearchDTO) {
        model.addAttribute("walletDTO", adminWalletService.getWallet(adminWalletSearchDTO));
        model.addAttribute("roles", commonCodeService.getListByGroupName("ROLE"));
        model.addAttribute("rolePermission", DataStatic.WALLET_ROLE.getWriteByRoleUser(walletLogin.getRole()));
        return "/admin/wallet/edit";
    }

    @PostMapping("/wallet/edit")
    public String doWalletEdit(Model model, @ModelAttribute("walletForm") AdminWalletDTO adminWalletDTO) {
        adminWalletService.update(adminWalletDTO);
        return "redirect:/admin/wallet/list";
    }
}
