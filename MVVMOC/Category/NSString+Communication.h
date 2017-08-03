//
//  NSString+Communication.h
//  communication
//
//  Created by wyj on 14-9-21.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//  NSString 通信相关的分类

#import <Foundation/Foundation.h>

@interface NSString (Communication)
// 打电话
-(void)dialTelephone;
// 发短信
-(void)sendMessageWithViewController:(UIViewController *)vc body:(NSString *)body;
@end
