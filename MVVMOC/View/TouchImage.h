//
//  TouchImage.h
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/10.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchImageTapBlock)();
@interface TouchImage : UIImageView
@property(nonatomic,copy) TouchImageTapBlock tabBlock;
@end
