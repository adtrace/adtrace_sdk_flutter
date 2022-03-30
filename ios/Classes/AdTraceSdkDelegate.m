

#import <objc/runtime.h>
#import "AdtraceSdkDelegate.h"

static dispatch_once_t onceToken;
static AdtraceSdkDelegate *defaultInstance = nil;
static NSString *dartAttributionCallback;
static NSString *dartSessionSuccessCallback;
static NSString *dartSessionFailureCallback;
static NSString *dartEventSuccessCallback;
static NSString *dartEventFailureCallback;
static NSString *dartDeferredDeeplinkCallback;
static NSString *dartConversionValueUpdatedCallback;

@implementation AdtraceSdkDelegate

#pragma mark - Object lifecycle methods

- (id)init {
    self = [super init];
    if (nil == self) {
        return nil;
    }
    return self;
}

#pragma mark - Public methods

+ (id)getInstanceWithSwizzleOfAttributionCallback:(NSString *)swizzleAttributionCallback
                           sessionSuccessCallback:(NSString *)swizzleSessionSuccessCallback
                           sessionFailureCallback:(NSString *)swizzleSessionFailureCallback
                             eventSuccessCallback:(NSString *)swizzleEventSuccessCallback
                             eventFailureCallback:(NSString *)swizzleEventFailureCallback
                         deferredDeeplinkCallback:(NSString *)swizzleDeferredDeeplinkCallback
                   conversionValueUpdatedCallback:(NSString *)swizzleConversionValueUpdatedCallback
                     shouldLaunchDeferredDeeplink:(BOOL)shouldLaunchDeferredDeeplink
                                 andMethodChannel:(FlutterMethodChannel *)channel {
    
    dispatch_once(&onceToken, ^{
        defaultInstance = [[AdtraceSdkDelegate alloc] init];
        
        // Do the swizzling where and if needed.
        if (swizzleAttributionCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceAttributionChanged:)
                                  swizzledSelector:@selector(adtraceAttributionChangedWannabe:)];
            dartAttributionCallback = swizzleAttributionCallback;
        }
        if (swizzleSessionSuccessCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceSessionTrackingSucceeded:)
                                  swizzledSelector:@selector(adtraceSessionTrackingSucceededWannabe:)];
            dartSessionSuccessCallback = swizzleSessionSuccessCallback;
        }
        if (swizzleSessionFailureCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceSessionTrackingFailed:)
                                  swizzledSelector:@selector(adtraceSessionTrackingFailedWananbe:)];
            dartSessionFailureCallback = swizzleSessionFailureCallback;
        }
        if (swizzleEventSuccessCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceEventTrackingSucceeded:)
                                  swizzledSelector:@selector(adtraceEventTrackingSucceededWannabe:)];
            dartEventSuccessCallback = swizzleEventSuccessCallback;
        }
        if (swizzleEventFailureCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceEventTrackingFailed:)
                                  swizzledSelector:@selector(adtraceEventTrackingFailedWannabe:)];
            dartEventFailureCallback = swizzleEventFailureCallback;
        }
        if (swizzleDeferredDeeplinkCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceDeeplinkResponse:)
                                  swizzledSelector:@selector(adtraceDeeplinkResponseWannabe:)];
            dartDeferredDeeplinkCallback = swizzleDeferredDeeplinkCallback;
        }
        if (swizzleConversionValueUpdatedCallback != nil) {
            [defaultInstance swizzleCallbackMethod:@selector(adtraceConversionValueUpdated:)
                                  swizzledSelector:@selector(adtraceConversionValueUpdatedWannabe:)];
            dartConversionValueUpdatedCallback = swizzleConversionValueUpdatedCallback;
        }

        [defaultInstance setShouldLaunchDeferredDeeplink:shouldLaunchDeferredDeeplink];
        [defaultInstance setChannel:channel];
    });

    return defaultInstance;
}

+ (void)teardown {
    defaultInstance = nil;
    onceToken = 0;
}

#pragma mark - Private & helper methods

- (void)adtraceAttributionChangedWannabe:(ADTAttribution *)attribution {
    if (attribution == nil) {
        return;
    }
    
    id keys[] = {
        @"trackerToken",
        @"trackerName",
        @"network",
        @"campaign",
        @"adgroup",
        @"creative",
        @"clickLabel",
        @"adid",
        @"costType",
        @"costAmount",
        @"costCurrency" };
    id values[] = {
        [self getValueOrEmpty:[attribution trackerToken]],
        [self getValueOrEmpty:[attribution trackerName]],
        [self getValueOrEmpty:[attribution network]],
        [self getValueOrEmpty:[attribution campaign]],
        [self getValueOrEmpty:[attribution adgroup]],
        [self getValueOrEmpty:[attribution creative]],
        [self getValueOrEmpty:[attribution clickLabel]],
        [self getValueOrEmpty:[attribution adid]],
        [self getValueOrEmpty:[attribution costType]],
        [self getNumberValueOrEmpty:[attribution costAmount]],
        [self getValueOrEmpty:[attribution costCurrency]]
    };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *attributionMap = [NSDictionary dictionaryWithObjects:values
                                                                     forKeys:keys
                                                                       count:count];
    [self.channel invokeMethod:dartAttributionCallback arguments:attributionMap];
}

