//
//  JDNotificationHub.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/2.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "NotificationHub.h"

@implementation NotificationHub

-(instancetype)initWithShowInView:(UIView *)view {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        [view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(8, 8));
            make.left.mas_equalTo(view.mas_right).with.mas_equalTo(0);
            make.top.mas_equalTo(-4);
        }];
        [self hiddenInView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)showInView {
    self.hidden = NO;
}
-(void)hiddenInView {
    self.hidden = YES;
}
@end
