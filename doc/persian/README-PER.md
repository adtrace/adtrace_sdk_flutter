
<div dir="rtl" align='right'>فارسی | <a href="../../README.md">English</a></div>


<p align="center"><a href="https://adtrace.io" target="_blank" rel="noopener noreferrer"><img width="100" src="https://adtrace.io/fa/wp-content/uploads/2020/09/cropped-logo-sign-07-1.png" alt="Adtrace logo"></a></p>

<p align="center">
  <a href='https://pub.dev/packages/adtrace_sdk'><img src='https://img.shields.io/badge/pub-0.1.3-blue.svg'></a>
  <a href='https://opensource.org/licenses/MIT'><img src='https://img.shields.io/badge/License-MIT-green.svg'></a>
</p>

## <div dir="rtl" align='right'>خلاصه</div>

<div dir="rtl" align='right'>
SDK فلاتر ادتریس. شما برای اطلاعات بیشتر میتوانید به <a href="adtrace.io">adtrace.io</a>  مراجعه کنید.
</div>

## <div dir="rtl" align='right'>فهرست محتوا</div>

### <div dir="rtl" align='right'>پیاده سازی فوری</div>

<div dir="rtl" align='right'>
<ul>
  <li><a href="#qs-example-app">برنامه نمونه</a></li>
  <li><a href="#qs-getting-started">شروع پیاده سازی</a></li>
    <ul>
      <li><a href="#qs-sdk-add">افزودن SDK به پروژه</a></li>
      <li><a href="#qs-adtrace-project-settings">تنظیمات پیاده سازی</a></li>
      <ul>
        <li><a href="#qs-android-permissions">مجوزهای اندروید</a></li>
        <li><a href="#qs-android-gps">سرویس های گوگل پلی</a></li>
        <li><a href="#qs-android-proguard">تنظیمات Proguard</a></li>
        <li><a href="#qs-android-referrer">تنظیمات Install referrer</a></li>
          <ul>
                  <li><a href="#qs-android-referrer-gpr-api">Google Play Referrer API</a></li>
                  <li><a href="#qs-android-referrer-gps-intent">Google Play Store intent</a></li>
          </ul>
      </ul>
    </ul>
  <li><a href="#qs-integ-sdk">پیاده سازی SDK داخل برنامه</a></li>
  <ul>
    <li><a href="#qs-basic-setup">راه اندازی اولیه</a></li>
    <li><a href="#qs-session-tracking">ردیابی نشست</a></li>
    <ul>
      <li><a href="#qs-session-tracking-android">ردیابی نشست در اندروید</a></li>
    </ul>
      <li><a href="#qs-signature">امضا SDK</a></li>                 
      <li><a href="#qs-adtrace-logging">لاگ ادتریس</a></li>
      <li><a href="#qs-build-the-app">ساخت برنامه</a></li>
  </ul>
  </ul>
</div>

### <div dir="rtl" align='right'>لینک دهی عمیق</div>

<div dir="rtl" align='right'>
<ul>
  <li><a href="#dl-overview">نمای کلی لینک دهی عمیق</a></li>                  
  <li><a href="#dl-standard">سناریو لینک دهی عمیق استاندار</a></li>
  <li><a href="#dl-deferred">سناریو لینک دهی عمیق به تعویق افتاده</a></li>
  <li><a href="#dl-app-android">بکارگیری لینک دهی عمیق در اندروید</a></li>
  <li><a href="#dl-app-ios">بکارگیری لینک دهی عمیق در iOS</a></li>
  <li><a href="#dl-reattribution">اتریبیوت مجدد از طریق لینک عمیق</a></li>
</ul>
</div>

### <div dir="rtl" align='right'>ردیابی رویداد</div>

<div dir="rtl" align='right'>
<ul>
  <li><a href="#et-track-event">ردیابی رویداد معمولی</a></li>                 
  <li><a href="#et-track-revenue">ردیابی رویداد درآمدی</a></li>
  <li><a href="#et-revenue-deduplication">جلوگیری از تکرار رویداد درآمدی</a></li>
</ul>
</div>

### <div dir="rtl" align='right'>پارامترهای سفارشی</div>

<div dir="rtl" align='right'>
<ul>
  <li><a href="#cp-overview">نمای کلی پارامترهای سفارشی</a></li>
  <li><a href="#cp-ep">پارامترهای رویداد</a>
    <ul>
      <li><a href="#cp-ep-callback">پارامترهای callback رویداد</a></li>                 
      <li><a href="#cp-ep-partner">پارامترهای partner رویداد</a></li>
      <li><a href="#cp-ep-id">شناسه callback رویداد</a></li>
      <li><a href="#cp-ep-value">مقدار رویداد</a></li>
    </ul>
  </li>                 
  <li><a href="#cp-sp" >پارامترهای نشست</a>
    <ul>
      <li><a href="#cp-sp-callback">پارامترهای callback نشست</a></li>                 
      <li><a href="#cp-sp-partner">پارامترهای partner نشست</a></li>
      <li><a href="#cp-sp-delay-start">شروع با تاخیر</a></li>
    </ul>
  </li>
</ul>
</div>

### <div dir="rtl" align='right'>ویژگی های بیشتر</div>

<div dir="rtl" align='right'>
<ul>
  <li><a href="#af-push-token">توکن push (ردیابی تعداد حذف برنامه)</a></li> 
  <li><a href="#af-attribution-callback">callback اتریبیوشن</a></li>
  <li><a href="#af-session-event-callbacks">callback های رویداد و نشست</a></li>
  <li><a href="#af-user-attribution">اتریبیوشن کاربر</a></li>                 
  <li><a href="#af-send-installed-apps">ارسال برنامه های نصب شده دستگاه</a></li>                  
  <li><a href="#af-di">شناسه های دستگاه</a>
    <ul>
      <li><a href="#af-di-idfa">شناسه تبلیغات iOS</a></li>
      <li><a href="#af-di-gps-adid">شناسه تبلیغات سرویس های گوگل پلی</a></li>                 
      <li><a href="#af-di-amz-adid">شناسه تبلیغات آمازون</a></li>
      <li><a href="#af-di-adid">شناسه دستگاه ادتریس</a></li>
    </ul>
  </li>                 
  <li><a href="#af-pre-installed-trackers">ردیابی قبل از نصب</a></li>                 
  <li><a href="#af-offline-mode">حالت آفلاین</a></li>                 
  <li><a href="#af-disable-tracking">غیرفعال کردن ردیابی</a></li>                 
  <li><a href="#af-event-buffering">بافرکردن رویدادها</a></li>                  
  <li><a href="#af-background-tracking">ردیابی در پس زمینه</a></li>                 
  <li><a href="#af-gdpr-forget-me">GPDR</a></li>                  
</ul>
</div>

## <div dir="rtl" align='right'>پیاده سازی فوری</div>

### <div id="qs-example-app" dir="rtl" align='right'>برنامه نمونه</div>

<div dir="rtl" align='right'>
درون <a href="/example">پوشه <code>نمونه</code></a> یک برنامه فلاتر نمونه وجود دارد که میتوانید بررسی کنید SDK ادتریس چگونه پیاده سازی شده است.
</div>

### <div id="qs-getting-started" dir="rtl" align='right'>شروع پیاده سازی</div>

<div dir="rtl" align='right'>
برای پیاده سازی SDK ادتریس قدم به قدم مراحل زیر را دنبال کنید.
</div>

### <div id="qs-sdk-add" dir="rtl" align='right'>افزودن SDK به پروژه</div>

<div dir="rtl" align='right'>
شما از طریق فایل <code>pubspec.yaml</code> میتوانید SDK ادتریس را اضافه نمایید:
</div>
<br/>

