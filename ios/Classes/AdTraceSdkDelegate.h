#import <Flutter/Flutter.h>
#import "Adtrace.h"

@interface AdTraceSdkDelegate : NSObject<AdtraceDelegate>

@property (nonatomic) BOOL shouldLaunchDeferredDeeplink;
@property (nonatomic, weak) FlutterMethodChannel *channel;

+ (id)getInstanceWithSwizzleOfAttributionCallback:(NSString *)swizzleAttributionCallback
                           sessionSuccessCallback:(NSString *)swizzleSessionSuccessCallback
                           sessionFailureCallback:(NSString *)swizzleSessionFailureCallback
                             eventSuccessCallback:(NSString *)swizzleEventSuccessCallback
                             eventFailureCallback:(NSString *)swizzleEventFailureCallback
                         deferredDeeplinkCallback:(NSString *)swizzleDeferredDeeplinkCallback
                   conversionValueUpdatedCallback:(NSString *)swizzleConversionValueUpdatedCallback
              skad4ConversionValueUpdatedCallback:(NSString *)swizzleSkad4ConversionValueUpdatedCallback
                     shouldLaunchDeferredDeeplink:(BOOL)shouldLaunchDeferredDeeplink
                                 andMethodChannel:(FlutterMethodChannel *)channel;

+ (void)teardown;

@end
