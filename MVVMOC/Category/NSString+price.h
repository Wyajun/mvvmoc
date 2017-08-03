//
//  NSString+price.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/3.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (price)
// 12.12万-》 121,200
-(NSString *)wanyanQianfengWei;
// 1222-> 1,222
-(NSString *)QianfengWei;
// 1222 -> 1.22万元
-(NSString *)wanYuan;
// 1222 -> 1.22
-(NSString *)wanYuan1;
// 12200->122
-(NSString *)fenZhuanYuan;
//12222->122.22
-(NSString *)xiaoShuLiangWei;
@end
