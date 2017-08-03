//
//  JDPageLoadingFailureView.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/7/2.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "PageLoadingFailureView.h"
#import "Resource.h"
#import <objc/runtime.h>

typedef void (^clickBlock) ();

@interface UIView (loadingFailure)
@property(nonatomic,strong)PageLoadingFailureView *loadingFailureView;
@end

@interface PageLoadingFailureView()
@property(nonatomic,copy)clickBlock clickBlock;
@end
@implementation PageLoadingFailureView
+(void)showPageLoagingFailure:(UIView *)showInView ClickBlock:(void (^)())clickBlock {
    if (showInView.loadingFailureView.superview) {
        return;
    }
    PageLoadingFailureView *failureView = showInView.loadingFailureView;
    if (!failureView) {
        failureView = [[PageLoadingFailureView alloc] init];
    }
    
    [showInView addSubview:failureView];
    [failureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showInView);
        make.centerY.equalTo(showInView);
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    failureView.clickBlock = clickBlock;
    showInView.loadingFailureView = failureView;
}

+(void)hideShowInView:(UIView *)showInView {
    PageLoadingFailureView *failureView = showInView.loadingFailureView;
    [failureView removeFromSuperview];
}
+(BOOL)hasShowLoagingFailureInView:(UIView *)showInView {
    PageLoadingFailureView *failureView = showInView.loadingFailureView;
    if (failureView) {
        return YES;
    }
    return NO;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickPress) forControlEvents:UIControlEventTouchUpInside];
        [self creatShowErrorView];
    }
    return self;
}
-(void)creatShowErrorView {
    
    UIView *backView = [[UIView alloc] init];
    backView.userInteractionEnabled = NO;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];
    
    UIImageView *errorImg = [[UIImageView alloc] init];
    errorImg.image = [Resource imageName:@"JDWuWangLuo"];
    [backView addSubview:errorImg];
    [errorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView);
        make.centerX.mas_equalTo(backView);
        make.bottom.mas_equalTo(0);
    }];
    
//    UILabel *textLab = [[UILabel alloc] init];
//    textLab.font = [UIFont systemFontOfSize:12];
//    textLab.textColor = UIColorFromRGB(0x5e5e5e);
//    textLab.text = @"加载失败,点击页面刷新";
//    [backView addSubview:textLab];
//    
//    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(errorImg.mas_bottom).with.offset(10);
//        make.centerX.mas_equalTo(backView);
//        make.bottom.mas_equalTo(backView);
//    }];
    
}
-(void)clickPress {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
static char loadingFailure;
@implementation UIView (loadingFailure)

-(PageLoadingFailureView *)loadingFailureView {
     return objc_getAssociatedObject(self, &loadingFailure);
}
-(void)setLoadingFailureView:(PageLoadingFailureView *)loadingFailureView {
    objc_setAssociatedObject(self, &loadingFailure,
                             loadingFailureView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
@end