```yaml
dependencies:
  adtrace_sdk: ^0.1.3
```

<br/>
<div dir="rtl" align='right'>
سپس به ترمینال رفته و خط زیر را اجرا کنید:
</div>
<br/>

```
flutter packages get
```

### <div id="qs-adtrace-project-settings" dir="rtl" align='right'>تنظیمات پیاده سازی</div>

<div dir="rtl" align='right'>
هنگامی که SDK ادتریس را به برنامه خود اضافه کردید، مواردی دیگر لازم است تا ادتریس به درستی کار کند که در زیر به این موارد میپردازیم.
</div>

### <div id="qs-android-permissions" dir="rtl" align='right'>مجوزهای اندروید</div>

<div dir="rtl" align='right'>
در ادامه دسترسی های زیر را در فایل <code>AndroidManifest.xml</code> خود اضافه کنید:
</div>
<br/>

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

<br/>
<div dir="rtl" align='right'>
اگر استور مدنظر شما <strong>به جز گوگل پلی</strong> باشد دسترسی زیر را اضافه کنید:
</div>
<br/>

```xml
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
```

### <div id="qs-android-gps" dir="rtl" align='right'>سرویس های گوگل پلی</div>

<div dir="rtl" align='right'>
از تاریخ 1 آگوست 2014، برنامه های داخل گوگل پلی بایستی از <a href="https://support.google.com/googleplay/android-developer/answer/6048248?hl=en">شناسه تبلیغاتی گوگل</a> برای شناسایی یکتابودن دستگاه استفاده کنند. برای فعالسازی امکان استفاده از این شناسه خط زیر را به <code>dependencies</code> فایل <code>build.gradle</code> خود اضافه کنید:
</div>
<br/>

```gradle
implementation 'com.google.android.gms:play-services-ads-identifier:17.0.0'
```

<br/>
<div dir="rtl" align='right'>
<strong>نکته: </strong> SDK ادتریس محصور به استفاده از ورژن خاصی از <code>play-services-ads-identifier</code> گوگل پلی نیست. بنابراین استفاده از آخرین نسخه این کتابخانه برای ادتریس مشکلی ایجاد نمیکند.
</div>

### <div id="qs-android-proguard" dir="rtl" align='right'>تنظیمات Proguard</div>

<div dir="rtl" align='right'>
اگر از Progaurd استفاده میکنید، دستورهای زیر را در فایل Progaurd خود اضافه کنید:
</div>
<br/>

```
-keep public class io.adtrace.sdk.** { *; }
-keep class com.google.android.gms.common.ConnectionResult {
    int SUCCESS;
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {
    com.google.android.gms.ads.identifier.AdvertisingIdClient$Info getAdvertisingIdInfo(android.content.Context);
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {
    java.lang.String getId();
    boolean isLimitAdTrackingEnabled();
}
-keep public class com.android.installreferrer.** { *; }
```

<br/>
<div dir="rtl" align='right'>
اگر استور مد نظر شما <strong>گوگل پلی نمیباشد</strong>، فقط میتوانید قوانین پکیج <code>io.adtrace.sdk</code> را اضافه نمایید:
</div>
<br/>

```
-keep public class io.adtrace.sdk.** { *; }
```

### <div id="qs-android-referrer" dir="rtl" align='right'>تنظیمات Install referrer</div>

<div dir="rtl" align='right'>
برای آنکه به درستی نصب یک برنامه به سورس خودش اتریبیوت شود، ادتریس به اطلاعاتی درمورد <strong>install referrer</strong> نیاز دارد. این مورد با استفاده از <strong>Google Play Referrer API</strong> یا توسط <strong>Google Play Store intent</strong> بواسطه یک broadcast receiver دریافت میشود.
</div>
<br/>
<div dir="rtl" align='right'>
<strong>نکته مهم:</strong> Google Play Referrer API جدیدا راه حلی قابل اعتمادتر و با امنیت بیشتر برای جلو گیری از تقلب click injection  توسط گوگل  جدیدا معرفی شده است. <strong>به صورت اکید</strong> توصیه میشود که از این مورد در برنامه های خود استفاده کنید. Google Play Store intent امنیت کمتری در این مورد دارد و در آینده deprecate خواهد شد.
</div>

#### <div id="qs-android-referrer-gpr-api" dir="rtl" align='right'>Google Play Referrer API</div>

<div dir="rtl" align='right'>
به منظور استفاده از این کتابخانه خط زیر را در قسمت <code>build.gradle</code> برنامه خود اضافه کنید:
</div>
<br/>

```gradle
implementation 'com.android.installreferrer:installreferrer:1.1.2'
```

<br/>
<div dir="rtl" align='right'>
همچنین مطمئن شوید که درصورت داشتن Progaurd، بخش <a href="qs-proguard-settings">تنظیمات Progaurd</a> به صورت کامل اضافه شده است، مخصوصا دستور زیر:
</div>
<br/>

```
-keep public class com.android.installreferrer.** { *; }
```

#### <div id="qs-android-referrer-gps-intent" dir="rtl" align='right'>Google Play Store intent</div>

<div dir="rtl" align='right'>
گوگل طی <a href="https://android-developers.googleblog.com/2019/11/still-using-installbroadcast-switch-to.html">بیانیه ای</a> اعلام کرد که از 1 مارچ 2020 دیگر اطلاعات <code>INSTALL_REFERRER</code> را به صورت broadcast ارسال نمیکند، برای همین به رویکرد <a href="#qs-ir-gpr-api">Google Play Referrer API</a> مراجعه کنید.
</div>
<br/>
<div dir="rtl" align='right'>
شما بایستی اطلاعات <code>INSTALL_REFERRER</code> گوگل پلی را توسط یک broadcast receiver دریافت کنید. اگر از <strong>broadcast receiver خود</strong> استفاده نمیکنید، تگ <code>receiver</code> را داخل تگ <code>application</code> درون فایل <code>AndroidManifest.xml</code> خود اضافه کنید:
</div>
<br/>

```xml
<receiver
    android:name="io.adtrace.sdk.AdTraceReferrerReceiver"
    android:permission="android.permission.INSTALL_PACKAGES"
    android:exported="true" >
    <intent-filter>
        <action android:name="com.android.vending.INSTALL_REFERRER" />
    </intent-filter>
</receiver>
```

<br/>
<div dir="rtl" align='right'>
اگر قبلا از یک broadcast receiver برای دریافت اطلاعات <code>INSTALL_REFERRER</code> استفاده میکرده اید، از <a href="https://github.com/adtrace/adtrace_sdk_android/blob/master/doc/english/multiple-receivers.md">این دستورالعمل</a>  برای اضافه نمودن broadcast receiver ادتریس استفاده کنید.
</div>

### <div id="qs-integ-sdk" dir="rtl" align='right'>پیاده سازی SDK داخل برنامه</div>

<div dir="rtl" align='right'>
ابتدا ردیابی یک نشست ساده را پیاده سازی میکنیم.
</div>

### <div id="qs-basic-setup" dir="rtl" align='right'>راه اندازی اولیه</div>

<div dir="rtl" align='right'>
از راه اندازی اولیه SDK ادتریس هرچه زودتر در اپ فلاتر خود اطمینان پیدا کنید (بر روی اولین widget برنامه). شما میتوانید به صورت زیر SDK را راه  اندازی کنید:
</div>
<br/>

```dart
AdTraceConfig config = new AdTraceConfig('{YourAppToken}', AdTraceEnvironment.sandbox);
AdTrace.start(config);
```

