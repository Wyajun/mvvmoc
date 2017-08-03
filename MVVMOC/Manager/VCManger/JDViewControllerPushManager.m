//
//  WyjVCManager.m
//  VCManager
//
//  Created by 王亚军 on 14-9-6.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import "JDViewControllerPushManager.h"
#import "ImagePickerViewController.h"
#import "JDNaviGator.h"
#import <objc/runtime.h>
#import "JSWebData.h"
#import "HttpUtils.h"
@interface JDViewControllerPushManager()
@property(nonatomic,strong)JDNaviGator *Wnav;
@property(nonatomic,strong)UITabBarController *tab;
@property(nonatomic)NSInteger selectIndex;
@end
@implementation JDViewControllerPushManager
+(instancetype)shareVCManager
{
    static JDViewControllerPushManager *share_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share_ = [[JDViewControllerPushManager alloc] initSuper];
    });
    return share_;
}
-(id)initSuper
{
    if (self = [super init]) {
        self.Wnav = [JDNaviGator shareNav];
    }
    return self;
}
-(void)setRootViewControll:(UIViewController *)rootViewControll {
    _rootViewControll = rootViewControll;
    
    if([rootViewControll isKindOfClass:[UITabBarController class]])
    _tab = (UITabBarController *)rootViewControll;
    self.Wnav = [JDNaviGator shareNav];
    
}



#pragma --mark 核心方法
-(void)popViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.Wnav popViewController:[self mostAppropriateControllerView] animated:animated];
}
-(void)popToRootViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.Wnav popRootViewController:[self mostAppropriateControllerView] animated:animated];
}
-(void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.Wnav dismissViewController:[self mostAppropriateControllerView] animated:animated];
}
-(void)popZuoHua:(UINavigationController *)nav {
    [self.Wnav popZuoHua:nav];
}
-(UIViewController *)mostAppropriateControllerView {
    // 如果根控制器不是——tab证明为初始化完成。返回空
    if (!_tab) {
        return nil;
    }
    // 当前保存的和——tab的选择的相同 则一定是——
    UINavigationController *tabNav = _tab.selectedViewController;
    if ( self.Wnav.currentViewController == tabNav.topViewController) {
        return self.Wnav.currentViewController;
    }
    
    // 这种情况出现在，tab切换但是Wnav.currentViewController还是保存旧的情况
     return tabNav.topViewController;
//    if (tabNav.viewControllers.count == 1) {
//        return tabNav.topViewController;
//    }
    #ifdef DEBUG
    NSAssert(NO, @"没有找到控制器");
    #endif
    return nil;
}

-(UINavigationController *)navigationController {
    
    UIViewController *vc = [self mostAppropriateControllerView];
    UINavigationController *nav = nil;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc;
    }else
     nav = vc.navigationController;
    #ifdef DEBUG
    NSAssert(nav != nil, @"没有找到控制器");
    #endif
    return nav;
}
-(UIViewController *)currentViewControll {
    return [self mostAppropriateControllerView];
}
@end
