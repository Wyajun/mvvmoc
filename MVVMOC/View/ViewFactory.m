//
//  TJViewFactory.m
//  TuJia
//
//  Created by 王亚军 on 16/4/19.
//  Copyright © 2016年 途家. All rights reserved.
//

#import "ViewFactory.h"
#import "Masonry.h"
@implementation ViewFactory
+(UILabel *)creatLab:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color {
    UILabel *lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor whiteColor];
    if (!title) {
        title = @"";
    }
    lab.text = title;
    lab.font = font;
    lab.textColor = color;
    return lab;
}


@end
