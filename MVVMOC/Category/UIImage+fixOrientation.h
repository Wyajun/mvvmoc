//
//  UIImage+fixOrientation.h
//  youwo
//
//  Created by robbie on 13-10-10.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

/*
 * max : 单位 M
 */
- (NSData *)fixImageMaxSize:(CGFloat)max;

/*
 * 按窄边最大值裁剪  narrowMax ： 窄边最大值
 */
- (UIImage *)resizeImage:(NSInteger)narrowMax;

/*
 * 修正图片显示方向不正确问题
 */
- (UIImage *)fixOrientation;

@end
