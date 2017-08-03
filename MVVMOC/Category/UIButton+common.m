//
//  UIButton+common.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/7/20.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import "UIButton+common.h"

@implementation UIButton (common)
+(UIButton *)creatBnt {
    UIButton *bnt = [[UIButton alloc] init];
    bnt.layer.cornerRadius = 3;
    bnt.clipsToBounds = YES;
    bnt.backgroundColor = UIColorFromRGB(0xde554c);
    return bnt;
}
@end
