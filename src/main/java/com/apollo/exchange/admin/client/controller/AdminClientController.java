package com.apollo.exchange.admin.client.controller;

import com.apollo.exchange.admin.client.dto.AdminClientDTO;
import com.apollo.exchange.admin.client.dto.AdminClientSearchDTO;
import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.user.dto.AdminUserDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.web3j.crypto.Wallet;

/**
 * @author hipo.dev
 * @apiNote Admin Client ( information ) controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AdminClientController {

    private final CommonCodeService commonCodeService;
    private final AdminTokenService adminTokenService;
    private final AdminClientService adminClientService;

    @GetMapping("/client/list")
    public String goClientList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AdminClientSearchDTO adminClientSearchDTO) {
        adminClientSearchDTO = adminClientService.initParam(adminClientSearchDTO, walletLogin);
        adminClientSearchDTO.setTotal(adminClientService.count(adminClientSearchDTO));

        model.addAttribute("search", adminClientSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clinetDTOList", adminClientService.getClientList(adminClientSearchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/client/list";
    }

    @GetMapping("/client/detail")
    public String goClientDetail(Model model, AdminClientSearchDTO adminClientSearchDTO) {
        adminClientSearchDTO.setRole(DataStatic.WALLET_ROLE.CLIENT);
        model.addAttribute("client", adminClientService.selectOne(adminClientSearchDTO));
        return "/admin/client/detail";
    }

    @GetMapping("/client/write")
    public String goClientWrite(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin) {
        walletLogin.setOperator("VIETKO");
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        return "/admin/client/write";
    }

    @PostMapping("/client/write")
    public String doClientWrite(AdminClientDTO adminClientDTO, AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO){
        adminClientService.register(adminUserDTO, adminWalletDTO, adminClientDTO);
        return "redirect:/admin/client/list";
    }

    @GetMapping("/client/edit")
    public String goClientEdit(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AdminClientSearchDTO adminClientSearchDTO) {
        adminClientSearchDTO.setRole(DataStatic.WALLET_ROLE.CLIENT);
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("client", adminClientService.selectOne(adminClientSearchDTO));
        return "/admin/client/edit";
    }

    @PostMapping("/client/edit")
    public String doClientEdit(AdminClientDTO adminClientDTO){
        adminClientService.updateOne(adminClientDTO);
        return "redirect:/admin/client/list";
    }
}