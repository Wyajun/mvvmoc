//
//  WyjVCManager.h
//  VCManager
//
//  Created by 王亚军 on 14-9-6.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDViewControllerPushManager : NSObject
@property(nonatomic,strong)UIViewController *rootViewControll;
@property(nonatomic,readonly,weak)UIViewController *currentViewControll;
// 此方法适合根视图就是导航控制器
+(instancetype)shareVCManager;

#pragma --mark 返回和谐方法
-(void)dismissViewController:(UIViewController *)viewControlle animated:(BOOL)animated;

-(void)popViewController:(UIViewController *)viewController animated:(BOOL)animated;

-(void)popToRootViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
