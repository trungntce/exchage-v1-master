package com.apollo.exchange.common.utils;

import java.lang.reflect.Field;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author tuyen.dev
 */
public class ObjectUtils {

    public static Map<String, Object> parameters(Object obj) {
        Map<String, Object> map = new LinkedHashMap<>();
        for (Field field : obj.getClass().getDeclaredFields()) {
            field.setAccessible(true);
            try {
                if(field.get(obj) != null && !field.get(obj).equals("") && !field.get(obj).equals(0)) map.put(field.getName(), field.get(obj));
            } catch (Exception e) { }
        }
        return map;
    }
}
