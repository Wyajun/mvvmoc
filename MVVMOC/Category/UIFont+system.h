//
//  UIFont+system.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/15.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 /// 15
 #define KTextFont1 15
 /// 13
 #define KTextFont2 13
 /// 10
 #define KTextFont3 10
 /// 40
 #define KTextFont4 40
 /// 17
 #define KTextFont5 17
 */
@interface UIFont (system)
/// 15
+(CGFloat)systemFontOfText1Size;
/// 15
+(UIFont *)systemFontOfText1Font;

/// 13
+(CGFloat)systemFontOfText2Size;
/// 13
+(UIFont *)systemFontOfText2Font;


/// 10
+(CGFloat)systemFontOfText3Size;
/// 10
+(UIFont *)systemFontOfText3Font;

/// 40
+(CGFloat)systemFontOfText4Size;
/// 40
+(UIFont *)systemFontOfText4Font;

/// 17
+(CGFloat)systemFontOfText5Size;
/// 17
+(UIFont *)systemFontOfText5Font;

/// 16
+(CGFloat)systemFontOfBntSize;
/// 16
+(UIFont *)systemFontOfBntFont;

@end
