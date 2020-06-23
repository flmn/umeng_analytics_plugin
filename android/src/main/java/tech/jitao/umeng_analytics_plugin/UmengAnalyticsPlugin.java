package tech.jitao.umeng_analytics_plugin;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * UmengAnalyticsPlugin
 */
public class UmengAnalyticsPlugin implements FlutterPlugin {

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "jitao.tech/umeng_analytics_plugin");
        channel.setMethodCallHandler(new MethodCallHandlerImpl(registrar.context()));
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "jitao.tech/umeng_analytics_plugin");
        channel.setMethodCallHandler(new MethodCallHandlerImpl(flutterPluginBinding.getApplicationContext()));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}
