//
//  UIView+ProgressHUD.h
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/10.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ProgressHUD)

- (void)showProgressHUD;

- (void)hideProgressHUD;

- (void)showErrorView:(void(^)())clickBlock;
- (void)hideErrorView;
- (void)showBlackPageView;
- (void)hideBlackPageView;
@end
