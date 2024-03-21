package com.apollo.exchange.web.trade.controller;

import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.apollo.exchange.web.buy.dto.BuyDTO;
import com.apollo.exchange.web.buy.dto.BuySearchDTO;
import com.apollo.exchange.web.buy.service.BuyService;
import com.apollo.exchange.web.sell.dto.SellSearchDTO;
import com.apollo.exchange.web.sell.service.SellService;
import com.apollo.exchange.web.token.dto.TokenDTO;
import com.apollo.exchange.web.token.dto.TokenSearchDTO;
import com.apollo.exchange.web.token.service.TokenService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ntt.dev
 * @apiNote Trade controller
 */
@Slf4j
@Controller
public class
TradeController {

    @Autowired
    private BuyService buyService;
    @Autowired
    private SellService sellService;
    @Autowired
    private TokenService tokenService;
    @Autowired
    private WalletService walletService;
    @Autowired
    private MessageSource messageSource;

    /**
     * get function view trade
     *
     * @param model
     * @param session
     * @param buySearchDTO
     * @param sellSearchDTO
     * @return url
     */
    @GetMapping("/trade")
    public String goTrade(Model model, HttpSession session, RedirectAttributes attributes, BuySearchDTO buySearchDTO, SellSearchDTO sellSearchDTO) {

        try {

            List<TokenDTO> getTokenList = new ArrayList<>();
            WalletDTO walletCurrent = walletService.getWalletCurrent(session, buySearchDTO.getWalletAddress());
            if (DataStatic.WALLET_ROLE.TRADER.equals(walletCurrent.getRole())
                    || DataStatic.WALLET_ROLE.CLIENT_TRADER.equals(walletCurrent.getRole())
                    || DataStatic.WALLET_ROLE.GUEST.equals(walletCurrent.getRole())) {
                List<String> operatorList = new ArrayList<>();
                operatorList.add("VIETKO");
                operatorList.add("BANI");
                TokenSearchDTO tokenSearchDTO = new TokenSearchDTO();
                tokenSearchDTO.setOperatorList(operatorList);
                getTokenList = tokenService.getTokenListByOperator(tokenSearchDTO);
            } else {
                getTokenList = tokenService.getTokenList();
            }

            // GET BUY LIST
            Map<String, Object> buyData = buyService.listBuy(session, buySearchDTO);
            List<BuySearchDTO> buyList = (buyData.get("buyList") != null ? (List<BuySearchDTO>) buyData.get("buyList") : null);

            // GET TOTAL BUY COUNT
            Integer buyCount = (buyData.get("total") != null ? (Integer) buyData.get("total") : 0);
            buySearchDTO.setTotal(buyCount);

            // GET LIST SELL
            Map<String, Object> sellData = sellService.listSell(session, sellSearchDTO);
            List<SellSearchDTO> sellList = (sellData.get("sellList") != null ? (List<SellSearchDTO>) sellData.get("sellList") : null);

            // GET TOTAL SELL COUNT
            Integer sellCount = (sellData.get("total") != null ? (Integer) sellData.get("total") : 0);
            sellSearchDTO.setTotal(sellCount);

            model.addAttribute("buyList", buyList);
            model.addAttribute("sellList", sellList);
            model.addAttribute("tokens", getTokenList);
            model.addAttribute("buySearch", buySearchDTO);
            model.addAttribute("sellSearch", sellSearchDTO);
            model.addAttribute("walletCurrent", walletService.getWalletCurrent(session, buySearchDTO.getWalletAddress()));

            return DataStatic.VIEW_RESOURCE.TRADE_WEB_NEW + "tradeList";


        } catch (Exception ex) {

            log.error(ex.toString());
        }

        attributes.addFlashAttribute("mess", messageSource.getMessage("login.message.fail.unauthorized.access",
                null, LocaleContextHolder.getLocale()));
        return "redirect:/";
    }
}
