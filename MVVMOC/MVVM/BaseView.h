//
//  BaseView.h
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@protocol ViewProtocol <NSObject>
@property(nonatomic,weak)id<ModelProtocol>baseModel;
@property(nonatomic,readonly)BOOL showHUD;
-(void)initCustomView;
-(void)refreshView;

@end

@interface UIView (BaseViewProtocol)<ViewProtocol>
-(void)repeatNetWorkRequest;
@end

@interface BaseView : UIView
@property(nonatomic)NSInteger refreshCount;
@end
