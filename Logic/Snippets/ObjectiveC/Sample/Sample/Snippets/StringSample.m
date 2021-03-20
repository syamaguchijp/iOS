//
//  StringSample.m
//  Sample
//
//  Created by admin on 2021/03/20.
//

#import "StringSample.h"

@implementation StringSample

- (id)init
{
    
    NSString *str = @"ABCDEFG12345";

    // 文字列内の変数利用
    NSLog(@"str = %@", str);

    // 一致判定
    NSString *strA = @"ABC";
    NSLog(@"%d", [strA isEqualToString:@"ABC"]);
    NSLog(@"%d", [strA caseInsensitiveCompare:@"aBc"] == NSOrderedSame);

    // 長さ
    NSLog(@"%ld", str.length);

    // 切り出し
    NSString *strAiueo = @"あいうえお";
    NSLog(@"%@", [strAiueo substringToIndex:2]); // あい（指定したインデックスを含まない。2=う）
    NSLog(@"%@", [strAiueo substringFromIndex:2]); // うえお（指定したインデックスを含む。2=う）
    NSLog(@"%@", [strAiueo substringWithRange:NSMakeRange(1,3)]); // いうえ

    // 検索
    NSLog(@"%d", [str containsString:@"ABC"]); // true
    NSLog(@"%d", [str hasPrefix:@"ABC"]); // true
    NSLog(@"%d", [str hasSuffix:@"45"]); // true

    // 分割
    NSArray *array = [@"A,B,C,D" componentsSeparatedByString:@","];
    for (NSString *str in array) {
        NSLog(@"for in %@", str);
    }

    // 結合
    NSLog(@"%@", [@"Honda" stringByAppendingString:@"Kawasaki"]);

    // 大文字小文字
    NSLog(@"%@", [@"abc" uppercaseString]); // ABC
    NSLog(@"%@", [@"ABC" lowercaseString]); // abc
    // 先頭の文字列のみ
    NSLog(@"%@", [@"abc" capitalizedString]); // Abc

    // 置換
    NSLog(@"%@", [str stringByReplacingOccurrencesOfString: @"AB" withString: @"XXX"]);

    // 前後の空白を削除
    NSString *str2 = @" ab cd ";
    NSLog(@"%@", [str2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]); // ab cd

    // フォーマット
    NSLog(@"%@", [NSString stringWithFormat:@"%05d", 123]); // 00123
    
    // 数値に変換
    NSString *numStr = @"123";
    NSLog(@"%d", [numStr intValue]);
    
    
    self = [super init];
    
    return self;
}

@end
