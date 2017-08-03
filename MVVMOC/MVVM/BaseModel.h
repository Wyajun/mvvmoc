//
//  BaseModel.h
//  MVVMOC
//
//  Created by 王亚军 on 16/6/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommontCallBack.h"

@protocol ModelProtocol <NSObject>
-(void)sendNetWorkReQuest:(void(^)(CommontCallBack *ccb))callback;
@end


@interface BaseModel : NSObject<ModelProtocol>

@end

