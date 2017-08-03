//
//  JDThread.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/16.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thread : NSObject
+(void)afterSecRun:(CGFloat)sce block:(void(^)())block;
+(void)runInMain:(void(^)())block;
@end
