package com.apollo.exchange.web.register.controller;

import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.user.dto.UserDTO;
import com.apollo.exchange.common.user.service.UserService;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.apollo.exchange.common.wallet.service.WalletService;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author ntt.dev
 * @controllerNote register controller
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class RegisterController {

    private final UserService userService;
    private final MessageSource messageSource;
    private final WalletService walletService;

    /**
     * @param model
     * @return
     * @author ntt.dev
     * @note page show input register user
     */
    @GetMapping("/join/select")
    public String goRegisterSelect(Model model) {
        return DataStatic.VIEW_RESOURCE.REGISTER_WEB_NEW + "joinSelect";
    }

    /**
     * @param model
     * @param userDTO
     * @return
     * @author ntt.dev
     * @note page show input register user
     */
    @GetMapping("/join/user")
    public String goRegisterUser(Model model, UserDTO userDTO) {

        model.addAttribute("joinUserForm", userDTO);
        return DataStatic.VIEW_RESOURCE.REGISTER_WEB_NEW + "joinUser";
    }

    /**
     * @param session
     * @param model
     * @param userDTO
     * @return
     * @author ntt.dev
     * @note post form register user
     */
    @PostMapping("/join/user")
    public String doRegisterUser(HttpSession session, Model model, @ModelAttribute("joinUserForm") UserDTO userDTO) {

        UserDTO joinData = userService.userRegistrationProcess(userDTO);
        if (joinData == null) {

            model.addAttribute("joinUserForm", userDTO);
            model.addAttribute("mess", messageSource.getMessage("register.register.message.fail.title",
                    null, LocaleContextHolder.getLocale()));
            return goRegisterUser(model, userDTO);
        }

        model.addAttribute("mess", messageSource.getMessage("register.request.message.success.title"
                , null, LocaleContextHolder.getLocale()));

        return goRegisterUserResult(model, joinData);

    }

    /**
     * @param model
     * @param registerResult
     * @return
     * @author ntt.dev
     * @note show information register
     */
    @GetMapping("/join/userResult")
    public String goRegisterUserResult(Model model, UserDTO registerResult) {

        model.addAttribute("title", messageSource.getMessage("register.logo.title", null, LocaleContextHolder.getLocale()));
        model.addAttribute("dataWallet", registerResult);
        return DataStatic.VIEW_RESOURCE.REGISTER_WEB_NEW + "joinUserResult";
    }


    /**
     * @param model
     * @param walletDTO
     * @return
     * @author ntt.dev
     * @note page show input register wallet
     */
    @GetMapping("/join/wallet")
    public String goRegisterWallet(Model model, WalletDTO walletDTO) {

//        model.addAttribute("title", messageSource.getMessage("register.logo.title", null, LocaleContextHolder.getLocale()));
        model.addAttribute("joinWalletForm", walletDTO);
        return DataStatic.VIEW_RESOURCE.REGISTER_WEB_NEW + "joinWallet";
    }

    /**
     * @param session
     * @param model
     * @param walletDTO
     * @return
     * @author ntt.dev
     * @note post form register wallet
     */
    @PostMapping("/join/wallet")
    public String doRegisterWallet(HttpSession session, Model model, @ModelAttribute("joinWalletForm") WalletDTO walletDTO) {

        WalletDTO joinData = walletService.createWallet(walletDTO);
        if (joinData == null) {

            model.addAttribute("joinWalletForm", walletDTO);
            model.addAttribute("mess", messageSource.getMessage("register.register.message.fail.title",
                    null, LocaleContextHolder.getLocale()));
            return goRegisterWallet(model, walletDTO);
        }

        model.addAttribute("mess", messageSource.getMessage("register.request.message.success.title",
                null, LocaleContextHolder.getLocale()));
        return goRegisterWalletResult(model, joinData);
    }

    /**
     * @param model
     * @param registerResult
     * @return
     * @author ntt.dev
     * @note show information register
     */
    @GetMapping("/join/walletResult")
    public String goRegisterWalletResult(Model model, WalletDTO registerResult) {

        model.addAttribute("title", messageSource.getMessage("register.logo.title", null, LocaleContextHolder.getLocale()));
        model.addAttribute("dataWallet", registerResult);
        return DataStatic.VIEW_RESOURCE.REGISTER_WEB_NEW + "joinWalletResult";
    }

}
