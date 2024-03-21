package com.apollo.exchange.config.security;

import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author ionio.dev
 * @apiNote Spring Security User Access Restriction Handler
 */
@Slf4j
@SuppressWarnings("All")
public class UserAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException e)
            throws IOException, ServletException {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            log.warn("User: " + auth.getName() + " attempted to access the protected URL: " + request.getRequestURI());
        }

        String referer = request.getHeader("referer");
        String targetUrl;

        if(referer == null) {
            if(request.getRequestURL() != null && request.getRequestURL().indexOf("/admin") > 0) {
                targetUrl = "/admin/index";
            } else {
                targetUrl = "/index";
            }

        } else {
            if(referer != null && referer.contains("/admin")) {
                targetUrl = "/admin/index";
            } else {
                targetUrl = "/index";
            }
        }

        UserDetail userDetail = (UserDetail) auth.getPrincipal();
        WalletDTO walletDTO = userDetail.getWallet();

        if(walletDTO.getRole().equals("USER")) {
            targetUrl = "/index";
        }

        if(walletDTO.getRole().equals("TRADER")) {
            targetUrl = "/index";
        }

        response.sendRedirect(targetUrl);
    }

}