<br/>
<div dir="rtl" align='right'>
مقدار <code>{YourAppToken}</code> را با توکن اپ خود جایگزین نمایید. این مقدار را درون پنل ادتریس خود میتوانید مشاهده کنید.
</div>
<br/>
<div dir="rtl" align='right'>
وابسته به نوع خروجی اپ شما که درحالت تست یا تجاری میباشد، بایستی مقدار <code>environment</code> را یکی از مقادیر زیر انتخاب نمایید:
</div>
<br/>

```dart
AdTraceEnvironment.sandbox;
AdTraceEnvironment.production;
```

<br/>
<div dir="rtl" align='right'>
<strong>نکته:</strong> این مقدار تنها در زمان تست برنامه شما بایستی مقدار <code> AdTraceConfig.EnvironmentSandbox</code> قرار بگیرد. این پارامتر را به <code>AdTraceConfig.EnvironmentProduction</code> قبل از انتشار برنامه خود تغییر دهید.
</div>
<br/>
<div dir="rtl" align='right'>
ادتریس enviroment را برای تفکیک ترافیک داده واقعی و آزمایشی بکار میبرد.
</div>

### <div id="qs-session-tracking" dir="rtl" align='right'>ردیابی نشست</div>

<div dir="rtl" align='right'>
<strong>نکته مهم:</strong> این مرحله <strong>اهمیت بالایی</strong> دارد و از <strong>پیاده سازی آن  مطمئن شوید.</strong>
</div>
<br/>
<div dir="rtl" align='right'>
ردیابی نشست در پلتفرم iOS به طور خود به خود قابل پشتیبانی میباشد، اما برای پلتفرم اندروید  نیاز به یک سری کار اضافی میباشد که در ادامه به این خواهیم پرداخت.
</div>

### <div id="qs-session-tracking-android" dir="rtl" align='right'>ردیابی نشست در اندروید</div>

<div dir="rtl" align='right'>
در پلتفرم اندروید نیاز است تا lifecycle های Activity برنامه تان را درنظر بگیرید، به صورتی که متد <code>()AdTrace.onResume</code> هنگامی که وارد forground برنامه و متد <code>()AdTrace.onPause</code> هنگامی که اپ در پس زمینه درحال اجراست بایستی فراخوانی شوند. شما برای این کار میتوانید به صورت کلی (global) و یا برای هر widget اصلی برنامه خود (این متد را در بالای هر widget اصلی فراخوانی کنید) . به عنوان نمونه داریم:
</div>
<br/>

```dart
class AdTraceExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AdTrace Flutter Example App',
      home: new MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState(); // <-- Initialize SDK in here.
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.resumed:
          AdTrace.onResume();
          break;
        case AppLifecycleState.paused:
          AdTrace.onPause();
          break;
        case AppLifecycleState.suspending:
          break;
      }
    });
  }
}
```

### <div id="qs-signature" dir="rtl" align='right'>امضا SDK</div>

<div dir="rtl" align='right'>
اگر امضا SDK فعال شده است، از متد زیر برای پیاده سازی استفاده کنید:
</div>
<br/>
<div dir="rtl" align='right'>
یک App Secret توسط متد <code>setAppSecret</code> داخل <code>AdTraceConfig</code> فراخوانی میشود:
</div>
<br/>

```dart
AdTraceConfig adTraceConfig = new AdTraceConfig(yourAppToken, environment);
AdTraceConfig.setAppSecret(secretId, info1, info2, info3, info4);
AdTrace.start(adTraceConfig);
```

### <div id="qs-adtrace-logging" dir="rtl" align='right'>لاگ ادتریس</div>

<div dir="rtl" align='right'>
شما میتوانید در حین تست لاگ ادتریس را از طریق <code>logLevel</code> که در <code>AdTraceConfig</code> قرار دارد کنترل کنید:
</div>
<br/>

```dart
adTraceConfig.logLevel = AdTraceLogLevel.verbose; // enable all logs
adTraceConfig.logLevel = AdTraceLogLevel.debug; // disable verbose logs
adTraceConfig.logLevel = AdTraceLogLevel.info; // disable debug logs (default)
adTraceConfig.logLevel = AdTraceLogLevel.warn; // disable info logs
adTraceConfig.logLevel = AdTraceLogLevel.error; // disable warning logs
adTraceConfig.logLevel = AdTraceLogLevel.suppress; // disable all logs
```

### <div id="qs-build-the-app" dir="rtl" align='right'>ساخت برنامه</div>

<div dir="rtl" align='right'>
برنامه فلاتر خود را بیلد گرفته و اجرا نمایید. در لاگ مربوط به اندروید یا iOS میتوانید لاگ های دریافتی از SDK ادتریس را مشاهده نمایید.
</div>

## <div dir="rtl" align='right'>لینک دهی عمیق</div>

### <div id="dl-overview" dir="rtl" align='right'>نمای کلی لینک دهی عمیق</div>

<div dir="rtl" align='right'>
اگر از url ادتریس با تنظیمات deep link برای ترک کردن استفاده میکنید، امکان دریافت اطلاعات و محتوا دیپ لینک از طریق ادتریس فراهم میباشد. با کلیک کردن لینک کاربر ممکن است که قبلا برنامه را داشته باشد(سناریو لینک دهی عمیق استاندارد) یا اگر برنامه را نصب نداشته باشد(سناریو لینک دهی عمیق به تعویق افتاده) به کار برده شود. 
</div>
<br/>
<div dir="rtl" align='right'>
در <strong>سطح نیتیو</strong> لینک دهی عمیق بایستی انجام شود که این کار در پروژه Xcode برای iOS و درون Android Studio برای اندروید بکارگرفته میشود.
</div>

### <div id="dl-standard" dir="rtl" align='right'>سناریو لینک دهی عمیق استاندار</div>

<div dir="rtl" align='right'>
اطلاعات درباره لینک دهی عمیق استاندار امکان ارسال به کد Dart در فلاتر نمیباشد. هنگامی که شما لینک دهی عمیق را در برنامه خود فعالسازی میکنید، امکان دریافت اطلاعات را در سطح نیتیو دارید. برای اطلاعات بیشتر برای فعالسازی لینک دهی عمیق میتوانید به قسمت <a href="dl-app-android">اندروید</a> و یا <a href="#dl-app-ios">iOS</a> مراجعه کنید.
</div>

### <div id="dl-deferred" dir="rtl" align='right'>سناریو لینک دهی عمیق به تعویق افتاده</div>

<div dir="rtl" align='right'>
برای آنکه در این سناریو اطلاعات محتوای آدرس را بدست آورید نیاز به ایجاد یک متد به صورت callback در <code>AdTraceConfig</code> دارید که اطلاعات URL به دست شما خواهد رسید. شما از طریق عضو <code>deferredDeeplinkCallback</code> میتوانید متد خودتان را فراخوانی کنید:
</div>
<br/>

```dart
AdTraceConfig adTraceConfig = new AdTraceConfig(yourAppToken, environment);
adTraceConfig.deferredDeeplinkCallback = (String uri) {
  print('[AdTrace]: Received deferred deeplink: ' + uri);
};
AdTrace.start(adTraceConfig);
```

<br/>
<div dir="rtl" align='right'>
در این سناریو به تعویق افتاده، یک مورد اضافی بایستی به تنظیمات اضافه شود. هنگامی که SDK ادتریس اطاعات دیپ لینک را دریافت کرد، شما امکان این را دارید که SDK، با استفاده از این اطلاعات باز شود یا خیر که از طریق  عضو <code>launchDeferredDeeplink</code> قابل استفاده است:
</div>
<br/>

