//
//  User.h
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

// デリゲートするためのプロトコル
@protocol UserDelegate <NSObject>
@optional
- (void)didUpdateUser:(int)number;
@end

// クロージャ
typedef void (^setAgeCompletionHandler)(BOOL isOk, NSString *errorCode);

@interface User : NSObject {
    NSString *nickName; // @property宣言していないため、セッターとゲッターが必要
}

// イニシャライザ
- (id)initWithName:(NSString *)name;

// セッターとゲッター
- (NSString *)nickName;
- (void)setNickName:(NSString *)nickName;

// @property宣言するため、セッターとゲッターは不要
@property (nonatomic, assign) BOOL isMale;
@property (nonatomic, retain) NSString *name;

// Publicなメソッド
- (void)setAge:(int)value completion:(setAgeCompletionHandler)handler;
- (void)dump;

// デリゲートプロパティ
@property (weak, nonatomic) id<UserDelegate> delegate; // 弱参照で

@end

NS_ASSUME_NONNULL_END
