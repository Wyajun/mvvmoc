//
//  MBProgressHUD+Window.m
//
//  Created by joywii on 14-6-6.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "MBProgressHUD+Window.h"

@implementation MBProgressHUD (Window)


+(MB_INSTANCETYPE)showAlertIndeterminateInWindowsWithText:(NSString *)message
{
    return [[self class] showAlertIndeterminateInWindowsWithText:message withDetailText:nil] ;
}

+(MB_INSTANCETYPE)showAlertIndeterminateInWindowsWithText:(NSString *)message
                                           withDetailText:(NSString *)detail
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (!window)
    {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
	HUD.labelText = message;
    HUD.detailsLabelText = detail ;
    
    return HUD ;
}

+(MB_INSTANCETYPE)showAlertIndeterminateInWindows
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (!window)
    {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate ;
    return HUD ;
}

+(MB_INSTANCETYPE)showAlertMessageInWindows:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (!window)
    {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.mode = MBProgressHUDModeText ;
    HUD.labelText = message;
    return HUD ;

}
+(MB_INSTANCETYPE)showAlertMessageInWindowsWithKeyboard:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (!window)
    {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [HUD setYOffset:-50];
    HUD.mode = MBProgressHUDModeText ;
    HUD.labelText = message;
    return HUD ;
}

+(MB_INSTANCETYPE)showInView:(UIView *)view message:(NSString *)message
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText ;
    HUD.labelText = message;
    return HUD;
}
+(MB_INSTANCETYPE)showOnKeyboardInView:(UIView *)view message:(NSString *)message
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText ;
    [HUD setYOffset:-50];
    HUD.labelText = message;
    return HUD;
}
//===========================================================================================//

@end