```dart
AdTraceConfig adTraceConfig = new AdTraceConfig(yourAppToken, environment);
adTraceConfig.launchDeferredDeeplink = true;
adTraceConfig.deferredDeeplinkCallback = (String uri) {
  print('[AdTrace]: Received deferred deeplink: ' + uri);
};
AdTrace.start(adTraceConfig);
```

<br/>
<div dir="rtl" align='right'>
توجه فرمایید که اگر کالبکی تنظیم نشود، <strong>SDK ادتدریس در حالت پیشفرض تلاش میکند تا URL را اجرا کند</strong>.
</div>
<br/>
<div dir="rtl" align='right'>
برای فعالسازی اینکه اپ شما لینک دهی عمیق را پشتیبانی میکند، برای هر پلتفرم بایستی scheme ای تنظیم شود.
</div>

### <div id="dl-app-android" dir="rtl" align='right'>بکارگیری لینک دهی عمیق در اندروید</div>

<div dir="rtl" align='right'>
برای تنظیم لینک دهی عمیق در اندروید میتوانید از راهنمایی <a href="https://github.com/adtrace/adtrace_sdk_android#deep-linking">SDK اندروید</a> استفاده کنید. این کار در محیط Android Studio انجام میشود.
</div>

### <div id="dl-app-ios" dir="rtl" align='right'>بکارگیری لینک دهی عمیق در iOS</div>

<div dir="rtl" align='right'>
برای تنظیم لینک دهی عمیق در iOS میتوانید از راهنمایی <a href="https://github.com/adtrace/adtrace_sdk_ios#deep-linking">iOS SDK</a> استفاده کنید. این کار در محیط Xcode انجام میشود.
</div>

### <div id="dl-reattribution" dir="rtl" align='right'>اتریبیوت مجدد از طریق لینک عمیق</div>

<div dir="rtl" align='right'>
اگر شما از این ویژگی استفاده میکنید، برای اینکه کاربر به درستی مجددا اتریبیوت شود، نیاز دارید یک دستور اضافی به برنامه خود اضافه کنید.
</div>
<br/>
<div dir="rtl" align='right'>
هنگامی که اطلاعات دیپ لینک را دریافت میکنید، متد <code>AdTrace.appWillOpenUrl(Uri, Context)</code>  را فراخوانی کنید. از طریق این SDK تلاش میکند تا ببیند اطلاعات جدیدی درون دیپ لینک برای اتریبیوت کردن قرار دارد یا خیر. اگر وجود داشت، این اطلاعات به سرور ارسال میشود.  اگر کاربر از طریق کلیک بر ترکر ادتریس مجددا اتریبیوت شود، میتوانید از قسمت <a href="#af-attribution-callback">اتریبیوشن کالبک</a> اطلاعات جدید را برای این کاربر دریافت کنید.
</div>
<br/>
<div dir="rtl" align='right'>
فراخوانی متد <code>AdTrace.appWillOpenUrl(Uri, Context)</code> بایستی مثل زیر باشد:
</div>
<br/>

```dart
import io.adtrace.sdk.flutter.AdTraceSdk;

public class MainActivity extends FlutterActivity {
    // Either call make the call in onCreate.
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        Intent intent = getIntent();
        Uri data = intent.getData();
        AdTraceSdk.appWillOpenUrl(data, this);
    }

    // Or make the cakll in onNewIntent.
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Uri data = intent.getData();
        AdTraceSdk.appWillOpenUrl(data, this);
    }
}
```

<div dir="rtl" align='right'>
بستگی به مقدار <code>android:launchMode</code> درون Activity اندروید که در فایل <code>AndroidManifest.xml</code> قابل دسترسی است، اطلاعات <code>deep_link</code> به محل مناسبی از Activity ارسال خواهد شد. برای اطلاعات بیشتر درمورد مقادیر <code>android:launchMode</code> میتوانید به <a href="">مستندات رسمی اندروید</a> مراجعه کنید.
</div>

<div dir="rtl" align='right'>
در دو محل داخل Activity مورد نظر اطلاعات و محتوای دیپ لینک شما ارسال خواهد شد، از طریق یک شی<code>Intent</code> درون متد <code>onCreate</code> و یا <code>onNewIntent</code> قابل دسترسی میباشد. هنگامی که برنامه شما شروع به آغاز کند، یکی از این متدها شروع به کار گیری میشود و شما قادر خواهید بود این لینک را که توسط پارامتر <code>deep_link</code> پاس داده شده است، دریافت نمایید.
</div>
<br/>
<div dir="rtl" align='right'>
هنگامی که همه چیز راه اندازی شد، متد <code>appWillOpenUrl</code> به صورت زیر فراخوانی باید بشود:
</div>
<br/>

```objc
#import "AdTrace.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [AdTrace appWillOpenUrl:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    if ([[userActivity activityType] isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        [AdTrace appWillOpenUrl:[userActivity webpageURL]];
    }
    return YES;
}

@end
```

## <div dir="rtl" align='right'>ردیابی رویداد</div>

### <div id="et-track-event" dir="rtl" align='right'>ردیابی رویداد معمولی</div>

<div dir="rtl" align='right'>
شما برای یک رویداد میتوانید از انواع رویدادها درون برنامه خود استفاده کنید. فرض کنید که میخواهید لمس یک دکمه را رصد کنید. بایستی ابتدا یک رویداد درون پنل خود ایجاد کنید. اگر فرض کنیم که توکن رویداد شما <code>abc123</code> باشد، سپس در قسمت کلیک کردن دکمه مربوطه کد زیر را برای ردیابی لمس دکمه اضافه کنید:
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
AdTrace.trackEvent(adTraceEvent);
```

### <div id="et-track-revenue" dir="rtl" align='right'>ردیابی رویداد درآمدی</div>

<div dir="rtl" align='right'>
اگر کاربران شما از طریق کلیک بر روی تبلیغات یا پرداخت درون برنامه ای، رویدادی میتوانند ایجاد کنند، شما میتوانید آن درآمد را از طریق رویدادی مشخص رصد کنید. اگر فرض کنیم که یک ضربه به ارزش یک سنت از واحد یورو باشد، کد شما برای ردیابی این رویداد به صورت زیر میباشد:
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
adTraceEvent.setRevenue(0.01, 'EUR');
AdTrace.trackEvent(adTraceEvent);
```

<br/>
<div dir="rtl" align='right'>
این ویژگی میتواند با پارامترهای callback نیز ترکیب شود.
</div>
<br/>
<div dir="rtl" align='right'>
هنگامی که واحد پول را تنظیم کردید، ادتریس به صورت خودکار درآمدهای ورودی را به صورت خودکار به انتخاب شما تبدیل میکند.
</div>

### <div id="et-revenue-deduplication" dir="rtl" align='right'>جلوگیری از تکرار رویداد درآمدی</div>

