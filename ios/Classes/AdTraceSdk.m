#import "AdTraceSdk.h"
#import "AdTraceSdkDelegate.h"
#import "Adtrace.h"

static NSString * const CHANNEL_API_NAME = @"io.adtrace.sdk/api";

@interface AdTraceSdk ()

@property (nonatomic, retain) FlutterMethodChannel *channel;

@end

@implementation AdTraceSdk

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:CHANNEL_API_NAME
                                                                binaryMessenger:[registrar messenger]];
    AdTraceSdk *instance = [[AdTraceSdk alloc] init];
    instance.channel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)dealloc {
    [self.channel setMethodCallHandler:nil];
    self.channel = nil;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"start" isEqualToString:call.method]) {
        [self start:call withResult:result];
    } else if ([@"onResume" isEqualToString:call.method]) {
        [Adtrace trackSubsessionStart];
    } else if ([@"onPause" isEqualToString:call.method]) {
        [Adtrace trackSubsessionEnd];
    } else if ([@"trackEvent" isEqualToString:call.method]) {
        [self trackEvent:call withResult:result];
    } else if ([@"setEnabled" isEqualToString:call.method]) {
        [self setEnabled:call withResult:result];
    } else if ([@"sendFirstPackages" isEqualToString:call.method]) {
        [self sendFirstPackages:call withResult:result];
    } else if ([@"gdprForgetMe" isEqualToString:call.method]) {
        [self gdprForgetMe:call withResult:result];
    } else if ([@"disableThirdPartySharing" isEqualToString:call.method]) {
        [self disableThirdPartySharing:call withResult:result];
    } else if ([@"getAttribution" isEqualToString:call.method]) {
        [self getAttribution:call withResult:result];
    } else if ([@"getIdfa" isEqualToString:call.method]) {
        [self getIdfa:call withResult:result];
    } else if ([@"getIdfv" isEqualToString:call.method]) {
        [self getIdfv:call withResult:result];
    } else if ([@"getGoogleAdId" isEqualToString:call.method]) {
        [self getGoogleAdId:call withResult:result];
    } else if ([@"getSdkVersion" isEqualToString:call.method]) {
        [self getSdkVersion:call withResult:result];
    } else if ([@"setOfflineMode" isEqualToString:call.method]) {
        [self setOfflineMode:call withResult:result];
    } else if ([@"setPushToken" isEqualToString:call.method]) {
        [self setPushToken:call withResult:result];
    } else if ([@"appWillOpenUrl" isEqualToString:call.method]) {
        [self appWillOpenUrl:call withResult:result];
    } else if ([@"trackAdRevenue" isEqualToString:call.method]) {
        [self trackAdRevenue:call withResult:result];
    } else if ([@"trackAdRevenueNew" isEqualToString:call.method]) {
        [self trackAdRevenueNew:call withResult:result];
    } else if ([@"trackAppStoreSubscription" isEqualToString:call.method]) {
        [self trackAppStoreSubscription:call withResult:result];
    } else if ([@"trackPlayStoreSubscription" isEqualToString:call.method]) {
        [self trackPlayStoreSubscription:call withResult:result];
    } else if ([@"requestTrackingAuthorizationWithCompletionHandler" isEqualToString:call.method]) {
        [self requestTrackingAuthorizationWithCompletionHandler:call withResult:result];
    } else if ([@"getAppTrackingAuthorizationStatus" isEqualToString:call.method]) {
        [self getAppTrackingAuthorizationStatus:call withResult:result];
    } else if ([@"updateConversionValue" isEqualToString:call.method]) {
        [self updateConversionValue:call withResult:result];
    } else if ([@"trackThirdPartySharing" isEqualToString:call.method]) {
        [self trackThirdPartySharing:call withResult:result];
    } else if ([@"trackMeasurementConsent" isEqualToString:call.method]) {
        [self trackMeasurementConsent:call withResult:result];
    } else if ([@"setTestOptions" isEqualToString:call.method]) {
        [self setTestOptions:call withResult:result];
    } else if ([@"addSessionCallbackParameter" isEqualToString:call.method]) {
        NSString *key = call.arguments[@"key"];
        NSString *value = call.arguments[@"value"];
        if (!([self isFieldValid:key]) || !([self isFieldValid:value])) {
            return;
        }
        [Adtrace addSessionCallbackParameter:key value:value];
    } else if ([@"removeSessionCallbackParameter" isEqualToString:call.method]) {
        NSString *key = call.arguments[@"key"];
        if (!([self isFieldValid:key])) {
            return;
        }
        [Adtrace removeSessionCallbackParameter:key];
    } else if ([@"resetSessionCallbackParameters" isEqualToString:call.method]) {
        [Adtrace resetSessionCallbackParameters];
    } else if ([@"addSessionPartnerParameter" isEqualToString:call.method]) {
        NSString *key = call.arguments[@"key"];
        NSString *value = call.arguments[@"value"];
        if (!([self isFieldValid:key]) || !([self isFieldValid:value])) {
            return;
        }
        [Adtrace addSessionPartnerParameter:key value:value];
    } else if ([@"removeSessionPartnerParameter" isEqualToString:call.method]) {
        NSString *key = call.arguments[@"key"];
        if (!([self isFieldValid:key])) {
            return;
        }
        [Adtrace removeSessionPartnerParameter:key];
    } else if ([@"resetSessionPartnerParameters" isEqualToString:call.method]) {
        [Adtrace resetSessionPartnerParameters];
    } else if ([@"isEnabled" isEqualToString:call.method]) {
        BOOL isEnabled = [Adtrace isEnabled];
        result(@(isEnabled));
    } else if ([@"getAdid" isEqualToString:call.method]) {
        result([Adtrace adid]);
    } else if ([@"checkForNewAttStatus" isEqualToString:call.method]) {
         [Adtrace checkForNewAttStatus];
    } else if ([@"getLastDeeplink" isEqualToString:call.method]) {
         [self getLastDeeplink:call withResult:result];
    } else if ([@"updateConversionValueWithErrorCallback" isEqualToString:call.method]) {
        [self updateConversionValueWithErrorCallback:call withResult:result];
    } else if ([@"updateConversionValueWithErrorCallbackSkad4" isEqualToString:call.method]) {
        [self updateConversionValueWithErrorCallbackSkad4:call withResult:result];
    } else if ([@"verifyAppStorePurchase" isEqualToString:call.method]) {
        [self verifyAppStorePurchase:call withResult:result];
    } else if ([@"verifyPlayStorePurchase" isEqualToString:call.method]) {
        [self verifyAppStorePurchase:call withResult:result];
    } else if ([@"processDeeplink" isEqualToString:call.method]) {
        [self processDeeplink:call withResult:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)start:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *appToken = call.arguments[@"appToken"];
    NSString *environment = call.arguments[@"environment"];
    NSString *logLevel = call.arguments[@"logLevel"];
    NSString *sdkPrefix = call.arguments[@"sdkPrefix"];
    NSString *defaultTracker = call.arguments[@"defaultTracker"];
    NSString *externalDeviceId = call.arguments[@"externalDeviceId"];
    NSString *userAgent = call.arguments[@"userAgent"];
    NSString *urlStrategy = call.arguments[@"urlStrategy"];
    NSString *secretId = call.arguments[@"secretId"];
    NSString *info1 = call.arguments[@"info1"];
    NSString *info2 = call.arguments[@"info2"];
    NSString *info3 = call.arguments[@"info3"];
    NSString *info4 = call.arguments[@"info4"];
    NSString *delayStart = call.arguments[@"delayStart"];
    NSString *attConsentWaitingInterval = call.arguments[@"attConsentWaitingInterval"];
    NSString *isDeviceKnown = call.arguments[@"isDeviceKnown"];
    NSString *eventBufferingEnabled = call.arguments[@"eventBufferingEnabled"];
    NSString *sendInBackground = call.arguments[@"sendInBackground"];
    NSString *needsCost = call.arguments[@"needsCost"];
    NSString *coppaCompliantEnabled = call.arguments[@"coppaCompliantEnabled"];
    NSString *linkMeEnabled = call.arguments[@"linkMeEnabled"];
    NSString *allowAdServicesInfoReading = call.arguments[@"allowAdServicesInfoReading"];
    NSString *allowIdfaReading = call.arguments[@"allowIdfaReading"];
    NSString *skAdNetworkHandling = call.arguments[@"skAdNetworkHandling"];
    NSString *readDeviceInfoOnceEnabled = call.arguments[@"readDeviceInfoOnceEnabled"];
    NSString *dartAttributionCallback = call.arguments[@"attributionCallback"];
    NSString *dartSessionSuccessCallback = call.arguments[@"sessionSuccessCallback"];
    NSString *dartSessionFailureCallback = call.arguments[@"sessionFailureCallback"];
    NSString *dartEventSuccessCallback = call.arguments[@"eventSuccessCallback"];
    NSString *dartEventFailureCallback = call.arguments[@"eventFailureCallback"];
    NSString *dartDeferredDeeplinkCallback = call.arguments[@"deferredDeeplinkCallback"];
    NSString *dartConversionValueUpdatedCallback = call.arguments[@"conversionValueUpdatedCallback"];
    NSString *dartSkad4ConversionValueUpdatedCallback = call.arguments[@"skad4ConversionValueUpdatedCallback"];
    BOOL allowSuppressLogLevel = NO;
    BOOL launchDeferredDeeplink = [call.arguments[@"launchDeferredDeeplink"] boolValue];

    // Suppress log level.
    if ([self isFieldValid:logLevel]) {
        if ([ADTLogger logLevelFromString:[logLevel lowercaseString]] == ADTLogLevelSuppress) {
            allowSuppressLogLevel = YES;
        }
    }

    // Create config object.
    ADTConfig *adtraceConfig = [ADTConfig configWithAppToken:appToken
                                                environment:environment
                                      allowSuppressLogLevel:allowSuppressLogLevel];

    // SDK prefix.
    if ([self isFieldValid:sdkPrefix]) {
        [adtraceConfig setSdkPrefix:sdkPrefix];
    }

    // Log level.
    if ([self isFieldValid:logLevel]) {
        [adtraceConfig setLogLevel:[ADTLogger logLevelFromString:[logLevel lowercaseString]]];
    }

    // Event buffering.
    if ([self isFieldValid:eventBufferingEnabled]) {
        [adtraceConfig setEventBufferingEnabled:[eventBufferingEnabled boolValue]];
    }

    // COPPA compliance.
    if ([self isFieldValid:coppaCompliantEnabled]) {
        [adtraceConfig setCoppaCompliantEnabled:[coppaCompliantEnabled boolValue]];
    }

    // LinkMe.
    if ([self isFieldValid:linkMeEnabled]) {
        [adtraceConfig setLinkMeEnabled:[linkMeEnabled boolValue]];
    }

    // Default tracker.
    if ([self isFieldValid:defaultTracker]) {
        [adtraceConfig setDefaultTracker:defaultTracker];
    }

    // External device ID.
    if ([self isFieldValid:externalDeviceId]) {
        [adtraceConfig setExternalDeviceId:externalDeviceId];
    }

    // User agent.
    if ([self isFieldValid:userAgent]) {
        [adtraceConfig setUserAgent:userAgent];
    }

    // URL strategy.
    if ([self isFieldValid:urlStrategy]) {
        if ([urlStrategy isEqualToString:@"ir"]) {
            [adtraceConfig setUrlStrategy:ADTUrlStrategyIR];
        } else if ([urlStrategy isEqualToString:@"mobi"]) {
            [adtraceConfig setUrlStrategy:ADTUrlStrategyMobi];
        } else if ([urlStrategy isEqualToString:@"data-residency-ir"]) {
            [adtraceConfig setUrlStrategy:ADTDataResidencyIR];
        }
    }

    // Background tracking.
    if ([self isFieldValid:sendInBackground]) {
        [adtraceConfig setSendInBackground:[sendInBackground boolValue]];
    }

    // Cost data.
    if ([self isFieldValid:needsCost]) {
        [adtraceConfig setNeedsCost:[needsCost boolValue]];
    }

    // Allow AdServices info reading.
    if ([self isFieldValid:allowAdServicesInfoReading]) {
        [adtraceConfig setAllowAdServicesInfoReading:[allowAdServicesInfoReading boolValue]];
    }

    // Allow IDFA reading.
    if ([self isFieldValid:allowIdfaReading]) {
        [adtraceConfig setAllowIdfaReading:[allowIdfaReading boolValue]];
    }

    // SKAdNetwork handling.
    if ([self isFieldValid:skAdNetworkHandling]) {
        if ([skAdNetworkHandling boolValue] == NO) {
            [adtraceConfig deactivateSKAdNetworkHandling];
        }
    }

    // Read device info once.
    if ([self isFieldValid:readDeviceInfoOnceEnabled]) {
        [adtraceConfig setReadDeviceInfoOnceEnabled:[readDeviceInfoOnceEnabled boolValue]];
    }

    // Set device known.
    if ([self isFieldValid:isDeviceKnown]) {
        [adtraceConfig setIsDeviceKnown:[isDeviceKnown boolValue]];
    }

    // Delayed start.
    if ([self isFieldValid:delayStart]) {
        [adtraceConfig setDelayStart:[delayStart doubleValue]];
    }

    // ATT consent delay.
    if ([self isFieldValid:attConsentWaitingInterval]) {
        [adtraceConfig setAttConsentWaitingInterval:[attConsentWaitingInterval intValue]];
    }

    // App secret.
    if ([self isFieldValid:secretId]
        && [self isFieldValid:info1]
        && [self isFieldValid:info2]
        && [self isFieldValid:info3]
        && [self isFieldValid:info4]) {
        [adtraceConfig setAppSecret:[[NSNumber numberWithLongLong:[secretId longLongValue]] unsignedIntegerValue]
                             info1:[[NSNumber numberWithLongLong:[info1 longLongValue]] unsignedIntegerValue]
                             info2:[[NSNumber numberWithLongLong:[info2 longLongValue]] unsignedIntegerValue]
                             info3:[[NSNumber numberWithLongLong:[info3 longLongValue]] unsignedIntegerValue]
                             info4:[[NSNumber numberWithLongLong:[info4 longLongValue]] unsignedIntegerValue]];
    }

    // Callbacks.
    if (dartAttributionCallback != nil
        || dartSessionSuccessCallback != nil
        || dartSessionFailureCallback != nil
        || dartEventSuccessCallback != nil
        || dartEventFailureCallback != nil
        || dartDeferredDeeplinkCallback != nil
        || dartConversionValueUpdatedCallback != nil
        || dartSkad4ConversionValueUpdatedCallback != nil) {
        [adtraceConfig setDelegate:
         [AdTraceSdkDelegate getInstanceWithSwizzleOfAttributionCallback:dartAttributionCallback
                                                 sessionSuccessCallback:dartSessionSuccessCallback
                                                 sessionFailureCallback:dartSessionFailureCallback
                                                   eventSuccessCallback:dartEventSuccessCallback
                                                   eventFailureCallback:dartEventFailureCallback
                                               deferredDeeplinkCallback:dartDeferredDeeplinkCallback
                                         conversionValueUpdatedCallback:dartConversionValueUpdatedCallback
                                    skad4ConversionValueUpdatedCallback:dartSkad4ConversionValueUpdatedCallback
                                           shouldLaunchDeferredDeeplink:launchDeferredDeeplink
                                                       andMethodChannel:self.channel]];
    }

    // Start SDK.
    [Adtrace appDidLaunch:adtraceConfig];
    [Adtrace trackSubsessionStart];
    result(nil);
}

