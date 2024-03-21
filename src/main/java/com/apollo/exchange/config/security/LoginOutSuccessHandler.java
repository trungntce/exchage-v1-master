package com.apollo.exchange.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author ionio.dev
 * @apiNote Spring Security User Logout Success Handler
 */
@Slf4j
public class LoginOutSuccessHandler extends SimpleUrlLogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {

        String referer = request.getHeader("referer");
        String targetUrl;

        if(referer == null) {
            if(request.getRequestURL() != null && request.getRequestURL().indexOf("/admin") > 0) {
                targetUrl = "/admin/login";
            } else {
                targetUrl = "/index";
            }

        } else {
            if(referer.contains("/admin")) {
                targetUrl = "/admin/login";
            } else {
                targetUrl = "/index";
            }
        }

        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

}