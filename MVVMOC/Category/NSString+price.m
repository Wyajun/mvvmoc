//
//  NSString+price.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/3.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "NSString+price.h"

@implementation NSString (price)
-(NSString *)wanyanQianfengWei {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
    return  [formatter stringFromNumber:[NSNumber numberWithInteger:[ self floatValue]*10000]];
}
-(NSString *)QianfengWei {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
     return  [formatter stringFromNumber:[NSNumber numberWithFloat:[ self floatValue]]];
}
-(NSString *)wanYuan {
    CGFloat wan = [self floatValue];
    return [NSString stringWithFormat:@"%.2f万元",wan/10000];
}
-(NSString *)wanYuan1 {
    CGFloat wan = [self floatValue];
    return [NSString stringWithFormat:@"%.2f",wan/10000];
}
-(NSString *)fenZhuanYuan {
    CGFloat wan = [self floatValue];
    return [NSString stringWithFormat:@"%.0f",wan/100];
}
-(NSString *)xiaoShuLiangWei {
    CGFloat wan = [self floatValue];
    return [NSString stringWithFormat:@"%.2f",wan/100];
}
@end
