package com.appsbay.classic_2048

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.appsbay.classic_2048.R

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.appsbay.classic_2048/ads"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getAdUnitIds") {
                val bannerId = getString(R.string.admob_banner_id)
                val appOpenId = getString(R.string.admob_appopen_id)
                result.success(mapOf(
                    "banner" to bannerId,
                    "appOpen" to appOpenId
                ))
            } else {
                result.notImplemented()
            }
        }
    }
}
