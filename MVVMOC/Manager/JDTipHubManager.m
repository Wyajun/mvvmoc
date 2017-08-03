//
//  JDTipHubManager.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/2.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "JDTipHubManager.h"
#import "NoticeManager.h"
#import "JDC2BHttpMgr.h"
@interface JDTipHubManager ()
@property(nonatomic,strong)NSMutableDictionary *tipHubDic;
@property(nonatomic)BOOL accontTip;
@end


@implementation JDTipHubManager

static NSString *const tipHubDic = @"tipHubDic";
singleton_implementation(JDTipHubManager);
-(instancetype)init {
    self = [super init];
    [self readTipHub];
    [[NoticeManager sharedNoticeManager] addAppBecomeActive:self Block:^{
        [self readTipHub];
    }];
    [[NoticeManager sharedNoticeManager]addAppEnterBackground:self Block:^{
        [self writeTipHub];
    }];
    return self;
}
-(void)readTipHub{
    if (self.tipHubDic.count <= 0) {
        self.tipHubDic = [NSMutableDictionary dictionaryWithDictionary:DefaultValueForKey(tipHubDic)];
    }
}
-(void)writeTipHub{
    DefaultSetValueForKey(_tipHubDic, tipHubDic)
}
// type:1为询价，2为购车
-(BOOL)showTipHubWithOrderId:(NSString *)orderId {
    
    NSString *key = [@"2:" stringByAppendingString:orderId];
    return [self showTipHubId:key];
}

-(BOOL)showTipHubWithXunJiaId:(NSString *)xunJiaId {
    NSString *key = [@"1:" stringByAppendingString:xunJiaId];
    return [self showTipHubId:key];
}


-(void)delTipHubWithOrderId:(NSString *)orderId {
     NSString *key = [@"2:" stringByAppendingString:orderId];
    [self delTipHUbId:key];
}
-(void)delTipHubWithXunJiaId:(NSString *)xunJiaId {
      NSString *key = [@"1:" stringByAppendingString:xunJiaId];
      [self delTipHUbId:key];
}

-(BOOL)showTipHubId:(NSString *)Id {
    @synchronized(_tipHubDic) {
        return [_tipHubDic[Id] boolValue];
    }
}
-(void)delTipHUbId:(NSString *)Id {
    @synchronized(_tipHubDic) {
        return [_tipHubDic removeObjectForKey:Id];
    }
}
-(void)setHubDic:(NSArray *)dic {
    @synchronized(_tipHubDic) {
        for (NSDictionary *type in dic) {
            NSString *type1 = [NSString stringWithFormat:@"%@:",type[@"type"]];
            for (NSString *typeID in type[@"ids"]) {
                NSString *key = [type1 stringByAppendingString:typeID];
                _tipHubDic[key] = @(YES);
            }
        }
    }
}
-(void)redSpot {
    [[JDC2BHttpMgr shareHttpMgr] JDRedSpot:^(CommontCallBack *ccb) {
        if ( ccb.code == 0) {
            [self setHubDic:ccb.result[@"result"]];
        }
    }];
}
@end
