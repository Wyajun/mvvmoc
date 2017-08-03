//
//  CommontCallBack.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/6/9.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CommontCallBackStatue) {
    CommontCallBackNone,
    CommontCallBackWarning = 1,
    CommontCallBackError,
    CommontCallBackSuccess,
    CommontCallBackCancle,
};

typedef NS_ENUM(NSInteger, HttpCodeStatus) {
    HttpCodeStatusNone = -1,
    /// 服务器成功
    HttpCodeStatusSuccess = 0,
    /// 余额不足
    HttpCodeStatusYGBZ = 20005,
    /// 更新app
    HttpCodeStatusGXAPP = 17,
    /// token错误
    HttpCodeStatusTokenCW = 1004,
    /// token 过期
    HttpCodeStatusTokenGQ = 1007,
    /// 服务器出错
    HttpCodeStatusFWQF = 500,
    /// 没有网络
    HttpCodeStatusWWL = -100,
};




@interface CommontCallBack : NSObject
@property (nonatomic) BOOL success; // 标示网络请求是否成功
@property(nonatomic)CommontCallBackStatue statue; // 请求的子状态
@property(nonatomic)NSInteger code; // 状态码
@property(nonatomic,copy)NSString *errorMessage; // code 不等于0 时的信息
@property(nonatomic,strong)id result; // 结果
+(instancetype)defaultCommontCallBack;
@end
