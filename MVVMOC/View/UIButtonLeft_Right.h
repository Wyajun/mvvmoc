//
//  UIButton_WyjLorR.h
//  KaiXinYunPan
//
//  Created by 王亚军 on 14-4-22.
//  Copyright (c) 2014年 王亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonLeft_Right : UIButton
@property(nonatomic)CGFloat startImageX; // 距离左侧的间距
@property(nonatomic)CGFloat SpaceTitle; // 图片与文字之间的间距
@property(nonatomic)CGFloat buttonHeight;// 文字的高度
+(instancetype)initWithTitle:(NSString *)title ImageIcon:(NSString *)imgName BackGround:(UIColor *)bcolor;

- (CGRect)titleRectForContentRect:(CGRect)contentRect;
- (CGRect)imageRectForContentRect:(CGRect)contentRect;

@end
