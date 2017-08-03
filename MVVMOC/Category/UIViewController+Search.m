//
//  UIViewController+Search.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/10/21.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "UIViewController+Search.h"
#import <objc/runtime.h>

@interface UIViewController (DisplayController)
@property(nonatomic,strong)UISearchDisplayController *displayController;
@end

@implementation UIViewController (Search)
-(UISearchDisplayController *)searchDisplayController {
    return self.displayController;
}


-(void)creatSearchDisplayControllerWithSearchBar:(UISearchBar *)search {
    UISearchDisplayController* search1 = [[UISearchDisplayController alloc]initWithSearchBar:search contentsController:self];
    search1.active = NO;
    [search1.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.displayController = search1;
    
}

@end
static char DisplayController;
@implementation UIViewController (DisplayController)


-(UISearchDisplayController *)displayController {
    return objc_getAssociatedObject(self, &DisplayController);
}

-(void)setDisplayController:(UISearchDisplayController *)displayController {
    objc_setAssociatedObject(self, &DisplayController,
                             displayController,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end