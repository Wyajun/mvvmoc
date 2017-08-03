//
//  HttpRequestManager.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/6/9.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import "HttpRequestManager.h"
#import "Reachability.h"
#import "CommontCallBack.h"
#import "HttpUtils.h"
#import "UserManager.h"
#import "BlockUI.h"
#import "JDViewControllerPushManager.h"
#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSInteger, RequestHTTPMethod) {
    RequestPOST,
    RequestGET,
    RequestUPFile,
};

@interface RequestObj : NSObject
@property(nonatomic)NSInteger requestCount;
@property(nonatomic,copy)NSString *requestURL;
@property(nonatomic,strong)NSDictionary *requestParame;
@property(nonatomic,copy)NSString *requestKey;
@property(nonatomic)RequestHTTPMethod httpMetod;
@property(nonatomic)NSData *fileData;
@property(nonatomic,copy)HttpRequestCompleted requestCallBack;
@end



@interface HttpRequestManager()
@property(nonatomic,strong)NSMutableDictionary *requstDic;
@property(nonatomic,strong)dispatch_queue_t  requestQueue;
@property(nonatomic)       BOOL isLogining; // 标记为taken失效时的处理 登录
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)dispatch_queue_t httpRequestQueue;
@end


//
@implementation HttpRequestManager
+(instancetype)shareHttpRequestManager
{
    static HttpRequestManager *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[HttpRequestManager alloc] initSuper];
    });
    return _share;
}
-(instancetype)initSuper
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] init];
        _httpRequestQueue = dispatch_queue_create([@"httpRequestQueue" UTF8String], 0);
        _manager.completionQueue = _httpRequestQueue;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        _manager.requestSerializer.timeoutInterval = 20;
        self.requestQueue = dispatch_queue_create([@"requestQueue" UTF8String], DISPATCH_QUEUE_SERIAL);
        self.requstDic = [NSMutableDictionary dictionary];
        self.isLogining = NO;
    }
    return self;
}

-(instancetype)init
{
    NSAssert(NO, @"请使用shareHttpRequestManager方法");
    return nil;
}

-(void)cancleAllRequest {
     self.requstDic = [NSMutableDictionary dictionary];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

-(void)POST:(NSString *)URLString parameters:(id)parameters callBack:(HttpRequestCompleted)callback
{
     NSDictionary *parameDic = [HttpUtils addCommonParameters:parameters];
     [self POST:URLString requestKey:nil parameters:parameDic callBack:callback];
}
-(void)GET:(NSString *)URLString parameters:(id)parameters callBack:(HttpRequestCompleted)callback {
     NSDictionary *parameDic = [HttpUtils addCommonParameters:parameters];
     [self GET:URLString requestKey:nil parameters:parameDic callBack:callback];
}

-(void)upFileData:(NSString *)URLString parameters:(id)parameters fileDada:(NSData *)filedata callBack:(HttpRequestCompleted)callback {
     NSDictionary *parameDic = [HttpUtils addCommonParameters:parameters];
    [self UPFile:URLString requestKey:nil fileData:filedata parameters:parameDic callBack:callback];
}

#pragma --mark 发起网络请求
-(void)POST:(NSString *)URLString requestKey:(NSString *)requestKey parameters:(id)parameters callBack:(HttpRequestCompleted)callback {
    if (requestKey.length <= 0) {
        requestKey = [self key];
    }
    __weak typeof(self)weak = self;
    [_manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommontCallBack *ccb = [CommontCallBack defaultCommontCallBack];
        ccb.code = [responseObject[@"code"] integerValue];
        if (ccb.code != 0) {
            ccb.errorMessage = responseObject[@"message"];
        }
        ccb.statue = CommontCallBackSuccess;
        ccb.result = responseObject;
        [weak.requstDic removeObjectForKey:requestKey];
        callback(responseObject,ccb);
        [weak dealWithCode:ccb];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback( nil,[self dealingWithFailure:requestKey error:error]);
    }];
    
//    if (!self.requstDic[requestKey]) {
//        RequestObj *obj = [[RequestObj alloc] init];
//        obj.requestURL = URLString;
//        obj.requestKey = requestKey;
//        obj.requestParame = parameters;
//        obj.requestCallBack = callback;
//        obj.httpMetod = RequestPOST;
//        obj.requestCount = 1;
//        dispatch_async(self.requestQueue, ^{
//            [self saveDataTask:obj key:requestKey];
//        });
//    }
}
-(void)GET:(NSString *)URLString requestKey:(NSString *)requestKey parameters:(id)parameters callBack:(HttpRequestCompleted)callback {
   
    if (requestKey.length <= 0) {
        requestKey = [self key];
    }
   __weak typeof(self)weak = self;
    [_manager GET:URLString parameters:parameters progress:nil  success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        CommontCallBack *ccb = [CommontCallBack defaultCommontCallBack];
        ccb.code = [responseObject[@"code"] integerValue];
        if (ccb.code != 0) {
            ccb.errorMessage = responseObject[@"message"];
        }
        ccb.statue = CommontCallBackSuccess;
        ccb.result = responseObject;
        [weak.requstDic removeObjectForKey:requestKey];
        callback(responseObject,ccb);
        [weak dealWithCode:ccb];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback( nil,[self dealingWithFailure:requestKey error:error]);
    }];
}

