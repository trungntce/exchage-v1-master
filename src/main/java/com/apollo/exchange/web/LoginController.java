package com.apollo.exchange.web;

import com.apollo.exchange.common.api.service.RestApiService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.login.service.LoginService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.CryptoUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.config.security.CustomUserDetailService;
import com.apollo.exchange.config.security.UserDetail;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author ionio.dev
 * @apiNote Login controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class LoginController {

    private final CommonCodeService commonCodeService;

    private final MessageSource messageSource;
    private final LoginService loginService;


    @GetMapping("/login")
    public String goLoginPage(HttpSession session, Model model) {
        session.removeAttribute(DataStatic.SESSION.WALLET);
        model.addAttribute("loginTypeList", commonCodeService.getListByGroupName("LOGIN_TYPE"));
        return "web-new/login/login";
    }

    @GetMapping("/exLogin")
    public String goExLoginPage(HttpSession session, Model model) {
        session.removeAttribute(DataStatic.SESSION.WALLET);
        model.addAttribute("loginTypeList", commonCodeService.getListByGroupName("LOGIN_TYPE"));
        SecurityContextHolder.clearContext();
        return "web-new/login/exLogin";
    }

    @PostMapping("/login")
    public String doLoginWallet(HttpServletRequest request, RedirectAttributes attributes, HttpSession httpSession, @ModelAttribute("loginWalletForm") LoginDTO mLogin) throws ServletException {

        return loginService.popupLogin(request, attributes, httpSession, mLogin);
    }

}
