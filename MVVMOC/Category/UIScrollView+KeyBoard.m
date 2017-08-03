//
//  UIScrollView+KeyBoard.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 16/3/6.
//  Copyright © 2016年 jiadao. All rights reserved.
//

#import "UIScrollView+KeyBoard.h"
#import <objc/runtime.h>
@interface UIScrollView(KeyBoardAttribute)<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *editView;
@property(nonatomic) BOOL keyboardPopUp;
@property(nonatomic,strong)UIView *keyBoardView;
@end



@implementation UIScrollView (KeyBoard)

@end

@implementation UIScrollView (KeyBoardAttribute)

static char editViewKeyBoard;
static char keyboardPopUp;
static char keyBoardView;
#pragma mark -- setter getter

-(void) addKeyBoardNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
}


-(void)keyboardWillHidden:(NSNotification *)notification {
    [self tapPress ];
}
-(void) keyboardWillShow:(NSNotification *)notification {
    
    self.keyboardPopUp = YES;
    NSDictionary*info=[notification userInfo];
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSLog(@"keyboard changed, keyboard width = %f, height = %f",
          kbSize.width,kbSize.height);
    [self.keyBoardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kbSize.height);
    }];
    
    CGRect frame = [self.editView convertRect:self.editView.bounds toView:self];
    CGFloat offset = frame.size.height + frame.origin.y;
    offset = offset - self.contentOffset.y;
    CGFloat height = kScreenHeight - kbSize.height;
    
    if ( offset > height) {
        CGFloat offsetY = offset - height + self.contentOffset.y;
        self.contentOffset = CGPointMake(0.0, offsetY);
    }
}
-(void) tapPress {
    self.keyboardPopUp = NO;
    [self endEditing:NO];
    [self.keyBoardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.keyboardPopUp) {
        return self.keyboardPopUp;
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer ];
}

-(void) registeredKeyboardNotification {
    [self addKeyBoardNotification];
    self.keyBoardView = [[UIView alloc] init];
    [self.superview addSubview:self.keyBoardView];
//    self.keyBoardView!.snp_makeConstraints { (make) -> Void in
//        make.left.equalTo(0)
//        make.right.equalTo(0)
//        make.bottom.equalTo(0)
//        make.height.equalTo(0)
//    }
//    self.keyboardPopUp = NO;
//    self.snp_updateConstraints { (make) -> Void in
//        make.bottom.equalTo(self.keyBoardView!.snp_top)
//    }
}

-(UIView *)editView {
    return objc_getAssociatedObject(self, &editViewKeyBoard);
}
-(void)setEditView:(UIView *)editView {
    objc_setAssociatedObject(self, &editViewKeyBoard, editView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)keyboardPopUp {
    return [objc_getAssociatedObject(self, &keyboardPopUp) boolValue];

}
-(void)setKeyboardPopUp:(BOOL)keyboardPopUp {
    objc_setAssociatedObject(self, &keyboardPopUp, @(keyboardPopUp),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)keyBoardView {
    return objc_getAssociatedObject(self, &keyBoardView);

}
-(void)setKeyBoardView:(UIView *)keyBoardView {
     objc_setAssociatedObject(self, &keyBoardView, keyBoardView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
