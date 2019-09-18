package com.koubeigongzuo.library.base;

/**
 * @author : created by wyman
 * @date : 2019-07-15 14:38
 * des :
 */
public class ResultException extends RuntimeException {
    /** 错误码 */
    private int errorCode;
    /** 错误信息 */
    private String errorMsg;

    public ResultException(int errorCode, String errorMsg) {
        super(errorMsg);
        this.errorCode = errorCode;
        this.errorMsg = errorMsg;
    }

    public int getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(int errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }
}