- (void)trackEvent:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *eventToken = call.arguments[@"eventToken"];
    NSString *revenue = call.arguments[@"revenue"];
    NSString *currency = call.arguments[@"currency"];
    NSString *callbackId = call.arguments[@"callbackId"];
    NSString *receipt = call.arguments[@"receipt"];
    NSString *productId = call.arguments[@"productId"];
    NSString *transactionId = call.arguments[@"transactionId"];
    NSString *strCallbackParametersJson = call.arguments[@"callbackParameters"];
    NSString *strValueParametersJson = call.arguments[@"eventValueParameters"];
    NSString *strPartnerParametersJson = call.arguments[@"partnerParameters"];

    // Create event object.
    ADTEvent *adtraceEvent = [ADTEvent eventWithEventToken:eventToken];

    // Revenue.
    if ([self isFieldValid:revenue]) {
        double revenueValue = [revenue doubleValue];
        [adtraceEvent setRevenue:revenueValue currency:currency];
    }

    // Receipt.
    if ([self isFieldValid:receipt]) {
        NSData *receiptValue;
        receiptValue = [receipt dataUsingEncoding:NSUTF8StringEncoding];
        [adtraceEvent setReceipt:receiptValue];
    }

    // Product ID.
    if ([self isFieldValid:productId]) {
        [adtraceEvent setProductId:productId];
    }

    // Transaction ID.
    if ([self isFieldValid:transactionId]) {
        [adtraceEvent setTransactionId:transactionId];
    }

    // Callback ID.
    if ([self isFieldValid:callbackId]) {
        [adtraceEvent setCallbackId:callbackId];
    }

    // Callback parameters.
    if (strCallbackParametersJson != nil) {
        NSData *callbackParametersData = [strCallbackParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id callbackParametersJson = [NSJSONSerialization JSONObjectWithData:callbackParametersData
                                                                    options:0
                                                                      error:NULL];
        for (id key in callbackParametersJson) {
            NSString *value = [callbackParametersJson objectForKey:key];
            [adtraceEvent addCallbackParameter:key value:value];
        }
    }

    // Partner parameters.
    if (strPartnerParametersJson != nil) {
        NSData *partnerParametersData = [strPartnerParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id partnerParametersJson = [NSJSONSerialization JSONObjectWithData:partnerParametersData
                                                                   options:0
                                                                     error:NULL];
        for (id key in partnerParametersJson) {
            NSString *value = [partnerParametersJson objectForKey:key];
            [adtraceEvent addPartnerParameter:key value:value];
        }
    }

    // Value parameters.
    if (strValueParametersJson != nil) {
        NSData *valueParametersData = [strValueParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id valueParametersJson = [NSJSONSerialization JSONObjectWithData:valueParametersData
                                                                   options:0
                                                                     error:NULL];
        for (id key in valueParametersJson) {
            NSString *value = [valueParametersJson objectForKey:key];
            [adtraceEvent addEventValueParameter:key value:value];
        }
    }

    // Track event.
    [Adtrace trackEvent:adtraceEvent];
    result(nil);
}

- (void)setEnabled:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *isEnabled = call.arguments[@"isEnabled"];
    if ([self isFieldValid:isEnabled]) {
        [Adtrace setEnabled:[isEnabled boolValue]];
    }
    result(nil);
}

- (void)sendFirstPackages:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    [Adtrace sendFirstPackages];
    result(nil);
}

