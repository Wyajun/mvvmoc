//
//  JDRootScrollView.h
//  滚动视图
//
//  Created by 王亚军 on 15/10/9.
//  Copyright © 2015年 王亚军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopScrollView ;
@protocol RootScrollViewDelegate;
@interface RootScrollView : UIView
@property(nonatomic,strong)NSArray *contentViews;
@property(nonatomic,weak)TopScrollView *topView;
@property(nonatomic)NSInteger selectIndex;
@property(nonatomic,weak)id<RootScrollViewDelegate>delegate;
-(void)scrollToSelectView;
@end
@protocol RootScrollViewDelegate <NSObject>

-(void)RootScrollView:(RootScrollView *)rootScrollView selectIndex:(NSInteger)selectIndex;

@end