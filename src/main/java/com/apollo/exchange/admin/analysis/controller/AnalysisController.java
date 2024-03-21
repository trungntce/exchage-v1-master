package com.apollo.exchange.admin.analysis.controller;

import com.apollo.exchange.admin.analysis.dto.AnalysisSearchDTO;
import com.apollo.exchange.admin.analysis.service.AnalysisService;
import com.apollo.exchange.admin.transferHistory.dto.AdminTransferHistorySearchDTO;
import com.apollo.exchange.admin.transferHistory.service.AdminTransferHistoryService;
import com.apollo.exchange.common.client.dto.ClientSearchDTO;
import com.apollo.exchange.common.client.service.ClientService;
import com.apollo.exchange.admin.token.dto.AdminTokenSearchDTO;
import com.apollo.exchange.admin.token.service.AdminTokenService;
import com.apollo.exchange.common.commonCode.service.CommonCodeService;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

/**
 * @author hipo.dev
 * @apiNote Admin Analysis ( information ) controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AnalysisController {

    private final CommonCodeService commonCodeService;
    private final AnalysisService analysisService;
    private final AdminTokenService tokenService;
    private final ClientService clientService;
    private final AdminTransferHistoryService adminTransferHistoryService;
    private final WalletService walletService;

    @GetMapping("/analysis/list")
    public String goAnalysisBuyList(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AnalysisSearchDTO analysisSearchDTO) {
        analysisSearchDTO = analysisService.initParam(walletLogin, analysisSearchDTO);

        model.addAttribute("search", analysisSearchDTO);
        model.addAttribute("tokenDTOList", tokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", clientService.getListByRole(walletLogin));
        model.addAttribute("analysisList", analysisService.getAnalysisList(analysisSearchDTO));
        model.addAttribute("ownerWalletFee", walletService.selectOwnerWalletFee(walletLogin));

        return "/admin/analysis/list";
    }

    @GetMapping("/analysis/detail")
    public String goAnalysisDetail(Model model, @SessionAttribute(DataStatic.SESSION.WALLET) WalletDTO walletLogin, @ModelAttribute("search") AdminTransferHistorySearchDTO searchDTO){
        searchDTO = adminTransferHistoryService.initParam(walletLogin, searchDTO);
        searchDTO.setTotal(adminTransferHistoryService.count(searchDTO));

        model.addAttribute("search", searchDTO);
        model.addAttribute("tokenDTOList", tokenService.getListByRole(walletLogin));
        model.addAttribute("clientDTOList", clientService.getListByRole(walletLogin));
        model.addAttribute("roleList", commonCodeService.getListByGroupName("ROLE"));
        model.addAttribute("transferHistory", adminTransferHistoryService.selectList(searchDTO));
        return "/admin/analysis/detail";
    }
}