- (void)gdprForgetMe:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    [Adtrace gdprForgetMe];
    result(nil);
}

- (void)disableThirdPartySharing:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    [Adtrace disableThirdPartySharing];
    result(nil);
}

- (void)setOfflineMode:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *isOffline = call.arguments[@"isOffline"];
    if ([self isFieldValid:isOffline]) {
        [Adtrace setOfflineMode:[isOffline boolValue]];
    }
    result(nil);
}

- (void)setPushToken:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *pushToken = call.arguments[@"pushToken"];
    if ([self isFieldValid:pushToken]) {
        [Adtrace setPushToken:pushToken];
    }
    result(nil);
}

- (void)appWillOpenUrl:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *urlString = call.arguments[@"url"];
    if (urlString == nil) {
        return;
    }

    NSURL *url;
    if ([NSString instancesRespondToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
#pragma clang diagnostic pop
    [Adtrace appWillOpenUrl:url];
}

- (void)trackAdRevenue:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *source = call.arguments[@"source"];
    NSString *payload = call.arguments[@"payload"];
    if (!([self isFieldValid:source]) || !([self isFieldValid:payload])) {
        return;
    }
    NSData *dataPayload = [payload dataUsingEncoding:NSUTF8StringEncoding];
    [Adtrace trackAdRevenue:source payload:dataPayload];
}

