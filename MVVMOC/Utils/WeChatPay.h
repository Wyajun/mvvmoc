//
//  JDWeChatPay.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/8.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDSingleton.h"
@interface WeChatPay : NSObject
singleton_interface(WeChatPay);
// 微信支付
-(void)weChatPay:(NSDictionary *)param ;
@end
