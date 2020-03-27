#import "UMMobClick/MobClick.h"
#import "UmengAnalyticsPlugin.h"

@implementation UmengAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"jitao.tech/umeng_analytics_plugin"
                                     binaryMessenger:[registrar messenger]];
    UmengAnalyticsPlugin* instance = [[UmengAnalyticsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"init" isEqualToString:call.method]) {
        [self init:call result:result];
    } else if ([@"pageStart" isEqualToString:call.method]) {
        [self pageStart:call result:result];
    } else if ([@"pageEnd" isEqualToString:call.method]) {
        [self pageEnd:call result:result];
    } else if ([@"event" isEqualToString:call.method]) {
        [self event:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result {
    UMConfigInstance.appKey = call.arguments[@"iosKey"];
    UMConfigInstance.channelId = call.arguments[@"channel"];
    UMConfigInstance.bCrashReportEnabled = call.arguments[@"catchUncaughtExceptions"];
    [MobClick startWithConfigure:UMConfigInstance];
    
    [MobClick setLogEnabled:call.arguments[@"logEnabled"]];
    [MobClick setEncryptEnabled:call.arguments[@"encryptEnabled"]];
    [MobClick setLogSendInterval:[call.arguments[@"sessionContinueMillis"] doubleValue]];
    
    result([NSNumber numberWithBool:YES]);
}

- (void)pageStart:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* viewName = call.arguments[@"viewName"];
    
    [MobClick beginLogPageView:viewName];
    
    result([NSNumber numberWithBool:YES]);
}

- (void)pageEnd:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* viewName = call.arguments[@"viewName"];
    
    [MobClick endLogPageView:viewName];
    
    result([NSNumber numberWithBool:YES]);
}

- (void)event:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* eventId = call.arguments[@"eventId"];
    NSString* label = call.arguments[@"label"];
    
    if (label == nil) {
        [MobClick event:eventId];
    } else {
        [MobClick event:eventId label:label];
    }
    
    result([NSNumber numberWithBool:YES]);
}

@end
