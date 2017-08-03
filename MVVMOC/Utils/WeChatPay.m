//
//  JDWeChatPay.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/8.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "WeChatPay.h"
#import "AlertController.h"
#import "WXApi.h"
#import "WXApiObject.h"
@implementation WeChatPay
singleton_implementation(WeChatPay);
-(void)weChatPay:(NSDictionary *)param {
    if ([param isKindOfClass:[NSDictionary class]]) {
        NSDictionary *reluteDic = param;
        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {

            //调起微信支付
            PayReq *request = [[PayReq alloc] init];
            request.openID  = reluteDic[@"appid"];
            request.partnerId = reluteDic[@"mch_id"];
            request.prepayId= reluteDic[@"prepay_id"];
            request.package = @"Sign=WXPay";//reluteDic[@"trade_type"];
            request.nonceStr= reluteDic[@"nonce_str"];
            request.timeStamp= [reluteDic[@"timestamp"] intValue];
            request.sign = reluteDic[@"client_sign"];
            //request.sign = sign;
            if (request.sign&&request.partnerId &&request.prepayId &&request.package && request.nonceStr && (request.timeStamp >0)) {
                [WXApi sendReq:request];
            }
        }else {
            [AlertController alterWithTitle:@"" message:@"您还没有安装微信，请安装后重试" cancelButtonTitle:@"确定" otherButtonTitles:nil selectIndex:nil];
        }
    }else {
        [AlertController alterWithTitle:@"提示" message:@"参数错误" cancelButtonTitle:@"确定" otherButtonTitles:nil selectIndex:nil];
    }
}
@end
