package com.apollo.exchange.common.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author ionio.dev
 * @apiNote Device-related utility classes
 */
public class DeviceUtils {

    public static String getDeviceType(HttpServletRequest req) {
        String userAgent = req.getHeader("User-Agent").toUpperCase();

        if(userAgent.contains("MOBILE")) {
            if(!userAgent.contains("PHONE")) {
                return "MOBILE";
            } else {
                return "TABLET";
            }
        } else {
            return "PC";
        }
    }

}