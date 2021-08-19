//  Reachability 3.5

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "MyReachability.h"

NSString *kMyReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";

#pragma mark - Supporting functions

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
#pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject*) info isKindOfClass: [MyReachability class]], @"info was wrong class in ReachabilityCallback");
    
    MyReachability* noteObject = (__bridge MyReachability *)info;
    // Post a notification to notify the client that the network reachability changed.
    [[NSNotificationCenter defaultCenter] postNotificationName: kMyReachabilityChangedNotification object: noteObject];
}

#pragma mark - Reachability implementation

@implementation MyReachability
{
    BOOL _alwaysReturnLocalWiFiStatus; //default is NO
    SCNetworkReachabilityRef _reachabilityRef;
}

#pragma mark - Class methods

+ (instancetype)reachabilityWithHostName:(NSString *)hostName
{
    MyReachability* returnValue = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if (reachability != NULL)
    {
        returnValue= [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
            returnValue->_alwaysReturnLocalWiFiStatus = NO;
        }
    }
    return returnValue;
}

+ (instancetype)reachabilityForLocalWiFi
{
    MyReachability* returnValue = [self reachabilityWithHostName:kMyExampleRfcDomainForWifi];
    if (returnValue != NULL)
    {
        returnValue->_alwaysReturnLocalWiFiStatus = YES;
    }
    
    return returnValue;
}

#pragma mark - Start and stop notifier

- (BOOL)startNotifier
{
    BOOL returnValue = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, &context))
    {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            returnValue = YES;
        }
    }
    
    return returnValue;
}

- (void)stopNotifier
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}

- (void)dealloc
{
    [self stopNotifier];
    if (_reachabilityRef != NULL)
    {
        CFRelease(_reachabilityRef);
    }
}

#pragma mark - Outer

- (NSString *)getCurrentSSID:(const CFStringRef)kCNNetworkInfoKey
{
    // 現在接続しているESSIDもしくはBSSIDを返す。引数：kCNNetworkInfoKeySSID or kCNNetworkInfoKeyBSSID
    
    CFArrayRef interfaces = CNCopySupportedInterfaces(); // 今接続しているwifiが得られる
    if (interfaces == NULL) {
        return nil;
    }
    CFIndex count = CFArrayGetCount(interfaces);
    NSString *ssid = nil;
    for (int i = 0; i < count; i++) {
        CFStringRef interface = CFArrayGetValueAtIndex(interfaces, i);
        CFDictionaryRef netinfo = CNCopyCurrentNetworkInfo(interface);
        if (netinfo && CFDictionaryContainsKey(netinfo, kCNNetworkInfoKey)) {
            ssid = [NSString stringWithString:
                    (__bridge NSString *)CFDictionaryGetValue(netinfo, kCNNetworkInfoKey)
                    ];
        }
        if (netinfo)
            CFRelease(netinfo);
    }
    CFRelease(interfaces);
    
    return ssid;
}

@end
