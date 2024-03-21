package com.apollo.exchange.common.login.service;

import com.apollo.exchange.common.api.service.RestApiService;
import com.apollo.exchange.common.client.dto.ClientDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.CryptoUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.config.security.UserDetail;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Service
@RequiredArgsConstructor
public class LoginService {
    private final MessageSource messageSource;
    private final ClientService clientService;
    public String popupLogin(HttpServletRequest request, RedirectAttributes attributes, HttpSession httpSession, @ModelAttribute("loginWalletForm") LoginDTO mLogin) throws ServletException {
        try {

            String walletAddress = mLogin.getWalletAddress();
            String password = mLogin.getPassword();
            String tradeType = mLogin.getTradeType();
            String tokenSymbol = mLogin.getTokenSymbol();
            ClientDTO clientDTO = clientService.getDataByApiKey(mLogin.getApiKey());
            // Check Client Key
            if (!clientDTO.getClientCode().equals(mLogin.getClientCode())) {
                attributes.addFlashAttribute("mess", messageSource.getMessage("the.api.key.unauthorized", null, LocaleContextHolder.getLocale()));
                return "redirect:exLogin";
            }
            if (mLogin.getWalletPassword() != null
                    || mLogin.getWalletAddress() == null) {
                attributes.addFlashAttribute("mess", messageSource.getMessage("the.input.not.valid", null, LocaleContextHolder.getLocale()));
                return "redirect:exLogin";
            }

            if (SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof UserDetails == false) {
                httpSession.setAttribute("loginType", "1");

                request.login(walletAddress, password);

                UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                WalletDTO walletDTO = userDetail.getWallet();

                HttpSession session = request.getSession(true);
                session.setAttribute(DataStatic.SESSION.WALLET, walletDTO);
            }

            UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            WalletDTO walletDTO = userDetail.getWallet();
            if (!userDetail.getPassword().equalsIgnoreCase(CryptoUtils.SHA256encryptor(password))
                    || !userDetail.getUsername().equalsIgnoreCase(walletAddress)) {

                SecurityContextHolder.clearContext();
                HttpSession session = request.getSession(true);//
                request.login(walletAddress, password);

                userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                walletDTO = userDetail.getWallet();


                session.setAttribute(DataStatic.SESSION.WALLET, walletDTO);
                httpSession.setAttribute("loginType", "1");
            }
            // Only user role login
            if (!walletDTO.getRole().equals(DataStatic.WALLET_ROLE.USER)) {
                attributes.addFlashAttribute("mess", messageSource.getMessage("login.message.fail.unauthorized.access", null, LocaleContextHolder.getLocale()));
                return "redirect:exLogin";
            }
            if (tradeType != null) {
                String param = (tokenSymbol != null) ? "?symbol=".concat(tokenSymbol).concat("&viewRole=API").concat("&clientId=" + clientDTO.getClientId()) : "";
                httpSession.setAttribute("tokenSymbol", tokenSymbol);
                switch (tradeType) {
                    case "SELL":
                        return "redirect:/exSellRegister".concat(param);
                    default:
                        return "redirect:/exBuyRegister".concat(param);
                }
            }
        } catch (Exception ex) {
            log.error(ex.toString());
        }
        attributes.addFlashAttribute("mess", messageSource.getMessage("login.message.fail", null, LocaleContextHolder.getLocale()));
        return "redirect:exLogin";
    }


}
