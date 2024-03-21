package com.apollo.exchange.common.properties;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataStatic {
    public class VIEW_RESOURCE {
        public static final String REGISTER_WEB = "web/register";
        public static final String TRADE_WEB = "web/trade";
        public static final String TRADE_BUY_DETAIL_WEB = "web/trade/buy";
        public static final String TRADE_SELL_DETAIL_WEB = "web/trade/sell";

        // NEW PATH
        public static final String MY_ROOM_WEB = "web-new/myRoom/";
        public static final String REGISTER_WEB_NEW = "web-new/register/";
        public static final String TRADE_WEB_NEW = "web-new/trade/";
        public static final String TRADE_BUY_DETAIL_WEB_NEW = "web-new/trade/buy/";
        public static final String TRADE_SELL_DETAIL_WEB_NEW = "web-new/trade/sell";
    }

    public class SESSION {
        public static final String WALLET = "wallet";
        public static final String LOGIN = "login";
        public static final String ANDROID = "android";
        public static final String WALLET_CURRENT = "wallet_current";
        public static final String LANG_CODE = "lang_code";

    }

    public class ORDER_TYPE {
        public static final int GENERAL = 1;
        public static final int API = 2;
    }

    public class SYMBOL {
        public static final String BANI = "BANI";
        public static final String EGG = "EGG";
    }
    public class FEEDBACK_TYPE {
        public static final int REQUEST = 1;
        public static final int REPLY = 2;
    }
    public class CHAT_TYPE {
        public static final int SEND = 1;
    }

    public static class WALLET_ROLE {
        public static final String SYSTEM = "SYSTEM";
        public static final String CENTRAL_BANK = "CENTRAL_BANK";
        public static final String VIETKO_FEE = "VIETKO_FEE";
        public static final String OPERATOR = "OPERATOR";
        public static final String OPERATOR_FEE = "OPERATOR_FEE";
        public static final String CLIENT = "CLIENT";
        public static final String CLIENT_TRADER = "CLIENT_TRADER";
        public static final String TRADER = "TRADER";
        public static final String USER = "USER";
        public static final String GUEST = "guest";

        public static List<String> getWriteByRoleUser(String roleCode) {
            Map<String, List<String>> m = new HashMap<>();

            String[] system = {TRADER, USER, CLIENT_TRADER};
            m.put(SYSTEM, Arrays.asList(system));

            String[] centralBank = {TRADER, USER, CLIENT_TRADER};
            m.put(CENTRAL_BANK, Arrays.asList(centralBank));

            String[] operator = {TRADER, USER, CLIENT_TRADER};
            m.put(OPERATOR, Arrays.asList(operator));

            String[] client = {TRADER, USER, CLIENT_TRADER};
            m.put(CLIENT, Arrays.asList(client));

            return m.get(roleCode);
        }
    }

    public static class VIEW_ROLE {
        public static final String MASTER = "MASTER";
        public static final String SITE_ADMIN = "SITE_ADMIN";
        public static final String TRADER = "TRADER";
        public static final String USER_SAFE = "USER_SAFE";
        public static final String OWNER_SAFE = "OWNER_SAFE";
        public static final String API = "API";
        public static final String USER = "USER";

        public static String getRole(String roleFrom, String roleTo) {
            Map<String, String> roles = new HashMap<>();
            roles.put("SYSTEM_OPERATOR", MASTER);

            roles.put("CENTRAL_BANK_OPERATOR", MASTER);
            roles.put("OPERATOR_CENTRAL_BANK", MASTER);

            roles.put("OPERATOR_CLIENT", SITE_ADMIN);
            roles.put("CLIENT_OPERATOR", SITE_ADMIN);

            roles.put("TRADER_OPERATOR", TRADER);
            roles.put("OPERATOR_TRADER", TRADER);
            return (roles.get(roleFrom + "_" + roleTo) == null) ? null : roles.get(roleFrom + "_" + roleTo);
        }
    }
}
