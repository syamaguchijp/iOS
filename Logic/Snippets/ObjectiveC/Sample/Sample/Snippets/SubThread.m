//
//  SubThread.m
//  Sample
//
//  Created by admin on 2021/02/26.
//

#import "SubThread.h"

@interface SubThread () {
}
@property (nonatomic, retain) dispatch_queue_t queue;
@property (nonatomic, retain) dispatch_semaphore_t semaphore;
@end

@implementation SubThread

-(id)init {
    
    self = [super init];
    
    // セマフォカウンタを1で初期化する（排他制御用）
    self.semaphore = dispatch_semaphore_create(1);
    self.queue = dispatch_queue_create("com.hoge.fuga", DISPATCH_QUEUE_CONCURRENT);
    
    return self;
}

// 普通にサブスレッドで実行する
-(void)runSubThread {
    
    NSLog(@"MainThread 1");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        // サブスレッドで実行
        NSLog(@"SubThread 1");
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"SubThread 2");
        dispatch_async(dispatch_get_main_queue(), ^(void){
            // メインスレッドで実行
            NSLog(@"MainThread 3");
        });
    });
    NSLog(@"MainThread 2");
}

// セマフォで排他制御してサブスレッドで実行する
-(void)runSemaphore {
    
    NSLog(@"runSemaphore start");
    
    // 非同期サブスレッド（排他制御）
    dispatch_barrier_async(self.queue, ^{
        
        NSLog(@"runSemaphore barrier_async start");
        
        // セマフォのカウンタが1以上になるまで待つ。これにより dispatch_semaphore_signal がコールされるまで、排他制御が可能。
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        
        [NSThread sleepForTimeInterval:5.0];
       
        // 排他制御用セマフォのカウンタを戻して、排他制御を解除
        dispatch_semaphore_signal(self.semaphore);
        
        NSLog(@"runSemaphore barrier_async end");
    });
}

@end
