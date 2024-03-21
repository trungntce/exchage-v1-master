package com.apollo.exchange.config.handler;

import com.apollo.exchange.admin.analysis.service.AnalysisService;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.common.chat.service.ChatService;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.web.token.service.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class PageInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    ChatService chatService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private AnalysisService analysisService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setAttribute("tokenList", tokenService.getTokenList());
        request.setAttribute("alarmStatistic", analysisService.getStatisticByUser(request));
        return super.preHandle(request, response, handler);
    }
}
