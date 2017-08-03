//
//  Toast.h
//  Toast
//
//  Created by HeCom on 15/4/28.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ToastData;
@interface Toast : NSObject
+(void)toastMessage:(NSString *)message;
+(void)toastSuccessShowImg:(NSString *)message;
+(void)toastErrorShowImg:(NSString *)message;
+(void)toastMessageWith:(ToastData *)data;

+(void)toastNotificationWithMessage:(NSString*)message completionBlock:(void (^)(void))completion;
@end


@interface ToastData : NSObject
+(instancetype)toastDataWith:(NSString *)massage showTime:(CGFloat)secondes;

+(instancetype)toastDataWith:(NSString *)massage title:(NSString *)title showTime:(CGFloat)secondes;

@property(nonatomic,strong)NSString *message;
@property(nonatomic)CGFloat showTimeSecondes;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIView *customView;// 必须设置size大小 负责无法显示
@end