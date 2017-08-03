//
//  JDTipHubManager.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/2.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDSingleton.h"
@interface JDTipHubManager : NSObject
singleton_interface(JDTipHubManager);
@property(nonatomic,readonly)BOOL showAccontTip;
-(void)redSpot;
-(BOOL)showTipHubWithOrderId:(NSString *)orderId;
-(BOOL)showTipHubWithXunJiaId:(NSString *)xunJiaId;

-(void)delTipHubWithOrderId:(NSString *)orderId;
-(void)delTipHubWithXunJiaId:(NSString *)xunJiaId;
@end
