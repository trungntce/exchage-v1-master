package com.apollo.exchange.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @apiNote Spring Security Authentication Entry Point
 * @author  ionio.dev
 */
@Slf4j
public class AuthenticationEntryPointHandler extends AbstractAuthenticationTargetUrlRequestHandler implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException e)
            throws IOException, ServletException {

        String referer = request.getHeader("referer");
        String redirectUrl;

        log.info("referer {}", referer);
        if(referer == null) {
            if(request.getRequestURL() != null && request.getRequestURL().indexOf("/admin") > 0) {
                redirectUrl = "/admin/login";
            } else {
                redirectUrl = "/login";
            }

        } else {
            if(referer != null && referer.contains("/admin")) {
                redirectUrl = "/admin/login";
            } else {
                redirectUrl = "/login";
            }
        }

        getRedirectStrategy().sendRedirect(request, response, redirectUrl);
    }
}
