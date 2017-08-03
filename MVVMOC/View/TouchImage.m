//
//  TouchImage.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/10.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "TouchImage.h"
@interface TouchImage()
@end
@implementation TouchImage

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.tabBlock) {
        self.tabBlock();
    }
}
@end
