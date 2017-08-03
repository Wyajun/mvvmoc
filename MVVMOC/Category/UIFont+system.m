//
//  UIFont+system.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/15.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "UIFont+system.h"

@implementation UIFont (system)
+(CGFloat)systemFontOfText1Size{
    return 15;
}
/// 15
+(UIFont *)systemFontOfText1Font{
    return [UIFont systemFontOfSize:15];
}

/// 13
+(CGFloat)systemFontOfText2Size {
    return 13;
}
/// 13
+(UIFont *)systemFontOfText2Font;{
    return [UIFont systemFontOfSize:13];
}


/// 10
+(CGFloat)systemFontOfText3Size;{
    return 10;
}
/// 10
+(UIFont *)systemFontOfText3Font; {
    return [UIFont systemFontOfSize:10];
}

/// 40
+(CGFloat)systemFontOfText4Size; {
    return 40;
}
/// 40
+(UIFont *)systemFontOfText4Font; {
    return [UIFont systemFontOfSize:40];
}

/// 17
+(CGFloat)systemFontOfText5Size; {
    return 17;
}
/// 17
+(UIFont *)systemFontOfText5Font; {
    return [UIFont systemFontOfSize:17];
}

/// 16
+(CGFloat)systemFontOfBntSize; {
    return 16;
}
/// 16
+(UIFont *)systemFontOfBntFont; {
  return   [UIFont systemFontOfSize:16];
}
@end
