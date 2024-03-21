package com.apollo.exchange.common.message;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.MessageSourceAccessor;

import java.util.Locale;

/**
 * @author ionio.dev
 * @apiNote Spring Message Support
 */
public class MessageSupport {

    private static MessageSourceAccessor messageSourceAccessor = null;

    public void setMessageSourceAccessor(MessageSourceAccessor messageSourceAccessor) {
        MessageSupport.messageSourceAccessor = messageSourceAccessor;
    }

    public static String getMessage(String code) {
        return messageSourceAccessor.getMessage(code, LocaleContextHolder.getLocale());
    }

    public static String getMessage(String code, Object[] objs) {
        return messageSourceAccessor.getMessage(code, objs, LocaleContextHolder.getLocale());
    }

    public static String getMessage(String code, String... params) {
        Object[] arr = new Object[params.length];
        System.arraycopy(params, 0, arr, 0, params.length);
        return getMessage(code, arr);
    }
}