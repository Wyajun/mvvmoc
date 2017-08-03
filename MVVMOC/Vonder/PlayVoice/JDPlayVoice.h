//
//  JDPlayVoice.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/8/4.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDPlayVoice : NSObject
+(instancetype)shareJDPlayVoice;
-(void)playVoice; // 播放音频
-(void)playShake; // 震动
@end
