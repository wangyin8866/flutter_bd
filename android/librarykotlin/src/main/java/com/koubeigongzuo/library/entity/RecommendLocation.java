package com.koubeigongzuo.library.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * Auth：yujunyao
 * Since: 2019/2/27 下午5:27
 * Email：yujunyao@aiwending.com
 */

public class RecommendLocation {

    public int status;

    public String message;

    public List<RecommendStops> recommendStops = new ArrayList<>();

    public static class RecommendStops {
        public String name;
        public String address;
        public float distance;
        public double bd09ll_x;
        public double bd09ll_y;
        public float gcj02ll_x;
        public float gcj02ll_y;
        public String id;
    }

}


