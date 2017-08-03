//
//  UITableView+Search.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/10/21.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "UITableView+Search.h"

@implementation UITableView (Search)
-(UISearchBar *)search {
    if (self.tableHeaderView) {
        return (UISearchBar *)self.tableHeaderView;
    }
   UISearchBar  *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [searchbar setPlaceholder:@"搜索列表"];
    self.tableHeaderView = searchbar;
    return searchbar;
}
@end
