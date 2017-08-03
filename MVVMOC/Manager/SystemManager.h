//
//  SystemManager.h
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/26.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SystemManager : NSObject

+(instancetype)shareSystemManager;
//重置登陆
-(BOOL)isResetLogin;
// 系统版本
-(NSString *)appvesrion;
//  推送提示音处理
-(void)PlayVoice;
// 设置提示音
-(void)setVocieType:(NSInteger)voiceType; // 目前状态 0 静音 1 声音 2 震动
// 提示音类型
-(NSInteger)voiceType;

-(NSString *)keFuPhone;
@end