- (void)trackAdRevenueNew:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *source = call.arguments[@"source"];
    NSString *revenue = call.arguments[@"revenue"];
    NSString *currency = call.arguments[@"currency"];
    NSString *adImpressionsCount = call.arguments[@"adImpressionsCount"];
    NSString *adRevenueNetwork = call.arguments[@"adRevenueNetwork"];
    NSString *adRevenueUnit = call.arguments[@"adRevenueUnit"];
    NSString *adRevenuePlacement = call.arguments[@"adRevenuePlacement"];
    NSString *strCallbackParametersJson = call.arguments[@"callbackParameters"];
    NSString *strPartnerParametersJson = call.arguments[@"partnerParameters"];

    // Create ad revenue object.
    ADTAdRevenue *adtraceAdRevenue = [[ADTAdRevenue alloc] initWithSource:source];

    // Revenue.
    if ([self isFieldValid:revenue]) {
        double revenueValue = [revenue doubleValue];
        [adtraceAdRevenue setRevenue:revenueValue currency:currency];
    }

    // Ad impressions count.
    if ([self isFieldValid:adImpressionsCount]) {
        int adImpressionsCountValue = [adImpressionsCount intValue];
        [adtraceAdRevenue setAdImpressionsCount:adImpressionsCountValue];
    }

    // Ad revenue network.
    if ([self isFieldValid:adRevenueNetwork]) {
        [adtraceAdRevenue setAdRevenueNetwork:adRevenueNetwork];
    }

    // Ad revenue unit.
    if ([self isFieldValid:adRevenueUnit]) {
        [adtraceAdRevenue setAdRevenueUnit:adRevenueUnit];
    }

    // Ad revenue placement.
    if ([self isFieldValid:adRevenuePlacement]) {
        [adtraceAdRevenue setAdRevenuePlacement:adRevenuePlacement];
    }

    // Callback parameters.
    if (strCallbackParametersJson != nil) {
        NSData *callbackParametersData = [strCallbackParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id callbackParametersJson = [NSJSONSerialization JSONObjectWithData:callbackParametersData
                                                                    options:0
                                                                      error:NULL];
        for (id key in callbackParametersJson) {
            NSString *value = [callbackParametersJson objectForKey:key];
            [adtraceAdRevenue addCallbackParameter:key value:value];
        }
    }

    // Partner parameters.
    if (strPartnerParametersJson != nil) {
        NSData *partnerParametersData = [strPartnerParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id partnerParametersJson = [NSJSONSerialization JSONObjectWithData:partnerParametersData
                                                                   options:0
                                                                     error:NULL];
        for (id key in partnerParametersJson) {
            NSString *value = [partnerParametersJson objectForKey:key];
            [adtraceAdRevenue addPartnerParameter:key value:value];
        }
    }

    // Track ad revenue.
    [Adtrace trackAdRevenue:adtraceAdRevenue];
    result(nil);
}

- (void)trackPlayStoreSubscription:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    result([FlutterError errorWithCode:@"non_existing_method"
                               message:@"trackPlayStoreSubscription not available for iOS platform"
                               details:nil]);
}