<div dir="rtl" align='right'>
شما میتوانید یک شناسه خرید مخصوص برای جلوگیری از تکرار رویداد درآمدی استفاده کنید. 10 شناسه آخر ذخیره میشود و درآمدهای رویدادهایی که شناسه خرید تکراری دارند درنظر گرفته نمیشوند. این برای موارد خریددرون برنامه ای بسیار کاربرد دارد. به مثال زیر توجه کنید.
</div>
<br/>
<div dir="rtl" align='right'>
اگر میخواهید پرداخت درون برنامه ای ها را رصد کنید، فراخوانی متد <code>trackEvent</code> را زمانی انجام دهید که خرید انجام شده است و محصول خریداری شده است. بدین صورت شما از تکرار رویداد درآمدی جلوگیری کرده اید.
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
adTraceEvent.transactionId = '{TransactionId}';
AdTrace.trackEvent(adTraceEvent);
```

## <div dir="rtl" align='right'>پارامترهای سفارشی</div>

### <div id="cp-overview" dir="rtl" align='right'>نمای کلی پارامترهای سفارشی</div>

<div dir="rtl" align='right'>
علاوه بر داده هایی که SDK ادتریس به صورت خودکار جمع آوری میکند، شما از ادتریس میتوانید مقدارهای سفارشی زیادی را با توجه به نیاز خود (شناسه کاربر، شناسه محصول و ...) به رویداد یا نشست خود اضافه کنید. پارامترهای سفارشی تنها به صورت خام و export شده قابل دسترسی میباشد و در پنل ادتریس قابل نمایش <strong>نمیباشد</strong>.</div> 
<br/>
<div dir="rtl" align='right'>
شما از <strong>پارامترهای callback</strong> برای استفاده داخلی خود بکار میبرید و از <strong>پارامترهای partner</strong> برای به اشتراک گذاری به شریکان خارج از برنامه استفاده میکنید. اگر یک مقدار (مثل شناسه محصول) برای خود و شریکان خارجی استفاده میشود، ما پیشنهاد میکنیم که از هر دو پارامتر partner و callback استفاده کنید.
</div>

### <div id="cp-ep" dir="rtl" align='right'>پارامترهای رویداد</div>

### <div id="cp-ep-callback" dir="rtl" align='right'>پارامترهای callback رویداد</div>

<div dir="rtl" align='right'>
شما میتوانید یک آدرس callback برای رویداد خود داخل پنل اضافه کنید. ادرتیس یک درخواست GET به آن آدرسی که اضافه نموده اید، ارسال خواهد کرد. همچنین پارامترهای callback برای آن رویداد را از طریق متد <code>addCallbackParameter</code> برای آن رویداد قبل از ترک آن استفاده کنید. ما این پارامترها را به آخر آدرس callback شما اضافه خواهیم کرد.
</div>
<br/>
<div dir="rtl" align='right'>
به عنوان مثال اگر شما آدرس <code>http://www.example.com/callback</code> را به رویداد خود اضافه نموده اید، ردیابی رویداد به صورت زیر خواهد بود:
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
adTraceEvent.addCallbackParameter('key', 'value');
adTraceEvent.addCallbackParameter('foo', 'bar');
AdTrace.trackEvent(adTraceEvent);
```

<br/>
<div dir="rtl" align='right'>
در اینصورت ما رویداد شما را رصد خواهیم کرد و یک درخواست به صورت زیر ارسال خواهیم کرد:
</div>
<br/>

```
http://www.example.com/callback?key=value&foo=bar
```

### <div id="cp-ep-partner" dir="rtl" align='right'>پارامترهای partner رویداد</div>

<div dir="rtl" align='right'>
شما همچنین پارامترهایی را برای شریکان خود تنظیم کنید که درون پنل ادتریس فعالسازی میشود.
</div>
<br/>
<div dir="rtl" align='right'>
این پارامترها به صورت callback که در بالا مشاهده میکنید استفاده میشود، فقط از طریق متد <code>addPartnerParameter</code> درون یک شی از <code>AdTraceEvent</code> فراخوانی میشود.
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
adTraceEvent.addPartnerParameter('key', 'value');
adTraceEvent.addPartnerParameter('foo', 'bar');
AdTrace.trackEvent(adTraceEvent);
```

### <div id="cp-ep-id" dir="rtl" align='right'>شناسه callback رویداد</div>

<div dir="rtl" align='right'>
شما همچنین میتوانید یک شناسه به صورت رشته برای هریک از رویدادهایی که رصد کردید اضافه کنید. این شناسه بعدا در callback موفق یا رد شدن آن رویداد به دست شما خواهد رسید که متوجه شوید این ردیابی به صورت موفق انجام شده است یا خیر. این مقدار از طریق متد <code>setCallbackId</code> درون شی  از <code>AdTraceEvent</code> قابل تنظیم است.
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
adTraceEvent.callbackId = '{CallbackId}';
AdTrace.trackEvent(adTraceEvent);
```

### <div id="cp-ep-value" dir="rtl" align='right'>مقدار رویداد</div>

<div dir="rtl" align='right'>
شما همچنین یک رشته دلخواه به رویداد خود میتوانید اضافه کنید. این مقدار از طریق <code>setEventValue</code> قابل استفاده است:
</div>
<br/>

```dart
AdTraceEvent adTraceEvent = new AdTraceEvent('abc123');
adTraceEvent.eventValue = '{eventValue}';
AdTrace.trackEvent(adTraceEvent);
```

### <div id="cp-sp" dir="rtl" align='right'>پارامترهای نشست</div>

<div dir="rtl" align='right'>
پارامترهای نشست به صورت محلی ذخیره میشوند و به همراه هر <strong>رویداد</strong> یا <strong>نشست</strong> ادتریس ارسال خواهند شد. هنگامی که هرکدام از این پارامترها  اضافه شدند، ما آنها را ذخیره خواهیم کرد پس نیازی به اضافه مجدد آنها نیست. افزودن مجدد پارامترهای مشابه تاثیری نخواهد داشت.
</div>
<br/>
<div dir="rtl" align='right'>
این پارامترها میتوانند قبل از شروع SDK ادتریس تنظیم شوند. اگر میخواهید هنگام نصب آنها را ارسال کنید، ولی پارامترهای آن بعد از نصب دراختیار شما قرار میگیرد، برای اینکار میتوانید از <a href="#cp-sp-delay-start">تاخیر</a> در شروع اولیه استفاده کنید.
</div>

### <div id="cp-sp-callback" dir="rtl" align='right'>پارامترهای callback نشست</div>

<div dir="rtl" align='right'>
شما میتوانید هرپارامتر callback ای که برای <a href="#cp-ep-callback">رویدادها</a> ارسال شده را در هر رویداد یا نشست ادتریس ذخیره کنید.
</div>
<br/>
<div dir="rtl" align='right'>
این پارامترهای callback نشست مشابه رویداد میباشد. برخلاف اضافه کردن key و value به یک رویداد، آنها را از طریق متد <code>AdTrace.addSessionCallbackParameter(String key, String value)</code> استفاده کنید:
</div>
<br/>

```dart
AdTrace.addSessionCallbackParameter('foo', 'bar');
```

<br/>
<div dir="rtl" align='right'>
پارامترهای callback نشست با پارامترهای callback به یک رویداد افزوده اید ادغام خواهد شد. پارامترهای رویداد بر نشست تقدم و برتری دارند، بدین معنی که اگر شما پارامتر callback یک ایونت را با یک key مشابه که به نشست افزوده شده است، این مقدار نسبت داده شده به این key از رویداد استفاده خواهد کرد.
</div>
<br/>
<div dir="rtl" align='right'>
این امکان فراهم هست که مقدار پارامترهای callback نشست از طریق key مورد نظربا متد <code>AdTrace.removeSessionCallbackParameter(String key)</code> حذف شود:
</div>
<br/>

```dart
AdTrace.removeSessionCallbackParameter('foo');
```

<br/>
<div dir="rtl" align='right'>
اگر شما مایل هستید که تمام مقدایر پارامترهای callback نشست را پاک کنید، بایستی از متد <code>()AdTrace.resetSessionCallbackParameters</code> استفاده کنید:
</div>
<br/>

```dart
AdTrace.resetSessionCallbackParameters();
```

### <div id="cp-sp-partner" dir="rtl" align='right'>پارامترهای partner نشست</div>

