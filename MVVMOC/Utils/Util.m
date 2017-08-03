//
//  JDUtil.m
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/6.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (BOOL)checkCellphone:(NSString *)cellphone
{
    //NSString *Regex = @"(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9])\\d{8}";
    NSString *Regex = @"(1[0-9])\\d{9}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:cellphone];
}

+ (BOOL)checkPassWord:(NSString *)password
{
    NSString * regex = @"(^[A-Za-z0-9]{6,16}$)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

/*
 *  判断object为空
 *
 *  @param object id
 *
 *  @return YES就是空
 */
+ (BOOL)isBlankObject:(id)object
{
    if (object == nil) {
        return YES;
    }
    if (object == NULL) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        if ([[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        } else {
            const char *str = [object UTF8String];
            if (strlen(str) == 0) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark -- 时间控件中 关于时间处理
// 转换到对应时区的时间Date
+ (NSDate *)convertDate:(NSDate *)date toTimeZone:(NSString *)timeZoneAbbreviation
{
    if (!date) {
        return nil;
    }
    //时区为空是 采用本地时区
    if (!timeZoneAbbreviation) {
        timeZoneAbbreviation = [[NSTimeZone localTimeZone] name];
    }
    
    NSTimeZone *locationZone  = [NSTimeZone systemTimeZone];
    NSTimeZone *zoneUTC     =   [NSTimeZone timeZoneWithName:timeZoneAbbreviation];
    NSTimeInterval s        = [zoneUTC secondsFromGMTForDate:date];
    NSTimeInterval p        = [locationZone secondsFromGMTForDate:date];
    NSTimeInterval i = s-p;
    NSDate *d = [NSDate dateWithTimeInterval:i sinceDate:date];
    return d;
}

+ (NSDate *)convertDate:(NSDate *)date fromTimeZone:(NSString *)fromZone toTimeZone:(NSString *)timeZoneAbbreviation
{
    if (!date) {
        return nil;
    }
    //时区为空是 采用本地时区
    if (!timeZoneAbbreviation) {
        timeZoneAbbreviation = [[NSTimeZone localTimeZone] name];
    }
    if (!fromZone) {
        fromZone = [[NSTimeZone localTimeZone] name];
    }
    
    NSTimeZone *locationZone  = [NSTimeZone timeZoneWithName:fromZone];
    NSTimeZone *zoneUTC     =   [NSTimeZone timeZoneWithName:timeZoneAbbreviation];
    NSTimeInterval s        = [zoneUTC secondsFromGMTForDate:date];
    NSTimeInterval p        = [locationZone secondsFromGMTForDate:date];
    NSTimeInterval i = s-p;
    NSDate *d = [NSDate dateWithTimeInterval:i sinceDate:date];
    return d;
}

+ (NSTimeInterval)formatNowTimeOffset:(float)offsetHour
{
    NSTimeInterval latter = 3600 * offsetHour;
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    if (offsetHour > 0) {
        timeInterval += latter;
    }
    return timeInterval;
}
@end
