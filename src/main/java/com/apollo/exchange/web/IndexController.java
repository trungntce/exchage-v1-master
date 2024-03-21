package com.apollo.exchange.web;

import com.apollo.exchange.common.message.MessageSupport;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.UrlUtils;
import com.apollo.exchange.web.board.dto.BoardSearchDTO;
import com.apollo.exchange.web.board.service.BoardService;
import com.apollo.exchange.web.buy.service.BuyService;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author ionio.dev
 * @apiNote Main index ( information ) controller
 */
@Slf4j
@Controller
public class IndexController {

    @Autowired
    private BoardService boardService;

    @GetMapping(value = {"/", "/index"})
    public String goIndexPage(HttpSession session) {

        return "web-new/index";
    }

    /***
     * @author ntt.dev
     * @param session
     * @param request
     * @return
     */
    @GetMapping("/logout")
    public String goLogout(HttpSession session, HttpServletRequest request) {

        session.removeAttribute(DataStatic.SESSION.WALLET);
        return UrlUtils.getPreviousPageByRequest(request).orElse("/");
    }

    @GetMapping("/about")
    public String goAbout(Model model){
        return "web-new/about/about";
    }

    @GetMapping("/faq")
    public String goFaq(Model model, BoardSearchDTO boardSearchDTO){
        boardSearchDTO.setBoardType(1);
        boardSearchDTO.setTotal(boardService.getBoardCount(boardSearchDTO));
        model.addAttribute("boardTitleList", boardService.getBoardTitleList(boardSearchDTO));
        model.addAttribute("boardList", boardService.getBoardList(boardSearchDTO));
        return "web-new/faq/faq";
    }

    @GetMapping("/manual")
    public String goManual(Model model){
        return "web-new/manual/list";
    }

    @GetMapping("/information") public String goInformation(Model model, BoardSearchDTO boardSearchDTO){
        boardSearchDTO.setBoardType(0);
        boardSearchDTO.setTotal(boardService.getBoardCount(boardSearchDTO));
        model.addAttribute("search", boardSearchDTO);
        model.addAttribute("boardList", boardService.getBoardList(boardSearchDTO));
        return "web-new/information/list";
    }

    @GetMapping("/information/detail")
    public String goInformationDetail(Model model, BoardSearchDTO boardSearchDTO){
        boardSearchDTO.setBoardType(0);
        model.addAttribute("boardDTO", boardService.getBoardDetail(boardSearchDTO));
        return "web-new/information/detail";
    }

    @GetMapping("/walletInstall")
    public String goWalletInstall(Model model){ return "web-new/walletInstall/walletInstall"; }

    @RequestMapping({"/doc","/document"})
    public String doc(){
        return "web-new/document";
    }
}
