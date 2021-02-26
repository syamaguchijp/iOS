//
//  SpecialUser.m
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import "SpecialUser.h"

@implementation SpecialUser

// 親クラスのメソッドをオーバーライド
- (void)dump {
    NSLog(@"名前=%@ ニックネーム=%@ 性別=%d", self.name, nickName, self.isMale);
    
    [super dump]; // 親クラスのメソッドを呼んでみる
}

@end
