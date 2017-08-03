//
//  BaseTableView.h
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "BaseModel.h"
#import "CommontCallBack.h"
@protocol ModelTableProtocol <NSObject>
@property(nonatomic,strong,readonly)NSArray *listData;
-(void)fetchListData:(void(^)(CommontCallBack *ccb))callback;
@optional
-(void)fetchListDataNext:(void(^)(CommontCallBack *ccb, BOOL isEnd))callback;
@end
@protocol BaseTableProtocol <NSObject>

@property(nonatomic,readonly)UITableViewStyle style;
@property(nonatomic,readonly)BOOL refreshHeader;
@property(nonatomic,readonly)BOOL refreshFooder;
@property(nonatomic,readonly)BOOL refreshNetWork;

-(void)registerCellClass:(UITableView *)tableView;
-(void)registerHeaderFooderClass:(UITableView *)tableView;

@end

@interface BaseTableModel:BaseModel<ModelTableProtocol>
@end


@interface BaseTableView : BaseView
@property(nonatomic,strong)NSMutableDictionary *cellDic;
@end

@interface BaseTableNoSection : BaseTableView

@end

@interface BaseTableSection : BaseTableView

@end
