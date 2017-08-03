//
//  JDAliPay.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/8.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDSingleton.h"
@interface AliPay : NSObject
singleton_interface(AliPay);
// 支付宝支付
- (void)aliPay:(NSString *)param ;
@end