- (void)trackAppStoreSubscription:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *price = call.arguments[@"price"];
    NSString *currency = call.arguments[@"currency"];
    NSString *transactionId = call.arguments[@"transactionId"];
    NSString *receipt = call.arguments[@"receipt"];
    NSString *transactionDate = call.arguments[@"transactionDate"];
    NSString *salesRegion = call.arguments[@"salesRegion"];
    // NSString *billingStore = call.arguments[@"billingStore"];
    NSString *strCallbackParametersJson = call.arguments[@"callbackParameters"];
    NSString *strPartnerParametersJson = call.arguments[@"partnerParameters"];

    // Price.
    NSDecimalNumber *priceValue;
    if ([self isFieldValid:price]) {
        priceValue = [NSDecimalNumber decimalNumberWithString:price];
    }

    // Receipt.
    NSData *receiptValue;
    if ([self isFieldValid:receipt]) {
        receiptValue = [receipt dataUsingEncoding:NSUTF8StringEncoding];
    }

    // Create subscription object.
    ADTSubscription *subscription = [[ADTSubscription alloc] initWithPrice:priceValue
                                                                  currency:currency
                                                             transactionId:transactionId
                                                                andReceipt:receiptValue];

    // Transaction date.
    if ([self isFieldValid:transactionDate]) {
        NSTimeInterval transactionDateInterval = [transactionDate doubleValue];
        NSDate *oTransactionDate = [NSDate dateWithTimeIntervalSince1970:transactionDateInterval];
        [subscription setTransactionDate:oTransactionDate];
    }

    // Sales region.
    if ([self isFieldValid:salesRegion]) {
        [subscription setSalesRegion:salesRegion];
    }

    // Callback parameters.
    if (strCallbackParametersJson != nil) {
        NSData *callbackParametersData = [strCallbackParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id callbackParametersJson = [NSJSONSerialization JSONObjectWithData:callbackParametersData
                                                                    options:0
                                                                      error:NULL];
        for (id key in callbackParametersJson) {
            NSString *value = [callbackParametersJson objectForKey:key];
            [subscription addCallbackParameter:key value:value];
        }
    }

    // Partner parameters.
    if (strPartnerParametersJson != nil) {
        NSData *partnerParametersData = [strPartnerParametersJson dataUsingEncoding:NSUTF8StringEncoding];
        id partnerParametersJson = [NSJSONSerialization JSONObjectWithData:partnerParametersData
                                                                   options:0
                                                                     error:NULL];
        for (id key in partnerParametersJson) {
            NSString *value = [partnerParametersJson objectForKey:key];
            [subscription addPartnerParameter:key value:value];
        }
    }

    // Track subscription.
    [Adtrace trackSubscription:subscription];
    result(nil);
}

