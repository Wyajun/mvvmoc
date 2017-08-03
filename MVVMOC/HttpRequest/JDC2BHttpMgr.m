//
//  JDC2BHttpMgr.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/9/25.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "JDC2BHttpMgr.h"
#import "HttpRequestManager.h"
#import "UserManager.h"


#define kCOORD_TYPE @"mars"

#define KJDBASEURLAPPEND(url) [kJDBASEURL stringByAppendingString:url]

@implementation JDC2BHttpMgr
+(instancetype)shareHttpMgr
{
    static JDC2BHttpMgr *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[JDC2BHttpMgr alloc] initSuper];
    });
    return _share;
}
-(instancetype)initSuper
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)init
{
    NSAssert(NO, @"请使用shareHttpRequestManager方法");
    return nil;
    
}
#pragma --mark 方法实现
//用户相关
-(void)JDSendMObileCaptcha:(NSString *)phoneNumber callback:(void (^)(id, CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] cancleAllRequest];
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"sellerpassport/send-mobile-captcha")  parameters:@{@"mobile":phoneNumber} callBack:callback];
}
-(void)JDLogin:(NSString *)phoneNumber yanZhengMa:(NSString *)yanZhengMa callback:(void (^)(id, CommontCallBack *))callback {
//    NSString *device_token = [JDUserManager shareJDUserManager].device_token;
//    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"sellerpassport/login" ) parameters:@{@"mobile":phoneNumber,@"captcha":yanZhengMa,@"device_token":device_token} callBack:callback];
}
-(void)JDAddToken {
//    NSString *device_token = [JDUserManager shareJDUserManager].device_token;
//    NSString *userId = [JDUserManager shareJDUserManager].seller.user_id;
//    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"sellerpassport/add-token" )parameters:@{@"device_token":device_token,@"identfy":@2,@"user_id":userId} callBack:^(id result, CommontCallBack *ccb) {
//        
//    }];
}
-(void)jdLogout:(NSString *)userId callback:(void (^)(id, CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"sellerpassport/logout") parameters:@{@"id":userId} callBack:callback];
}
// 业务相关
-(void)JDAddUserInfo:(NSString *)userName sex:(NSInteger)sex imageData:(NSData *)imageData callback:(void (^)(CommontCallBack *))callback {
    
    if (imageData) {
        [[HttpRequestManager shareHttpRequestManager] upFileData:KJDBASEURLAPPEND(@"seller-info/base-info") parameters:@{@"coord_type":kCOORD_TYPE,@"name":userName,@"sex":@(sex)} fileDada:imageData callBack:^(id result, CommontCallBack *ccb) {
            callback(ccb);
        }];
    }else {
        [[HttpRequestManager shareHttpRequestManager] POST:KJDBASEURLAPPEND(@"seller-info/base-info") parameters:@{@"coord_type":kCOORD_TYPE,@"name":userName,@"sex":@(sex)}  callBack:^(id result, CommontCallBack *ccb) {
             callback(ccb);
        }];
    }
    
}
-(void)JDApplyAudit:(NSString *)userName shopId:(NSString *)shopId imageData:(NSData *)imageData  callback:(void (^)(CommontCallBack *))callback {
    
    [[HttpRequestManager shareHttpRequestManager] upFileData:KJDBASEURLAPPEND(@"seller-info/apply-audit") parameters:@{@"coord_type":kCOORD_TYPE,@"name":userName,@"shop_id":shopId} fileDada:imageData callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetSellerInfo:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-info/account-detail") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetUserInfo:(NSString *)huanXiId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-info/get-hx-user" )parameters:@{@"coord_type":kCOORD_TYPE,@"hx_user":huanXiId,@"identity":@"1"} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetInqueryDispatchList:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"inquiry-dispatch/list") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetBiaoJiaList:(NSString *)dispatchId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"inquiry-dispatch/order-detail") parameters:@{@"coord_type":kCOORD_TYPE,@"dispatch_id":dispatchId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSubmitBaoJia:(NSString *)xunJiaId price:(NSInteger)price tip:(NSString *)tip callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"inquiry-dispatch/submit" )parameters:@{@"coord_type":kCOORD_TYPE,@"id":xunJiaId,@"price":@(price),@"tip":tip} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetsdDispatchList:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"sd-dispatch/list") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDAcceptsdDispatch:(NSString *)shiJiaId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"sd-dispatch/accept") parameters:@{@"coord_type":kCOORD_TYPE,@"id":shiJiaId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetVehicleBrand:(NSString *)level callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"vehicle-brand/get-by-level") parameters:@{@"coord_type":kCOORD_TYPE,@"level":level} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetVehicleLine:(NSString *)brandId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"vehicle-line/get-by-brand") parameters:@{@"coord_type":kCOORD_TYPE,@"brand_id":brandId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetVehicleType:(NSString *)lineId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"vehicle-type/get-by-line") parameters:@{@"coord_type":kCOORD_TYPE,@"line_id":lineId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerOffer:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-offer/list") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
    
}
-(void)JDSellerOfferSubmitTypeId:(NSString *)typeId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"seller-offer/submit") parameters:@{@"coord_type":kCOORD_TYPE,@"type_id":typeId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerOfferRemoveTypeId:(NSString *)typeId callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"seller-offer/remove" )parameters:@{@"coord_type":kCOORD_TYPE,@"type_id":typeId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGETCityList:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"city/get-all") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGETShopList:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"shop/get-all" )parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDAddSeller4SShop:(NSString *)shopName address:(NSString *)address tel:(NSString *)tel callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"shop/add" )parameters:@{@"coord_type":kCOORD_TYPE,@"name":shopName,@"address":address,@"tel":tel} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetYiJianFanKuiHistory:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"user-feedback/get-feedback") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];

}
-(void)JDSendYiJian:(NSString *)msg callback:(void (^)(CommontCallBack *))callback {
    
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"user-feedback/post-feedback" )parameters:@{@"coord_type":kCOORD_TYPE,@"content":msg} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDKeShiJia:(NSString *)carId canTest:(NSInteger)can callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"seller-offer/test-change") parameters:@{@"coord_type":kCOORD_TYPE,@"type_id":carId,@"can_test":@(can)} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDAddSellerActivity:(NSString *)title detail:(NSArray *)detail imgUrl:(NSString *)imgUrl vehicle_type:(NSString *)vehicle_type callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"seller-activity/create") parameters:@{@"coord_type":kCOORD_TYPE,@"tittle":title,@"detail":detail,@"img_url":imgUrl,@"vehicle_type":vehicle_type} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDAddSellerActivity:(NSString *)msrp price:(NSString *)price imgData:(NSData *)file start_time:(long)start_time end_time:(long)end_time vehicle_type:(NSString *)vehicle_type detail:(NSString *)detail callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] upFileData:KJDBASEURLAPPEND( @"seller-activity/create" ) parameters:@{@"msrp":msrp,@"price":price,@"start_time":@(start_time),@"end_time":@(end_time),@"vehicle_type":vehicle_type,@"detail":detail} fileDada:file callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDAddSellerActivity1:(NSString *)msrp price:(NSString *)price img_ulr:(NSString *)url start_time:(long)start_time end_time:(long)end_time vehicle_type_id:(NSString *)vehicle_type_id cover_title:(NSString *)cover_title stock:(NSInteger)stock detail_info:(NSString *)detail_info callback:(void (^)(CommontCallBack *))callback {
    
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"seller-activity/generat") parameters:@{@"msrp":msrp,@"price":price,@"start_time":@(start_time),@"end_time":@(end_time),@"vehicle_type_id":vehicle_type_id,@"detail_info":detail_info,@"stock":@(stock),@"detail":cover_title,@"img_url":url}  callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetSellerActivity:(NSInteger)page limit:(NSInteger)limit callback:(void (^)(CommontCallBack *))callback {
    
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-activity/lists")  parameters:@{@"page":@(page),@"limit":@(limit)} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerActivityOffline:(NSString *)activity_id callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-activity/offline")  parameters:@{@"activity_id":activity_id} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerInShop:(NSString *)order userCode:(NSString *)user_code callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"buy-order/in-shop")  parameters:@{@"order_id":order,@"user_code":user_code} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}

