import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var manager: BMKMapManager?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    manager = BMKMapManager()
    manager?.start("xgxSvhVGdjKLZAfYt2jXcEG2msR7m5G7", generalDelegate: nil)
    BMKLocationAuth.sharedInstance()?.checkPermision(withKey: "xgxSvhVGdjKLZAfYt2jXcEG2msR7m5G7", authDelegate: nil)
    MapViewSwiftPlugin.registerWith(registry: self)
    
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
