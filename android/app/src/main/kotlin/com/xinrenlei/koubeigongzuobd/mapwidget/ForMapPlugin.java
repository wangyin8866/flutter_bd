package com.xinrenlei.koubeigongzuobd.mapwidget;

import io.flutter.plugin.common.PluginRegistry;

/**
 * Auth：yujunyao
 * Since: 2019-09-11 11:21
 * Email：yujunyao@xinrenlei.net
 */

public class ForMapPlugin {

    public static void registerWith(PluginRegistry registry) {
        //防止多次注册
        final String key = ForMapPlugin.class.getCanonicalName();
        if (registry.hasPlugin(key)) return;
        //初始化 PluginRegistry
        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        //设置标识
        registrar.platformViewRegistry().registerViewFactory("com.xinrenlei.koubeigongzuobd.mapwidget.MapView", new MapViewFactory(registrar.messenger(), registrar.activity()));
    }

}
