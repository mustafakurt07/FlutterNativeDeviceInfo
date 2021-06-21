package com.example.flutter_projects
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter/device_info" // Unique Channel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
                call, result ->
            if (call.method == "getDeviceInfo") {
                val deviceInfo: HashMap<String, String> = getDeviceInfo()
                if (deviceInfo.isNotEmpty()) {
                    result.success(deviceInfo)
                } else {
                    result.error("UNAVAILABLE", "Device info not available.", null)
                }
            } else {
                result.notImplemented()
            }

        }
    }

    private fun getDeviceInfo(): HashMap<String, String> {
        val deviceInfo = HashMap<String, String>()
        deviceInfo["version"] = System.getProperty("os.version").toString() // OS version
        deviceInfo["device"] = android.os.Build.DEVICE           // Device
        deviceInfo["model"] = android.os.Build.MODEL            // Model
        deviceInfo["product"] = android.os.Build.PRODUCT          // Product
        return deviceInfo
    }
}
