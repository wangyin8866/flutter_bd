//
//  BMKMapView.swift
//  Runner
//
//  Created by zyx on 2019/9/10.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit

class MapView: NSObject, FlutterPlatformView {
    
    var frame: CGRect?
    var viewId: Int64?
    var messager: FlutterBinaryMessenger?
    var mapView: BMKMapView?
    var userLocation: BMKUserLocation?
    var locationManager: BMKLocationManager?
    
    init(frame: CGRect, viewID: Int64, args: Any?, binaryMessenger: FlutterBinaryMessenger) {
        self.frame = frame
        self.viewId = viewID
        self.messager = binaryMessenger
        super.init()
    }
    
    func initMethodChannel() {
        let mapChannel = FlutterMethodChannel(name: "bd.flutter.io/map", binaryMessenger: messager!)
        mapChannel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "moveToCenter" {
                self?.updateMap()
            }
        }
    }
    
    func view() -> UIView {
        initMethodChannel()
        
        mapView = BMKMapView(frame: frame ?? .zero)
        mapView?.showsUserLocation = true
        mapView?.userTrackingMode = BMKUserTrackingModeHeading
        mapView?.zoomLevel = 16
        
        locationManager = BMKLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = CLActivityType.automotiveNavigation
        locationManager?.coordinateType = .BMK09LL
        locationManager?.startUpdatingLocation()
        locationManager?.startUpdatingHeading()
        
        return mapView!
    }
    
    func updateMap() {
        mapView?.updateLocationData(userLocation)
        mapView?.setMapCenterToScreenPt(CGPoint(x: mapView?.center.x ?? 0, y: (mapView?.center.y ?? 0) - 150))
        mapView?.zoomLevel = 16
        if userLocation?.location == nil {
            return
        }
        mapView?.setCenter(userLocation?.location.coordinate ?? CLLocationCoordinate2DMake(0, 0), animated: true)
    }
    
}

extension MapView: BMKLocationManagerDelegate {
    
    func bmkLocationManager(_ manager: BMKLocationManager, didUpdate location: BMKLocation?, orError error: Error?) {
        if location == nil {
            return
        }
        locationManager?.stopUpdatingLocation()
        if userLocation == nil {
            userLocation = BMKUserLocation()
        }
        userLocation?.location = location?.location
        mapView?.updateLocationData(userLocation)
        updateMap()
    }
    
    func bmkLocationManager(_ manager: BMKLocationManager, didUpdate heading: CLHeading?) {
        if userLocation == nil {
            userLocation = BMKUserLocation()
        }
        userLocation?.heading = heading
        mapView?.updateLocationData(userLocation)
    }
    
}

class MapViewFactory: NSObject, FlutterPlatformViewFactory {
    
    var messager: FlutterBinaryMessenger?
    
    init(registry: FlutterBinaryMessenger) {
        self.messager = registry
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return MapView(frame: frame, viewID: viewId, args: args, binaryMessenger: messager!)
    }
    
}


class MapViewPlugin: NSObject {
    
    static func register(registry: FlutterPluginRegistry) {
        let pluginKey = "mapViewPlugin"
        if registry.hasPlugin(pluginKey) {
            return
        }
        let registrar = registry.registrar(forPlugin: pluginKey)
        let messenger = registrar.messenger()
        registrar.register(MapViewFactory(registry: messenger), withId: "mapView")
    }
    
}
