package com.apollo.exchange.config.security;

import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author ionio.dev
 * @apiNote Spring Security Certified Business
 */
@Slf4j
@Service
@SuppressWarnings("All")
public class CustomUserDetailService implements UserDetailsService {

    @Autowired
    private MessageSource messageSource;
    @Autowired
    private WalletService walletService = null;

    @Override
    public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException {

        log.info("login id : {}", loginId);
        List<Map<String, Object>> wallets = new ArrayList<>();

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String loginType = (String) request.getSession().getAttribute("loginType");
        WalletDTO walletDTO = null;
        // Type = 1 : Login by Wallet
        // Type = 2 : Login by User
        try {
            switch (loginType) {
                case "1":
                    walletDTO = walletService.getData(loginId);
                    if (walletDTO == null) {
                        throw new BadCredentialsException(messageSource.getMessage("login.message.fail.wallet.not.exist", null, LocaleContextHolder.getLocale()));
                    }

                    // Set wallets when using on font-end
                    wallets.add(walletDTO.toMap());
                    walletDTO.setWallets(wallets);
                    break;
                case "2":
                    walletDTO = walletService.getFirstDataByLoginId(loginId);
                    if (walletDTO == null) {
                        throw new BadCredentialsException(messageSource.getMessage("login.message.fail.user.not.exist", null, LocaleContextHolder.getLocale()));
                    }
                    // When login by User then get list wallets, using on font-end
//                    wallets.addAll(walletService.getListWalletsByLoginId(loginId));
                    // fix one user using one wallet
                    wallets.add(walletService.getListWalletsByLoginId(loginId).get(0));
                    walletDTO.setWallets(wallets);
                    break;
                default:
                    throw new BadCredentialsException(messageSource.getMessage("the.user.password.input.not.valid", null, LocaleContextHolder.getLocale()));
            }

        } catch (DataAccessException dae) {
            dae.printStackTrace();
            log.error("{}", dae.getMessage());

            throw new DataAccessException(messageSource.getMessage("login.message.fail.unauthorized.access", null, LocaleContextHolder.getLocale())) {
                private static final long serialVersionUID = 1L;
            };

        }

        return new UserDetail(walletDTO);
    }

}