<div dir="rtl" align='right'>
به همین صورت پارامترهای partner مثل <a href="#cp-sp-callback">پارامترهای callback نشست</a> در هر رویداد یا نشست ارسال خواهند شد.
</div>
<br/>
<div dir="rtl" align='right'>
این مقادیر برای تمامی شریکان که در پنل خود فعالسازی کردید ارسال میشود.
</div>
<br/>
<div dir="rtl" align='right'>
پارامترهای partner نشست همچون رویداد میباشد. بایستی از متد <code>AdTrace.addSessionPartnerParameter(String key, String value)</code> استفاده شود:
</div>
<br/>

```dart
AdTrace.addSessionPartnerParameter("foo", "bar");
```

<br/>
<div dir="rtl" align='right'>
پارامترهای partner نشست با پارامترهای partner به یک رویداد افزوده اید ادغام خواهد شد. پارامترهای رویداد بر نشست تقدم و برتری دارند، بدین معنی که اگر شما پارامتر partner یک ایونت را با یک key مشابه که به نشست افزوده شده است، این مقدار نسبت داده شده به این key از رویداد استفاده خواهد کرد.
</div>
<br/>
<div dir="rtl" align='right'>
این امکان فراهم هست که مقدار پارامترهای partner نشست از طریق key مورد نظربا متد <code>AdTrace.removeSessionPartnerParameter(String key)</code> حذف شود:
</div>
<br/>

```dart
AdTrace.removeSessionPartnerParameter("foo");
```

<br/>
<div dir="rtl" align='right'>
اگر شما مایل هستید که تمام مقدایر پارامترهای partner نشست را پاک کنید، بایستی از متد <code>()AdTrace.resetSessionPartnerParameters</code> استفاده کنید:
</div>
<br/>

```dart
AdTrace.resetSessionPartnerParameters();
```

### <div id="cp-sp-delay-start" dir="rtl" align='right'>شروع با تاخیر</div>

<div dir="rtl" align='right'>
شروع با تاخیر SDK ادتریس این امکان را به برنامه شما میدهد تا پارامترهای نشست شما در زمان نصب ارسال شوند.
</div>
<br/>
<div dir="rtl" align='right'>
  با استفاده از متد <code>setDelayStart</code> که ورودی آن عددی به ثانیه است، باعث تاخیر در شروع اولیه خواهد شد:
</div>
<br/>

```dart
adtraceConfig.setDelayStart(5.5);
```

<br/>
<div dir="rtl" align='right'>
در این مثال SDK ادتریس مانع از ارسال نشست نصب اولیه و هر رویدادی با تاخیر 5.5 ثانیه خواهد شد. بعد از اتمام این زمان (یا فراخوانی متد <code>()AdTrace.sendFirstPackages</code> در طی این زمان) هر پارامتر نشستی با تاخیر آن زمان افزوده خواهد شد و بعد آن ادتریس به حالت عادی به کار خود ادامه میدهد.
</div>
<br/>
<div dir="rtl" align='right'>
<strong>بیشترین زمان ممکن برای تاخیر در شروع SDK ادتریس 10 ثانیه خواهد بود.</strong>
</div>

## <div dir="rtl" align='right'>ویژگی های بیشتر</div>

<div dir="rtl" align='right'>
هنگامی که شما SDK ادتریس را پیاده سازی کردید، میتوانید از ویژگی های زیر بهره ببرید:
</div>

### <div id="af-push-token" dir="rtl" align='right'>توکن push (ردیابی تعداد حذف برنامه)</div>

<div dir="rtl" align='right'>
توکن پوش برای برقراری ارتباط با کاربران استفاده میشود، همچنین برای ردیابی تعداد حذف یا نصب مجدد برنامه از این توکن استفاده میشود.
</div>
<br/>
<div dir="rtl" align='right'>
برای ارسال توکن پوش نوتیفیکشین خط زیر را در قسمتی که کد را دریافت کرده اید (یا هنگامی که مقدار آن تغییر میکند) اضافه نمایید:
</div>
<br/>

```dart
AdTrace.setPushToken('{PushNotificationsToken}');
```

### <div id="af-attribution-callback" dir="rtl" align='right'>callback اتریبیوشن</div>

<div dir="rtl" align='right'>
شما میتوانید یک listener هنگامی که اتریبیشون ترکر تغییر کند، داشته باشید. ما امکان فراهم سازی این اطلاعات را به صورت همزمان به دلیل تنوع منبع اتریبیوشن را نداریم.
</div>
<br/>
<div dir="rtl" align='right'>
برای callback اتریبیشون  قبل از شروع SDK موارد زیر را اضافه کنید:
</div>
<br/>

```dart
AdTraceConfig adTraceConfig = new AdTraceConfig(yourAppToken, environment);
config.attributionCallback = (AdTraceAttribution attributionChangedData) {
  print('[AdTrace]: Attribution changed!');

  if (attributionChangedData.trackerToken != null) {
    print('[AdTrace]: Tracker token: ' + attributionChangedData.trackerToken);
  }
  if (attributionChangedData.trackerName != null) {
    print('[AdTrace]: Tracker name: ' + attributionChangedData.trackerName);
  }
  if (attributionChangedData.campaign != null) {
    print('[AdTrace]: Campaign: ' + attributionChangedData.campaign);
  }
  if (attributionChangedData.network != null) {
    print('[AdTrace]: Network: ' + attributionChangedData.network);
  }
  if (attributionChangedData.creative != null) {
    print('[AdTrace]: Creative: ' + attributionChangedData.creative);
  }
  if (attributionChangedData.adgroup != null) {
    print('[AdTrace]: Adgroup: ' + attributionChangedData.adgroup);
  }
  if (attributionChangedData.clickLabel != null) {
    print('[AdTrace]: Click label: ' + attributionChangedData.clickLabel);
  }
  if (attributionChangedData.adid != null) {
    print('[AdTrace]: Adid: ' + attributionChangedData.adid);
  }
};
AdTrace.start(adTraceConfig);
```

<br/>
<div dir="rtl" align='right'>
این تابع بعد از دریافت آخرین اطلاعات اتریبیوشن صدا زده خواهد شد. با این تابع، به پارامتر <code>attribution</code> دسترسی پیدا خواهید کرد. موارد زیر یک خلاصه ای از امکانات گفته شده است:
</div>
<div dir="rtl" align='right'>
<ul>
<li><code>trackerToken</code> توکن ترکر از اتریبیوشن درحال حاضر است و جنس آن رشته میباشد.</li>
<li><code>trackerName</code> اسم ترکر از اتریبیوشن درحال حاضر است و جنس آن رشته میباشد.</li>
<li><code>network</code> لایه نتورک از اتریبیوشن درحال حاضر است و جنس آن رشته میباشد.</li>
<li><code>campain</code> لایه کمپین از اتریبیوشن درحال حاضر است و جنس آن رشته میباشد.</li>
<li><code>adgroup</code> لایه ادگروپ از اتریبیوشن درحال حاضر است و جنس آن رشته میباشد.</li>
<li><code>creative</code> لایه کریتیو از اتریبیوشن درحال حاضر است و جنس آن رشته میباشد.</li>
<li><code>adid</code> شناسه ادتریس است و جنس آن رشته میباشد.</li>
<ul>
</div>

### <div id="af-session-event-callbacks" dir="rtl" align='right'>callback های رویداد و نشست</div>

