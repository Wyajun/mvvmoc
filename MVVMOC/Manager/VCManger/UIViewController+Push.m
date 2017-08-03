//
//  UIViewController+Push.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/18.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "UIViewController+Push.h"
#import <objc/runtime.h>
#import "JDViewControllerPushManager.h"
@implementation UIViewController (Push)
static char UIViewControllerParame;



-(void)setParameter:(id)parameter
{
    objc_setAssociatedObject(self, &UIViewControllerParame,
                             parameter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(id)parameter
{
    return objc_getAssociatedObject(self, &UIViewControllerParame);
}
-(void)JDAnalyticalParameter:(id)parameter {
}
@end
