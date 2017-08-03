//
//  NoticeManager.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/27.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDSingleton.h"
#import "WXApi.h"
@interface NoticeManager : NSObject<WXApiDelegate>
singleton_interface(NoticeManager);
// 接收到远程通知
-(void)receiveNotification:(NSDictionary *)infoDic;
// app启动
-(void)appDidFinishLaunching:(NSDictionary *)infoDic;
// 后台切换至前台操作
-(void)addAppBecomeActive:(id)lifeCycle Block:(void(^)())block;
// 前台进入后台操作
-(void)addAppEnterBackground:(id)lifeCycle Block:(void(^)())block;

// 进入首页跳转页面
-(void)pushAppFinishLaunching;

// 充值相关
-(void)registerChongZhiResultNotification:(id)liftCycle block:(void(^)(NSString *message))block;
-(void)aliPayChongZhiResultNotification:(NSDictionary *)result;
@end
