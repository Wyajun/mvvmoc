//
//  JDC2BHttpMgr.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/9/25.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommontCallBack.h"

@interface JDC2BHttpMgr : NSObject
+(instancetype)shareHttpMgr;
// 登录相关
-(void)JDSendMObileCaptcha:(NSString *)phoneNumber callback:(void(^)(id result,CommontCallBack *ccb))callback;
-(void)JDLogin:(NSString *)phoneNumber yanZhengMa:(NSString *)yanZhengMa callback:(void(^)(id result,CommontCallBack *ccb))callback;
-(void)jdLogout:(NSString *)userId callback:(void(^)(id result,CommontCallBack *ccb))callback;
-(void)JDAddToken;
// 更新用户信息
-(void)JDAddUserInfo:(NSString *)userName sex:(NSInteger)sex imageData:(NSData *)imageData callback:(void (^)(CommontCallBack *ccb))callback;
// 申请认证
-(void)JDApplyAudit:(NSString *)userName shopId:(NSString *)shopId imageData:(NSData *)imageData callback:(void (^)(CommontCallBack *ccb))callback;
-(void)JDGetSellerInfo:(void (^)(CommontCallBack *ccb))callback;
// 获取客户端用户信息 依据环信用户名
-(void)JDGetUserInfo:(NSString *)huanXiId callback:(void (^)(CommontCallBack *ccb))callback;
// 获取询价列表
-(void)JDGetInqueryDispatchList:(void (^)(CommontCallBack *ccb))callback;
// 获取其他人的报价列表
-(void)JDGetBiaoJiaList:(NSString *)dispatchId callback:(void (^)(CommontCallBack *ccb))callback;
// 提交报价
-(void)JDSubmitBaoJia:(NSString *)xunJiaId price:(NSInteger)price tip:(NSString *)tip callback:(void (^)(CommontCallBack *ccb))callback;
// 订单列表
-(void)JDOrderList:(void (^)(CommontCallBack *ccb))callback;

// 订单询价混合列表
-(void)JDInquiryDispatch:(void (^)(CommontCallBack *ccb))callback;


// 我的车型列表
-(void)JDSellerOffer:(void (^)(CommontCallBack *ccb))callback;
// 品牌列表
-(void)JDGetVehicleBrand:(NSString *)level callback:(void (^)(CommontCallBack *ccb))callback;
// 车系列表
-(void)JDGetVehicleLine:(NSString *)brandId callback:(void (^)(CommontCallBack *ccb))callback;
//  车型列表
-(void)JDGetVehicleType:(NSString *)lineId callback:(void (^)(CommontCallBack *ccb))callback;
// 添加我的报价车型
-(void)JDSellerOfferSubmitTypeId:(NSString *)typeId callback:(void (^)(CommontCallBack *ccb))callback;
//  取消我的报价车型
-(void)JDSellerOfferRemoveTypeId:(NSString *)typeId callback:(void (^)(CommontCallBack *ccb))callback;
// 获取城市列表
-(void)JDGETCityList:(void (^)(CommontCallBack *ccb))callback;
// 获取4s店列表
-(void)JDGETShopList:(void (^)(CommontCallBack *ccb))callback;
// 添加用户自己的4s店
-(void)JDAddSeller4SShop:(NSString *)shopName address:(NSString *)address tel:(NSString *)tel callback:(void (^)(CommontCallBack *ccb))callback;

// 设置可试驾
-(void)JDKeShiJia:(NSString *)carId canTest:(NSInteger)can callback:(void (^)(CommontCallBack *ccb))callback;

// 获取意见反馈历史
-(void)JDGetYiJianFanKuiHistory:(void (^)(CommontCallBack *ccb))callback;
// 发送意见反馈
-(void)JDSendYiJian:(NSString *)msg callback:(void (^)(CommontCallBack *ccb))callback;

// 添加活动 丢弃
-(void)JDAddSellerActivity:(NSString *)msrp  price:(NSString *)price imgData:(NSData *)file start_time:(long)start_time end_time:(long)end_time vehicle_type:(NSString *)vehicle_type detail:(NSString *)detail callback:(void (^)(CommontCallBack *ccb))callback;
///  添加活动1
-(void)JDAddSellerActivity1:(NSString *)msrp  price:(NSString *)price img_ulr:(NSString *)url start_time:(long)start_time end_time:(long)end_time vehicle_type_id:(NSString *)vehicle_type_id cover_title:(NSString *)cover_title stock:(NSInteger)stock detail_info:(NSString *)detail_info callback:(void (^)(CommontCallBack *ccb))callback;


// 获取活动列表
-(void)JDGetSellerActivity:(NSInteger)page limit:(NSInteger)limit callback:(void (^)(CommontCallBack *ccb))callback;
// 下线活动
-(void)JDSellerActivityOffline:(NSString *)activity_id callback:(void (^)(CommontCallBack *ccb))callback;
// 扫描二维码
-(void)JDSellerInShop:(NSString *)order userCode:(NSString *)user_code callback:(void (^)(CommontCallBack *ccb))callback;
// 上传发票
-(void)JDSellerUploadInvoice:(NSString *)dispatch_id file:(NSData *)file callback:(void (^)(CommontCallBack *ccb))callback;
/// 销售锁定
-(void)JDSellerLockOrder:(NSString *)orderId callback:(void (^)(CommontCallBack *ccb))callback;

// 询价订单详情
-(void)JDSellerInquiryDispatchDetail:(NSString *)dispatch_id callback:(void (^)(CommontCallBack *))callback;
// 获取订单详情
-(void)JDSellerOrderDetail:(NSString *)order callback:(void (^)(CommontCallBack *ccb))callback;
/// 提现 1=>销售充值，2=>返现
-(void)JDSellerCashOrderCreate:(NSString *)user_name account:(NSString *)account account_type:(NSString *)account_type cash_type:(NSInteger )cash_type fee:(NSInteger)fee callback:(void (^)(CommontCallBack *))callback;
/// 支付宝
-(void)JDRechargeAlipay:(NSInteger)count callback:(void (^)(CommontCallBack *))callback;
/// 微信充值
-(void)JDRechargec2bwxpay:(NSInteger)count callback:(void (^)(CommontCallBack *))callback;
/// 流水 
-(void)JDGetSelleJournal:(NSInteger)page limit:(NSInteger)limit callback:(void (^)(CommontCallBack *))callback;
/// 上传活动图片
-(void)JDUpLoadHuoDonImg:(NSData *)data callback:(void (^)(CommontCallBack *))callback;
/// 获取小红点
-(void)JDRedSpot:(void (^)(CommontCallBack *))callback;
@end