- (void)getAttribution:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    ADTAttribution *attribution = [Adtrace attribution];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (attribution == nil) {
        result(dictionary);
    }

    [self addValueOrEmpty:attribution.trackerToken withKey:@"trackerToken" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.trackerName withKey:@"trackerName" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.network withKey:@"network" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.campaign withKey:@"campaign" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.creative withKey:@"creative" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.adgroup withKey:@"adgroup" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.clickLabel withKey:@"clickLabel" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.adid withKey:@"adid" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.costType withKey:@"costType" toDictionary:dictionary];
    [self addNumberOrEmpty:attribution.costAmount withKey:@"costAmount" toDictionary:dictionary];
    [self addValueOrEmpty:attribution.costCurrency withKey:@"costCurrency" toDictionary:dictionary];
    result(dictionary);
}

- (void)getIdfa:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *idfa = [Adtrace idfa];
    result(idfa);
}

- (void)getIdfv:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *idfv = [Adtrace idfv];
    result(idfv);
}

- (void)getGoogleAdId:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    result([FlutterError errorWithCode:@"non_existing_method"
                               message:@"getGoogleAdId not available for iOS platform"
                               details:nil]);
}

- (void)getSdkVersion:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *sdkVersion = [Adtrace sdkVersion];
    result(sdkVersion);
}

- (void)requestTrackingAuthorizationWithCompletionHandler:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    [Adtrace requestTrackingAuthorizationWithCompletionHandler:^(NSUInteger status) {
        result([NSNumber numberWithUnsignedLong:status]);
    }];
}

- (void)getAppTrackingAuthorizationStatus:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    result([NSNumber numberWithInt:[Adtrace appTrackingAuthorizationStatus]]);
}

- (void)updateConversionValue:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *conversionValue = call.arguments[@"conversionValue"];
    if ([self isFieldValid:conversionValue]) {
        [Adtrace updateConversionValue:[conversionValue intValue]];
    }
    result(nil);
}

