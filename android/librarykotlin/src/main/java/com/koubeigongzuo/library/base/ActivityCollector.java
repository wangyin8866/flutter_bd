package com.koubeigongzuo.library.base;

import android.app.Activity;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by wy on 2016/5/19.
 */
public class ActivityCollector {
    public static List<Activity> activities = new ArrayList<Activity>();

    public static void addActivity(Activity activity) {
        activities.add(activity);
    }

    public static void removeActivity(Activity activity) {
        Iterator<Activity> it = activities.iterator();
        while (it.hasNext()) {
            if (activity == it.next()) {
                it.remove();
            }
        }
        //activities.remove(activity);
    }

    public static void finishAll() {
        for (Activity activity : activities) {
            if (!activity.isFinishing()) {
                activity.finish();
            }
        }

    }

    public static void finishActivity(Class tClass) {
        for (Activity activity : activities) {
            if (activity.getClass().equals(tClass)) {
                activity.finish();
            }
        }

    }
}
