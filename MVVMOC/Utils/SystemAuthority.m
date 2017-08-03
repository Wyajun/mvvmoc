//
//  SystemAuthority.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/19.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "SystemAuthority.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "Toast.h"
#import "AlertController.h"

static NSString *const albumSettingTip = @"照片被禁用，请在设置-隐私中开启";
static NSString *const cameraSettingTip = @"相机被禁用，请在设置-隐私中开启";
@implementation SystemAuthority
/*
 typedef enum {
 AuthorizationStatusNotDetermined = 0, // 用户尚未做出选择这个应用程序的问候
 AuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
 AuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
 AuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据} CLAuthorizationStatus;
 }
 */
+(AuthorityStatus)albumAuthority {
    if (IOS8) {
     PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
        switch (author) {
            case PHAuthorizationStatusRestricted:
            case PHAuthorizationStatusDenied:
                return SystemAuthorityJJ;
                break;
            case PHAuthorizationStatusAuthorized:
                return SystemAuthoritySQ;
                break;
            case PHAuthorizationStatusNotDetermined:
                return SystemAuthorityWBT;
                break;
            default:
                break;
        }
        
        
    }else {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
        switch (author) {
            case ALAuthorizationStatusRestricted:
            case ALAuthorizationStatusDenied:
                return SystemAuthorityJJ;
                break;
            case ALAuthorizationStatusAuthorized:
                return SystemAuthoritySQ;
                break;
            case ALAuthorizationStatusNotDetermined:
                return SystemAuthorityWBT;
                break;
            default:
                break;
        }
        
    }
    return SystemAuthorityNone;
}
+(AuthorityStatus)cameraAuthority {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (authStatus) {
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            return SystemAuthorityJJ;
            break;
        case AVAuthorizationStatusAuthorized:
            return SystemAuthoritySQ;
            break;
        case AVAuthorizationStatusNotDetermined:
            return SystemAuthorityWBT;
            break;
        default:
            break;
    }
    return SystemAuthorityNone;
}
+(void)openSetting:(NSString *)showTip  {
    if (IOS8) {
        [AlertController alterWithTitle:@"提示" message:showTip cancelButtonTitle:@"取消" otherButtonTitles:@"去设置" selectIndex:^(NSInteger selectIndex) {
            if (selectIndex == 1) {
                 BOOL success =  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                if (!success) {
                    [Toast toastMessage:@"自动跳转失败,请退出程序,手动设置"];
                }
            }
        }];
    }else {
        [AlertController alterWithTitle:@"提示" message:showTip cancelButtonTitle:@"知道了" otherButtonTitles:nil selectIndex:nil];
    }
    
}
+(void)openSetting:(SettingTipTextStatus)showTip ShowView:(UIView *)showView {
    NSString *tip ;
    if (showTip == SettingTipTextAlbum) {
        tip = albumSettingTip;
    }
    if (showTip == SettingTipTextCamera) {
        tip = cameraSettingTip;
    }
    if (IOS8) {
        [AlertController alterWithTitle:@"提示" message:tip cancelButtonTitle:@"取消" otherButtonTitles:@"去设置" selectIndex:^(NSInteger selectIndex) {
            if (selectIndex == 1) {
                BOOL success =  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                if (!success) {
                    [Toast toastMessage:@"自动跳转失败,请退出程序,手动设置"];
                }
            }else {
            [self showTip:tip InView:showView];
            }
        }];
    }else {
        if(showView){
            [self showTip:tip InView:showView];
        }else {
            [AlertController alterWithTitle:@"提示" message:tip cancelButtonTitle:@"知道了" otherButtonTitles:nil selectIndex:nil];
        }
    }
}
+(void)showTip:(NSString *)tip InView:(UIView *)view {

    if (!view ) {
        return;
    }
    UIView *backView = [[UIView alloc] init];
    [view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = tip;
    tipLab.numberOfLines = 0;
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfText1Font];
    tipLab.textColor = [UIColor systemWenZiHeader1];
    [backView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(kViewStartX);
        make.right.mas_equalTo(-kViewStartX);
    }];
}
@end
