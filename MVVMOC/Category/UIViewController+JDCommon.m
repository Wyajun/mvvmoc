//
//  UIViewController+JDCommon.m
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/11.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "UIViewController+JDCommon.h"
#import "UIView+ProgressHUD.h"
#import "NSString+Extent.h"
#import "MBProgressHUD.h"
#import "JDViewControllerPushManager.h"



@implementation UIViewController (JDCommon)

- (void)rightBarButtonPressed:(id)sender
{
    
}

- (void)leftBarButtonPressed:(id)sender
{
    [[JDViewControllerPushManager shareVCManager] popViewController:self animated:YES];
}
//创建Button
- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"6c6c6c"] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16] boundSize:button.frame.size];
    button.frame = CGRectMake(0, 0, size.width, 44);
    return button;
}
- (void)showRightButtonWithTitle:(NSString *)title
{
    UIButton *button = [self createButtonWithTitle:title];
    [button setTitleColor:[UIColor systemZhuTiSe] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)showRightButtonWithImage:(UIImage *)image highlight:(UIImage *)highLightImage
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    CGFloat marginX = image.size.width < 44 ? (44 - image.size.width) / 2 : 0;
    CGFloat marginY = image.size.height < 44 ? (44 - image.size.height) / 2 : 0;
    button.imageEdgeInsets = UIEdgeInsetsMake(marginY, marginX * 2, marginY, 0);
    [button setImage:image forState:UIControlStateNormal];
    if (!highLightImage) {
        [button setImage:image forState:UIControlStateHighlighted];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barItem;
}
- (void)showLeftButtonWithTitle:(NSString *)title
{
    // 设置leftBarButtonItem之后，左滑返回手势就会失效
    UIButton *button = [self createButtonWithTitle:title];
    [button setTitleColor:[UIColor colorWithHexString:@"6c6c6c"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barItem;
}
-(void)showDefaultLeftButton {
    if (self.navigationController.viewControllers.count > 0) {
         [self showLeftButtonWithImage:[Resource imageName:@"title_backarrow"] highlight:nil];
    }
   
}
- (void)showLeftButtonWithImage:(UIImage *)image highlight:(UIImage *)highLightImage
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    CGFloat marginX = image.size.width < 44 ? (44 - image.size.width) / 2 : 0;
    CGFloat marginY = image.size.height < 44 ? (44 - image.size.height) / 2 : 0;
    button.imageEdgeInsets = UIEdgeInsetsMake(marginY, 0, marginY, marginX * 2);
    [button setImage:image forState:UIControlStateNormal];
    if (!highLightImage) {
        [button setImage:image forState:UIControlStateHighlighted];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barItem;
}

-(UIButton *)customLeftButton {
    UIButton *backButton = (id)self.navigationItem.leftBarButtonItem.customView;
    if ([backButton isKindOfClass:[UIButton class]]) {
        return backButton;
    }
    return nil;
}
-(UIButton *)customRightButton {
    UIButton *backButton = (id)self.navigationItem.rightBarButtonItem.customView;
    if ([backButton isKindOfClass:[UIButton class]]) {
        return backButton;
    }
    return nil;
}

- (void)showProgressHUD
{
    [self.view showProgressHUD];
}

- (void)hideProgressHUD
{
    [self.view hideProgressHUD];
}
- (void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

- (void)showErrorView:(void(^)())clickBlock
{
    [self.view showErrorView:clickBlock];
}
- (void)hideErrorView
{
    [self.view hideErrorView];
}
@end
