//
//  JDMainThemeUtil.m
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/12.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "MainThemeUtil.h"

@implementation MainThemeUtil


+ (void)themeAppearence
{
    //Navgation字体颜色
    UIColor *titleColor = [UIColor systemWenZiHeader1];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: titleColor,
                                                           NSShadowAttributeName: shadow,
                                                           NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    //[[UINavigationBar appearance] setTintColor:titleColor];
    //Navgation按钮颜色
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor systemZhuTiSe], NSForegroundColorAttributeName,nil]
                                                                                            forState:UIControlStateNormal];
    //Navgation背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor systemViewBackgroundColor1]];
}

@end
