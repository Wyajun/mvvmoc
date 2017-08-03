//
//  VPIImageCropperData.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/3.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol VPImageCropperDelegate;
@interface VPIImageCropperData : NSObject
@property(nonatomic,strong)UIImage *image;
@property(nonatomic)CGRect cropFrame;
@property(nonatomic)CGFloat limitScaleRatio;
@property(nonatomic)BOOL   isArc;
@property(nonatomic,weak)id<VPImageCropperDelegate>delegate;
@end
