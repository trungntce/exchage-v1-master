package com.apollo.exchange.admin.user.controller;

import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.admin.user.dto.AdminUserDTO;
import com.apollo.exchange.admin.user.dto.AdminUserSearchDTO;
import com.apollo.exchange.admin.user.service.AdminUserService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.google.gson.Gson;
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
public class AdminUserController {

    private final CommonCodeService commonCodeService;
    private final AdminUserService userService;
    private final AdminTokenService adminTokenService;
    private final ClientService clientService;
    private final AdminClientService adminClientService;

    @GetMapping("/user/list")
    public String goUserList(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, AdminUserSearchDTO userSearchDTO) {
        userSearchDTO = userService.initParam(walletLogin, userSearchDTO);
        userSearchDTO.setTotal(userService.count(userSearchDTO));

        model.addAttribute("search", userSearchDTO);
        model.addAttribute("userDTOList", userService.getUserList(userSearchDTO));
        model.addAttribute("tokenDTOList", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", adminClientService.getListByRole(walletLogin));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        log.error("{}", new Gson().toJson(userService.getUserList(userSearchDTO)));
        return "/admin/user/list";
    }

    @GetMapping("/user/detail")
    public String goUserDetail(Model model, AdminUserSearchDTO userSearchDTO) {
        model.addAttribute("userDTO", userService.getUser(userSearchDTO));
        return "/admin/user/detail";
    }

    @GetMapping("/user/write")
    public String goUserWrite(Model model, @SessionAttribute("wallet") WalletDTO walletLogin) {
        model.addAttribute("tokens", adminTokenService.getListByRole(walletLogin));
        model.addAttribute("clients", clientService.getListByRole(walletLogin));
        model.addAttribute("roles", commonCodeService.getListByGroupName("ROLE"));
        model.addAttribute("rolePermission", DataStatic.WALLET_ROLE.getWriteByRoleUser(walletLogin.getRole()));
        model.addAttribute("userForm", new UserDTO());
        return "/admin/user/write";
    }

    @PostMapping("/user/write")
    public String doUserWrite(AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO){
        userService.register(adminUserDTO, adminWalletDTO);
        return "redirect:/admin/user/list";
    }

    @GetMapping("/user/edit")
    public String goUserEdit(Model model, @SessionAttribute("wallet") WalletDTO walletLogin, AdminUserSearchDTO userSearchDTO) {
        model.addAttribute("roles", commonCodeService.getListByGroupName("ROLE"));
        model.addAttribute("rolePermission", DataStatic.WALLET_ROLE.getWriteByRoleUser(walletLogin.getRole()));
        model.addAttribute("userDTO", userService.getUser(userSearchDTO));
        return "/admin/user/edit";
    }

    @PostMapping("/user/edit")
    public String doUserEdit(AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO){
        userService.update(adminUserDTO, adminWalletDTO);
        return "redirect:/admin/user/list";
    }

}
