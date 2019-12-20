package tech.jitao.umeng_analytics_plugin;

import android.content.Context;

import com.umeng.analytics.MobclickAgent;
import com.umeng.commonsdk.UMConfigure;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MethodCallHandlerImpl implements MethodChannel.MethodCallHandler {
    private final MethodChannel channel;
    private final Context context;

    MethodCallHandlerImpl(MethodChannel channel, Context context) {
        this.channel = channel;
        this.context = context;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "init":
                init(call, result);
                break;
            case "onPageStart":
                onPageStart(call, result);
                break;
            case "onPageEnd":
                onPageEnd(call, result);
                break;
            case "onEvent":
                onEvent(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void init(MethodCall call, MethodChannel.Result result) {
        final String androidKey = call.argument("androidKey");
        final String channel = call.argument("channel");

        Boolean logEnabled = call.argument("logEnabled");
        if (logEnabled == null) {
            logEnabled = false;
        }

        Boolean encryptEnabled = call.argument("encryptEnabled");
        if (encryptEnabled == null) {
            encryptEnabled = false;
        }

        Integer sessionContinueMillis = call.argument("sessionContinueMillis");
        if (sessionContinueMillis == null) {
            sessionContinueMillis = 30000;
        }

        Boolean catchUncaughtExceptions = call.argument("catchUncaughtExceptions");
        if (catchUncaughtExceptions == null) {
            catchUncaughtExceptions = true;
        }

        String pageCollectionMode = call.argument("pageCollectionMode");

        UMConfigure.setLogEnabled(logEnabled);
        UMConfigure.init(context, androidKey, channel, UMConfigure.DEVICE_TYPE_PHONE, null);
        UMConfigure.setEncryptEnabled(encryptEnabled);

        MobclickAgent.setSessionContinueMillis(sessionContinueMillis);
        MobclickAgent.setCatchUncaughtExceptions(catchUncaughtExceptions);

        if ("MANUAL".equals(pageCollectionMode)) {
            MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.MANUAL);
        } else {
            MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.AUTO);
        }

        result.success(true);
    }

    private void onPageStart(MethodCall call, MethodChannel.Result result) {
        final String viewName = call.argument("viewName");

        MobclickAgent.onPageStart(viewName);

        result.success(null);
    }

    private void onPageEnd(MethodCall call, MethodChannel.Result result) {
        final String viewName = call.argument("viewName");

        MobclickAgent.onPageEnd(viewName);

        result.success(null);
    }

    private void onEvent(MethodCall call, MethodChannel.Result result) {
        final String eventId = call.argument("eventId");
        final String label = call.argument("label");

        MobclickAgent.onEvent(context, eventId, label);

        result.success(null);
    }
}
