//
//  Resource.h
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/12.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Resource : NSObject
+(UIImage *)imageName:(NSString *)imageName;

// 默认车辆图片
+(UIImage *)defaultCarImage;
// 返回延中心点拉升的图片
+(UIImage *)resizeImage:(NSString *)imgName;
@end
