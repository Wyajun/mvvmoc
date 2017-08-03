//
//  BaseTableView.m
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import "BaseTableView.h"
#import "UIView+ProgressHUD.h"
#import "Thread.h"
#import "UIScrollView+Refresh.h"
@implementation BaseTableModel

-(void)sendNetWorkReQuest:(void (^)(CommontCallBack *))callback {
    [self fetchListData:callback];
}
-(void)fetchListData:(void (^)(CommontCallBack *))callback {
    
}

-(NSArray *)listData {
    return @[];
}

@end


@interface BaseTableView ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *listData;
-(void)reloadTableView;
@end

@interface BaseTableView (BaseTableProtocol)<BaseTableProtocol>

@end


@interface BaseTableView (UITableViewDelegate)<UITableViewDelegate,UITableViewDataSource>
-(void)setTableDelegate;
@end


@implementation BaseTableView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _listData = @[];
        _cellDic = [NSMutableDictionary dictionary];
    }
    return self;
}
-(void)initCustomView {
    if (self.tableView) {
        return;
    }
    self.listData = self.baseTableModel.listData;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor systemViewBackgroundColor];
    [self addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self registerCellClass:_tableView];
    [self registerHeaderFooderClass:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    __weak typeof(self)weak = self;
    if (self.refreshHeader) {
        [_tableView addHeaderWithCallback:^{
            [[weak baseTableModel] fetchListData:^(CommontCallBack *ccb) {
                [weak.tableView headerEndRefreshing];
                [weak reloadTableView];
            }];
        }];
    }
    if (self.refreshFooder) {
        [_tableView addFooterWithCallback:^{
            [[weak baseTableModel] fetchListDataNext:^(CommontCallBack *ccb, BOOL isEnd) {
                [weak.tableView footerEndRefreshing];
                weak.tableView.footerHidden = isEnd;
                [weak reloadTableView];
            }];
        }];
    }
    
}
-(void)reloadTableView {
    if ([NSThread isMainThread]) {
        self.listData = [self baseTableModel].listData;
        [self.tableView reloadData];
    }else {
        [Thread runInMain:^{
            self.listData = [self baseTableModel].listData;
            [self.tableView reloadData];
        }];
    }
    
}
-(BaseTableModel *)baseTableModel {
    return (BaseTableModel *)self.baseModel;
}
@end


@implementation BaseTableNoSection

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.listData.count;
    count > 0 ? [self hideBlackPageView]:[self showBlackPageView];
    return  count;
}
@end

@implementation BaseTableSection
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.listData.count;
    count > 0 ? [self hideBlackPageView]:[self showBlackPageView];
    return  count;
}
@end



@implementation BaseTableView (UITableViewDelegate)

-(void)setTableDelegate {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end


@implementation BaseTableView (BaseTableProtocol)

-(UITableViewStyle)style {
    return UITableViewStylePlain;
}
-(BOOL)refreshFooder {
    return NO;
}
-(BOOL)refreshHeader {
    return YES;
}
-(BOOL)refreshNetWork {
    return NO;
}
-(void)registerCellClass:(UITableView *)tableView {
    
}
-(void)registerHeaderFooderClass:(UITableView *)tableView {
    
}
-(void)refreshView {
    if (self.refreshCount < 1) {
        self.refreshCount ++;
        return;
    }
    if (self.refreshNetWork) {
        __weak typeof(self)weak = self;
        [self.baseTableModel fetchListData:^(CommontCallBack *ccb) {
            if (ccb.success) {
                [weak hideErrorView];
                [weak reloadTableView];
            }
        }];
    }else {
         [self reloadTableView];
    }
}
@end

