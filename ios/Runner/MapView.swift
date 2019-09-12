//
//  BMKMapView.swift
//  Runner
//
//  Created by zyx on 2019/9/10.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit

class MapView: NSObject, FlutterPlatformView {
    
    let frame: CGRect;
    let viewId: Int64;
    var messenger: FlutterBinaryMessenger!
    lazy var mapView: BMKMapView = {
        let mapView = BMKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = BMKUserTrackingModeHeading
        mapView.zoomLevel = 16
        
        return mapView
    }()
    var userLocation: BMKUserLocation?
    lazy var locationManager: BMKLocationManager = {
        let locationManager = BMKLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = CLActivityType.automotiveNavigation
        locationManager.coordinateType = .BMK09LL
        
        return locationManager
    }()
    
    init(_ frame: CGRect,viewID: Int64,args :Any?, binaryMessenger: FlutterBinaryMessenger) {
        self.frame = frame;
        self.viewId = viewID;
        self.messenger=binaryMessenger;
    }
    
    func initMethodChannel() {
        let mapChannel = FlutterMethodChannel(name: "bd.flutter.io/map", binaryMessenger: messenger)
        mapChannel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "moveToCenter" {
                self?.updateMap()
            } else if call.method == "mapViewWillDisappear" {
                self?.mapViewWillDisappear()
            }
        }
    }
    
    func view() -> UIView {
        initMethodChannel()
        
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        let v = UIView(frame: frame)
        v.backgroundColor = .cyan
        v.addSubview(mapView)
        
        return v
    }
    
    func mapViewWillDisappear() {
        mapView.viewWillDisappear()
    }
    
    func updateMap() {
        mapView.updateLocationData(userLocation)
        mapView.setMapCenterToScreenPt(CGPoint(x: mapView.center.x, y: (mapView.center.y) - 180))
        mapView.zoomLevel = 16
        if userLocation?.location == nil {
            return
        }
        mapView.setCenter(userLocation?.location.coordinate ?? CLLocationCoordinate2DMake(0, 0), animated: true)
    }
    
}

extension MapView: BMKLocationManagerDelegate {
    
    func bmkLocationManager(_ manager: BMKLocationManager, didUpdate location: BMKLocation?, orError error: Error?) {
        if location == nil {
            return
        }
        locationManager.stopUpdatingLocation()
        if userLocation == nil {
            userLocation = BMKUserLocation()
        }
        userLocation?.location = location?.location
        mapView.updateLocationData(userLocation)
        updateMap()
    }
    
    func bmkLocationManager(_ manager: BMKLocationManager, didUpdate heading: CLHeading?) {
        if userLocation == nil {
            userLocation = BMKUserLocation()
        }
        userLocation?.heading = heading
        mapView.updateLocationData(userLocation)
    }
    
}

class MapViewFactory: NSObject, FlutterPlatformViewFactory {
    
    var messenger: FlutterBinaryMessenger!
    
    @objc public init(messenger: (NSObject & FlutterBinaryMessenger)?) {
        super.init()
        self.messenger = messenger
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return MapView(frame, viewID: viewId, args: args, binaryMessenger: messenger)
    }
    
}


class MapViewSwiftPlugin: NSObject {
    static func registerWith(registry:FlutterPluginRegistry) {
        let pluginKey = "mapViewPlugin";
        if (registry.hasPlugin(pluginKey)) {return};
        let registrar = registry.registrar(forPlugin: pluginKey);
        let messenger = registrar.messenger() as! (NSObject & FlutterBinaryMessenger)
        registrar.register(MapViewFactory(messenger:messenger),withId: "mapView");
    }
}
