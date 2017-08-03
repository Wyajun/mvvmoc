//
//  NoticeManager.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/27.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "NoticeManager.h"
#import "Toast.h"
#import "SystemManager.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "JDViewControllerPushManager.h"
@interface NoticeManager ()
@property(nonatomic,strong)NSDictionary *launchOptions;
@property(nonatomic) BOOL isLaunch;
@property(nonatomic) BOOL isallow;
@property(nonatomic) BOOL isActive; // 程序是否在前台
@property(nonatomic,strong)NSMutableDictionary *actionDic;
@property(nonatomic,strong) dispatch_queue_t    Bindqueue;
@end

#define KSYSAPPBECOMEACTIVE @"sysappBecomeActive" /// app进入前台
#define KSYSAPPDidFinishLaunching @"KSYSAPPDidFinishLaunching"
#define KSYSAPPEnterBackground @"KSYSAPPEnterBackground"
#define KSYSNEWRESERVATION @"sysnewreservation"
#define KSYSORDERSTATUSCHANGE @"sysorderstatuschange"
static NSString *const KsysMyAcconut = @"KsysMyAcconut"; //我的账户
static NSString *const kchongZhiResult = @"chongZhiKey";
@implementation NoticeManager
singleton_implementation(NoticeManager);
-(instancetype)init {
    self = [super init];
    if (self) {
        _actionDic = [NSMutableDictionary dictionary];
        _Bindqueue =  dispatch_queue_create([@"SystemManagerQueue" UTF8String], DISPATCH_QUEUE_CONCURRENT);
        _isLaunch = NO;
        _isallow = YES;
        [self registerSystemNotification];
    }
    return self;
}
#pragma --mark 系统消息
-(void)registerSystemNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)addAppBecomeActive:(id)lifeCycle Block:(void (^)())block {
    
    dispatch_barrier_async(_Bindqueue, ^{
        [self setActionKey:KSYSAPPBECOMEACTIVE Key:lifeCycle block:block];
    });
}
-(void)appBecomeActive {
    self.isActive = YES;
    dispatch_async(_Bindqueue, ^{
        [self runBlock:KSYSAPPBECOMEACTIVE parame:nil];
    });
}

-(void)addAppEnterBackground:(id)lifeCycle Block:(void (^)())block {
    dispatch_barrier_async(_Bindqueue, ^{
        [self setActionKey:KSYSAPPEnterBackground Key:lifeCycle block:block];
    });
}
-(void)appEnterBackground {
    self.isActive = NO;
    dispatch_async(_Bindqueue, ^{
        [self runBlock:KSYSAPPEnterBackground parame:nil];
    });
}
-(void)appDidFinishLaunching:(NSDictionary *)infoDic {
    self.isLaunch = YES;
    self.launchOptions = infoDic;
}
#pragma --mark 新订单处理
-(void)registerReservationNotification:(id)liftCycle block:(void (^)())block {
    dispatch_barrier_async(_Bindqueue, ^{
        [self setActionKey:KSYSNEWRESERVATION Key:liftCycle block:block];
    });
}
-(void)sendReservationId{
    dispatch_async(_Bindqueue, ^{
        [self runBlock:KSYSNEWRESERVATION parame:nil];
    });
}
#pragma --mark 订单状态改变处理
-(void)registerOrderStatusChangeNotification:(id)liftCycle block:(void (^)(NSString *))block {
    dispatch_barrier_async(_Bindqueue, ^{
        [self setActionKey:KSYSORDERSTATUSCHANGE Key:liftCycle block:block];
    });
}
-(void)sendOrderStatueChange:(NSString *)orderId {
    dispatch_async(_Bindqueue, ^{
        [self runBlock:KSYSORDERSTATUSCHANGE parame:orderId];
    });
}
#pragma --mark 充值结果
-(void)registerChongZhiResultNotification:(id)liftCycle block:(void (^)(NSString *))block {
    dispatch_barrier_async(_Bindqueue, ^{
        [self setActionKey:kchongZhiResult Key:liftCycle block:block];
    });
}
/*
 *code  支付宝
 9000	订单支付成功
 8000	正在处理中
 4000	订单支付失败
 6001	用户中途取消
 6002	网络连接出错
 */
