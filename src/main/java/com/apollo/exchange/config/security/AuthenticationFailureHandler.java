package com.apollo.exchange.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author ionio.dev
 * @apiNote Spring Security User Authentication Failed Handler
 */
@Slf4j
public class AuthenticationFailureHandler extends AbstractAuthenticationTargetUrlRequestHandler implements org.springframework.security.web.authentication.AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException e) throws IOException, ServletException {

        /*
        Enumeration<String> enumeration = httpServletRequest.getAttributeNames();
        while (enumeration.hasMoreElements()) {
            String name = enumeration.nextElement();
            log.error("[ AuthenticationFail ] AttributeName : {} | Parameter : {}", name, httpServletRequest.getParameter(name));
        }
        */

        String code = "";
        String message = e.getMessage();
        log.error("{}", message);

        switch (message) {
            case "Wallet id that does not exist.":
                code = "1";
                break;
            case "User id that does not exist.":
                code = "2";
                break;
            case "Password inconsistency":
                code = "3";
                break;
        }

        String referer = request.getHeader("referer");
        String targetUrl;

        if(referer.contains("/admin")) {
            targetUrl = "/admin/login?error=" + code;
        } else {
            targetUrl = "/login?error=" + code;
        }

        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }
}
