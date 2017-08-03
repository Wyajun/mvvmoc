//
//  TJGridView.m
//  日历控件
//
//  Created by 王亚军 on 16/5/25.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import "GeneralGridView.h"
#import "GridViewCellProtocol.h"
#import "masonry.h"
@interface GeneralGridView()
@property(nonatomic,strong) UICollectionView *collectView;
@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
@end
#define kReuseIdentifier  @"ReuseIdentifier"
@interface GeneralGridView (Delegate)<UICollectionViewDelegate,UICollectionViewDataSource>


@end
@implementation GeneralGridView

-(instancetype)initWithCell:(Class)cell {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.scrollEnabled = NO;
        [self addSubview:_collectView];
        self.backgroundColor = [UIColor whiteColor ];
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [_collectView registerClass:cell forCellWithReuseIdentifier:kReuseIdentifier];
    }
    return self;
}

-(void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    _layout.itemSize = itemSize;
}

-(void)setLineSpace:(CGFloat)lineSpace {
    _lineSpace = lineSpace;
    _layout.minimumLineSpacing = lineSpace;
}
-(void)setRowSpace:(CGFloat)rowSpace {
    _rowSpace = rowSpace;
    _layout.minimumInteritemSpacing = _rowSpace;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    _collectView.backgroundColor = backgroundColor;
}
-(void)reloadData {
    [_collectView reloadData];
}
@end
@implementation GeneralGridView (Delegate)

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    [cell setCellData:_list[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gridSelectIndexPath) {
        self.gridSelectIndexPath(indexPath);
    }
}
@end
