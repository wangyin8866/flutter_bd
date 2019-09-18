package com.koubeigongzuo.library.widget.views;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.*;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.util.AttributeSet;
import com.koubeigongzuo.library.R;

public class RectCircleImageView extends androidx.appcompat.widget.AppCompatImageView {

	private static final ScaleType SCALE_TYPE = ScaleType.CENTER_CROP;

	private static final Bitmap.Config BITMAP_CONFIG = Bitmap.Config.ARGB_8888;
	private static final int COLORDRAWABLE_DIMENSION = 1;

	public static final int TYPE_CIRCLE = 0;  
	public static final int TYPE_ROUND = 1; 
    
	private static final int DEFAULT_BORDER_WIDTH = 0;
	private static final int DEFAULT_BORDER_COLOR = Color.BLACK;
	private static final int DEFAULT_ROUND_RADIUS = 10;

	private final RectF mDrawableRect = new RectF();
	private final RectF mBorderRect = new RectF();

	private final Matrix mShaderMatrix = new Matrix();
	private final Paint mBitmapPaint = new Paint();
	private final Paint mBorderPaint = new Paint();

    private int type;
    private int mRoundRadius = DEFAULT_ROUND_RADIUS;
	private int mBorderColor = DEFAULT_BORDER_COLOR;
	private int mBorderWidth = DEFAULT_BORDER_WIDTH;

	private Bitmap mBitmap;
	private BitmapShader mBitmapShader;
	private int mBitmapWidth;
	private int mBitmapHeight;
	
	private int mWidth;
	private int mHeight;

	private float mDrawableRadius;
	private float mBorderRadius;

	private boolean mReady;
	private boolean mSetupPending;

	public RectCircleImageView(Context context) {
		this(context, null);
	}

	public RectCircleImageView(Context context, AttributeSet attrs) {
		this(context, attrs, 0);
	}

