//
//  JDAlertController.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/8.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertController : NSObject
/// 取消是0 其他是1
+(void)alterWithTitle:(NSString *)title message:(NSString *)message  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle selectIndex:(void(^) (NSInteger selectIndex) )selectIndex;
// 取消是数组的长度 ，数组按钮从0...n-1
+(void)sheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles selectIndex:(void(^) (NSInteger selectIndex) )selectIndex;
@end
