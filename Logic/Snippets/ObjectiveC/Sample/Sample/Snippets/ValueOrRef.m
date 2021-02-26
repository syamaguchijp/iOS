//
//  ValueOrRef.m
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import "ValueOrRef.h"
#import "User.h"

@implementation ValueOrRef

- (id)init
{
    self = [super init];
    
    // 値型
    [self test1:7];
    [self test2: @"TOKYO"];
    
    // 参照型
    [self test10:[@[@"HONDA", @"SUZUKI", @"YAMAHA"] mutableCopy]];
    [self test11:[@{@"a": @"HONDA", @"b": @"SUZUKI", @"c": @"YAMAHA"} mutableCopy]];
    [self test12:[[User alloc] initWithName:@"HONDA"]];
    
    return self;
}

#pragma mark - 値型

- (void)test1:(int)num {
    int num2 = num;
    num2 = 100;
    NSLog(@"num=%d num2=%d", num, num2);
}

- (void)test2:(NSString *)str {
    NSString *str2 = str;
    str2 = @"OSAKA";
    NSLog(@"str=%@ str2=%@", str, str2);
}

#pragma mark - 参照型

- (void)test10:(NSMutableArray *)ary {
    NSMutableArray *ary2 = ary;
    ary2[0] = @"KAWASAKI";
    NSLog(@"ary=%@ ary2=%@", ary[0], ary2[0]);
}

- (void)test11:(NSMutableDictionary *)dict {
    NSMutableDictionary *dict2 = dict;
    dict2[@"a"] = @"KAWASAKI";
    NSLog(@"ary=%@ ary2=%@", dict[@"a"], dict2[@"a"]);
}

- (void)test12:(User *)user {
    User *user2 = user;
    user2.name = @"KAWASAKI";
    NSLog(@"user=%@ user2=%@", user.name, user2.name);
}

@end
