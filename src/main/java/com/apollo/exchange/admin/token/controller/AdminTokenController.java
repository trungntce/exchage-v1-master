package com.apollo.exchange.admin.token.controller;

import com.apollo.exchange.admin.client.dto.AdminClientDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenDTO;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.admin.user.dto.AdminUserDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.common.api.dto.ApiTransferDTO;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.utils.UrlUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @author hipo.dev
 * @apiNote Admin Token ( information ) controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AdminTokenController {

    private final CommonCodeService commonCodeService;
    private final AdminTokenService adminTokenService;
    private final ApiService apiService;
    private final MessageSource messageSource;

    @GetMapping("/token/list")
    public String goTokenList(Model model, AdminTokenSearchDTO adminTokenSearchDTO) {
        adminTokenSearchDTO.setTotal(adminTokenService.count(adminTokenSearchDTO));

        model.addAttribute("search", adminTokenSearchDTO);
        model.addAttribute("tokenDTOList", adminTokenService.getTokenList(adminTokenSearchDTO));
        model.addAttribute("useYn", commonCodeService.getListByGroupName("USE_YN"));
        return "/admin/token/list";
    }

    @GetMapping("/token/detail")
    public String goTokenDetail(Model model, @ModelAttribute("search") AdminTokenSearchDTO adminTokenSearchDTO) {
        model.addAttribute("token", adminTokenService.getToken(adminTokenSearchDTO));
        model.addAttribute("walletDTO", adminTokenService.selectWalletOpByToken(adminTokenSearchDTO));
        return "/admin/token/detail";
    }

    @PostMapping("/token/transfer")
    public String doTokenTransfer(HttpServletRequest request, RedirectAttributes redirectAttributes, ApiTransferDTO apiTransferDTO){
        String txId = apiService.transferNoFee(apiTransferDTO);
        if("".equalsIgnoreCase(txId)) {
            redirectAttributes.addFlashAttribute("mess", messageSource.getMessage("common.admin.message.transfer.fail.title", null, LocaleContextHolder.getLocale()));
        }else{
            redirectAttributes.addFlashAttribute("mess", messageSource.getMessage("common.admin.message.transfer.success.title", null, LocaleContextHolder.getLocale()));
        }
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }

    @GetMapping("/token/write")
    public String goTokenWrite() {
        return "/admin/token/write";
    }

    @PostMapping("/token/write")
    public String doTokenWrite(AdminTokenDTO adminTokenDTO, AdminUserDTO adminUserDTO, AdminWalletDTO adminWalletDTO){
        adminTokenService.register(adminTokenDTO, adminUserDTO, adminWalletDTO);
        return "redirect:/admin/token/list";
    }

    @GetMapping("/token/edit")
    public String goTokenEdit(Model model, AdminTokenSearchDTO tokenSearchDTO) {
        model.addAttribute("token", adminTokenService.getToken(tokenSearchDTO));
        model.addAttribute("walletDTO", adminTokenService.selectWalletOpByToken(tokenSearchDTO));
        return "/admin/token/edit";
    }

    @PostMapping("/token/edit")
    public String doTokenEdit(AdminTokenDTO tokenDTO){
        adminTokenService.updateOne(tokenDTO);
        return "redirect:/admin/token/list";
    }
}