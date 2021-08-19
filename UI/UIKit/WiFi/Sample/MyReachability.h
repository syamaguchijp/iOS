
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;

extern NSString *kMyReachabilityChangedNotification;

@interface MyReachability : NSObject

+ (instancetype)reachabilityForLocalWiFi; // Checks whether a local WiFi connection is available.
- (BOOL)startNotifier;
- (void)stopNotifier;
- (NSString *)getCurrentSSID:(const CFStringRef)kCNNetworkInfoKey;

@end
