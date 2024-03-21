package com.apollo.exchange.config.filter;


import com.apollo.exchange.common.chat.service.ChatService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.sun.org.apache.bcel.internal.generic.ATHROW;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @author N.T.T
 * @description Validation filters for all web
 */
@Slf4j
public class AuthenticationFilter implements Filter {

    @Autowired
    ChatService chatService;

    @Autowired
    UserService userService;

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private WalletService walletService;



    private String[] PATHS_FILTER = {"/trade", "/buyRegister", "/exBuyRegister",
            "/tradeBuyDetail", "/exTradeBuyDetail", "/sellRegister", "/exSellRegister",
            "/tradeSellDetail", "/exTradeSellDetail", "/myRoom"};

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, filterConfig.getServletContext());
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);

        HttpServletRequest rq = (HttpServletRequest) servletRequest;
        // CHECK ROLE, ONLY ROLE TRADE AND USER
        WalletDTO walletSession = (WalletDTO) rq.getSession().getAttribute(DataStatic.SESSION.WALLET);
        if (null != walletSession) {
            // Get currentWalletAddress
            String currentWalletAddress = request.getParameter("walletAddress") == null
                    ? walletSession.getWalletAddress() : request.getParameter("walletAddress");
            WalletDTO walletCurrentSession = walletService.getWalletCurrent(rq.getSession(), currentWalletAddress);
            servletRequest.setAttribute(DataStatic.SESSION.WALLET_CURRENT, walletCurrentSession);


            request.setAttribute("chatByUser", chatService.selectChatByUserId(request));
            request.setAttribute("chatByLineUser", chatService.selectAllChatLineByUserId(request));
            UserDTO userCurrent = userService.selectUserByWalletAddress(walletSession.getWalletAddress());
            request.setAttribute("userCurrent", userCurrent);
        }



        servletRequest.setAttribute(DataStatic.SESSION.LANG_CODE, LocaleContextHolder.getLocale().toString());
        if (Arrays.asList(PATHS_FILTER).contains(request.getRequestURI())) {
            WalletDTO walletDTO = new WalletDTO();
            if (null != walletSession) {
                for (int i = 0; i < walletSession.getWallets().size(); i++) {
                    Object objWallet = (Object) walletSession.getWallets().get(i);
                    if (objWallet instanceof WalletDTO) {
                        walletDTO = (WalletDTO) walletSession.getWallets().get(i);
                    } else {
                        Map<String, Object> map = walletSession.getWallets().get(i);
                        walletDTO = new WalletDTO(map);
                    }
                    if (DataStatic.WALLET_ROLE.USER.equalsIgnoreCase(walletDTO.getRole())
                            || DataStatic.WALLET_ROLE.CLIENT_TRADER.equalsIgnoreCase(walletDTO.getRole())
                            || DataStatic.WALLET_ROLE.TRADER.equalsIgnoreCase(walletDTO.getRole())) {
                        filterChain.doFilter(request, response);
                        return;
                    }

                }
            }
            // Not login then show only trade page
            else if (("/trade").contains(request.getRequestURI())) {
                filterChain.doFilter(request, response);
                return;
            }
            // Return authentication error

            response.sendRedirect("/?error=3");
            return;
        }
        filterChain.doFilter(request, response);
        return;
    }

    @Override
    public void destroy() {

    }
}
