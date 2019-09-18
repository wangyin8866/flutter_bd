package com.koubeigongzuo.library.config

import com.koubeigongzuo.library.utils.PreferenceLocal

/**
 * @author wyman
 * @date  2018/9/4
 * description : 接口地址
 */
object BaseNetValueConfig {
    /**
     * api
     */
    private const val ONLINE_SERVER_URL = "https://onsite-api.shurenzhipin.com"
    private const val DEV_SERVER_URL = "http://onsite-api.ci.dev.lanxinka.com"
    private const val TEST_SERVER_URL = "http://onsite-api.st1.test.lanxinka.com"
    private const val TEST_ST2_SERVER_URL = "http://onsite-api.st2.test.lanxinka.com"
    private const val TEST_ST3_SERVER_URL = "http://onsite-api.st3.test.lanxinka.com"
    private const val UAT = "https://pre-onsite-api.shurenzhipin.com"
    var SERVER_URL: String by PreferenceLocal("SERVER_URL", ONLINE_SERVER_URL)
    /**
     * h5
     */
    private const val ONLINE_H5_URL = "https://h5.shurenzhipin.com"
    private const val DEV_H5_URL = "http://onsite-h5.ci.dev.lanxinka.com"
    private const val TEST_H5_URL = "http://onsite-h5.st1.test.lanxinka.com"
    private const val TEST_H5_URL2 = "http://onsite-h5.st2.test.lanxinka.com"
    private const val TEST_H5_URL3 = "http://onsite-h5.st3.test.lanxinka.com"
    private const val H5_UAT = "https://pre-h5.shurenzhipin.com"
    var H5_URL: String by PreferenceLocal("H5_URL", ONLINE_H5_URL)

    private const val ONLINE_ACTIVITY_URL = "https://activity-h5.shurenzhipin.com"
    private const val DEV_ACTIVITY_URL = "http://activity-h5.ci.dev.lanxinka.com"
    private const val ST1_ACTIVITY_URL = "http://activity-h5.st1.test.lanxinka.com"
    private const val ST2_ACTIVITY_URL = "http://activity-h5.st2.test.lanxinka.com"
    private const val ST3_ACTIVITY_URL = "http://activity-h5.st3.test.lanxinka.com"
    private const val ACTIVITY_UAT = "https://pre-activity-h5.shurenzhipin.com"
    var ACTIVITY_URL: String by PreferenceLocal("ACTIVITY_URL", ONLINE_ACTIVITY_URL)

    /**
     * 融云系统账号
     */

    private const val RONG_ACCOUNT_SYSTEM_DEV = "C_dev_2975"
    private const val RONG_ACCOUNT_INTERVIEW_DEV = "C_dev_2960"

    private const val RONG_ACCOUNT_SYSTEM_TEST = "C_test_41768"
    private const val RONG_ACCOUNT_INTERVIEW_TEST = "C_test_41757"

    private const val RONG_ACCOUNT_SYSTEM_ONLINE = "C_production_17763"
    private const val RONG_ACCOUNT_INTERVIEW_ONLINE = "C_production_17854"

    var RONG_ACCOUNT_SYSTEM: String by PreferenceLocal("RONG_ACCOUNT_SYSTEM", RONG_ACCOUNT_SYSTEM_ONLINE)
    var RONG_ACCOUNT_INTERVIEW: String by PreferenceLocal("RONG_ACCOUNT_INTERVIEW", RONG_ACCOUNT_INTERVIEW_ONLINE)

    fun initUrl(which: Int) {

        when (which) {
            0 -> {
                SERVER_URL = DEV_SERVER_URL
                H5_URL = DEV_H5_URL
                ACTIVITY_URL = DEV_ACTIVITY_URL
                RONG_ACCOUNT_SYSTEM = RONG_ACCOUNT_SYSTEM_DEV
                RONG_ACCOUNT_INTERVIEW = RONG_ACCOUNT_INTERVIEW_DEV
            }
            1 -> {
                SERVER_URL = ONLINE_SERVER_URL
                H5_URL = ONLINE_H5_URL
                ACTIVITY_URL = ONLINE_ACTIVITY_URL
                RONG_ACCOUNT_SYSTEM = RONG_ACCOUNT_SYSTEM_ONLINE
                RONG_ACCOUNT_INTERVIEW = RONG_ACCOUNT_INTERVIEW_ONLINE
            }
            2 -> {
                SERVER_URL = TEST_SERVER_URL
                H5_URL = TEST_H5_URL
                ACTIVITY_URL = ST1_ACTIVITY_URL
                RONG_ACCOUNT_SYSTEM = RONG_ACCOUNT_SYSTEM_TEST
                RONG_ACCOUNT_INTERVIEW = RONG_ACCOUNT_INTERVIEW_TEST
            }
            3 -> {
                SERVER_URL = ONLINE_SERVER_URL
                H5_URL = ONLINE_H5_URL
                ACTIVITY_URL = ONLINE_ACTIVITY_URL
                BaseConstant.KEY_IS_HD = 1
                RONG_ACCOUNT_SYSTEM = RONG_ACCOUNT_SYSTEM_ONLINE
                RONG_ACCOUNT_INTERVIEW = RONG_ACCOUNT_INTERVIEW_ONLINE
            }
            4 -> {
                SERVER_URL = TEST_ST2_SERVER_URL
                H5_URL = TEST_H5_URL2
                ACTIVITY_URL = ST2_ACTIVITY_URL
                RONG_ACCOUNT_SYSTEM = RONG_ACCOUNT_SYSTEM_TEST
                RONG_ACCOUNT_INTERVIEW = RONG_ACCOUNT_INTERVIEW_TEST
            }
            5 -> {
                SERVER_URL = TEST_ST3_SERVER_URL
                H5_URL = TEST_H5_URL3
                ACTIVITY_URL = ST3_ACTIVITY_URL
                RONG_ACCOUNT_SYSTEM = RONG_ACCOUNT_SYSTEM_TEST
                RONG_ACCOUNT_INTERVIEW = RONG_ACCOUNT_INTERVIEW_TEST

            }
            7 -> {
                SERVER_URL = UAT
                H5_URL = H5_UAT
                ACTIVITY_URL = ACTIVITY_UAT
            }
        }

    }
}