- (void)trackThirdPartySharing:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSNumber *isEnabled = call.arguments[@"isEnabled"];
    NSString *strGranularOptions = call.arguments[@"granularOptions"];
    NSString *strPartnerSharingSettings = call.arguments[@"partnerSharingSettings"];

    // Create third party sharing object.
    ADTThirdPartySharing *adtraceThirdPartySharing = [[ADTThirdPartySharing alloc]
                                                     initWithIsEnabledNumberBool:[self isFieldValid:isEnabled] ? isEnabled : nil];

    // Granular options.
    if (strGranularOptions != nil) {
        NSArray *arrayGranularOptions = [strGranularOptions componentsSeparatedByString:@"__ADT__"];
        if (arrayGranularOptions != nil) {
            for (int i = 0; i < [arrayGranularOptions count]; i += 3) {
                [adtraceThirdPartySharing addGranularOption:[arrayGranularOptions objectAtIndex:i]
                                                       key:[arrayGranularOptions objectAtIndex:i+1]
                                                     value:[arrayGranularOptions objectAtIndex:i+2]];
            }
        }
    }

    // Partner sharing settings.
    if (strPartnerSharingSettings != nil) {
        NSArray *arrayPartnerSharingSettings = [strPartnerSharingSettings componentsSeparatedByString:@"__ADT__"];
        if (arrayPartnerSharingSettings != nil) {
            for (int i = 0; i < [arrayPartnerSharingSettings count]; i += 3) {
                [adtraceThirdPartySharing addPartnerSharingSetting:[arrayPartnerSharingSettings objectAtIndex:i]
                                                              key:[arrayPartnerSharingSettings objectAtIndex:i+1]
                                                            value:[[arrayPartnerSharingSettings objectAtIndex:i+2] boolValue]];
            }
        }
    }

    // Track third party sharing.
    [Adtrace trackThirdPartySharing:adtraceThirdPartySharing];
    result(nil);
}

- (void)trackMeasurementConsent:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *measurementConsent = call.arguments[@"measurementConsent"];
    if ([self isFieldValid:measurementConsent]) {
        [Adtrace trackMeasurementConsent:[measurementConsent boolValue]];
    }
    result(nil);
}

- (void)getLastDeeplink:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSURL *lastDeeplink = [Adtrace lastDeeplink];
    if (![self isFieldValid:lastDeeplink]) {
        result(nil);
    } else {
        result([lastDeeplink absoluteString]);
    }
}

- (void)updateConversionValueWithErrorCallback:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *conversionValue = call.arguments[@"conversionValue"];
    if ([self isFieldValid:conversionValue]) {
        [Adtrace updatePostbackConversionValue:[conversionValue intValue]
                            completionHandler:^(NSError * _Nullable error) {
            result([error localizedDescription]);
        }];
    }
}

- (void)updateConversionValueWithErrorCallbackSkad4:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *conversionValue = call.arguments[@"conversionValue"];
    NSString *coarseValue = call.arguments[@"coarseValue"];
    NSString *lockWindow = call.arguments[@"lockWindow"];
    if ([self isFieldValid:conversionValue] &&
        [self isFieldValid:coarseValue] &&
        [self isFieldValid:lockWindow]) {
        [Adtrace updatePostbackConversionValue:[conversionValue intValue]
                                  coarseValue:coarseValue
                                   lockWindow:(BOOL)lockWindow
                            completionHandler:^(NSError * _Nullable error) {
            result([error localizedDescription]);
        }];
    }
}

- (void)verifyPlayStorePurchase:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    result([FlutterError errorWithCode:@"non_existing_method"
                               message:@"verifyPlayStorePurchase not available for iOS platform"
                               details:nil]);
}

- (void)verifyAppStorePurchase:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *receipt = call.arguments[@"receipt"];
    NSString *productId = call.arguments[@"productId"];
    NSString *transactionId = call.arguments[@"transactionId"];

    // Receipt.
    NSData *receiptValue;
    if ([self isFieldValid:receipt]) {
        receiptValue = [receipt dataUsingEncoding:NSUTF8StringEncoding];
    }

    // Create purchase instance.
    ADTPurchase *purchase = [[ADTPurchase alloc] initWithTransactionId:transactionId
                                                             productId:productId
                                                            andReceipt:receiptValue];

    // Verify purchase.
    [Adtrace verifyPurchase:purchase
         completionHandler:^(ADTPurchaseVerificationResult * _Nonnull verificationResult) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        if (verificationResult == nil) {
            result(dictionary);
        }

        [self addValueOrEmpty:verificationResult.verificationStatus
                      withKey:@"verificationStatus"
                 toDictionary:dictionary];
        [self addValueOrEmpty:[NSString stringWithFormat:@"%d", verificationResult.code]
                      withKey:@"code"
                 toDictionary:dictionary];
        [self addValueOrEmpty:verificationResult.message
                      withKey:@"message"
                 toDictionary:dictionary];
        result(dictionary);
    }];
}

