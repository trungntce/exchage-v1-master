package com.apollo.exchange.admin;

import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Locale;

/**
 * @author ionio.dev
 * @apiNote Admin Login controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AdminLoginController {

    private final CommonCodeService commonCodeService;

    @GetMapping("/login")
    public String goAdminLoginPage(Model model) {
        model.addAttribute("loginTypeList", commonCodeService.getListByGroupName("LOGIN_TYPE"));
        return "/admin/login";
    }
}
