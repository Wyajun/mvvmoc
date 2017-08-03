//
//  JDHttpUtils.h
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/1.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtils : NSObject

+ (NSString *)userAgentString;

+ (NSString*)createMd5Sign:(NSMutableDictionary*)dict;
+ (NSDictionary *)commendParameterDic;
// 转换请求参数
+ (NSDictionary *)addCommonParameters:(NSDictionary *)_params;
/// 特定活动参数拼接
+(NSString *)dicToUrl:(NSDictionary *)dic;
/// 账单流水
+(NSString *)liuShuiDic;
/// 常见问题
+(NSString *)changJianWenTi;
#pragma --mark 
@end
