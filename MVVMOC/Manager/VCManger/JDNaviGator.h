//
//  WyjNaviGator.h
//  VCManager
//
//  Created by 王亚军 on 14-9-6.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface JDNaviGator : NSObject
@property(nonatomic,weak,readonly)UIViewController *currentViewController;
// 这个方法不是单利方法，是类方法
+(instancetype)shareNav;

-(void)pushViewController:(NSString *)vcid parame:(id)parame pushVc:(UINavigationController *)nav;

-(void)pushViewController:(NSString *)vcid parame:(id)parame pushVc:(UINavigationController *)nav storyboardWithName:(NSString *)storyboardName bundle:(NSBundle *)bundle;

-(void)pushViewController:(NSString *)vcid parame:(id)parame pushVc:(UINavigationController *)nav animated:(BOOL)animated;

-(void)popViewController:(UIViewController *)vcid;

-(void)popViewController:(UIViewController *)vcid animated:(BOOL)animated;
-(void)popZuoHua:(UINavigationController *)nav;
-(void)popRootViewController:(UIViewController *)vcid animated:(BOOL)animated;

-(void)presentViewController:(NSString *)vcid parame:(id)parame presentVc:(UIViewController *)presentVc isNavigationController:(BOOL)isNav;

-(void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

