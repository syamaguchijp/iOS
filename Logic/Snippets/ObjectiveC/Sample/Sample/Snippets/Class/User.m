//
//  User.m
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import "User.h"


@interface User () {
    int age; // プライベートなメンバ変数
}

@end

@implementation User

@synthesize name; // propteryはsynthesizeすればこの名称でアクセスできる
@synthesize isMale;

// イニシャライザ
- (id)init {
    self = [super init];
    if (self != nil) {
        age = 20;
    }
    return self;
}

// イニシャライザ（引数付き）
- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self != nil) {
        self.name = name;
    }
    return self;
}

// セッター
- (NSString *)nickName {
    return nickName;
}

// ゲッター
- (void)setNickName:(NSString *)n {
    nickName = n;
}

- (void)setAge:(int)value completion:(setAgeCompletionHandler)handler {
    age = value;
    handler(YES, @"NO_ERROR");
    
}

- (void)dump {
    NSLog(@"name=%@ nickName=%@ age=%d isMale=%d", name, nickName, age, isMale);
    
    // デリゲート
    if ([self.delegate respondsToSelector:@selector(didUpdateUser:)]) {
        [self.delegate didUpdateUser:1000];
    }
}

@end
