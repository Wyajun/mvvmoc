//
//  JDPageLoadingFailureView.h
//  jiadao_ios
//
//  Created by 王亚军 on 15/7/2.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageLoadingFailureView : UIControl
+(void)showPageLoagingFailure:(UIView *)showInView ClickBlock:(void(^)())clickBlock;
+(void)hideShowInView:(UIView *)showInView;
+(BOOL)hasShowLoagingFailureInView:(UIView *)showInView;
@end
