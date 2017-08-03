//
//  JDContentMoreView.m
//  滚动视图
//
//  Created by 王亚军 on 15/10/9.
//  Copyright © 2015年 王亚军. All rights reserved.
//

#import "ContentMoreView.h"
#import "TopScrollView.h"
#import "RootScrollView.h"
@interface ContentMoreView ()
@property(nonatomic,strong)RootScrollView *rootView;
@property(nonatomic,strong)TopScrollView *topView;
@end


@implementation ContentMoreView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)resetView {
    
    self.topView.frame = self.titleViewFrame;
    self.rootView.frame = self.contentViewFrame;
    self.topView.titleViews = self.titleViews;
    self.rootView.contentViews = self.contentViews;
    self.rootView.topView = self.topView;
    
    
}
-(void)setDelegate:(id<RootScrollViewDelegate>)delegate {
    self.rootView.delegate = delegate;
}
-(TopScrollView *)topView {
    if(_topView) {
        return _topView;
    }
    _topView = [[TopScrollView alloc] init];
    [self addSubview:_topView];
    return _topView;
}
-(RootScrollView *)rootView {
    if (!_rootView) {
        _rootView = [[RootScrollView alloc] init];
    }
    [self addSubview:_rootView];
    return _rootView;
}
-(void)setSelectIndex:(NSInteger)selectIndex {
    self.topView.selectIndex = selectIndex;
    self.rootView.selectIndex = selectIndex;
    [self.rootView scrollToSelectView];
}
@end
