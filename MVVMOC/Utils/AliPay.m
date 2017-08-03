//
//  JDAliPay.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/8.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "AliPay.h"
#import "NoticeManager.h"
#import <AlipaySDK/AlipaySDK.h>
@implementation AliPay
singleton_implementation(AliPay);

-(void)aliPay:(NSString *)param {
    [[AlipaySDK defaultService] payOrder:param fromScheme:kAliPayAppid callback:^(NSDictionary *resultDic) {
        [[NoticeManager sharedNoticeManager] aliPayChongZhiResultNotification:resultDic];
    }];
}
- (void)aliPayConfirmOrderFailure:(void(^)(NSError *error))failure
{
    
}
@end
