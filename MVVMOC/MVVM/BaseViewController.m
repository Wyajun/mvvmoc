//
//  BaseViewController.m
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
#import "Masonry.h"
@implementation UIViewController (ViewControllerProtocol )


-(BOOL)hiddenNavBar {
    return NO;
}

-(BaseView *)baseView {
    return nil;
}
-(BaseModel *)baseModel {
    return nil;
}
@end

@implementation BaseViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self baseViewDidLoad];
}

-(void)baseViewDidLoad {
  
    self.view.backgroundColor = [UIColor systemViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self showDefaultLeftButton];
    
    [self.view addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.hiddenNavBar) {
            make.top.mas_equalTo(0);
        }else {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
        }
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.left.and.right.mas_equalTo(0);
    }];
    [self.baseView layoutIfNeeded];
    self.baseView.baseModel = self.baseModel;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.baseView refreshView];
}




@end



