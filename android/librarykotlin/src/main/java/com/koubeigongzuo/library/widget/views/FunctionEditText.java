package com.koubeigongzuo.library.widget.views;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.TextView;
import com.koubeigongzuo.library.R;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;


/**
 * Auth：yujunyao
 * Since: 2017/5/12 下午6:30
 * Email：yujunyao@ylb.net
 */

public class FunctionEditText extends androidx.appcompat.widget.AppCompatEditText {

    private final static int DEFAULT_CLEAR_CION = 0;

    private int clearIcon;//清空图标
    private int cursorColor;//光标颜色
    private boolean isShowPhoneFormat;//是否手机号显示方式
    private boolean isShowBankCardFormat;//是否银行卡显示方式

    private Drawable mClearDrawable;
    private boolean isFoucs;

    public FunctionEditText(Context context) {
        this(context, null);
    }

    public FunctionEditText(Context context, AttributeSet attrs) {
        this(context, attrs, android.R.attr.editTextStyle);
    }

    public FunctionEditText(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context, attrs, defStyle);
    }

    private void init(Context context, AttributeSet attrs, int defStyle) {
        final TypedArray typedArray = context.getTheme().obtainStyledAttributes(attrs, R.styleable.FunctionEditText, defStyle, 0);
        if (typedArray != null) {
            clearIcon = typedArray.getResourceId(R.styleable.FunctionEditText_clearIcon, DEFAULT_CLEAR_CION);
            cursorColor = typedArray.getResourceId(R.styleable.FunctionEditText_cursorColor, R.drawable.cursor_color);
            isShowPhoneFormat = typedArray.getBoolean(R.styleable.FunctionEditText_isShowPhoneFormat, false);
            isShowBankCardFormat = typedArray.getBoolean(R.styleable.FunctionEditText_isShowBankCardFormat, false);
            typedArray.recycle();
        }

        //输入框清空图标
        if (mClearDrawable == null && clearIcon != DEFAULT_CLEAR_CION) {
            mClearDrawable = getResources().getDrawable(clearIcon);
            mClearDrawable.setBounds(0, 0, mClearDrawable.getIntrinsicWidth(), mClearDrawable.getIntrinsicHeight());
        }

        //设置光标颜色
        try {
            Field f = TextView.class.getDeclaredField("mCursorDrawableRes");
            f.setAccessible(true);
            f.set(this, cursorColor);
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

        //默认隐藏图标
        hideClearIcon(false);

        super.setOnFocusChangeListener(new OnFocusChangeListenerImpl());//自己本身

        super.addTextChangedListener(new TextWatcherImpl());//自己本身
    }

    private TextWatcher textWatcher;//第二层监听
    private OnFocusChangeListener onFocusChangeListener;//第二层监听

    private List<TextWatcher> subWatcherListeners = new ArrayList<>();//第三层以后监听
    private List<OnFocusChangeListener> subChangeListeners = new ArrayList<>();//第三层以后监听

    @Override
    public void addTextChangedListener(TextWatcher watcher) {
        this.textWatcher = watcher;
    }

    @Override
    public void setOnFocusChangeListener(OnFocusChangeListener onFocusChangeListener) {
        this.onFocusChangeListener = onFocusChangeListener;
    }

    public void setTextWatcher(TextWatcher textWatcher) {
        this.subWatcherListeners.add(textWatcher);
    }

    public void setOnFocusListener(OnFocusChangeListener onFocusChangeListener) {
        this.subChangeListeners.add(onFocusChangeListener);
    }

    //设置清空图标的显示隐藏
    private void hideClearIcon(boolean isVisible) {
        Drawable right = isVisible ? mClearDrawable : null;
        setCompoundDrawables(getCompoundDrawables()[0],
                getCompoundDrawables()[1], right, getCompoundDrawables()[3]);
    }

    private class OnFocusChangeListenerImpl implements OnFocusChangeListener {

        @Override
        public void onFocusChange(View view, boolean b) {
            isFoucs = b;
            if (b) {
                hideClearIcon(getText().length() > 0);
            } else {
                hideClearIcon(false);
            }
            if (onFocusChangeListener != null) {
                onFocusChangeListener.onFocusChange(view, b);
            }
            for (OnFocusChangeListener onFocusChangeListener : subChangeListeners) {
                onFocusChangeListener.onFocusChange(view, b);
            }
        }
    }

    private class TextWatcherImpl implements TextWatcher {

        private int oldLength = 0;
        private boolean isChange = true;
        private int curLength = 0;

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            if (isShowBankCardFormat) {
                oldLength = s.length();
            }
            if (textWatcher != null) {
                textWatcher.beforeTextChanged(s, start, count, after);
            }
            for (TextWatcher textWatcher : subWatcherListeners) {
                textWatcher.beforeTextChanged(s, start, count, after);
            }
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            if (isFoucs) {
                hideClearIcon(s.length() > 0);
            }

            if (isShowPhoneFormat) {
                showPhoneFormat(s, start, before);
            }

            if (isShowBankCardFormat) {
                curLength = s.length();
                if (curLength == oldLength || curLength <= 3) {
                    isChange = false;
                } else {
                    isChange = true;
                }
            }
            if (textWatcher != null) {
                textWatcher.onTextChanged(s, start, before, count);
            }
            for (TextWatcher textWatcher : subWatcherListeners) {
                textWatcher.onTextChanged(s, start, before, count);
            }
        }

        @Override
        public void afterTextChanged(Editable s) {
            try {
                if (isShowBankCardFormat) {
                    if (isChange) {
//                        int selectIndex = getSelectionEnd();//获取光标位置
                        String content = s.toString().replaceAll(" ", "");
                        StringBuffer sb = new StringBuffer(content);
                        //遍历加空格
                        int index = 1;
//                        emptyNumA = 0;
                        for (int i = 0; i < content.length(); i++) {
                            if ((i + 1) % 4 == 0) {
                                sb.insert(i + index, " ");
                                index++;
//                                emptyNumA++;
                            }
                        }
                        String result = sb.toString();
                        if (result.endsWith(" ")) {
                            result = result.substring(0, result.length() - 1);
                        }
                        setText(result);
                        setSelection(result.length());
                        isChange = false;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (textWatcher != null) {
                textWatcher.afterTextChanged(s);
            }
            for (TextWatcher textWatcher : subWatcherListeners) {
                textWatcher.afterTextChanged(s);
            }
        }
    }

    private void showPhoneFormat(CharSequence s, int start, int before) {
        if (s == null || s.length() == 0) return;
        int selectionStart = getSelectionStart();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (i != 3 && i != 8 && s.charAt(i) == ' ') {
                continue;
            } else {
                sb.append(s.charAt(i));
                if ((sb.length() == 4 || sb.length() == 9) && sb.charAt(sb.length() - 1) != ' ') {
                    sb.insert(sb.length() - 1, ' ');
                }
            }
        }
        if (!sb.toString().equals(s.toString())) {
            setText(sb.toString());
            try {
                if (before > 0) {//一般会等于1，往前删除
                    setSelection(selectionStart);
                } else {
                    if (selectionStart>0&&selectionStart < sb.toString().length()) {
                        String temp = sb.toString().substring(selectionStart - 1, selectionStart);
                        if (temp.equals(" ")) {
                            setSelection(selectionStart + before + 1);
                        } else {
                            setSelection(selectionStart + before);
                        }
                    } else {
                        setSelection(sb.toString().length());
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
//                ToastUtils.showShort("请输入11位手机号");
            }

        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (event.getAction() == MotionEvent.ACTION_UP) {
            if (getCompoundDrawables()[2] != null) {

                boolean touchable = event.getX() > (getWidth() - getTotalPaddingRight())
                        && (event.getX() < ((getWidth() - getPaddingRight())));

                if (touchable) {
                    this.setText("");
                }
            }
        }
        return super.onTouchEvent(event);
    }
}
