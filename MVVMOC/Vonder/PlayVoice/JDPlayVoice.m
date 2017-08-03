//
//  JDPlayVoice.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/8/4.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import "JDPlayVoice.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface JDPlayVoice()<AVAudioPlayerDelegate>
@property(nonatomic,strong)AVAudioPlayer *audioPlayer;
@end

@implementation JDPlayVoice
+(instancetype)shareJDPlayVoice {
    static JDPlayVoice *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[JDPlayVoice alloc ] initSuper];
    });
    return _share;
}
-(instancetype)initSuper {
    self = [super init];
    if (self) {
        NSString * musicPath = [[NSBundle mainBundle]  pathForResource:@"msg" ofType:@"wav"];
        if (musicPath) {
            NSURL * musicURL = [NSURL fileURLWithPath:musicPath];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
            self.audioPlayer.delegate = self;
            
        }
    }
    return self;
}
-(void)playShake {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
-(void)playVoice {
     AudioServicesPlaySystemSound(1007);
//    if (self.audioPlayer.playing) {
//        return;
//    }
//    [self.audioPlayer play];
}
@end