-(void)JDSellerUploadInvoice:(NSString *)dispatch_id file:(NSData *)file callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] upFileData:KJDBASEURLAPPEND(@"buy-order/upload-invoice")   parameters:@{@"order_id":dispatch_id} fileDada:file callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerLockOrder:(NSString *)orderId callback:(void (^)(CommontCallBack *))callback {
   
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"buy-order/lock")  parameters:@{@"order_id":orderId} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerInquiryDispatchDetail:(NSString *)dispatch_id callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"inquiry-dispatch/detail") parameters:@{@"dispatch_id":dispatch_id} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDSellerOrderDetail:(NSString *)order callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND( @"buy-order/detail" )parameters:@{@"order_id":order} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDOrderList:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"buy-order/list") parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDInquiryDispatch:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"inquiry-dispatch/combine-list")  parameters:@{@"coord_type":kCOORD_TYPE} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
// 1用户2销售
-(void)JDSellerCashOrderCreate:(NSString *)user_name account:(NSString *)account account_type:(NSString *)account_type cash_type:(NSInteger )cash_type fee:(NSInteger)fee callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"cash-order/create")  parameters:@{@"coord_type":kCOORD_TYPE,@"user_name":user_name,@"account":account,@"account_type":account_type,@"cash_type":@(cash_type),@"fee":@(fee),@"role":@(2)} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDRechargeAlipay:(NSInteger)count callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"alipay/order") parameters:@{@"coord_type":kCOORD_TYPE,@"order_id":[self key],@"fee":@(count), @"type":@6} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDRechargec2bwxpay:(NSInteger)count callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"wxpay/app-pay") parameters:@{@"coord_type":kCOORD_TYPE,@"type":@"6",@"fee":@(count)} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDGetSelleJournal:(NSInteger)page limit:(NSInteger)limit callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-journal/list")  parameters:@{@"page":@(page),@"limit":@(limit)} callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDUpLoadHuoDonImg:(NSData *)data callback:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] upFileData:KJDBASEURLAPPEND(@"seller-activity/upload-img") parameters:nil fileDada:data callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(void)JDRedSpot:(void (^)(CommontCallBack *))callback {
    [[HttpRequestManager shareHttpRequestManager] GET:KJDBASEURLAPPEND(@"seller-info/red-spot")  parameters:nil callBack:^(id result, CommontCallBack *ccb) {
        callback(ccb);
    }];
}
-(NSString *)key {
    
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
@end
