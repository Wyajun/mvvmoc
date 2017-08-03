//
//  Consts.h
//  jiadao_ios
//
//  Created by 仲维涛 on 15/5/29.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#ifndef jiadao_ios_Consts_h
#define jiadao_ios_Consts_h

#define kAppName @"好车驾到"

#define textColor5e [UIColor systemWenZiHeader1]

#define textColor99 [UIColor systemWenZiHeader2]
#define textColor3d [UIColor systemWenZiHeader1]
#define textColorde [UIColor systemButtonColor1]
#define textColor00 [UIColor systemZhuTiSe]
#define viewBackColorf3 [UIColor systemViewBackgroundColor]
#define CellBackColorH1 [UIColor systemFGX]




#define KTopFGX(backView,viewname) KTopOffsetFGX(backView,viewname,0)
#define KTopStartxFGX(backView,viewame) KTopStartxOffsetFGX(backView,viewname,0,kViewStartX)
#define KTopOffsetFGX(backView,viewname,offset) KTopStartxOffsetFGX(backView,viewname,offset,0)

#define KTopStartxOffsetFGX(backView,viewname,offset,startx) UIView *viewname  = [[UIView alloc] init];\
viewname.backgroundColor = CellBackColorH1;\
[backView addSubview:viewname];\
[viewname mas_makeConstraints:^(MASConstraintMaker *make) {\
make.right.mas_equalTo(0);\
make.left.mas_equalTo(startx);\
make.top.mas_equalTo(offset);\
make.height.mas_equalTo(0.5);\
}];


#define KBottomFGX(backView,viewname) KBottomStartxOffsetFGX (backView,viewname,0)
#define KBottomStartxOffsetFGX(backView,viewname,startx) UIView *viewname  = [[UIView alloc] init];\
viewname.backgroundColor = CellBackColorH1;\
[backView addSubview:viewname];\
[viewname mas_makeConstraints:^(MASConstraintMaker *make) {\
make.right.and.bottom.mas_equalTo(0);\
make.left.mas_equalTo(startx);\
make.height.mas_equalTo(0.5);\
}];

/*
 * 常用的方法
 */
#define kTabBarHeight       64
#define kToolBarHeight      44
#define kStatusbarHeight    20

/*
 * 活动裁图比例
 */
#define kHuoDonImageBi 0.59
/*
 * 全局开始x和间距
 */
#define kViewStartX 15
#define kViewSpace 8
#define KViewHeigth2 55
#define kViewHeigth1 48
#define KViewHeader 30
#define KViewCornerRadius 4
#define KButHeight  40

#define KbuttonDefaultSet(bnt)  bnt.backgroundColor = [UIColor systemButtonColor];\
bnt.titleLabel.font = [UIFont systemFontOfSize:16];\
bnt.layer.cornerRadius = KViewCornerRadius;\
bnt.clipsToBounds = YES;

#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height
#define kNavHeight          [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? 64.0f : 44.0f

/*
 * 系统版本
 */
#define IOS8                [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS7                [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define kSystemVersion      [[[UIDevice currentDevice] systemVersion] floatValue]


#define is_iphone4          (([UIScreen mainScreen].bounds.size.height)==480)
#define is_iphone5          (([UIScreen mainScreen].bounds.size.height)==568)
#define is_iphone6          (([UIScreen mainScreen].bounds.size.height)==667)
#define is_iphone6Plus      (([UIScreen mainScreen].bounds.size.height)==736)
#define kAppVersionChange                  @"kAppVersionChange" //APP 版本变更
/*
 * 网络失败提示
 */
#define KNetWorkSelfError @"网络未连接，请检查你的网络设置"
#define KNetWorkSeverError @"系统网络出现故障，请稍后再试"


/*
 * 自定义颜色
 */
#define JDColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/*
 * 消息通知
 */

/*
 * 友盟
 */
#ifdef DEBUG
#define kUmengKey           @"564c1beee0f55a13c3004826"  //测试 - 友盟Key
#else
#define kUmengKey           @"564c1c26e0f55a51a70000f4"
#endif



#define kJDBASEURL @"http://dev2.jiadao.cn/"

//#define kJDBASEURL @"http://sales.jiadao.cn/"




//#define kUmengKey           @"55c1b00367e58ef5700005bf"             //正式 - 友盟Key

/*
 * 分享相关
 */

////微信
#define kWeiXinKey          @"wx191918ebdda13726"                   //微信Key
#define kWeiXinSecret       @"d48a749ecc875c1dabdd2a4bc21805c4"     //微信Key
// 支付宝
#define kAliPayAppid        @"cn.jiadao.seller"
////新浪微博
//#define kSinaKey            @"56508766"                             //新浪Key
//#define kSinaSecret         @"191162f5f406d8b71aa269131f901ac1"     //新浪密钥
//#define kSinaRedirectUri    @"http://www.yongche.com/favicon.ico"   //新浪回调地址

/*
 * NSUserDefault操作相关的宏定义
 */
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define DefaultValueForKey(key)             [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define DefaultSetValueForKey(value,key)    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

/*
 * DLog
 */
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#ifdef DEBUG
#define D_NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define D_NSLog(format, ...)
#endif

#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)
#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])
#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

#endif
