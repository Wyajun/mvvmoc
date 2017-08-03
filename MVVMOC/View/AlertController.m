//
//  JDAlertController.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/8.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "AlertController.h"
#import "JDViewControllerPushManager.h"
#import "BlockUI.h"
@implementation AlertController
+(void)alterWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle selectIndex:(void (^)(NSInteger))selectIndex {
    if (IOS8) {
        [AlertController alterIOS8WithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle selectIndex:selectIndex];
    }else {
        [AlertController alterIOS7WithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle selectIndex:selectIndex];
    }
}
+(void)alterIOS8WithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle selectIndex:(void (^)(NSInteger))selectIndex {
   
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelButtonTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if(selectIndex) {
                selectIndex(0);
            }
        }];
        [alter addAction:cancelAction];
    }
    if (otherButtonTitle.length > 0) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(selectIndex) {
                selectIndex(1);
            }
            
        }];
        [alter addAction:otherAction];
    }
    
    
    
    [[JDViewControllerPushManager shareVCManager].currentViewControll presentViewController:alter animated:YES completion:nil];
    
}
+(void)alterIOS7WithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle selectIndex:(void (^)(NSInteger))selectIndex {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [alter showWithCompletionHandler:^(NSInteger buttonIndex) {
        if(selectIndex) {
            selectIndex(buttonIndex);
        }
    }];
}
+(void)sheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles selectIndex:(void(^) (NSInteger selectIndex) )selectIndex {
    if (IOS8) {
        [AlertController sheetIOS8WithTitle:title cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles selectIndex:selectIndex];
    }else {
        [AlertController sheetIOS7WithTitle:title cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles selectIndex:selectIndex];
    }
}
+(void)sheetIOS7WithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles selectIndex:(void(^) (NSInteger selectIndex) )selectIndex {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *title in otherButtonTitles) {
        [sheet addButtonWithTitle:title];
    }
    [sheet showInView:[JDViewControllerPushManager shareVCManager].currentViewControll.view withCompletionHandler:^(NSInteger buttonIndex) {
        if(selectIndex) {
            selectIndex(buttonIndex);
        }
    }];
}
+(void)sheetIOS8WithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles selectIndex:(void(^) (NSInteger selectIndex) )selectIndex{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if(selectIndex) {
            if (otherButtonTitles.count > 0) {
              selectIndex(otherButtonTitles.count);
            }else {
                selectIndex(0);
            }
        }
    }];
    [alter addAction:cancelAction];
    NSInteger index = 0;
    for (NSString *title in otherButtonTitles) {
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(selectIndex) {
                selectIndex(index);
            }
        }];
        [alter addAction:otherAction];
        index++;
    }
    [[JDViewControllerPushManager shareVCManager].currentViewControll presentViewController:alter animated:YES completion:nil];
}
@end
