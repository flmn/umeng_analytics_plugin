import Flutter
import UIKit
import UMCAnalytics

public class SwiftUmengAnalyticsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jitao.tech/umeng_analytics_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftUmengAnalyticsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            _init(call, result: result);
        case "onPageStart":
            _onPageStart(call, result: result);
        case "onPageEnd":
            _onPageEnd(call, result: result);
        case "onEvent":
            _onEvent(call, result: result);
        default:
            result(FlutterMethodNotImplemented);
        }
    }
    
    private func _init(_ call: FlutterMethodCall, result: FlutterResult) {
        result(true);
    }
    
    private func _onPageStart(_ call: FlutterMethodCall, result: FlutterResult) {
         String viewName = call.argument("viewName");

        MobClick.beginLogPageView(viewName);

        result.success(null);
    }
    
    private func _onPageEnd(_ call: FlutterMethodCall, result: FlutterResult) {
        final String viewName = call.argument("viewName");

        MobClick.endLogPageView(viewName);

        result.success(null);
    }
    
    private func _onEvent(_ call: FlutterMethodCall, result: FlutterResult) {
        final String eventId = call.argument("eventId");
        final String label = call.argument("label");

        MobClick.event(eventId, label);

        result.success(null);
    }
}
