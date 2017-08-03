//
//  JDDatePicker.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/13.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, JDDatePickerType)
{
    // yy-mm-dd
    JDDatePickerYMD = 1 ,
   
    
};
@interface DatePicker : UIView

@property(nonatomic,copy)void(^dateSelect)(NSDate *);
@property(nonatomic,strong)NSDate *startDate;
@property(nonatomic,weak)UITextField *textField;
-(instancetype)initWithType:(JDDatePickerType )type;

@end
