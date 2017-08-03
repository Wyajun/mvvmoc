//
//  JsWebViewController.m
//  JsWebView
//
//  Created by xdf on 4/29/15.
//  Copyright (c) 2015 xdf. All rights reserved.
//

#import "JsWebViewController.h"
#include "UIViewController+Push.h"
#import "JDViewControllerPushManager.h"
#import "JDWebView.h"
#import "JSWebData.h"
#import "Share.h"
@interface JsWebViewController ()<JDWebViewDelegate>
@property (nonatomic, strong)  JSWebData *jsData;
@property (nonatomic,weak)JDWebView *webView;
@property(nonatomic)BOOL isPOP;
@end

@implementation JsWebViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _isPOP = self.navigationController.interactivePopGestureRecognizer.enabled;
     self.jsData = self.parameter;
    self.title = self.jsData.title;
    JDWebView *web = [[JDWebView alloc] init];
   
    [self.view addSubview:web];
    [web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    _webView = web;
    _webView.delegate = self;
    NSString *cleanString = [self.jsData.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     web.url = [NSURL URLWithString:cleanString];
    [self showDefaultLeftButton];
    [self dealWithWebType:_jsData.webType];
}

- (void)leftBarButtonPressed:(id)sender
{
    if(self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = _isPOP;
    [[JDViewControllerPushManager shareVCManager] popViewController:self animated:YES];
}
#pragma --mark webType
-(void)rightBarButtonPressed:(id)sender {
    switch (_jsData.webType) {
        case JDWebTypeNone:
            break;
        case JDWebTypeTeJiaChe:
            [self fenXiangTeJiaChe];
            break;
        default:
            break;
    }
}


-(void)dealWithWebType:(JDWebType)type {
    switch (type) {
        case JDWebTypeNone:
            break;
        case JDWebTypeTeJiaChe:
            [self dealWithTeJiaChe];
            break;
        default:
            break;
    }
}

-(void)fenXiangTeJiaChe {
    [Share shareTeJiaChe:_jsData.parame];
}

-(void)dealWithTeJiaChe {
    [self showRightButtonWithTitle:@"分享"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma --mark delegate
-(void)JDWebViewEndLoaded:(JDWebView *)webView {
    self.title = self.jsData.title;
    [self setPOP:!webView.canGoBack];
}
-(void)JDWebViewFauile:(JDWebView *)webView {
    self.title = self.jsData.title;
    [self setPOP:!webView.canGoBack];
}
-(void)JDWebViewStartLoading:(JDWebView *)webView {
    self.title = @"加载中...";
    
    [self setPOP:NO];
}
-(void)setPOP:(BOOL)pop {
    self.navigationController.interactivePopGestureRecognizer.enabled = pop;
}
@end