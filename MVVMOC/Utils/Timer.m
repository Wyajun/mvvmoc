//
//  KZTimer.m
//  iOSAnalyze
//
//  Created by joywii on 15/4/1.
//  Copyright (c) 2015年 sohu. All rights reserved.
//

#import "Timer.h"

@interface Timer()

@property (nonatomic) dispatch_source_t source;
@property (nonatomic, assign) BOOL suspended;

@end

@implementation Timer

+ (Timer *)timerWithInterval:(uint64_t)interval
                         leeway:(uint64_t)leeway
                          queue:(dispatch_queue_t)queue
                          block:(dispatch_block_t)block
{
    return [[Timer alloc] initWithInterval:interval leeway:leeway queue:queue block:block];
}

+ (Timer *)timerWithStart:(uint64_t)start leeway:(uint64_t)leeway queue:(dispatch_queue_t)queue block:(dispatch_block_t)block
{
    return [[Timer alloc] initWithStart:start leeway:leeway queue:queue block:block];
}

- (id)initWithInterval:(uint64_t)interval
                leeway:(uint64_t)leeway
                 queue:(dispatch_queue_t)queue
                 block:(dispatch_block_t)block
{
    self = [super init];
    if (self == nil) return nil;
    
    self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (self.source != nil) {
        dispatch_source_set_timer(self.source,dispatch_walltime(NULL, 0),interval,leeway);
        dispatch_source_set_event_handler(self.source, block);
    }
    self.suspended = YES;
    
    return self;
}

- (id)initWithStart:(uint64_t)start leeway:(uint64_t)leeway queue:(dispatch_queue_t)queue block:(dispatch_block_t)block
{
    self = [super init];
    if (self == nil) return nil;
    
    self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (self.source != nil) {
        dispatch_source_set_timer(self.source, dispatch_walltime(NULL, start), DISPATCH_TIME_FOREVER, leeway);
        dispatch_source_set_event_handler(self.source, block);
    }
    self.suspended = YES;
    
    return self;
}
- (void)dealloc
{
    [self resume];
}
- (void)resume {
    if (!self.suspended) return;
    
    dispatch_resume(self.source);
    self.suspended = NO;
}

- (void)suspend {
    if (self.suspended) return;
    
    dispatch_suspend(self.source);
    self.suspended = YES;
}

- (void)cancel {
    dispatch_source_cancel(self.source);
}
@end
