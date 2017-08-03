//
//  UILabel+creat.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/7/20.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import "UILabel+creat.h"

@implementation UILabel (creat)
+(UILabel *)creatLab:(NSString *)text textcolor:(UIColor *)color font:(CGFloat)font {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:font];
    lab.textColor = color;
    if ([text isKindOfClass:[NSString class]]) {
      lab.text = text;
    }else {
      lab.text = @"";
    }
    
    return lab;
}
@end
