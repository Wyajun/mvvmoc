//
//  JDWebView.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/10.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JDWebViewDelegate;
@interface JDWebView : UIView
@property (strong, nonatomic) NSURL *url;
@property (nonatomic,readonly) BOOL canGoBack;
@property (nonatomic,weak)id<JDWebViewDelegate>delegate;
- (void)goBack;
@end

@protocol JDWebViewDelegate <NSObject>

@optional
-(void)JDWebViewStartLoading:(JDWebView *)webView;
-(void)JDWebViewEndLoaded:(JDWebView *)webView;
-(void)JDWebViewFauile:(JDWebView *)webView;

@end
