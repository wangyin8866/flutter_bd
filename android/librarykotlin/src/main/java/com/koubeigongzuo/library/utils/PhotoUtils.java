package com.koubeigongzuo.library.utils;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.view.View;
import com.blankj.utilcode.util.SPUtils;
import com.jph.takephoto.app.TakePhoto;
import com.jph.takephoto.model.CropOptions;
import com.koubeigongzuo.library.R;
import com.koubeigongzuo.library.config.BaseConstant;
import com.koubeigongzuo.library.widget.dialog.CustomerDialog;

import java.io.File;

import static androidx.core.app.ActivityCompat.requestPermissions;

/**
 * Created by wangyin on 2017/10/23.
 */

public class PhotoUtils {
    /**
     * 设置图像
     */
    public static void showUserPicDialog(final Context mContext, final TakePhoto takePhoto) {

        final CustomerDialog dialog = new CustomerDialog(mContext);
        dialog.userPicDialog(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int i = view.getId();
                if (i == R.id.cancel) {
                    dialog.dismiss();

                } else if (i == R.id.tv_picture) {
                    dialog.dismiss();
                    PhotoUtils.toPhone(mContext, takePhoto);

                } else if (i == R.id.tv_album) {
                    dialog.dismiss();
                    PhotoUtils.toGallery(takePhoto);

                }
            }
        }).show();
    }

    /**
     * 拍照
     */
    public static void toPhone(Context mContext, TakePhoto takePhoto) {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int hasCamera = mContext.checkSelfPermission(Manifest.permission.CAMERA);
            int hasWsd = mContext.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE);
            if (hasCamera == PackageManager.PERMISSION_GRANTED && hasWsd == PackageManager.PERMISSION_GRANTED) {
                takePhoto.onPickFromCaptureWithCrop(handlerFile(), getCropOptions());
            } else {
                requestPermissions((Activity) mContext, new String[]{Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE}, 123);
            }
        } else {
            takePhoto.onPickFromCaptureWithCrop(handlerFile(), getCropOptions());
        }
    }

    private static Uri handlerFile() {
        File file = new File(Environment.getExternalStorageDirectory(), BaseConstant.ID_CARD_SCAN_PIC + System.currentTimeMillis() + ".jpg");
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        SPUtils.getInstance("image").put("imagePath", Uri.fromFile(file).getPath());
        return Uri.fromFile(file);
    }

    private static CropOptions getCropOptions() {
        CropOptions.Builder builder = new CropOptions.Builder();
        builder.setAspectX(1);
        builder.setAspectY(1);
        builder.setOutputX(400).setOutputY(400);
        builder.setWithOwnCrop(true);
        return builder.create();
    }

    /**
     * 相册
     *
     * @param takePhoto
     */
    public static void toGallery(TakePhoto takePhoto) {
        takePhoto.onPickFromGalleryWithCrop(handlerFile(), getCropOptions());
    }
}
