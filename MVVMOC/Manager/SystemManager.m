//
//  SystemManager.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/26.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "SystemManager.h"
#import "JDPlayVoice.h"
#import "NoticeManager.h"
#import "UserManager.h"
#define KSYEVOICETYPE @"sysvoicetype"


@implementation SystemManager
+(instancetype)shareSystemManager {
    static SystemManager *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[SystemManager alloc] initSuper];
    });
    return _share;
}
-(instancetype)initSuper {
    self = [super init];
    if (self) {
       
    }
    return self;
}
-(instancetype)init {
    NSAssert(NO, @"请使用单利方法");
    return nil;
}
+(void)load {
    [NoticeManager sharedNoticeManager];
}
-(BOOL)isResetLogin {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldVersion"];
    if ([currentVersion isEqualToString:oldVersion]) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"oldVersion"];
    return NO;
}
-(NSString *)appvesrion {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([kJDBASEURL isEqualToString:@"http://dev2.jiadao.cn/"]) {
        return [NSString stringWithFormat:@"测试版 v%@",currentVersion];
    }
    return [@"v" stringByAppendingString:currentVersion];
}
#pragma --mark 推送播放声音处理
-(void)PlayVoice {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:KSYEVOICETYPE];
    if (!number) {
        number = @(1);
    }
    NSInteger type = [number integerValue];
    if (type == 1) {
        [[JDPlayVoice shareJDPlayVoice] playVoice];
    }
    if (type == 2) {
        [[JDPlayVoice shareJDPlayVoice] playShake];
    }
}
-(void)setVocieType:(NSInteger)voiceType {
    [[NSUserDefaults standardUserDefaults] setObject:@(voiceType) forKey:KSYEVOICETYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSInteger)voiceType {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:KSYEVOICETYPE];
    if (!number) {
        number = @(1);
    }
    return [number integerValue];
}
-(NSString *)keFuPhone {
    return @"400-010-6766";
}
@end
