//
//  JDHttpUtils.m
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/1.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "HttpUtils.h"
#import "UserManager.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>

#define kSignKey @"MhxzKhl@jiadao.cn"

@implementation HttpUtils

+ (NSString *)userAgentString
{
    return nil;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}

+ (NSDictionary *)addCommonParameters:(NSDictionary *)_params
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_params];
   
    
    
    return dic;
}

+(NSString *)dicToUrl:(NSDictionary *)dic {
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionaryWithDictionary:dic];
//    // 添加定义参数
//    [parames addEntriesFromDictionary:[JDHttpUtils commendParameterDic]];
//    parames[@"access_token"] = [JDUserManager shareJDUserManager].seller.access_token;
//    parames[@"user_id"] = [JDUserManager shareJDUserManager].seller.user_id;
//    parames[@"city_id"] = [JDUserManager shareJDUserManager].cityId;
//    parames[@"channel"] = @"c2b";
//    //签名
//    NSString *sign = [JDHttpUtils createMd5Sign:parames];
//    
//    [parames setObject:sign forKey:@"sign"];
//    
//    
//    NSMutableString *contentString  = nil;
//    NSArray *keys = [parames allKeys];
//    for (NSString *key in keys) {
//        if (contentString.length > 0) {
//            [contentString appendFormat:@"&%@=%@",key,parames[key]];
//        }else {
//            contentString = [NSMutableString stringWithFormat:@"%@=%@",key,parames[key]];
//        }
//    }
    return @"";
    
}

+(NSString *)liuShuiDic {
    NSMutableString *contentString  = nil;
    NSDictionary *parames = [HttpUtils addCommonParameters:nil];
    NSArray *keys = [parames allKeys];
    for (NSString *key in keys) {
        if (contentString.length > 0) {
            [contentString appendFormat:@"&%@=%@",key,parames[key]];
        }else {
            contentString = [NSMutableString stringWithFormat:@"%@=%@",key,parames[key]];
        }
    }
    
    return [NSString stringWithFormat:@"%@seller-journal/bill-detail?%@",kJDBASEURL,contentString];
}

+(NSString *)changJianWenTi {
    
    NSMutableString *contentString  = nil;
    NSDictionary *parames = [HttpUtils addCommonParameters:nil];
    NSArray *keys = [parames allKeys];
    for (NSString *key in keys) {
        if (contentString.length > 0) {
            [contentString appendFormat:@"&%@=%@",key,parames[key]];
        }else {
            contentString = [NSMutableString stringWithFormat:@"%@=%@",key,parames[key]];
        }
    }
    
    return [NSString stringWithFormat:@"%@product/question?%@",kJDBASEURL,contentString];
}
//创建package签名
+ (NSString*)createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        [contentString appendFormat:@"%@=%@", categoryId, [dict objectForKey:categoryId]];
        
//        id value = [dict objectForKey:categoryId];
//        if ([value isKindOfClass:[NSNumber class]]) {
//            [contentString appendFormat:@"%@=%@", categoryId, [(NSNumber *)value stringValue]];
//        } else {
//            if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
//                && ![categoryId isEqualToString:@"sign"]
//                && ![categoryId isEqualToString:@"key"]
//                )
//            {
//                [contentString appendFormat:@"%@=%@", categoryId, [dict objectForKey:categoryId]];
//            }
//        }
    }
    //添加key字段
    [contentString appendFormat:@"%@", kSignKey];
    //得到MD5 sign签名
    NSString *md5Sign =[self md5:contentString];

    return md5Sign;
}
// 默认填充参数
+(NSDictionary *)commendParameterDic{
    static NSDictionary *_commendDic = nil;
    //.200.234.95/userpassport/login?mobile=18612439020&captcha=2910&mobile_type=adsf&app_ver=asdf
    if (_commendDic.count <= 0) {
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        _commendDic = @{@"mobile_type":@"iOS",@"app_ver":version,@"app_name":@"好车驾到",@"mobile_brand":[self getCurrentDeviceModel],@"mobile_ver":[self getCurrentDeviceModel],@"api_ver":@"1",@"channel":@"appstore",};
    }
    return _commendDic;
}
// 获取设备
+(NSString *)getCurrentDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform =  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

@end
