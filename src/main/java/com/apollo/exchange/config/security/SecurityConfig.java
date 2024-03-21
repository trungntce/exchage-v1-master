package com.apollo.exchange.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 * @author ionio.dev
 * @apiNote Spring Security Configuration
 */
@Slf4j
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final static String ALL_PERMISSIONS = "hasAnyRole(" +
            "'ROLE_SYSTEM', 'ROLE_OPERATOR', 'ROLE_CENTRAL_BANK', 'ROLE_CLIENT'" +
            ", 'ROLE_TRADER', 'ROLE_USER', 'CLIENT_TRADER', 'VIETKO_FEE')";

    private final static String ALL_ADMIN_PERMISSIONS = "hasAnyRole(" +
            "'ROLE_SYSTEM', 'ROLE_CENTRAL_BANK', 'ROLE_OPERATOR', 'ROLE_CLIENT', 'CLIENT_TRADER', 'VIETKO_FEE')";

    private String[] ALL_WEB_PERMISSIONS = {"/", "/index", "/login", "/exLogin", "/trade", "/transfer",
            "/balances/**", "/assets/**", "/walletInstall", "/manual/**", "/information/**", "/faq", "/about",
            "/join/**", "/api/wallet/deviceId", "/chat/addChatLine"};


    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**");
        web.ignoring().antMatchers("/layout/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.sessionManagement()
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
                .expiredUrl("/");

        http.csrf().disable();
        http.headers().frameOptions().sameOrigin();

        http.authorizeRequests()
                .antMatchers(ALL_WEB_PERMISSIONS).permitAll()
                .antMatchers("/admin/login").permitAll()
                .antMatchers("/admin/**").access(ALL_ADMIN_PERMISSIONS)
                .antMatchers("/**").access(ALL_PERMISSIONS)
                .and()
                .addFilterBefore(customAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

        http.formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/security/login")
                .defaultSuccessUrl("/");

        http.logout()
                .logoutUrl("/logout")
                .logoutSuccessHandler(loginOutSuccessHandler())
                .invalidateHttpSession(true);

        http.exceptionHandling().authenticationEntryPoint(authenticationEntryPoint());
        http.exceptionHandling().accessDeniedHandler(accessDeniedHandler());
    }

    @Bean
    public AccessDeniedHandler accessDeniedHandler() {
        return new UserAccessDeniedHandler();
    }

    @Bean
    public AuthenticationEntryPoint authenticationEntryPoint() {
        return new AuthenticationEntryPointHandler();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        return new AuthenticationProvider();
    }

    @Bean
    public LoginSuccessHandler loginSuccessHandler() {
        return new LoginSuccessHandler();
    }

    @Bean
    public LoginOutSuccessHandler loginOutSuccessHandler() {
        return new LoginOutSuccessHandler();
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new AuthenticationFailureHandler();
    }

    @Bean
    public CustomUserDetailService customUserDetailService() {
        return new CustomUserDetailService();
    }

    @Bean
    public CustomAuthenticationFilter customAuthenticationFilter() throws Exception {

        CustomAuthenticationFilter customAuthenticationFilter = new CustomAuthenticationFilter();
        customAuthenticationFilter.setAuthenticationManager(super.authenticationManagerBean());
        customAuthenticationFilter.setRequiresAuthenticationRequestMatcher(
                new AntPathRequestMatcher("/security/login", HttpMethod.POST.toString()));
        customAuthenticationFilter.setAuthenticationSuccessHandler(loginSuccessHandler());
        customAuthenticationFilter.setAuthenticationFailureHandler(authenticationFailureHandler());
        customAuthenticationFilter.setUsernameParameter("loginId");
        customAuthenticationFilter.setPasswordParameter("loginPw");
        return customAuthenticationFilter;
    }
}