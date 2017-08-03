//
//  JDNotificationHub.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/2.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationHub : UIView
-(instancetype)initWithShowInView:(UIView *)view;
-(void)showInView;
-(void)hiddenInView;
@end
