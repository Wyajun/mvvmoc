//
//  BaseViewController.h
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "BaseView.h"
@protocol ViewControllerProtocol <NSObject>
@property(nonatomic,readonly)BaseView *baseView;
@property(nonatomic,readonly)BaseModel *baseModel;
@property(nonatomic,readonly)BOOL hiddenNavBar;
@end


@interface BaseViewController : UIViewController

@end

@interface UIViewController (ViewControllerProtocol)<ViewControllerProtocol>

@end