- (void)processDeeplink:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString *deeplink = call.arguments[@"deeplink"];
    if ([self isFieldValid:deeplink]) {
        NSURL *nsUrl;
        if ([NSString instancesRespondToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
            nsUrl = [NSURL URLWithString:[deeplink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            nsUrl = [NSURL URLWithString:[deeplink stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
#pragma clang diagnostic pop

        [Adtrace processDeeplink:nsUrl completionHandler:^(NSString * _Nonnull resolvedLink) {
            if (![self isFieldValid:resolvedLink]) {
                result(nil);
            } else {
                result(resolvedLink);
            }
        }];
    }
}

- (void)setTestOptions:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    AdtraceTestOptions *testOptions = [[AdtraceTestOptions alloc] init];
    NSString *baseUrl = call.arguments[@"baseUrl"];
    NSString *gdprUrl = call.arguments[@"gdprUrl"];
    NSString *subscriptionUrl = call.arguments[@"subscriptionUrl"];
    NSString *purchaseVerificationUrl = call.arguments[@"purchaseVerificationUrl"];
    NSString *extraPath = call.arguments[@"extraPath"];
    NSString *timerIntervalInMilliseconds = call.arguments[@"timerIntervalInMilliseconds"];
    NSString *timerStartInMilliseconds = call.arguments[@"timerStartInMilliseconds"];
    NSString *sessionIntervalInMilliseconds = call.arguments[@"sessionIntervalInMilliseconds"];
    NSString *subsessionIntervalInMilliseconds = call.arguments[@"subsessionIntervalInMilliseconds"];
    NSString *teardown = call.arguments[@"teardown"];
    NSString *deleteState = call.arguments[@"deleteState"];
    NSString *noBackoffWait = call.arguments[@"noBackoffWait"];
    NSString *adServicesFrameworkEnabled = call.arguments[@"adServicesFrameworkEnabled"];

    if ([self isFieldValid:baseUrl]) {
        testOptions.baseUrl = baseUrl;
    }
    if ([self isFieldValid:gdprUrl]) {
        testOptions.gdprUrl = gdprUrl;
    }
    if ([self isFieldValid:subscriptionUrl]) {
        testOptions.subscriptionUrl = subscriptionUrl;
    }
    if ([self isFieldValid:purchaseVerificationUrl]) {
        testOptions.purchaseVerificationUrl = purchaseVerificationUrl;
    }
    if ([self isFieldValid:extraPath]) {
        testOptions.extraPath = extraPath;
    }
    if ([self isFieldValid:timerIntervalInMilliseconds]) {
        testOptions.timerIntervalInMilliseconds = [NSNumber numberWithLongLong:[timerIntervalInMilliseconds longLongValue]];
    }
    if ([self isFieldValid:timerStartInMilliseconds]) {
        testOptions.timerStartInMilliseconds = [NSNumber numberWithLongLong:[timerStartInMilliseconds longLongValue]];
    }
    if ([self isFieldValid:sessionIntervalInMilliseconds]) {
        testOptions.sessionIntervalInMilliseconds = [NSNumber numberWithLongLong:[sessionIntervalInMilliseconds longLongValue]];
    }
    if ([self isFieldValid:subsessionIntervalInMilliseconds]) {
        testOptions.subsessionIntervalInMilliseconds = [NSNumber numberWithLongLong:[subsessionIntervalInMilliseconds longLongValue]];
    }
    if ([self isFieldValid:teardown]) {
        testOptions.teardown = [teardown boolValue];
        if (testOptions.teardown) {
            [AdTraceSdkDelegate teardown];
        }
    }
    if ([self isFieldValid:deleteState]) {
        testOptions.deleteState = [deleteState boolValue];
    }
    if ([self isFieldValid:noBackoffWait]) {
        testOptions.noBackoffWait = [noBackoffWait boolValue];
    }
    if ([self isFieldValid:adServicesFrameworkEnabled]) {
        testOptions.adServicesFrameworkEnabled = [adServicesFrameworkEnabled boolValue];
    }

    [Adtrace setTestOptions:testOptions];
}

- (BOOL)isFieldValid:(NSObject *)field {
    if (field == nil) {
        return NO;
    }

    // Check if its an instance of the singleton NSNull.
    if ([field isKindOfClass:[NSNull class]]) {
        return NO;
    }

    // If field can be converted to a string, check if it has any content.
    NSString *str = [NSString stringWithFormat:@"%@", field];
    if (str != nil) {
        if ([str length] == 0) {
            return NO;
        }
    }

    return YES;
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

- (void)addNumberOrEmpty:(NSNumber *)value
                 withKey:(NSString *)key
            toDictionary:(NSMutableDictionary *)dictionary {
    if (nil != value) {
        [dictionary setObject:[value stringValue] forKey:key];
    } else {
        [dictionary setObject:@"" forKey:key];
    }
}

@end
