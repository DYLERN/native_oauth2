import Flutter
import UIKit

public class NativeOauth2Plugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "za.drt/native_oauth2", binaryMessenger: registrar.messenger())
        let instance = NativeOauth2Plugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "authenticate":
            self.authenticate(call: call, result: result)
        default:
            result(FlutterError(code: "UNSUPPORTED_OPERATION", message: "There exists no ios implementation for the \(call.method) method", details: nil))
        }
    }
    
    private let authManager = AuthenticationManager()
    
    private func authenticate(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String:Any] else {
            result(FlutterError(code: "ARGUMENT_ERROR", message: "Failed to parse method call args as dictionary", details: nil))
            return
        }
        guard let authUrl = args["authUri"] as? String else {
            result(FlutterError(code: "ARGUMENT_ERROR", message: "authUrl is required", details: nil))
            return
        }
        guard let urlObject = URL(string: authUrl) else {
            result(FlutterError(code: "ARGUMENT_ERROR", message: "authUrl muse be a valid URL", details: nil))
            return
        }
        guard let redirectUrlScheme = args["redirectUriScheme"] as? String else {
            result(FlutterError(code: "ARGUMENT_ERRRO", message: "redirectUrlScheme is required", details: nil))
            return
        }
        
        authManager.authenticate(url: urlObject, redirectUrlScheme: redirectUrlScheme) { authResult in
            switch authResult {
            case .ok(let redirectUrl):
                result(redirectUrl)
                return
            case .err(let error):
                result(FlutterError(code: "UNEXPECTED_ERROR", message: error.localizedDescription, details: nil))
                return
            }
        }
    }
}
