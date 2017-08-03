//
//  UIView+ProgressHUD.m
//  jiadao_ios
//
//  Created by 仲维涛 on 15/6/10.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "UIView+ProgressHUD.h"
#import "PageLoadingFailureView.h"
#import "BlankPage.h"
#import "MBProgressHUD.h"

@implementation UIView (ProgressHUD)

- (void)showProgressHUD
{
    [MBProgressHUD showHUDAddedTo:self  animated:YES];
}
- (void)hideProgressHUD
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

-(void)showErrorView:(void (^)())clickBlock {
    [PageLoadingFailureView showPageLoagingFailure:self ClickBlock:clickBlock];
}
-(void)hideErrorView {
    [PageLoadingFailureView hideShowInView:self];
}
-(void)showBlackPageView {
    [BlankPage showBlankPage:self];
}
-(void)hideBlackPageView {
    [BlankPage hideBlankPage:self];
}
@end
