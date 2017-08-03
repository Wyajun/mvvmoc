//
//  NSString+Communication.m
//  communication
//
//  Created by wyj on 14-9-21.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import "NSString+Communication.h"
#import <MessageUI/MessageUI.h>
#import <objc/runtime.h>
@interface SendMessage : NSObject <MFMessageComposeViewControllerDelegate>
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *body;
-(void)sendMessage:(UIViewController *)vc;
@end
@implementation SendMessage

-(void)sendMessage:(UIViewController *)vc
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
//    NSString * infoKey = nil;
    if (messageClass != nil)
    {
        if ([messageClass canSendText])
        {
            [self displaySMSComposerSheet:vc];
            NSLog(@"ok");
        }
        else
        {
            NSLog(@"设备不支持发短信");
        }
    }else
    {
        NSLog(@"os系统不支持发短信");
    }
}
-(void)displaySMSComposerSheet:(UIViewController *)vc
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.body = self.body;
    if (self.tel.length > 0) {
       picker.recipients = @[self.tel];
    }
    [self setServiceInfo:picker];
    [vc presentViewController:picker animated:YES completion:^{
        
    }];
    
}
-(void) setServiceInfo:(id)serviceInfo
{
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
        {
            
            break;
        }
        case MessageComposeResultSent:
        {
           
            break;
        }
        case MessageComposeResultFailed:
        {
           
            break;
        }
        default:
        {
            
            break;
        }
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
@interface UIViewController(Communication)
@property(nonatomic,strong)SendMessage *sendMessage;
@end

@implementation UIViewController (Communication)
#pragma mark - 运行时相关
static char WyjsendMessage;
-(SendMessage *)sendMessage
{
    return objc_getAssociatedObject(self, &WyjsendMessage);
}

-(void)setSendMessage:(SendMessage *)sendMessage
{
    objc_setAssociatedObject(self, &WyjsendMessage,
                             sendMessage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


@implementation NSString (Communication)
-(void)dialTelephone
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self ]]];
}
-(void)sendMessageWithViewController:(UIViewController *)vc body:(NSString *)body
{
    if (!vc.sendMessage) {
        vc.sendMessage = [[SendMessage alloc] init];
    }
    if (self.length > 0) {
       vc.sendMessage.tel = self;
    }
    vc.sendMessage.body = body;
    [vc.sendMessage sendMessage:vc];
}


@end