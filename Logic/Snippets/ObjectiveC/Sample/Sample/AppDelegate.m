//
//  AppDelegate.m
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import "AppDelegate.h"
#import "ArraySample.h"
#import "User.h"
#import "SpecialUser.h"
#import "ValueOrRef.h"
#import "SubThread.h"

@interface AppDelegate () <UserDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    //ArraySample *arraySample = [[ArraySample alloc] init];
    
    /*
    User *user = [[User alloc] initWithName:@"Honda"];
    user.isMale = true;
    user.nickName = @"AAA";
    user.delegate = self;
    [user dump];
    [user setAge:40 completion:^(BOOL isOk, NSString *errorCode) {
        NSLog(@"setAge completion!");
    }];
    
    SpecialUser *spu = [[SpecialUser alloc] initWithName:@"Yamaha"];
    spu.isMale = true;
    spu.nickName = @"BBB";
    [spu dump];
     */
    
    //ValueOrRef *vr = [[ValueOrRef alloc] init];
    
    /*
    SubThread *st = [[SubThread alloc] init];
    //[st runSubThread];
    [st runSemaphore];
    [st runSemaphore];
     */
    
    return YES;
}

// Userクラスの自作デリゲート <UserDelegate>
- (void)didUpdateUser:(int)number {
    NSLog(@"didUpdateUser!!!!!");
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
