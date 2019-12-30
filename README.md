# umeng_analytics_plugin

Flutter 版友盟统计插件。

公众号文章：[Flutter 集成友盟统计](https://mp.weixin.qq.com/s/2kkx09OhBO4bgclPqrVWNA)。

## 基础使用

代码可参考 example。

### 初始化

到 [https://www.umeng.com/] 申请 Android 和 iOS 的appKey。调用 init 方法初始化。

```
await UMengAnalyticsPlugin.init(
    androidKey: '5dfc5b91cb23d26df0000a90',
    iosKey: '5dfc5c034ca35748d1000c4c',
);
```

### 页面开始和结束
```
UMengAnalyticsPlugin.pageStart('page');
```

```
UMengAnalyticsPlugin.pageEnd('page');
```

### 自定义事件

```
UMengAnalyticsPlugin.event('event');
```

## 自动收集页面事件

这种方式只能收集 Navigator 的 push 和 pop 动作，程序自己控制的页面转换，需要手工处理。

### 使用 AppAnalysis 类监听导航

```
MaterialApp(
    ...
    onGenerateRoute: Router.generateRoute,
    navigatorObservers: [AppAnalysis()],
    ...
)
```

### AppAnalysis 类参考代码
```
class AppAnalysis extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {
      UMengAnalyticsPlugin.pageStart(route.settings.name);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {
      UMengAnalyticsPlugin.pageEnd(route.settings.name);
    }
  }
}
```

记得设置 route name，否则 route.settings.name 取出为空，例如：
```
MaterialPageRoute(
  settings: RouteSettings(name: RouteNames.XXX),
  builder: (context) => XxxView(),
);
```
