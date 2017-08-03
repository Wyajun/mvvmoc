//
//  TJGridViewCellProtocol.h
//  TuJia
//
//  Created by 王亚军 on 16/5/25.
//  Copyright © 2016年 途家. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GridViewCellProtocol <NSObject>

-(void)setCellData:(id)data;
@end

@interface UICollectionViewCell (gridViewCell)<GridViewCellProtocol>

@end
