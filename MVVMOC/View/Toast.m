//
//  Toast.m
//  Toast
//
//  Created by HeCom on 15/4/28.
//
//

#import "Toast.h"
#import "TWMessageBarManager.h"

const  NSString *defaultSuccessImage = @"success.png";
const NSString *defaultErrorImage = @"error.png";
const CGFloat showTimeSeconds = 2;
const CGFloat bottomHeight = 100;


@interface ToastMgr : NSObject<TWMessageBarStyleSheet>
@property(nonatomic,strong)NSMutableArray *toastDatas;
+(instancetype)shareToastMgr;
-(void)showToastData:(ToastData *)toastData;
@end

@implementation Toast

+(void)toastMessage:(NSString *)message
{
    ToastData *data = [ToastData toastDataWith:message showTime:showTimeSeconds];
    [[ToastMgr shareToastMgr] showToastData:data];
}
+(void)toastSuccessShowImg:(NSString *)message
{
    ToastData *data = [ToastData toastDataWith:message showTime:showTimeSeconds];
    data.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:[defaultSuccessImage copy]]];
    [[ToastMgr shareToastMgr] showToastData:data];
}
+(void)toastErrorShowImg:(NSString *)message
{
    ToastData *data = [ToastData toastDataWith:message showTime:showTimeSeconds];
    data.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:[defaultErrorImage copy]]];
    [[ToastMgr shareToastMgr] showToastData:data];
}
+(void)toastMessageWith:(ToastData *)data
{
    [[ToastMgr shareToastMgr] showToastData:data];
}
+(void)toastNotificationWithMessage:(NSString *)message completionBlock:(void (^)(void))completion {
    [TWMessageBarManager sharedInstance].styleSheet = [ToastMgr shareToastMgr];
//    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"订单"
//                                                   description:message
//                                                          type:TWMessageBarMessageTypeInfo
//                                               statusBarHidden:NO
//                                                      callback:completion];
//    
//    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"提示" description:message type:TWMessageBarMessageTypeInfo duration:5 ];
     [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"提示" description:message type:TWMessageBarMessageTypeInfo duration:6 callback:completion ];
}
@end

@implementation ToastData
+(instancetype)toastDataWith:(NSString *)massage showTime:(CGFloat)secondes
{
    ToastData *data = [[ToastData alloc] init];
    if (!massage || ![massage isKindOfClass:[NSString class]]) {
        massage = @"";
    }
    data.message = massage;
    data.showTimeSecondes =secondes;
    return data;
}
+(instancetype)toastDataWith:(NSString *)massage title:(NSString *)title showTime:(CGFloat)secondes
{
    ToastData *data = [[ToastData alloc] init];
    data.message = massage;
    data.showTimeSecondes =secondes;
    data.title = title;
    return data;
}
@end


@implementation ToastMgr

+(instancetype)shareToastMgr
{
   static ToastMgr *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[ToastMgr alloc] initSuper];
    });
    return _share;
}
-(instancetype)initSuper
{
    self = [super init];
    if (self) {
        self.toastDatas = [NSMutableArray array];
    }
    return self;
}
-(void)showToastData:(ToastData *)toastData
{
    @synchronized(self.toastDatas)
    {
        [self.toastDatas addObject:toastData];
        if (self.toastDatas.count == 1) {
            if ( [NSThread isMainThread]) {
               [self showView:toastData];
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showView:toastData];
                });
            }
            
        }
    }
    
}
-(UIColor *)backgroundColorForMessageType:(TWMessageBarMessageType)type {
    return UIColorFromRGB(0x00aaef) ;
}
-(UIColor *)strokeColorForMessageType:(TWMessageBarMessageType)type {
    return UIColorFromRGB(0x00aaef) ;
}
-(UIImage *)iconImageForMessageType:(TWMessageBarMessageType)type {
    return [Resource imageName:@"appIcon"];
}
//-(CGFloat)
-(ToastData *)getFirstToastData
{
    @synchronized(self.toastDatas)
    {
        [self.toastDatas removeObjectAtIndex:0];
        if (self.toastDatas.count <= 0) {
            return nil;
        }else
        {
            return  [self.toastDatas firstObject];
        }
    }
}
-(void)showView:(ToastData *)data
{
    NSAssert(data.message, @"message不可为空");
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    backView.layer.cornerRadius = 5;
    backView.clipsToBounds = YES;
    UIView *topView ;
    if (data.customView) {
        [backView addSubview:data.customView];
        data.customView.translatesAutoresizingMaskIntoConstraints = NO;
        [data.customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(data.customView.frame.size);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(data.customView.frame.size.width + 10);
        }];
        topView = data.customView;
    }
    if (data.title.length > 0) {
        UILabel *titleLab = [[UILabel alloc] init];
        
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:20];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = data.title;
        
        [backView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(3);
            make.right.mas_equalTo(-3);
            if (data.customView) {
                make.top.mas_equalTo(data.customView.mas_bottom).with.offset(10);
            }else {
                make.top.mas_equalTo(5);
            }
        }];
        topView = titleLab;
    }
    UILabel *messageLab = [[UILabel alloc] init];
    messageLab.textColor = [UIColor whiteColor];
    messageLab.font = [UIFont systemFontOfSize:15];
    messageLab.text = data.message;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.numberOfLines = 0;
    [backView addSubview:messageLab];
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.width.mas_lessThanOrEqualTo(kScreenWidth - 60);
        if (topView) {
            make.top.mas_equalTo(topView.mas_bottom).with.offset(3);
            make.bottom.mas_equalTo(-8);
        }else {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }
    }];
    UIView* window = nil;
    if ([[UIApplication sharedApplication] windows].count > 1) {
        window = [[[UIApplication sharedApplication] windows] lastObject];
    }else{
        window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    [window addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-bottomHeight);
    }];
    
    [self afterSecondes:data.showTimeSecondes callback:^{
        [backView removeFromSuperview];
        ToastData *data = [[ToastMgr shareToastMgr] getFirstToastData];
        if (data) {
            [[ToastMgr shareToastMgr] showView:data];
        }
    }];
}
-(void)afterSecondes:(CGFloat )delayInSeconds callback:(void (^)())block
{
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //推迟两纳秒执行
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        block();
    });
}
@end



