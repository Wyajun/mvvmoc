//
//  JDUtil.h
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/6.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//检查电话号码是否合法
+ (BOOL)checkCellphone:(NSString *)cellphone;

//检查密码是否合法
+ (BOOL)checkPassWord:(NSString *)password;

//判断对象是否为空
+ (BOOL)isBlankObject:(id)object;

+ (NSDate *)convertDate:(NSDate *)date toTimeZone:(NSString *)timeZoneAbbreviation;

+ (NSDate *)convertDate:(NSDate *)date fromTimeZone:(NSString *)fromZone toTimeZone:(NSString *)timeZoneAbbreviation;

+ (NSTimeInterval)formatNowTimeOffset:(float)offsetHour;
@end


//double none = 5;
//double one = 5.1;
//double two = 5.01;
//double lots = 5.918286558251858392107584219;
//
//NSNumber *numberNone = [NSNumber numberWithDouble:none];
//NSNumber *numberOne = [NSNumber numberWithDouble:one];
//NSNumber *numberTwo = [NSNumber numberWithDouble:two];
//NSNumber *numberLots = [NSNumber numberWithDouble:lots];
//
//NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//formatter.roundingIncrement = [NSNumber numberWithDouble:0.01];
//formatter.numberStyle = NSNumberFormatterDecimalStyle;
//
//NSLog(@"%@",[formatter stringFromNumber:numberNone]);
//NSLog(@"%@",[formatter stringFromNumber:numberOne]);
//NSLog(@"%@",[formatter stringFromNumber:numberTwo]);
//NSLog(@"%@",[formatter stringFromNumber:numberLots]);