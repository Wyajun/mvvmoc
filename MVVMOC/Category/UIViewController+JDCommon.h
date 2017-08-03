//
//  UIViewController+JDCommon.h
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/11.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JDCommon)<UIGestureRecognizerDelegate>




//具体类实现
- (void)rightBarButtonPressed:(id)sender;
- (void)leftBarButtonPressed:(id)sender;


- (void)showRightButtonWithTitle:(NSString *)title;
- (void)showRightButtonWithImage:(UIImage *)image highlight:(UIImage *)highLightImage;

- (void)showLeftButtonWithTitle:(NSString *)title;
- (void)showLeftButtonWithImage:(UIImage *)image highlight:(UIImage *)highLightImage;
- (void)showDefaultLeftButton;
-(UIButton *)customLeftButton;

-(UIButton *)customRightButton;

- (void)showProgressHUD;

- (void)hideProgressHUD;

- (void)showMessage:(NSString *)message;

- (void)showErrorView:(void(^)())clickBlock;

- (void)hideErrorView;

@end
