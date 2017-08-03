//
//  JDThread.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/16.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "Thread.h"

@implementation Thread
+(void)afterSecRun:(CGFloat)sce block:(void (^)())block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sce * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (block) {
            block();
        } });
}
+(void)runInMain:(void (^)())block {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}
@end
