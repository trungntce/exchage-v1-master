package com.apollo.exchange.admin;

import com.apollo.exchange.admin.analysis.dto.AnalysisSearchDTO;
import com.apollo.exchange.admin.analysis.service.AnalysisService;
import com.apollo.exchange.admin.client.dto.AdminClientSearchDTO;
import com.apollo.exchange.admin.client.service.AdminClientService;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.admin.user.dto.AdminUserSearchDTO;
import com.apollo.exchange.admin.user.service.AdminUserService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/api")
public class AdminApiController {

    final AdminTokenService tokenService;
    final AdminClientService adminClientService;
    final AdminUserService adminUserService;

    @Autowired
    private AnalysisService analysisService;

    /**
     * @author tuyen.dev
     * @description validation field {symbol} unique in table
     * @param tokenSearchDTO {symbol}
     * @return true: symbol is exists / false: symbol isn't exists
     * */
    @GetMapping("/validate/token")
    public Boolean validateToken(AdminTokenSearchDTO tokenSearchDTO){
        return tokenService.isExists(tokenSearchDTO);
    }

    /**
     * @author tuyen.dev
     * @description validation field {symbol} unique in table
     * @param adminClientSearchDTO {apiKey, clientCode}
     * @return true: {apiKey, clientCode} is exists / false: {apiKey, clientCode} isn't exists
     * */
    @GetMapping("/validate/client")
    public Boolean validateClient(AdminClientSearchDTO adminClientSearchDTO){
        return adminClientService.isExists(adminClientSearchDTO);
    }

    /**
     * @author tuyen.dev
     * @description validation field {userId} unique in table
     * @param adminUserSearchDTO {userId}
     * @return true: {userId} is exists / false: {userId} isn't exists
     * */
    @GetMapping("/validate/user")
    public Boolean validateUser(AdminUserSearchDTO adminUserSearchDTO){
        return adminUserService.isExists(adminUserSearchDTO);
    }

    @GetMapping("/analysis/holder/group")
    public Object analysisHolderGroup(@SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AnalysisSearchDTO search){
        search = analysisService.initParam(walletLogin, search);
        return analysisService.analysisHolderGroup(search);
    }

    @GetMapping("/analysis/order")
    public Object analysisOrder(HttpServletRequest request){
        return analysisService.getStatisticByUser(request);
    }
}
