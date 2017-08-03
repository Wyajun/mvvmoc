//
//  UIScrollView+Refresh.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/24.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "MJRefresh.h"
#import <objc/runtime.h>
typedef void(^refreshFooder)() ;
@interface UIScrollView(RefreshBlock)
@property(nonatomic,copy)refreshFooder fooder;
@end
@implementation UIScrollView (Refresh)
@dynamic footerHidden;
-(void)addHeaderWithCallback:(void (^)())header {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:header];
}
-(void)addFooterWithCallback:(void (^)())fooder {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    self.fooder = fooder;
}
-(void)loadMoreData {
    if (self.fooder) {
        self.fooder();
    }
}
-(void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}
-(void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
}
-(void)setFooterHidden:(BOOL)footerHidden {
    self.mj_footer.hidden = footerHidden;
}
@end
@implementation UIScrollView (RefreshBlock)

static char refreshFooder1;
-(refreshFooder )fooder
{
    return objc_getAssociatedObject(self, &refreshFooder1);
}

-(void)setFooder:(refreshFooder)fooder
{
    objc_setAssociatedObject(self, &refreshFooder1,
                             fooder,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
