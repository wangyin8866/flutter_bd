package com.koubeigongzuo.library.entity;

import java.util.List;

/**
 * @author : created by wyman
 * @date : 2019-06-12 13:26
 * des :
 */
public class RacingBean {

    /**
     * total : 10
     * lists : [{"content":"187***1678刚刚通过面试找到了7000元的工作"},{"content":"187***1678五分钟前通过面试找到了7000元的工作"},{"content":"赵**1小时前通过了面试找到了8700元的工作"},{"content":"李**1小时前邀请好友面试获得了30元"},{"content":"186**5795 5分钟前邀请好友面试获得了10元"},{"content":"137***6187刚刚预约了面试官面试"},{"content":"王**刚刚预约了面试官面试"},{"content":"王**五分钟前预约了面试官面试"},{"content":"137***6189五分钟预约了面试官面试"},{"content":"岗位-营业员上线了啦，薪资10000"}]
     */

    private int total;
    private List<ListsBean> lists;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<ListsBean> getLists() {
        return lists;
    }

    public void setLists(List<ListsBean> lists) {
        this.lists = lists;
    }

    public static class ListsBean {
        /**
         * content : 187***1678刚刚通过面试找到了7000元的工作
         */

        private String content;

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }
}
