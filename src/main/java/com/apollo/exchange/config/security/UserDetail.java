package com.apollo.exchange.config.security;

import com.apollo.exchange.common.wallet.dto.WalletDTO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author ionio.dev
 * @apiNote Spring Security Authentication Details Options
 */
@SuppressWarnings("All")
public class UserDetail implements UserDetails {

    private static final long serialVersionUID = -1711149426482820302L;
    private List<GrantedAuthority> authorities;
    private WalletDTO walletDTO;

    public UserDetail(WalletDTO walletDTO) {

        this.walletDTO = walletDTO;
        authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_" + walletDTO.getRole()));
    }

    public WalletDTO getWallet() {
        return this.walletDTO;
    }

    public void setUser(WalletDTO walletDTO) {
        this.walletDTO = walletDTO;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return walletDTO.getWalletPw();
    }

    @Override
    public String getUsername() {
        return walletDTO.getWalletAddress();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public int hashCode() {
        return walletDTO.getWalletId();
    }

    public boolean equals(Object obj) {

        if (!(obj instanceof UserDetail)) {
            return false;
        }

        UserDetail detail = (UserDetail) obj;

        if (this.walletDTO.getWalletId() == null && detail.getWallet().getWalletId() != null) {
            return false;
        }

        if (this.walletDTO.getWalletId() != null && detail.getWallet().getWalletId() == null) {
            return false;
        }

        return true;
    }
}
