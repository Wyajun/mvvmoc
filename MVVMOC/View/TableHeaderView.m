//
//  JDTableHeaderView.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/26.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "TableHeaderView.h"
@interface TableHeaderView()
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *titleLab;
@end
@implementation TableHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatBackView];
    }
    return self;
}
-(void)creatBackView {
    _backView = self.contentView;
    _backView.backgroundColor = viewBackColorf3;
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.textColor = UIColorFromRGB(0xa6a6a6);
    [_backView addSubview:_titleLab];
    
}

- (void)setHeadTitle:(NSString *)headTitle {
    _titleLab.text = headTitle;
    _headTitle = headTitle;
}

@end
