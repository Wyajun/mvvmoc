//
//  KZTimer.h
//  iOSAnalyze
//
//  Created by joywii on 15/4/1.
//  Copyright (c) 2015年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject

+ (Timer *)timerWithInterval:(uint64_t)interval
                        leeway:(uint64_t)leeway
                         queue:(dispatch_queue_t)queue
                         block:(dispatch_block_t)block;

+ (Timer *)timerWithStart:(uint64_t)start
                     leeway:(uint64_t)leeway
                      queue:(dispatch_queue_t)queue
                      block:(dispatch_block_t)block;

- (id)initWithInterval:(uint64_t)interval
                leeway:(uint64_t)leeway
                 queue:(dispatch_queue_t)queue
                 block:(dispatch_block_t)block;

- (id)initWithStart:(uint64_t)start
             leeway:(uint64_t)leeway
              queue:(dispatch_queue_t)queue
              block:(dispatch_block_t)block;

- (void)resume;
- (void)suspend;
- (void)cancel;

@end