	public RectCircleImageView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);

		TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.RectCircleImageView, defStyle, 0);
		type = a.getInt(R.styleable.RectCircleImageView_rect_type, TYPE_ROUND);
		mRoundRadius = a.getDimensionPixelSize(R.styleable.RectCircleImageView_rect_round_Radius, DEFAULT_ROUND_RADIUS);
		mBorderWidth = a.getDimensionPixelSize(R.styleable.RectCircleImageView_rect_border_width, DEFAULT_BORDER_WIDTH);
		mBorderColor = a.getColor(R.styleable.RectCircleImageView_rect_border_color,DEFAULT_BORDER_COLOR);
		a.recycle();

		init();
	}

	public void setRoundRadius(int roundRadius) {
		this.mRoundRadius = roundRadius;
	}

	private void init() {
		super.setScaleType(SCALE_TYPE);
		mReady = true;
		if (mSetupPending) {
			setup();
			mSetupPending = false;
		}
	}
	
	@Override  
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {   
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);   
        if (type == TYPE_CIRCLE) {
            mWidth = Math.min(getMeasuredWidth(), getMeasuredHeight());    
            setMeasuredDimension(mWidth, mWidth);  
        }
    }

	@Override
	protected void onDraw(Canvas canvas) {
		if (getDrawable() == null)
			return;	
		
		if (type == TYPE_ROUND) {
            canvas.drawRoundRect(mDrawableRect, mRoundRadius, mRoundRadius, mBitmapPaint);
            if (mBorderWidth != 0) {
    			canvas.drawRoundRect(mBorderRect , mRoundRadius + mBorderWidth / 2, mRoundRadius + mBorderWidth / 2, mBorderPaint);
    		}
        } else if (type == TYPE_CIRCLE) {
    		canvas.drawCircle(getWidth() / 2, getHeight() / 2, mDrawableRadius, mBitmapPaint);
    		if (mBorderWidth != 0) {
    			canvas.drawCircle(getWidth() / 2, getHeight() / 2, mBorderRadius, mBorderPaint);
    		}            
        }  
	}

	private void setup() {
		if (!mReady) {
			mSetupPending = true;
			return;
		}
		if (mBitmap == null) {
			return;
		}
		mBitmapShader = new BitmapShader(mBitmap, Shader.TileMode.CLAMP, Shader.TileMode.CLAMP);
		mBitmapPaint.setAntiAlias(true);
		mBitmapPaint.setShader(mBitmapShader);
		mBorderPaint.setStyle(Paint.Style.STROKE);
		mBorderPaint.setAntiAlias(true);
		mBorderPaint.setColor(mBorderColor);
		mBorderPaint.setStrokeWidth(mBorderWidth);
		mBitmapHeight = mBitmap.getHeight();
		mBitmapWidth = mBitmap.getWidth();
		mBorderRect.set(0, 0, getWidth(), getHeight());
		mDrawableRect.set(mBorderWidth, mBorderWidth, mBorderRect.width() - mBorderWidth, mBorderRect.height() - mBorderWidth);
		
		if (type == TYPE_CIRCLE) {
			mBorderRadius = (mBorderRect.width() - mBorderWidth)/2;
			mDrawableRadius = mDrawableRect.width()/2;
		} else if (type == TYPE_ROUND) {
			mBorderRect.set(mBorderWidth/2, mBorderWidth/2, getWidth() - mBorderWidth/2, getHeight() - mBorderWidth/2);
		}
		
		updateShaderMatrix();
		invalidate();
	}


	private void updateShaderMatrix() {
		float scaleX = 1.0f;
		float scaleY = 1.0f;
		float scale = 1.0f;
		float dx = 0;
		float dy = 0;
		if (type == TYPE_CIRCLE) {
			scaleX = mWidth * 1.0f / mBitmapWidth;
			scaleY = mWidth * 1.0f / mBitmapHeight;
			scale = Math.max(scaleX, scaleY);
		} else if (type == TYPE_ROUND) {
			scaleX = getWidth() * 1.0f / mBitmapWidth;
			scaleY = getHeight() * 1.0f / mBitmapHeight;
			scale = Math.max(scaleX, scaleY);
		}			
		if (scaleX > scaleY) {
			dy = (mDrawableRect.height() - mBitmapHeight * scale) * 0.5f;
		} else {
			dx = (mDrawableRect.width() - mBitmapWidth * scale) * 0.5f;
		}
		
		mShaderMatrix.set(null);
		mShaderMatrix.setScale(scale, scale);
		mShaderMatrix.postTranslate((int) (dx + 0.5f) + mBorderWidth, (int) (dy + 0.5f) + mBorderWidth);
		mBitmapShader.setLocalMatrix(mShaderMatrix);
	}

	@Override
	protected void onSizeChanged(int w, int h, int oldw, int oldh) {
		super.onSizeChanged(w, h, oldw, oldh);
		setup();
	}
	
	public int getType() {
		return type;
	}

	public void setType(int mType) {
		if (type == mType) {
			return;
		}
		type = mType;
		requestLayout();
	}

	public int getBorderColor() {
		return mBorderColor;
	}

	public void setBorderColor(int borderColor) {
		if (borderColor == mBorderColor) {
			return;
		}
		mBorderColor = borderColor;
		mBorderPaint.setColor(mBorderColor);
		invalidate();
	}

	public int getBorderWidth() {
		return mBorderWidth;
	}

	public void setBorderWidth(int borderWidth) {
		if (borderWidth == mBorderWidth) {
			return;
		}
		mBorderWidth = borderWidth;
		setup();
	}
	
	@Override
	public ScaleType getScaleType() {
		return SCALE_TYPE;
	}

	@Override
	public void setScaleType(ScaleType scaleType) {
//		if (scaleType != SCALE_TYPE) {
//			throw new IllegalArgumentException(String.format("ScaleType %s not supported.", scaleType));
//		}
	}

	@Override
	public void setImageBitmap(Bitmap bm) {
		super.setImageBitmap(bm);
		mBitmap = bm;
		setup();
	}

	@Override
	public void setImageDrawable(Drawable drawable) {
		super.setImageDrawable(drawable);
		mBitmap = getBitmapFromDrawable(drawable);
		setup();
	}

	@Override
	public void setImageResource(int resId) {
		super.setImageResource(resId);
		mBitmap = getBitmapFromDrawable(getDrawable());
		setup();
	}

	@Override
	public void setImageURI(Uri uri) {
		super.setImageURI(uri);
		mBitmap = getBitmapFromDrawable(getDrawable());
		setup();
	}
	
	private Bitmap getBitmapFromDrawable(Drawable drawable) {
		if (drawable == null) {
			return null;
		}

		if (drawable instanceof BitmapDrawable) {
			return ((BitmapDrawable) drawable).getBitmap();
		}

		try {
			Bitmap bitmap;
			if (drawable instanceof ColorDrawable) {
				bitmap = Bitmap.createBitmap(COLORDRAWABLE_DIMENSION, COLORDRAWABLE_DIMENSION, BITMAP_CONFIG);
			} else {
				bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), BITMAP_CONFIG);
			}
			Canvas canvas = new Canvas(bitmap);
			drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
			drawable.draw(canvas);
			return bitmap;
		} catch (OutOfMemoryError e) {
			return null;
		}
	}

}