//
//  NSString+Time.h
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/24.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)



// 今天
- (BOOL) isToday;
// 明天
- (BOOL) isTomorrow;
// 后天
- (BOOL) isAfterTomorrow;


/**
 *  将当前的时间字符串转换成今天、明天或者后天，其他时间显示月日 最终格式为 今天（周一）时分 24小时制
 *
 *  @return
 */
- (NSString*) converteTimeDescription;
/**
 *  将当前的时间字符串转换成今天、明天或者后天，其他时间显示月日 最终格式为 今天（周一）
 *
 *  @return
 */
- (NSString*) converteTimeDescription1;
/**
 *  将当前的时间字符串转换成yyyy-mm-dd
 *
 *  @return
 */
- (NSString*) converteTimeDescription2;

/**
 *  将当前的时间字符串转换成qq显示时间
 *
 *  @return
 */
- (NSString*) converteTimeDescription3;

/**
 *  将当前的时间字符串转换yyyy-mm-dd hh-mm-ss
 *
 *  @return
 */
- (NSString*) converteTimeDescription4;

/**
 *  比较当前时间戳大小 格式yyyy-mm-dd
 *
 *  @return
 */
-(NSComparisonResult )compareTimeStr:(NSString *)string;
@end