<div dir="rtl" align='right'>
این امکان فراهم است که یک listener هنگامی که رویداد یا نشستی ردیابی میشود، به اطلاع شما برساند. چهار نوع listener داریم: یکی برای ردیابی موفق بودن رویدادها، یکی برای ردیابی ناموفق بودن رویدادها، دیگری برای موفق بودن نشست و آخری نیز برای ناموفق بودن ردیابی نشست. برای درست کردن همچین listener هایی به صورت زیر عمل میکنیم:
</div>
<br/>

```dart
AdTraceConfig adTraceConfig = new AdTraceConfig(yourAppToken, environment);

// Set session success tracking delegate.
config.sessionSuccessCallback = (AdTraceSessionSuccess sessionSuccessData) {
  print('[AdTrace]: Session tracking success!');

  if (sessionSuccessData.message != null) {
    print('[AdTrace]: Message: ' + sessionSuccessData.message);
  }
  if (sessionSuccessData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + sessionSuccessData.timestamp);
  }
  if (sessionSuccessData.adid != null) {
    print('[AdTrace]: Adid: ' + sessionSuccessData.adid);
  }
  if (sessionSuccessData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + sessionSuccessData.jsonResponse);
  }
};

// Set session failure tracking delegate.
config.sessionFailureCallback = (AdTraceSessionFailure sessionFailureData) {
  print('[AdTrace]: Session tracking failure!');

  if (sessionFailureData.message != null) {
    print('[AdTrace]: Message: ' + sessionFailureData.message);
  }
  if (sessionFailureData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + sessionFailureData.timestamp);
  }
  if (sessionFailureData.adid != null) {
    print('[AdTrace]: Adid: ' + sessionFailureData.adid);
  }
  if (sessionFailureData.willRetry != null) {
    print('[AdTrace]: Will retry: ' + sessionFailureData.willRetry.toString());
  }
  if (sessionFailureData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + sessionFailureData.jsonResponse);
  }
};

// Set event success tracking delegate.
config.eventSuccessCallback = (AdTraceEventSuccess eventSuccessData) {
  print('[AdTrace]: Event tracking success!');

  if (eventSuccessData.eventToken != null) {
    print('[AdTrace]: Event token: ' + eventSuccessData.eventToken);
  }
  if (eventSuccessData.message != null) {
    print('[AdTrace]: Message: ' + eventSuccessData.message);
  }
  if (eventSuccessData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + eventSuccessData.timestamp);
  }
  if (eventSuccessData.adid != null) {
    print('[AdTrace]: Adid: ' + eventSuccessData.adid);
  }
  if (eventSuccessData.callbackId != null) {
    print('[AdTrace]: Callback ID: ' + eventSuccessData.callbackId);
  }
  if (eventSuccessData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + eventSuccessData.jsonResponse);
  }
};

// Set event failure tracking delegate.
config.eventFailureCallback = (AdTraceEventFailure eventFailureData) {
  print('[AdTrace]: Event tracking failure!');

  if (eventFailureData.eventToken != null) {
    print('[AdTracet]: Event token: ' + eventFailureData.eventToken);
  }
  if (eventFailureData.message != null) {
    print('[AdTrace]: Message: ' + eventFailureData.message);
  }
  if (eventFailureData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + eventFailureData.timestamp);
  }
  if (eventFailureData.adid != null) {
    print('[AdTrace]: Adid: ' + eventFailureData.adid);
  }
  if (eventFailureData.callbackId != null) {
    print('[AdTrace]: Callback ID: ' + eventFailureData.callbackId);
  }
  if (eventFailureData.willRetry != null) {
    print('[AdTrace]: Will retry: ' + eventFailureData.willRetry.toString());
  }
  if (eventFailureData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + eventFailureData.jsonResponse);
  }
};

AdTrace.start(adTraceConfig);
```

<br/>
<div dir="rtl" align='right'>
listener ها هنگامی فراخوانده میشوند که SDK تلاش به ارسال داده سمت سرور کند. با این listener شما دسترسی به  داده های دریافتی دارید. موارد زیر یک خلاصه ای از داده های دریافتی هنگام نشست موفق میباشد:
</div>
<br/>
<div dir="rtl" align='right'>
<ul>
<li><code>message</code> پیام از طرف سرور(یا ارور از طرف SDK)</li>
<li><code>timestamp</code> زمان دریافتی از سرور</li>
<li><code>adid</code> یک شناسه یکتا که از طریق ادتریس ساخته شده است</li>
<li><code>jsonResponse</code> شی JSON دریافتی از سمت سرور</li>
</ul>
</div>
<br/>
<div dir="rtl" align='right'>
هر دو داده دریافتی رویداد شامل موارد زیر میباشد:
</div>
<br/>
<div dir="rtl" align='right'>
<ul>
<li><code>eventToken</code> توکن مربوط به رویداد مورد نظر</li>
<li><code>callbackId</code> <a href="#cp-ep-id">شناسه callback</a> که برای یک رویداد تنظیم میشود</li>
</ul>
</div>
<br/>
<div dir="rtl" align='right'>
و هر دو رویداد و نشست ناموفق شامل موارد زیر میشوند:
</div>
<br/>
<div dir="rtl" align='right'>
<ul>
<li><code>willRetry</code> یک boolean ای  تلاش مجدد برای ارسال داده را نشان میدهد.</li>
</ul>
</div>

### <div id="af-user-attribution" dir="rtl" align='right'>اتریبیوشن کاربر</div>

<div dir="rtl" align='right'>
همانطور که در بخش <a href="#af-attribution-callback">callback اتریبیوشن</a> توضیح دادیم، این  callback هنگامی که اطلاعات اتریبیوشن عوض بشود، فعالسازی میشود. برای دسترسی به اطلاعات اتریبیوشن فعلی کاربر درهر زمانی که نیاز بود از طریق متد زیر قابل دسترس است:
</div>
<br/>

```dart
AdTraceAttribution attribution = AdTrace.getAttribution();
```

<br/>
<div dir="rtl" align='right'>
<strong>نکته</strong>: اطلاعات اتریبیوشن فعلی تنها درصورتی دردسترس است که از سمت سرور نصب برنامه ردیابی شود و از طریق callback اتریبیوشن فعالسازی شود. <strong>امکان این نیست که</strong> قبل از اجرا اولیه SDK  و فعالسازی callback اتریبیوشن بتوان به داده های کاربر دسترسی پیدا کرد.
</div>

### <div id="af-send-installed-apps" dir="rtl" align='right'>ارسال برنامه های نصب شده دستگاه</div>

<div dir="rtl" align='right'>
برای افزایش دقت و امنیت در تشخیص تقلب برنامه ای، میتوانید برنامه های ئرون دستگاه کاربر را برای ارسال سمت سرور به صورت زیر فعالسازی کنید:
</div>
<br/>

```dart
adtraceConfig.enableInstalledApps = true;
```

<br/>
<div dir="rtl" align='right'>
<strong>نکته</strong>: این ویژگی در حالت پیشفرض <strong>غیرفعال</strong> میباشد.
</div>

### <div id="af-di" dir="rtl" align='right'>شناسه های دستگاه</div>

<div dir="rtl" align='right'>
SDK ادتریس انواع شناسه ها رو به شما پیشنهاد میکند.
</div>

### <div id="af-di-idfa" dir="rtl" align='right'>شناسه تبلیغات iOS</div>

<div dir="rtl" align='right'>
برای دستیابی به شناسه iOS یا همان IDFA میتوانید به صورت زیر عمل کنید:
</div>
<br/>

```dart
AdTrace.getIdfa().then((idfa) {
  // Use idfa string value.
});
```

### <div id="af-di-gps-adid" dir="rtl" align='right'>شناسه تبلیغات سرویس های گوگل پلی</div>

