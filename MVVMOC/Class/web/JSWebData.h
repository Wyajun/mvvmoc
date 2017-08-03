//
//  JSWebData.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/16.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,JDWebType)
{
    // 未知状态
    JDWebTypeNone,
    /// 1.特价车
    JDWebTypeTeJiaChe = 1 ,
    
};
@interface JSWebData : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;
@property(nonatomic)JDWebType webType;
@property(nonatomic,strong)id parame;
@end