-(void) UPFile:(NSString *)URLString requestKey:(NSString *)requestKey fileData:(NSData *)fileData parameters:(id)parameters callBack:(HttpRequestCompleted)callback  {
    
    if (requestKey.length <= 0) {
        requestKey = [self key];
    }
    __weak typeof(self)weak = self;
    
    [_manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommontCallBack *ccb = [CommontCallBack defaultCommontCallBack];
        ccb.code = [responseObject[@"code"] integerValue];
        if (ccb.code != 0) {
            ccb.errorMessage = responseObject[@"message"];
        }
        ccb.statue = CommontCallBackSuccess;
        [weak.requstDic removeObjectForKey:requestKey];
        ccb.result = responseObject;
        callback(responseObject,ccb);
        [weak dealWithCode:ccb];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback( nil,[self dealingWithFailure:requestKey error:error]);
    }];
    
    
//    if (!self.requstDic[requestKey]) {
//        RequestObj *obj = [[RequestObj alloc] init];
//        obj.requestURL = URLString;
//        obj.requestKey = requestKey;
//        obj.requestParame = parameters;
//        obj.requestCallBack = callback;
//        obj.httpMetod = RequestUPFile;
//        obj.fileData = fileData;
//        obj.requestCount = 1;
//        dispatch_async(self.requestQueue, ^{
//            [self saveDataTask:obj key:requestKey];
//        });
//    }
}
#pragma --mark 保持请求
- (void) saveDataTask:(RequestObj *)dataTask key:(NSString *)requestKey {
        self.requstDic[requestKey] = dataTask;
}
#pragma --mark 失败处理
-(CommontCallBack *)dealingWithFailure:(NSString *)requestKey error:(NSError *)error
{
    CommontCallBack *ccb = [CommontCallBack defaultCommontCallBack];
    
    ccb.statue = CommontCallBackError;
    if ([self isDisconnentedNetwork]) {
       ccb.errorMessage = KNetWorkSelfError;
        ccb.code = HttpCodeStatusWWL;
    }else {
        ccb.code = HttpCodeStatusFWQF;
        ccb.errorMessage = KNetWorkSeverError;
    }
    return ccb;
//    if(self.isLogining) {
//    [self.requstDic removeObjectForKey:requestKey];
//    }
//    RequestObj *taskObj = self.requstDic[requestKey];
//    taskObj.requestCount--;
//    if (taskObj.requestCount <= 0) {
//        CommontCallBack *ccb = [CommontCallBack defaultCommontCallBack];
//        ccb.code = -100;
//        ccb.statue = CommontCallBackError;
//        ccb.errorMessage = [error localizedFailureReason];
//        taskObj.requestCallBack(nil,ccb);
//    }else {
//        if (taskObj.httpMetod == RequestPOST) {
//            [self POST:taskObj.requestURL requestKey:taskObj.requestKey parameters:taskObj.requestParame callBack:taskObj.requestCallBack];
//        }else if(taskObj.httpMetod == RequestGET){
//            [self GET:taskObj.requestURL requestKey:taskObj.requestKey parameters:taskObj.requestParame callBack:taskObj.requestCallBack];
//        }else if(taskObj.httpMetod == RequestUPFile) {
//            [self UPFile:taskObj.requestURL  requestKey:taskObj.requestKey fileData:taskObj.fileData parameters:taskObj.requestParame callBack:taskObj.requestCallBack];
//        }
//    }
    
}
-(NSString *)key {
    
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
// 判断是否断网
- (BOOL) isDisconnentedNetwork
{
    if([[Reachability reachabilityForInternetConnection] isReachable]){
        return NO;
    }
    return YES;
}
-(void)chuLiAccess_token:(NSString *)key {
    if(self.isLogining)
        return;
    self.isLogining = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [JDViewControllerPushManager shareVCManager];
        __weak typeof(self)weak = self;
       

    });
}
-(void)dealWithCode:(CommontCallBack *)ccb {
    
    if (ccb.code == HttpCodeStatusTokenGQ || ccb.code == HttpCodeStatusTokenCW) {
        dispatch_async(self.requestQueue, ^{
            [self chuLiAccess_token:nil];
        });
    }
        if (ccb.code == HttpCodeStatusGXAPP) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *url = ccb.errorMessage;
                if(url.length > 0) {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"您当前的客户端版本过低，请及时更新！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alter showWithCompletionHandler:^(NSInteger buttonIndex) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }];
                }
            });

        
    }
}
@end

@implementation RequestObj



@end
