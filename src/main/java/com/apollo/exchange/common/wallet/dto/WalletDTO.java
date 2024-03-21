package com.apollo.exchange.common.wallet.dto;

import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.utils.ObjectUtils;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.*;

/**
 * @author ionio.dev
 * @apiNote WALLET Data Transfer Object
 */
@Data
@AllArgsConstructor
public class WalletDTO {

    private Integer walletId = null;
    private String symbol = "BANI";
    private String clientCode = "GOLD_CODE";
    private String operator = null;
    private String walletAddress = null;
    private String privateKey = null;
    private String loginPw = null;
    private String loginId = null;
    private String walletPw = null;
    private String password = null;
    private String bankName = null;
    private String bankOwner = null;
    private String bankAccount = null;
    private String name = null;
    private String tel = null;
    private String email = null;
    private BigDecimal fee = null;
    private String mail = null;
    private String useYn; //Alarm
    private String path; //Alarm

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate = null;

    private String role = null;
    private Integer userWalletId = null;
    private String tokenDeviceId;

    // Add list wallets
    private List<Map<String, Object>> wallets = new ArrayList<>();
    // REPEAT_SECONDS
    private int repeatSeconds = 5;

    public WalletDTO() { }

    public WalletDTO(Integer walletId, String walletAddress){
        this.walletId = walletId;
        this.walletAddress = walletAddress;
    }

    public WalletDTO(String symbol, String role){
        this.role = role;
        this.symbol = symbol;
    }

    public WalletDTO(Map<String, Object> m) {
        if (m.get("walletId") != null) this.walletId = (Integer) m.get("walletId");
        if (m.get("symbol") != null) this.symbol = (String) m.get("symbol");
        if (m.get("walletAddress") != null) this.walletAddress = (String) m.get("walletAddress");
        if (m.get("privateKey") != null) this.privateKey = (String) m.get("privateKey");
        if (m.get("walletPw") != null) this.walletPw = (String) m.get("walletPw");
        if (m.get("bankName") != null) this.bankName = (String) m.get("bankName");
        if (m.get("bankOwner") != null) this.bankOwner = (String) m.get("bankOwner");
        if (m.get("bankAccount") != null) this.bankAccount = (String) m.get("bankAccount");
        if (m.get("name") != null) this.name = (String) m.get("name");
        if (m.get("role") != null) this.role = (String) m.get("role");
        if (m.get("tel") != null) this.tel = (String) m.get("tel");
        if (m.get("email") != null) this.email = (String) m.get("email");
        if (m.get("fee") != null) this.fee = (BigDecimal) m.get("fee");
        if (m.get("mail") != null) this.mail = (String) m.get("mail");
    }

    public WalletDTO(UserDTO userDTO) {
        this.password = userDTO.getLoginPw();
        this.walletPw = userDTO.getLoginPw();
        this.symbol = userDTO.getSymbol();
        this.name = userDTO.getName();
        this.tel = userDTO.getTel();
        this.bankName = userDTO.getBankName();
        this.bankOwner = userDTO.getBankOwner();
        this.bankAccount = userDTO.getBankAccount();
        this.clientCode = userDTO.getClientCode();
    }

    public Map<String, Object> toMap() {
        return ObjectUtils.parameters(this);
    }
}


