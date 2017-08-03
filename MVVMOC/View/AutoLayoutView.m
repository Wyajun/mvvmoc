//
//  AuotLayoutScrollerView.m
//  自动布局
//
//  Created by wyj on 14-10-19.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import "AutoLayoutView.h"
#import "Masonry.h"
#import <objc/runtime.h>

CGFloat const AuotLayoutViewAutoHeight = -1;
CGFloat const AuotLayoutViewAutoWidth  = -1;


@interface AutoLayoutView()
@property(nonatomic)AutoLayoutViewType type;
@property (nonatomic, strong) MASConstraint *bottomConstraint;
@property (nonatomic, strong) MASConstraint *sizeConstraint;
@property(nonatomic,weak) UIView *LastView;
@property(nonatomic,weak) UIView *contentView;
@property(nonatomic)CGSize size;
@end
@implementation AutoLayoutView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *content = [[UIView alloc] init];
        [self addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        self.contentView = content;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame viewType:(AutoLayoutViewType)type
{
    self = [self initWithFrame:frame];
    if (self) {
        [self setContentSize:frame.size viewType:type];
    }
    return self;
}
-(void)setContentSize:(CGSize)size viewType:(AutoLayoutViewType)type {
    
    if (type == AutoLayoutViewTypeV) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width);
        }];
       
    }else {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
        }];
    }
    self.type = type;
}



-(void)addAutoLayoutViewV:(UIView *)view height:(CGFloat)height
{
    NSAssert(self.type == AutoLayoutViewTypeV, @"scrollview为垂直方向添加view才能调用此方法");
    [self.contentView addSubview:view];
    
    if (self.LastView) {
        [self.bottomConstraint uninstall];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            self.bottomConstraint = make.bottom.mas_equalTo(0);
            make.left.and.right.mas_equalTo(0);
            make.top.mas_equalTo(self.LastView.mas_bottom);
            if (height != AuotLayoutViewAutoHeight) {
                make.height.mas_equalTo(height);
            }
        }];
       
    }else
    {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            self.bottomConstraint = make.bottom.mas_equalTo(0);
            make.left.and.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            if (height != AuotLayoutViewAutoHeight) {
                make.height.mas_equalTo(height);
            }
        }];
        
    }
    self.LastView = view;
}
-(void)addAutoLayoutViewH:(UIView *)view width:(CGFloat)width
{
    NSAssert(self.type == AutoLayoutViewTypeH, @"scrollview为水平方向添加view才能调用此方法");
    [self.contentView addSubview:view];
       if (self.LastView) {
           [self.bottomConstraint uninstall];
           [view mas_makeConstraints:^(MASConstraintMaker *make) {
               self.bottomConstraint = make.right.mas_equalTo(0);
               make.top.and.bottom.mas_equalTo(0);
               make.left.mas_equalTo(self.LastView.mas_right);
               if (width != AuotLayoutViewAutoWidth) {
                   make.width.mas_equalTo(width);
               }
           }];
        
    }else{
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            self.bottomConstraint = make.right.mas_equalTo(0);
            make.top.and.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            if (width != AuotLayoutViewAutoWidth) {
                make.width.mas_equalTo(width);
            }
        }];
    }
    self.LastView = view;
}
-(void)setAutoLayoutView:(UIView *)view content:(CGFloat)content
{
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.type == AutoLayoutViewTypeV) {
            make.height.mas_equalTo(content);
        }else {
             make.width.mas_equalTo(content);
        }
    }];
}
-(CGRect)autoLayoutView:(UIView *)view {
    return [view convertRect:view.bounds toView:self.contentView];
}
-(void)setContentSize:(CGSize)contentSize reset:(BOOL)reset {
    if (reset) {
        [self.sizeConstraint uninstall];
        [self.bottomConstraint install];
    }else {
        [self.bottomConstraint uninstall];
        [self.sizeConstraint uninstall];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
         self.sizeConstraint = make.size.mas_equalTo(contentSize);
        }];
        
    }
}

@end

