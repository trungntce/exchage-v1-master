package com.apollo.exchange.admin;

import com.apollo.exchange.admin.analysis.dto.AnalysisDTO;
import com.apollo.exchange.admin.analysis.dto.AnalysisSearchDTO;
import com.apollo.exchange.admin.analysis.service.AnalysisService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpServletRequest;

/**
 * @author ionio.dev
 * @apiNote Admin Main index ( information ) controller
 */
@Slf4j
@Controller
@RequestMapping("admin")
public class AdminIndexController {

    @Autowired
    private AnalysisService analysisService;

    @GetMapping({"", "/index"})
    public String goAdminIndexPage(Model model, HttpServletRequest request, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, AnalysisSearchDTO searchDTO) {

        searchDTO = analysisService.initParam(walletLogin, searchDTO);
        AnalysisDTO sellData = analysisService.selectSumSellHomePage(searchDTO);
        model.addAttribute("search", searchDTO);
        model.addAttribute("sumBuy", analysisService.selectSumBuyHomePage(searchDTO).getTotalQuantity());
        model.addAttribute("sumSell", sellData.getTotalQuantity());
        model.addAttribute("sumFee", analysisService.selectSumFeeHomePage(searchDTO));
        model.addAttribute("sumWithdraw", sellData.getTotalPrice());
        model.addAttribute("countWallet", analysisService.selectCountWalletHomePage(searchDTO).getWalletCount());
        return "/admin/index";
    }
}
