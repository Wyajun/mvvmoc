//
//  JDBlankPage.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/7/31.
//  Copyright (c) 2015年 jiadao. All rights reserved.
//

#import "BlankPage.h"
#import "Resource.h"
#import <objc/runtime.h>
@interface UIView (blankPage)
@property(nonatomic,strong)BlankPage *blankPageView;
@end

@interface BlankPage ()
@end

@implementation BlankPage
+(void)showBlankPage:(UIView *)showInView {
    
    if (showInView.blankPageView) {
        showInView.blankPageView.hidden = NO;
        CGSize size = showInView.size;
        showInView.blankPageView.center = CGPointMake(size.width/2, size.height/2);
        return;
    }
    BlankPage *failureView = [[BlankPage alloc] initWithClass:[showInView class]];
    if (([showInView isKindOfClass:[UITableView class]] || [showInView isKindOfClass:[UICollectionView class]]) && showInView.subviews.count > 1) {
        [showInView insertSubview:failureView atIndex:1];
    }
    else {
        [showInView addSubview:failureView];
    }
    CGSize size = showInView.size;
    failureView.center = CGPointMake(size.width/2, size.height/2);
    showInView.blankPageView = failureView;
}

+(void)hideBlankPage:(UIView *)showInView {
    BlankPage *failureView = showInView.blankPageView;
    failureView.hidden = YES;
}

-(instancetype)initWithClass:(Class )class {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        self.frame = CGRectMake(0, 0, 115, 172);
        [self creatShowBlackView:class];
    }
    return self;
}

-(void)creatShowBlackView:(Class)class {
    UIImageView *errorImg = [[UIImageView alloc] init];
    errorImg.image = [Resource imageName:@"JDKonBaiYe"];
    [self addSubview:errorImg];
    [errorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.edges.mas_equalTo(0);
    }];
}

@end
static char blankPage111111;
@implementation UIView (blankPage)

-(BlankPage *)blankPageView {
     return objc_getAssociatedObject(self, &blankPage111111);
}

-(void)setBlankPageView:(BlankPage *)blankPageView {
    objc_setAssociatedObject(self, &blankPage111111,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
