//
//  MBProgressHUD+Window.h
//
//  Created by joywii on 14-6-6.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Window)

+(MB_INSTANCETYPE)showAlertIndeterminateInWindowsWithText:(NSString *)message ;

+(MB_INSTANCETYPE)showAlertIndeterminateInWindowsWithText:(NSString *)message
withDetailText:(NSString *)detail;

+(MB_INSTANCETYPE)showAlertIndeterminateInWindows ;

+(MB_INSTANCETYPE)showAlertMessageInWindows:(NSString *)message ;

+(MB_INSTANCETYPE)showAlertMessageInWindowsWithKeyboard:(NSString *)message;

+(MB_INSTANCETYPE)showInView:(UIView *)view message:(NSString *)message;

+(MB_INSTANCETYPE)showOnKeyboardInView:(UIView *)view message:(NSString *)message;
@end
