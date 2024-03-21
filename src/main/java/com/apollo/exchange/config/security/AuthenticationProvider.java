package com.apollo.exchange.config.security;

import com.apollo.exchange.common.login.dto.LoginDTO;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.CryptoUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author ionio.dev
 * @apiNote Spring Security Authentication Provider
 */
@Slf4j
@SuppressWarnings("All")
public class AuthenticationProvider extends AbstractUserDetailsAuthenticationProvider {

    @Autowired
    private CustomUserDetailService customUserDetailService = null;

    @Override
    protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication)
            throws AuthenticationException {

        String password = authentication.getCredentials().toString();
        if (password.length() == 64) {
            password = authentication.getCredentials().toString();

        } else {
            password = CryptoUtils.SHA256encryptor(password);
        }

        if (!password.equals(userDetails.getPassword())) {
            throw new AuthenticationServiceException(
                    messages.getMessage("AbstractUserDetailsAuthenticationProvider.badPassword",
                            "Password inconsistency"));
        }

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession(true);
        LoginDTO loginDTO = new LoginDTO();
        loginDTO.setPassword(authentication.getCredentials().toString());
        loginDTO.setUsername(authentication.getPrincipal().toString());
        loginDTO.setType(request.getSession().getAttribute("loginType").toString());
        session.setAttribute(DataStatic.SESSION.LOGIN, loginDTO);


    }

    @Override
    protected UserDetails retrieveUser(String username, UsernamePasswordAuthenticationToken arg1) throws AuthenticationException {

        UserDetails loadedUser;

        try {
            loadedUser = customUserDetailService.loadUserByUsername(username);

            if (!loadedUser.isAccountNonLocked()) {
                throw new BadCredentialsException("User account is locked");
            }

            if (!loadedUser.isCredentialsNonExpired()) {
                throw new BadCredentialsException("User account is waited");
            }

            if (!loadedUser.isEnabled()) {
                throw new BadCredentialsException("User account not enabled");
            }

        } catch (BadCredentialsException badCredentialsException) {
            throw badCredentialsException;

        } catch (Exception repositoryProblem) {
            throw new AuthenticationServiceException(repositoryProblem.getMessage(), repositoryProblem);
        }

        return loadedUser;
    }
}
