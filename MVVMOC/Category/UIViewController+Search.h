//
//  UIViewController+Search.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/10/21.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+Search.h"
@interface UIViewController (Search)
-(void)creatSearchDisplayControllerWithSearchBar:(UISearchBar *)search;
@property(nonatomic,readonly)UISearchDisplayController *searchDisplayController;
@end