<div dir="rtl" align='right'>
سرویس های مشخص (همچون Google Analytics) برای هماهنگی بین شناسه تبلیغات و شناسه کاربر به جهت ممانعت از گزارش تکراری به شما نیاز دارد.
</div>
<br/>

<div dir="rtl" align='right'>
برای دستیابی به شناسه تبلیغاتی گوگل لازم است تا یک تابع callback به متد <code>AdTrace.getGoogleAdId</code> که این شناسه را دریافت میکند به صورت زیر استفاده کنید:
</div>
<br/>

```dart
AdTrace.getGoogleAdId().then((googleAdId) {
  // Use googleAdId string value.
});
```


### <div id="af-di-amz-adid" dir="rtl" align='right'>شناسه تبلیغات آمازون</div>

<div dir="rtl" align='right'>
برای دستیابی به شناسه تبلیغاتی آمازون لازم است تا یک تابع callback به متد <code>AdTrace.getAmazonAdId</code> که این شناسه را دریافت میکند به صورت زیر استفاده کنید:
</div>
<br/>

```dart
AdTrace.getAmazonAdId().then((amazonAdId) {
  // Use amazonAdId string value.
});
```

### <div id="af-di-adid" dir="rtl" align='right'>شناسه دستگاه ادتریس</div>

<div dir="rtl" align='right'>
برای هر دستگاهی که نصب میشود، سرور ادتریس یک <strong>شناسه یکتا</strong> (که به صورت <strong>adid</strong> نامیده ومشود) تولید میکند. برای دستیابی به این شناسه میتوانید به صورت زیر استفاده کنید:
</div>
<br/>

```dart
AdTrace.getAdid().then((adid) {
  // Use adid string value.
});
```

<br/>
<div dir="rtl" align='right'>
<strong>نکته</strong>: اطلاعات مربوط به شناسه <strong>شناسه ادتریس</strong> تنها بعد از ردیابی نصب توسط سرور ادتریس قابل درسترس است. دسترسی به شناسه ادتریس قبل این ردیابی و یا قبل راه اندازی ادتریس <strong>امکان پذیر نیست</strong>.
</div>

### <div id="af-pre-installed-trackers" dir="rtl" align='right'>ردیابی قبل از نصب</div>

<div dir="rtl" align='right'>
اگر مایل به این هستید که SDK ادتریس تشخیص این را بدهد که کدام کاربرانی از طریق نصب از پیشن تعیین شده وارد برنامه شده اند مراحل زیر را انجام دهید:
</div>
<br/>
<div dir="rtl" align='right'>
<ul>
<li>یک ترکر جدید در پنل خود ایجاد نمایید.</li>
<li>در تنظیمات SDK ادتریس مثل زیر ترکر پیشفرض را اعمال کنید:</li>
</ul>
</div>
<br/>

```dart
adTraceConfig.defaultTracker = '{TrackerToken}';
```

<br/>
<div dir="rtl" align='right'>
<ul>
<li>مقدار <code>{TrackerToken}</code> را با مقدار توکن ترکری که در مرحله اول دریافت کرده اید جاگزین کنید.</li>
<li>برنامه خود را بسازید. در قسمت خروجی لاگ خود همچین خطی را مشاهده خواهید کرد.</li>
</ul>
</div>
<br/>

```
Default tracker: 'abc123'
```

### <div id="af-offline-mode" dir="rtl" align='right'>حالت آفلاین</div>

<div dir="rtl" align='right'>
برای مسدودسازی ارتباط SDK با سرورهای ادتریس میتوانید از حالت آفلاین SDK استفاده کنید(درحالیکه مجموعه داده ها بعدا برای رصد کردن ارسال میشود). در حالت آفلاین تمامی اطلاعات درون یک فایل ذخیره خواهد شد. توجه کنید که در این حالت رویدادهای زیادی را ایجاد نکنید.
</div>
<br/>
<div dir="rtl" align='right'>
برای فعالسازی حالت آفلاین متد <code>setOfflineMode</code> را با پارامتر <code>true</code> فعالسازی کنید.
</div>
<br/>

```dart
AdTrace.setOfflineMode(true);
```

<br/>
<div dir="rtl" align='right'>
بر عکس حالت بالا با فراخوانی متد <code>setOfflineMode</code> به همراه متغیر <code>false</code> میتوانید این حالت آفلاین را غیرفعال کنید. هنگامی که SDK ادتریس به حالت آنلاین برگردد، تمامی اطلاعات ذخیر شده با زمان صحیح مربوط به خودش سمت سرور ارسال میشود.
</div>
<br/>
<div dir="rtl" align='right'>
برخلاف غیرفعال کردن ردیابی، این تنظیم بین نشست ها <strong>توصیه نمیشود</strong>. این بدین معنی است که SDK هرزمان که شروع شود در حالت آنلاین است، حتی اگر برنامه درحالت آفلاین خاتمه پیدا کند.
</div>

### <div id="af-disable-tracking" dir="rtl" align='right'>غیرفعال کردن ردیابی</div>

<div dir="rtl" align='right'>
شما میتوانید SDK ادتریس را برای رصدکردن هرگونی فعالیت برای این دستگاه غیر فعال کنید که این کار از طریق متد <code>setEnabled</code> با پارامتر <code>false</code> امکان پذیر است. <strong>این تنظیم بین نشست ها به خاطر سپرده میشود</strong>.
</div>
<br/>

```dart
AdTrace.setEnabled(false);
```

<br/>
<div dir="rtl" align='right'>
شما برای اطلاع از فعال بودن ادتریس میتوانید از تابع <code>isEnabled</code> استفاده کنید. این امکان فراهم است که  SDK ادتریس را با متد <code>setEnabled</code> و پارامتر <code>true</code> فعالسازی کنید.
</div>

### <div id="af-event-buffering" dir="rtl" align='right'>بافرکردن رویدادها</div>

<div dir="rtl" align='right'>
اگر برنامه شما استفاده زیادی از رویدادها میکند، ممکن است بخواهید با یک حالت تاخیر و در یک مجموعه هر دقیقه ارسال کنید. میتوانید از طریق زیر بافرکردن رویدادها را فعالسازی کنید:
</div>
<br/>

```dart
adTraceConfig.eventBufferingEnabled = true;
```

### <div id="af-background-tracking" dir="rtl" align='right'>ردیابی در پس زمینه</div>

<div dir="rtl" align='right'>
رفتار پیشفرض SDK ادتریس هنگامی که برنامه در حالت پس زمینه قرار دارد، به صورت متوقف شده از ارسال داده ها میباشد. برای تغییر این مورد میتوانید به صورت زیر عمل کنید:
</div>
<br/>

```dart
adTraceConfig.sendInBackground = true;
```

### <div id="af-gdpr-forget-me" dir="rtl" align='right'>GPDR</div>

<div dir="rtl" align='right'>
بر طبق قانون GPDR شما این اعلان را به ادتریس میتوانید بکنید هنگامی که کاربر حق این را دارد که اطلاعاتش محفوظ بماند. از طریق متد زیر میتوانید این کار را انجام دهید:
</div>
<br/>

```js
AdTrace.gdprForgetMe();
```

<br/>
<div dir="rtl" align='right'>
طی دریافت این داده، ادتریس تمامی داده های کاربر را پاک خواهد کرد و ردیابی کاربر را متوقف خواهد کرد. هیچ درخواستی از این دستگاه به ادتریس در آینده ارسال نخواهد شد.
</div>
<br/>
<div dir="rtl" align='right'>
درنظر داشته باشید که حتی در زمان تست، این تصمیم بدون تغییر خواهد بود و قابل برگشت <strong>نیست</strong>.
</div>
