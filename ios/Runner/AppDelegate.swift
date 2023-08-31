import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.providAPIKey('AIzaSyC3BfQIf1YLBzZF7LcljVFFJZZ9qAXqJA4')
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