-(void)aliPayChongZhiResultNotification:(NSDictionary *)resultDic {
    dispatch_async(_Bindqueue, ^{
        if (resultDic) {
            NSString *message = nil;
            switch ([resultDic[@"resultStatus"] integerValue ]) {
                case 9000:
                    message = @"充值成功";
                    break;
                case 8000:
                    message = @"充值正在处理中";
                    break;
                case 4000:
                    message = @"充值失败";
                    break;
                case 6001:
                    message = @"充值取消";
                    break;
                case 6002:
                    message = @"网络连接出错";
                    break;
                default:
                    message = @"充值未完成";
                    break;
            }
           [self runBlock:kchongZhiResult parame:message];
        }
    });
}
/*
 0	成功	展示成功页面
 -1	错误	可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
 -2	用户取消	无需处理。发生场景：用户不支付了，点击取消，返回APP。
 */
- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (resp.errCode == WXSuccess) {
            DLog(@"分享微信成功");
        }
    } else if ([resp isKindOfClass:[PayResp class]]) {
        NSString *message = nil;
        switch (resp.errCode) {
            case 0:
                message = @"充值成功";
                break;
            case -1:
                message = @"充值失败";
                break;
            case -2:
                message = @"充值取消";
                break;
            default:
                message = @"充值未完成";
                break;
        }
        [self runBlock:kchongZhiResult parame:message];
    }
}
#pragma --mark 我的账户发生改变
-(void)registerMyAccountChange:(id)lifeCycle Block:(void (^)())block {
    dispatch_barrier_async(_Bindqueue, ^{
        [self setActionKey:KsysMyAcconut Key:lifeCycle block:block];
    });
}
-(void)sendMyAccountChange {
    dispatch_async(_Bindqueue, ^{
        [self runBlock:KsysMyAcconut parame:nil];
    });
}
#pragma --mark
-(void)receiveNotification:(NSDictionary *)infoDic {
    if (!self.isLaunch && self.isActive) {
         [[SystemManager shareSystemManager] PlayVoice];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self analysisPushContent:infoDic];
    });
    
}
-(void)analysisPushContent:(NSDictionary *)infoDic {
    if (infoDic.count <= 0) {
        return;
    }
    NSDictionary *contentDic = infoDic[@"aps"][@"content"];
    if (self.isLaunch || !self.isActive) {
        [self pushViewController:contentDic];
        return;
    }
    NSString *message_type = contentDic[@"type"];
    NSString *alert = infoDic[@"aps"][@"alert"];
    [Toast toastNotificationWithMessage:alert completionBlock:^{
        [self pushViewController:contentDic];
    }];
    switch ([message_type integerValue]) {
        case 1:
            [self sendMyAccountChange];
            break;
        case 2: {
            NSString *oredr_id = [NSString stringWithFormat:@"%@",contentDic[@"data"][@"order_id"]];
             [self sendOrderStatueChange:oredr_id];
             }
            break;
        case 3:
            [self sendReservationId];
            break;
        default:
            break;
    }
}
-(void)pushViewController:(NSDictionary*)contentDic {
    NSString *message_type = contentDic[@"type"];
}
-(void)allowSendReservationNotification:(BOOL)allow {
    _isallow = allow;
}
-(void)appFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.launchOptions = launchOptions;
    self.isLaunch = YES;
}
-(void)pushAppFinishLaunching {
    if (!self.isLaunch) {
        return;
    }
    [self analysisPushContent:self.launchOptions];
    self.launchOptions = nil;
    self.isLaunch = NO;
}

#pragma --mark 核心方法
-(void)setActionKey:(NSString *)actionKey Key:(id)key block:(id)block {
    NSMapTable *mapTable = _actionDic[actionKey];
    if (!mapTable) {
        mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                         valueOptions:NSMapTableCopyIn];
        _actionDic[actionKey] = mapTable;
    }
    [mapTable setObject:block forKey:key];
}

-(void)runBlock:(NSString *)key parame:(id)parame {
    NSMapTable *mapTable = _actionDic[key];
    if (!mapTable) {
        return;
    }
    
    NSEnumerator *enumerator = [mapTable objectEnumerator];
    id obj;
    
    while ( obj = [enumerator nextObject] ) {
        if (parame) {
            ( (void (^)(id)) obj)(parame);
        }else {
            ( (void (^)()) obj)();
        }
    }
}


@end
