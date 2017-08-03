//
//  UIButton_WyjLorR.m
//  KaiXinYunPan
//
//  Created by 王亚军 on 14-4-22.
//  Copyright (c) 2014年 王亚军. All rights reserved.
//

#import "UIButtonLeft_Right.h"
@implementation UIButtonLeft_Right

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)initWithTitle:(NSString *)title ImageIcon:(NSString *)imgName BackGround:(UIColor *)bcolor;
{
    UIButtonLeft_Right *LorR = [UIButtonLeft_Right buttonWithType:UIButtonTypeCustom];
    [LorR setTitle:title forState:UIControlStateNormal];
    [LorR setImage:[Resource imageName:imgName] forState:UIControlStateNormal ];
    [LorR setBackgroundColor:bcolor];
    return LorR;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    CGFloat titleX = image.size.width + _startImageX + _SpaceTitle;
    CGFloat titleWidth = self.bounds.size.width - titleX;
    if(_buttonHeight < 7) {
        _buttonHeight = self.self.bounds.size.height;
    }
    return CGRectMake(titleX, (self.bounds.size.height - _buttonHeight)/2, titleWidth,_buttonHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    return CGRectMake(_startImageX, (self.bounds.size.height - image.size.height)/2, image.size.width, image.size.height);
}

@end
