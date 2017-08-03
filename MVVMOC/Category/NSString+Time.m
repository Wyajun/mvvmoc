//
//  NSString+Time.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/24.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

-(NSString *)converteTimeDescription {
    
    static NSDateFormatter* format = nil;
    NSDate* date = [self fromatDate];
    if (!format) {
        format = [[NSDateFormatter alloc] init];
        
    }
    if ([self isToday]) {
        [format setDateFormat:@"(EEEE) HH:mm"];
        return [NSString stringWithFormat:@"今天 %@",[format stringFromDate:date]];
    }
    if ([self isTomorrow]) {
        [format setDateFormat:@"(EEEE) HH:mm"];
        return [NSString stringWithFormat:@"明天 %@",[format stringFromDate:date]];
    }
    if ([self isAfterTomorrow]) {
        [format setDateFormat:@"(EEEE) HH:mm"];
        return [NSString stringWithFormat:@"后天 %@",[format stringFromDate:date]];
    }
    [format setDateFormat:@"MM-dd (EEEE) HH:mm"];
    return [format stringFromDate:date];
    
    return nil;
}
-(NSString *)converteTimeDescription1 {
    static NSDateFormatter* format = nil;
    NSDate* date = [self fromatDate];
    if (!format) {
        format = [[NSDateFormatter alloc] init];
        
    }
    if ([self isToday]) {
        [format setDateFormat:@"(EEEE)"];
        return [NSString stringWithFormat:@"今天 %@",[format stringFromDate:date]];
    }
    if ([self isTomorrow]) {
        [format setDateFormat:@"(EEEE)"];
        return [NSString stringWithFormat:@"明天 %@",[format stringFromDate:date]];
    }
    if ([self isAfterTomorrow]) {
        [format setDateFormat:@"(EEEE)"];
        return [NSString stringWithFormat:@"后天 %@",[format stringFromDate:date]];
    }
    [format setDateFormat:@"MM-dd (EEEE)"];
    return [format stringFromDate:date];
}
-(NSString *)converteTimeDescription2 {
    static NSDateFormatter* format = nil;
    NSDate* date = [self fromatDate];
    if (!format) {
        format = [[NSDateFormatter alloc] init];
    }
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:date];
}
-(NSString *)converteTimeDescription3 {
    static NSDateFormatter* format = nil;
    NSDate* date = [self fromatDate];
    if (!format) {
        format = [[NSDateFormatter alloc] init];
        
    }
    if ([self isToday]) {
        [format setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
    }
    if ([self isYesterday]) {
        return @"昨天";
    }
    [format setDateFormat:@"EEEE"];
    return [format stringFromDate:date];
}
-(NSString *)converteTimeDescription4 {
    static NSDateFormatter* format = nil;
    NSDate* date = [self fromatDate];
    if (!format) {
        format = [[NSDateFormatter alloc] init];
         [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
   
    return [format stringFromDate:date];
}
-(NSComparisonResult )compareTimeStr:(NSString *)string {
    NSString *time = [string converteTimeDescription2];
    NSString *time1 = [self converteTimeDescription2];
    return [time1 compare:time];
}

#pragma --mark 以下为工具方法
- (NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL) isEqualToStringIgnoreCase:(NSString *)aString
{
    if (aString && [aString isKindOfClass:[NSString class]]) {
        return [[self lowercaseString] isEqualToString: [aString lowercaseString]];
    }
    return NO;
}

- (NSDate*) fromatDate
{
    NSString* trim = [self trim];
    
    if ([@"" isEqualToString:trim]) {
        return [NSDate date];
    }
    
    static NSNumberFormatter* format = nil;
    if (!format) {
        format = [[NSNumberFormatter alloc] init];
    }
    if([format numberFromString:trim])
    {
        //为纯数字
        NSInteger sec = [trim integerValue];
        return [NSDate dateWithTimeIntervalSince1970:sec];
    }
    return [NSDate date];
}
//只有日期的字符串
- (NSString*) getDateString:(NSDate*) date
{
    static NSDateFormatter* format = nil;
    if (!format) {
        format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
    }
    return [format stringFromDate:date];
}

//判断两个时间是否是同一天
- (BOOL) isEqualDay:(NSDate*) date1 date:(NSDate*)date2
{
    NSString* date1Str = [self getDateString:date1];
    NSString* date2Str = [self getDateString:date2];
    if ([date1Str isEqualToStringIgnoreCase:date2Str]) {
        return YES;
    }
    return NO;
}

// 今天
- (BOOL) isToday {
    
    NSDate* date = [self fromatDate];
    NSDate* today = [self getToday];
    return [self isEqualDay:date date:today];
}

// 明天
- (BOOL) isTomorrow {
    NSDate* date = [self fromatDate];
    NSDate* today = [self getTomorrow];
    return [self isEqualDay:date date:today];
}
-(BOOL)isYesterday {
    NSDate* date = [self fromatDate];
    NSDate* today = [self getYesterday];
    return [self isEqualDay:date date:today];
}
// 后天
- (BOOL) isAfterTomorrow {
    NSDate* date = [self fromatDate];
    NSDate* today = [self getAfterTomorrow];
    return [self isEqualDay:date date:today];
}

-(NSDate *)getToday {
    return [NSDate date];
}

-(NSDate *)getTomorrow {
    NSDate* tomorrow = [[NSDate alloc]initWithTimeIntervalSinceNow: 86400];// 明天
    return tomorrow;
}
-(NSDate *)getYesterday {
    NSDate* tomorrow = [[NSDate alloc]initWithTimeIntervalSinceNow: -86400];// 明天
    return tomorrow;
}
-(NSDate *)getAfterTomorrow {
    NSDate* afterTomorrow = [[NSDate alloc]initWithTimeIntervalSinceNow: 172800];//后天
    return afterTomorrow;
}
@end
