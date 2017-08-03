//
//  JDWebView.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/10.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "JDWebView.h"
#import "UIView+ProgressHUD.h"
#import "NJKWebViewProgress.h"
@interface JDWebView()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *progressProxy;
@property (nonatomic,strong)  UIProgressView *progressView;
@end
@implementation JDWebView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWebview];
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _webView.delegate = _progressProxy;
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        
        _progressView = [[UIProgressView alloc] init];
        _progressView.tintColor = [UIColor systemZhuTiSe];
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
    }
    return self;
}
- (void)initWebview {
    self.webView = [[UIWebView alloc] init];
    [self.webView setScalesPageToFit: YES];
    self.webView.delegate = self;
    [self addSubview: self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
-(void)setUrl:(NSURL *)url {
    _url = url;
    [self loadWeb];
}
-(void)loadWeb {
    NSURLRequest *request =[NSURLRequest requestWithURL: _url];
    [self.webView loadRequest:request];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error) {
        if([_delegate respondsToSelector:@selector(JDWebViewFauile:)]) {
            [_delegate JDWebViewFauile:self];
        }
        __weak typeof(self)weak = self;
        self.progressView.hidden = YES;
        [self showErrorView:^{
            [weak loadWeb] ;
        }];
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    self.progressView.hidden = NO;
    [self hideErrorView];
    if([_delegate respondsToSelector:@selector(JDWebViewStartLoading:)]) {
        [_delegate JDWebViewStartLoading:self];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    if([_delegate respondsToSelector:@selector(JDWebViewStartLoading:)]) {
        [_delegate JDWebViewEndLoaded:self];
    }
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
        if([_delegate respondsToSelector:@selector(JDWebViewStartLoading:)]) {
            [_delegate JDWebViewStartLoading:self];
        }
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:0 options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
        if([_delegate respondsToSelector:@selector(JDWebViewStartLoading:)]) {
            [_delegate JDWebViewEndLoaded:self];
        }
    }
    
    [_progressView setProgress:progress animated:NO];
}
#pragma --mark getter
-(BOOL)canGoBack {
    return self.webView.canGoBack;
}
-(void)goBack {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.webView goBack];
}
@end
