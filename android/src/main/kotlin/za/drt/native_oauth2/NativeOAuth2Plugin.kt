package za.drt.native_oauth2

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.browser.customtabs.CustomTabsIntent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.util.*
import kotlin.concurrent.schedule

/** NativeOAuth2Plugin */
class NativeOAuth2Plugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.NewIntentListener, PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    companion object {
        const val CHROME_CUSTOM_TABS_REQUEST_CODE = 100
    }

    private var redirectListener: ((redirectUrl: String) -> Unit)? = null
    private var cancelListener: (() -> Unit)? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "za.drt/native_oauth2")
        channel.setMethodCallHandler(this)

    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "authenticate" -> authenticate(call, result)
            else -> result.notImplemented()
        }
    }

    private fun authenticate(call: MethodCall, result: Result) {
        val launchUri = call.argument<String>("authUri")

        if (launchUri == null) {
            result.error("MISSING_ARGUMENT", "authUri argument is required", null)
            return
        }

        redirectListener = { redirectUrl ->
            result.success(redirectUrl)
            redirectListener = null
            cancelListener = null
        }
        cancelListener = {
            result.success(null)
            redirectListener = null
            cancelListener = null
        }

        displayCustomTab(launchUri)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onNewIntent(intent: Intent): Boolean {
        val redirectUri = intent.dataString
        if (redirectUri != null) {
            redirectListener?.invoke(redirectUri)
            return true
        }
        return false
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return when (requestCode) {
            CHROME_CUSTOM_TABS_REQUEST_CODE -> {
                Timer().schedule(1500) {
                    cancelListener?.invoke()
                }

                true
            }
            else -> false
        }
    }

    private fun displayCustomTab(uriString: String) {
        val intent = CustomTabsIntent.Builder().build()
        intent.intent.data = Uri.parse(uriString)
        activity.startActivityForResult(intent.intent, CHROME_CUSTOM_TABS_REQUEST_CODE)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addOnNewIntentListener(this)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        // Not implemented
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        // Not implemented
    }

    override fun onDetachedFromActivity() {
        // Not implemented
    }
}
