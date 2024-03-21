package com.apollo.exchange.config.security;

import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletSearchDTO;
import com.apollo.exchange.admin.wallet.service.AdminWalletService;
import com.apollo.exchange.common.accessLog.dto.AccessLogDTO;
import com.apollo.exchange.common.accessLog.service.AccessLogService;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.DeviceUtils;
import com.apollo.exchange.common.utils.NetworkUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import eu.bitwalker.useragentutils.UserAgent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author ionio.dev
 * @apiNote Spring Security User Authentication Success Handler
 */
@Slf4j
@SuppressWarnings("All")
public class LoginSuccessHandler extends AbstractAuthenticationTargetUrlRequestHandler implements AuthenticationSuccessHandler {

    @Autowired
    private AccessLogService accessLogService = null;

    @Autowired
    private AdminWalletService adminWalletService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        WalletDTO walletDTO = userDetail.getWallet();

        HttpSession session = request.getSession(true);

        AdminWalletDTO adminWalletDTO = adminWalletService.getWallet(new AdminWalletSearchDTO(walletDTO.getWalletId()));
        walletDTO.setClientCode(adminWalletDTO.getClientCode());
        session.setAttribute(DataStatic.SESSION.WALLET, walletDTO);

        String referer = request.getHeader("referer");

        UserAgent agent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        AccessLogDTO accessLogDTO = new AccessLogDTO();
        accessLogDTO.setWalletId(walletDTO.getWalletId());
        accessLogDTO.setTracking(1);
        accessLogDTO.setLoginType(Integer.parseInt(request.getSession().getAttribute("loginType").toString()));
        accessLogDTO.setOs(agent.getOperatingSystem().toString());
        accessLogDTO.setBrowser(agent.getBrowser().toString());
        accessLogDTO.setIp(NetworkUtils.getClientIpAddressIfServletRequestExist(request));
        accessLogDTO.setDevice(DeviceUtils.getDeviceType(request));
        accessLogService.register(accessLogDTO);

        // When user login android and setAtribute android
        LoginDTO loginDTO = (LoginDTO) session.getAttribute(DataStatic.SESSION.LOGIN);
        Map<String, Object> sessionAndroid = new HashMap<>();
        sessionAndroid.put("loginId", loginDTO.getUsername());
        sessionAndroid.put("loginPw", loginDTO.getPassword());
        sessionAndroid.put("type", loginDTO.getType());
        sessionAndroid.put("sessionId", session.getId());
        sessionAndroid.put("wallets", walletDTO.getWallets());
        session.setAttribute(DataStatic.SESSION.ANDROID, new ObjectMapper().writeValueAsString(sessionAndroid));
//        session.setAttribute(DataStatic.SESSION.ANDROID_2, new Gson().toJson(sessionAndroid));


        String targetUrl = "/";

        if (referer == null) {
            if (request.getRequestURL() != null && request.getRequestURL().indexOf("admin") > 0) {
                targetUrl = "/admin/index";
            } else {
                targetUrl = "/index";
            }

        } else {
            if (referer.contains("admin")) {
                targetUrl = "/admin/index";

            } else {
                if (referer.contains("exLogin")) {
                    targetUrl = "/exBuyRegister";
                } else {
                    String redirectUrl = (String) session.getAttribute("prevPage");
                    if (redirectUrl != null) {

                        if (!redirectUrl.contains("login")) {
                            targetUrl = redirectUrl;
                        } else {
                            targetUrl = "/index";
                        }
                        ;
                        session.removeAttribute("prevPage");

                    } else {
                        targetUrl = "/index";
                        targetUrl = (session.getAttribute("_lang") != null) ? "/index?langCode=" + session.getAttribute("_lang") : "/index";
                    }
                }
            }
        }

        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }
}
