//
//  Share.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 16/1/13.
//  Copyright © 2016年 jiadao. All rights reserved.
//

#import "Share.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
#import "Toast.h"
@implementation Share

+(void)shareTeJiaChe:(NSString *)url {
    //1、创建分享参数
    NSArray* imageArray = @[[Resource imageName:@"appIcon"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"我在发现了一款超值特价车，快来看看吧~"
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:@"好车驾到特价车来袭"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               [Toast toastMessage:@"分享成功"];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               [Toast toastMessage:@"分享失败"];
                               break;
                           }
                           case SSDKResponseStateCancel: {
                               [Toast toastMessage:@"分享被取消"];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

+(void)load {
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"e8fec3366714"
     
          activePlatforms:@[
                            @(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformSubTypeQQFriend),
                            @(SSDKPlatformSubTypeQZone)
                           ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx191918ebdda13726"
                                       appSecret:@"d48a749ecc875c1dabdd2a4bc21805c4"];
                 break;
             case  SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105104330"
                                      appKey:@"c94HFz7UY5Krocb7"
                                    authType:SSDKAuthTypeBoth];
                 break;
            default:
                 break;
         }
     }];
}
@end
