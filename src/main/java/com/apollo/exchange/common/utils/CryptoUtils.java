package com.apollo.exchange.common.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/**
 * @author ionio.dev
 * @apiNote Encryption Utility Class
 */
public class CryptoUtils {

    public static String SHA256encryptor(String str) {

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(str.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}