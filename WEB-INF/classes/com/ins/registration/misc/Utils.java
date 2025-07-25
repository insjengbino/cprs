//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ins.registration.misc;

import java.util.Calendar;
import java.util.Date;

public class Utils {
    public static Calendar toCalendar(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(11, 0);
        calendar.set(12, 0);
        calendar.set(13, 0);
        calendar.set(14, 0);
        return calendar;
    }

    public static boolean isValid(Date periodOfEffectivity, Date dateCreated) {
        Calendar calendar1 = toCalendar(periodOfEffectivity);
        Calendar calendar2 = toCalendar(dateCreated);
        calendar1.add(1, 1);
        if (periodOfEffectivity.after(dateCreated)) {
            return false;
        } else {
            return !calendar1.getTime().before(dateCreated);
        }
    }

    public static String formatTwoDecimal(String value) {
        if (value == null || value.trim().length() == 0) return null;
        return new java.text.DecimalFormat("#0.00").format(new java.math.BigDecimal(value.trim()));
    }
}