- (void)adtraceSessionTrackingSucceededWannabe:(ADTSessionSuccess *)sessionSuccessResponseData {
    if (nil == sessionSuccessResponseData) {
        return;
    }

    id keys[] = { @"message", @"timestamp", @"adid", @"jsonResponse" };
    id values[] = {
        [self getValueOrEmpty:[sessionSuccessResponseData message]],
        [self getValueOrEmpty:[sessionSuccessResponseData timeStamp]],
        [self getValueOrEmpty:[sessionSuccessResponseData adid]],
        [self toJson:[self getObjectValueOrEmpty:[sessionSuccessResponseData jsonResponse]]]
    };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *sessionSuccessMap = [NSDictionary dictionaryWithObjects:values
                                                                  forKeys:keys
                                                                    count:count];
    [self.channel invokeMethod:dartSessionSuccessCallback arguments:sessionSuccessMap];
}

- (void)adtraceSessionTrackingFailedWananbe:(ADTSessionFailure *)sessionFailureResponseData {
    if (nil == sessionFailureResponseData) {
        return;
    }

    NSString *willRetryString = [sessionFailureResponseData willRetry] ? @"true" : @"false";
    id keys[] = { @"message", @"timestamp", @"adid", @"willRetry", @"jsonResponse" };
    id values[] = {
        [self getValueOrEmpty:[sessionFailureResponseData message]],
        [self getValueOrEmpty:[sessionFailureResponseData timeStamp]],
        [self getValueOrEmpty:[sessionFailureResponseData adid]],
        willRetryString,
        [self toJson:[self getObjectValueOrEmpty:[sessionFailureResponseData jsonResponse]]]
    };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *sessionFailureMap = [NSDictionary dictionaryWithObjects:values
                                                                  forKeys:keys
                                                                    count:count];
    [self.channel invokeMethod:dartSessionFailureCallback arguments:sessionFailureMap];
}

- (void)adtraceEventTrackingSucceededWannabe:(ADTEventSuccess *)eventSuccessResponseData {
    if (nil == eventSuccessResponseData) {
        return;
    }
    
    id keys[] = { @"message", @"timestamp", @"adid", @"eventToken", @"callbackId", @"jsonResponse" };
    id values[] = {
        [self getValueOrEmpty:[eventSuccessResponseData message]],
        [self getValueOrEmpty:[eventSuccessResponseData timeStamp]],
        [self getValueOrEmpty:[eventSuccessResponseData adid]],
        [self getValueOrEmpty:[eventSuccessResponseData eventToken]],
        [self getValueOrEmpty:[eventSuccessResponseData callbackId]],
        [self toJson:[self getObjectValueOrEmpty:[eventSuccessResponseData jsonResponse]]]
    };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *eventSuccessMap = [NSDictionary dictionaryWithObjects:values
                                                                forKeys:keys
                                                                  count:count];
    [self.channel invokeMethod:dartEventSuccessCallback arguments:eventSuccessMap];
}

- (void)adtraceEventTrackingFailedWannabe:(ADTEventFailure *)eventFailureResponseData {
    if (nil == eventFailureResponseData) {
        return;
    }

    NSString *willRetryString = [eventFailureResponseData willRetry] ? @"true" : @"false";
    id keys[] = { @"message", @"timestamp", @"adid", @"eventToken", @"callbackId", @"willRetry", @"jsonResponse" };
    id values[] = {
        [self getValueOrEmpty:[eventFailureResponseData message]],
        [self getValueOrEmpty:[eventFailureResponseData timeStamp]],
        [self getValueOrEmpty:[eventFailureResponseData adid]],
        [self getValueOrEmpty:[eventFailureResponseData eventToken]],
        [self getValueOrEmpty:[eventFailureResponseData callbackId]],
        willRetryString,
        [self toJson:[self getObjectValueOrEmpty:[eventFailureResponseData jsonResponse]]]
    };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *eventFailureMap = [NSDictionary dictionaryWithObjects:values
                                                                forKeys:keys
                                                                  count:count];
    [self.channel invokeMethod:dartEventFailureCallback arguments:eventFailureMap];
}

- (BOOL)adtraceDeeplinkResponseWannabe:(NSURL *)deeplink {
    id keys[] = { @"uri" };
    id values[] = { [deeplink absoluteString] };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *deeplinkMap = [NSDictionary dictionaryWithObjects:values
                                                            forKeys:keys
                                                              count:count];
    [self.channel invokeMethod:dartDeferredDeeplinkCallback arguments:deeplinkMap];
    return self.shouldLaunchDeferredDeeplink;
}

- (void)adtraceConversionValueUpdatedWannabe:(NSNumber *)conversionValue {
    id keys[] = { @"conversionValue" };
    id values[] = { [conversionValue stringValue] };
    NSUInteger count = sizeof(values) / sizeof(id);
    NSDictionary *conversionValueMap = [NSDictionary dictionaryWithObjects:values
                                                                   forKeys:keys
                                                                     count:count];
    [self.channel invokeMethod:dartConversionValueUpdatedCallback arguments:conversionValueMap];
}

- (void)swizzleCallbackMethod:(SEL)originalSelector
             swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)addValueOrEmpty:(NSObject *)value
                withKey:(NSString *)key
           toDictionary:(NSMutableDictionary *)dictionary {
    if (nil != value) {
        [dictionary setObject:[NSString stringWithFormat:@"%@", value] forKey:key];
    } else {
        [dictionary setObject:@"" forKey:key];
    }
}

- (NSString *)toJson:(id)object {
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&writeError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)getValueOrEmpty:(NSString *)value {
    if (value == nil || value == NULL) {
        return @"";
    }
    return value;
}

- (id)getNumberValueOrEmpty:(NSNumber *)value {
    if (value == nil || value == NULL) {
        return @"";
    }
    return [value stringValue];
}

- (id)getObjectValueOrEmpty:(id)value {
    if (value == nil || value == NULL) {
        return [NSDictionary dictionary];
    }
    return value;
}

@end
