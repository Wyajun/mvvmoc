//
//  HttpRequestManager.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/6/9.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommontCallBack;
typedef void (^HttpRequestCompleted)(id result,CommontCallBack *ccb);

@interface HttpRequestManager : NSObject
+(instancetype)shareHttpRequestManager;
- (void)POST:(NSString *)URLString
                    parameters:(id)parameters callBack:(HttpRequestCompleted)callback;
- (void)GET:(NSString *)URLString
                   parameters:(id)parameters callBack:(HttpRequestCompleted)callback;
                ;
-(void)upFileData:(NSString *)URLString parameters:(id)parameters fileDada:(NSData *)filedata callBack:(HttpRequestCompleted)callback;
-(void)cancleAllRequest;
@end
