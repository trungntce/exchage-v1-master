package com.apollo.exchange.common.utils;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtils {

    public static List<String> dayList(Date s, Date e){
        Calendar cs = Calendar.getInstance();
        cs.setTime(s);
        Calendar ce = Calendar.getInstance();
        ce.setTime(e);

        List<String> result = new ArrayList<>();
        while (ce.after(cs)){
            result.add(String.format("%d/%02d/%02d", cs.get(Calendar.YEAR), cs.get(Calendar.MONTH)+1, cs.get(Calendar.DAY_OF_MONTH)));
            cs.add(Calendar.DAY_OF_YEAR, 1);
        }
        result.add(String.format("%d/%02d/%02d", cs.get(Calendar.YEAR), cs.get(Calendar.MONTH)+1, cs.get(Calendar.DAY_OF_MONTH)));
        return result;
    }
}
