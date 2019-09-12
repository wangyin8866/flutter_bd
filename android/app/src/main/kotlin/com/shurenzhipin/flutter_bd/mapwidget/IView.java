package com.shurenzhipin.flutter_bd.mapwidget;

import com.baidu.mapapi.model.LatLng;

/**
 * Auth：yujunyao
 * Since: 2019-09-11 13:23
 * Email：yujunyao@xinrenlei.net
 */

public interface IView {

    void initLoaction();

    void moveToCenter(LatLng latLng, boolean defalutZoom);

    void calculateOffsetAndMove(LatLng latLng);

}
