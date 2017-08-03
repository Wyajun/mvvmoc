//
//  UIScrollView+Refresh.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/24.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)
@property(nonatomic)BOOL footerHidden;
-(void)addHeaderWithCallback:(void(^)())header;
-(void)headerEndRefreshing;
-(void)addFooterWithCallback:(void(^)())fooder;
-(void)footerEndRefreshing;
@end
