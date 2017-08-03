//
//  UIButtonUp_down.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/25.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "UIButtonUp_down.h"

@implementation UIButtonUp_down
#pragma mark 调整内部ImageView的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    CGFloat titleY = image.size.height + _startImageY + _SpaceTitle;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    return CGRectMake(0, titleY, self.bounds.size.width,  titleHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    return CGRectMake((self.bounds.size.width-image.size.width)/2, _startImageY, image.size.width, image.size.height);
}
@end
