//
//  BaseView.m
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import "BaseView.h"
#import "UIView+ProgressHUD.h"
@implementation UIView (BaseViewProtocol)
@dynamic baseModel;

-(void)refreshView {
    
}

-(void)initCustomView {
    
}
-(void)repeatNetWorkRequest {
    
    if (self.showHUD) {
        [self showProgressHUD];
    }
    __weak typeof(self)weak = self;
    [self.baseModel sendNetWorkReQuest:^(CommontCallBack *ccb) {
        [weak hideProgressHUD];
        if (ccb.success) {
            [weak hideErrorView];
            [weak initCustomView];
        }else {
            [weak hideBlackPageView];
            [weak showErrorView:^{
                [weak repeatNetWorkRequest];
            }];
        }
    }];
}

@end

@interface BaseView ()
@property(nonatomic,weak)id<ModelProtocol>baseModel1;

@end
@implementation BaseView
-(instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        _refreshCount  = 0;
    }
    return self;
}
-(void)setBaseModel:(id<ModelProtocol>)baseModel {
    _baseModel1 = baseModel;
    [self repeatNetWorkRequest];
}
-(id<ModelProtocol>)baseModel {
    return _baseModel1;
}
@end
