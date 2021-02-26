//
//  ArraySample.m
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import "ArraySample.h"

@implementation ArraySample

- (id)init
{
    // NSArray
    
    // 生成
    NSArray *array = [NSArray arrayWithObjects:@"TOKYO", @"OSAKA", @"HAKATA", nil];
    array = [[NSArray alloc] initWithObjects:@"TOKYO", @"OSAKA", @"HAKATA", nil];
    array = @[@"TOKYO", @"OSAKA", @"HAKATA"];
    
    // アクセス
    NSLog(@"array[0]=%@", array[0]);
    NSLog(@"array[0]=%@", [array objectAtIndex:1]);
    NSLog(@"lastObject=%@", [array lastObject]);
    NSLog(@"count=%d", [array count]);
    
    // 存在確認
    if ([array containsObject:@"HAKATA"]) {
        NSLog(@"contains Hakata");
    }
    
    // 走査
    for (int i = 0; i < array.count; i++) {
        NSLog(@"for %@", array[i]);
    }
    for (NSString *obj in array) {
        NSLog(@"for in %@", obj);
    }
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%d: %@", idx, obj);
    }];
    
    // NSMutableArray
    
    // 生成
    NSMutableArray *mArrray = [NSMutableArray array];
    mArrray = [NSMutableArray arrayWithObjects:@"TOKYO", @"OSAKA", @"HAKATA", nil];
    mArrray = [@"TOKYO", @"OSAKA", @"HAKATA" mutableCopy];
    
    // 追加
    [mArrray addObject:@"HIROSIMA"];
    [mArrray addObject:[NSNull null]]; // 空要素
    
    // 削除
    [mArrray removeObject:@"HIROSIMA"];
    [mArrray removeObjectAtIndex:1];
    
    
    // NSDictionary
    
    // 生成
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"value1", @"key1",
                          @"value2", @"key2",
                          @"value3", @"key3",
                          nil];
    dict = @{@"key1":@"value1", @"key2":@"value2", @"key3":@"value3"};
             
                             
    // アクセス
    NSLog(@"dict key1=%@", [dict objectForKey: @"key1"]);
    NSLog(@"dict key1=%@", [dict valueForKey: @"key1"]);
    NSLog(@"dict key1=%@", dict[@"key1"]);
    NSLog(@"count=%d", [dict count]);
    
    // 走査
    for (id key in [dict keyEnumerator]) {
        NSLog(@"%@: %@", key, dict[key]);
    }
    for (id value in [dict objectEnumerator]) {
        NSLog(@"%@", value);
    }
    for (id key in dict){
        NSLog(@"%@: %@", key, dict[key]);
    }
    
    // NSMutableDictionary
    
    // 生成
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic = [@{@"key4": @"value4",
              @"key5": @"value5",
              @"key6": @"value6"} mutableCopy];
    
    // 追加
    [mDic setObject:@"value1" forKey:@"key1"];
    [mDic setObject:@"value2" forKey:@"key2"];
    [mDic setObject:@"value3" forKey:@"key3"];
    
    // 更新
    [mDic setObject:@"AAAA" forKey:@"key1"];
    mDic[@"key3"] = @"BBBB";
    
    // 削除
    [mDic removeObjectForKey:@"key2"];
    
    for (id key in mDic){
        NSLog(@"%@: %@", key, mDic[key]);
    }
    
    // NSMutableSet
    
    // 生成
    NSMutableSet *set = [NSMutableSet setWithObjects:@"A", @"B", @"C", nil];
    set = [[NSMutableSet alloc] initWithObjects:@"A", @"B", @"C", nil];
    
    // 追加
    [set addObject:@"A"];
    
    // 削除
    [set removeObject:@"B"];
    //[set removeAllObjects];
    
    // 走査
    for (NSString *obj in set){
        NSLog(@"set %@", obj);
    }
    
    
    self = [super init];
    
    return self;
}


@end
