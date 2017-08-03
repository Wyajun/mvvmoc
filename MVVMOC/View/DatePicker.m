//
//  JDDatePicker.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/13.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "DatePicker.h"

@interface DatePicker ()
@property(nonatomic,strong)NSDate *selectdata;
@property(nonatomic,strong)UIDatePicker  *datePick;
@end

@implementation DatePicker

-(instancetype)initWithType:(JDDatePickerType)type {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 256)];
    if (self) {
        [self creatDateView:type];
    }
    return self;
}
-(void)creatDateView:(JDDatePickerType)type {
    switch (type) {
        case JDDatePickerYMD:
            [self creatDateYMD];
            break;
            
        default:
            break;
    }
}
-(void)creatDateYMD {
    
    UIView *toolBar = [self creatDateYMDToolBar];
    [self addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UIDatePicker *datePick = [[UIDatePicker alloc] init];
    datePick.backgroundColor = [UIColor whiteColor];
    datePick.datePickerMode = UIDatePickerModeDate;
    [datePick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePick];
    [datePick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(216);
    }];
    _datePick = datePick;
    datePick.minimumDate = [NSDate date];
    self.selectdata = [NSDate date];
}

-(UIView *)creatDateYMDToolBar {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor systemViewBackgroundColor1];
    UIButton *leftBnt = [[UIButton alloc] init];
    [leftBnt setTitle:@"取消" forState:UIControlStateNormal];
    [leftBnt setTitleColor:[UIColor systemWenZiHeader1] forState:UIControlStateNormal];
    [leftBnt  addTarget:self action:@selector(leftBntPress) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftBnt];
    [leftBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    
    UIButton *rightBnt = [[UIButton alloc] init];
    [rightBnt setTitle:@"确定" forState:UIControlStateNormal];
    [rightBnt setTitleColor:[UIColor systemWenZiHeader1] forState:UIControlStateNormal];
     [rightBnt  addTarget:self action:@selector(rightBntPress) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBnt];
    [rightBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
    }];
    
    return view;
}
-(void)leftBntPress {
    if (self.textField) {
        [self.textField resignFirstResponder];
    }else {
        
    }
    
}
-(void)rightBntPress {
    if (self.dateSelect) {
        self.dateSelect(_selectdata);
    }
    [self leftBntPress];

}
-(void)dateChange:(UIDatePicker *)pick {
    _selectdata = pick.date;
}
-(void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    _selectdata = startDate;
    _datePick.date = startDate;
}
@end
