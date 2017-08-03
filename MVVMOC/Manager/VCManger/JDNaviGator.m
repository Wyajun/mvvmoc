//
//  WyjNaviGator.m
//  VCManager
//
//  Created by 王亚军 on 14-9-6.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import "JDNaviGator.h"
#import "UIViewController+Push.h"
@interface JDNaviGator()
@property(nonatomic,weak)UIViewController *viewController;
@end
@implementation JDNaviGator
+(instancetype)shareNav
{
    
    return [[JDNaviGator alloc] init];
}

-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)pushViewController:(NSString *)vcid parame:(id)parame pushVc:(UINavigationController *)nav {
    [self pushViewController:vcid parame:parame pushVc:nav animated:YES];
}
-(void)popViewController:(UIViewController *)vcid  {
    [self popViewController:vcid  animated:YES];
}


-(void)popViewController:(UIViewController *)vcid animated:(BOOL)animated
{
    UINavigationController *nav = vcid.navigationController;
    [nav popViewControllerAnimated:animated];
    _viewController = nav.topViewController;
}
-(void)popRootViewController:(UIViewController *)vcid animated:(BOOL)animated {
    UINavigationController *nav = vcid.navigationController;
     [nav popToRootViewControllerAnimated:animated];
    _viewController = nav.topViewController;
}
-(void)pushViewController:(NSString *)vcid parame:(id)parame pushVc:(UINavigationController *)nav animated:(BOOL)animated
{
    Class class = NSClassFromString(vcid);
    UIViewController  *viewController = [[class alloc] init];
    _viewController = viewController;
    NSString *error = [NSString stringWithFormat:@"没有找到可以push控制器 --- %@",vcid];
    NSAssert(viewController != nil, error);
    viewController.parameter = parame;
    [viewController JDAnalyticalParameter:parame];
    [nav pushViewController:viewController animated:animated];
}

-(void)pushViewController:(NSString *)vcid parame:(id)parame pushVc:(UINavigationController *)nav storyboardWithName:(NSString *)storyboardName bundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:vcid];
    _viewController = viewController;
    viewController.parameter = parame;
    [viewController JDAnalyticalParameter:parame];
    [nav pushViewController:viewController animated:YES];
}

-(void)presentViewController:(NSString *)vcid parame:(id)parame presentVc:(UIViewController *)presentVc isNavigationController:(BOOL)isNav  {
    Class class = NSClassFromString(vcid);
    UIViewController  *viewController = [[class alloc] init];
    _viewController = viewController;
    NSString *error = [NSString stringWithFormat:@"没有找到可以push控制器 --- %@",vcid];
    NSAssert(viewController != nil, error);
    viewController.parameter = parame;
    [viewController JDAnalyticalParameter:parame];
    if (isNav) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        [presentVc presentViewController:nav animated:YES completion:nil];
       
    }else
    {
        [presentVc presentViewController:viewController animated:YES completion:nil];
    }
    
}
-(void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _viewController = viewController.presentingViewController;
    [viewController dismissViewControllerAnimated:animated completion:nil];
}
-(void)popZuoHua:(UINavigationController *)nav {
    _viewController = nav.topViewController;
}
-(UIViewController *)currentViewController {
    return _viewController;
}
@end
