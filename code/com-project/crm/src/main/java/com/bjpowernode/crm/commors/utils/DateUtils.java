package com.bjpowernode.crm.commors.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    public static String fromateDateTime(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String  dateStr=sdf.format(date);
        return dateStr;
    }
    public static String fromateDate(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String  dateStr=sdf.format(date);
        return dateStr;
    }
    public static String fromateTime(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        String  dateStr=sdf.format(date);
        return dateStr;
    }
}
