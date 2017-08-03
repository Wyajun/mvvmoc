//
//  JDUserManager.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/17.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()

@end



@implementation UserManager

+(instancetype)shareJDUserManager {
   static UserManager *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[UserManager alloc] initSuper];
    });
    return _share;
}
-(instancetype)initSuper {
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)init {
    NSAssert(NO, @"请使用单利方法");
    return nil;
}

-(void)YanZhengMa:(NSString *)phone callback:(void (^)(BOOL,NSString *))callback{
    
}
-(void)login:(NSString *)phone yanZhengMa:(NSString *)yzm callback:(void (^)(BOOL,NSString *))callback{
    __weak typeof(self) weak = self;
    
    
}



-(void)tuiChuiLoginCallBack:(void (^)(BOOL, NSString *))callback {
    __weak typeof(self) weak = self;
    
}
-(void)upDataUserInfo:(NSString *)userName sex:(NSInteger )sex image:(UIImage *)image callback:(void (^)(BOOL, NSString *))callback {
    __weak typeof(self)weak = self;
   
}
-(void)renZhengSeller:(NSString *)userName shopName:(NSString *)shop image:(UIImage *)image callback:(void (^)(BOOL, NSString *))callback {
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);
     __weak typeof(self)weak = self;
    }
-(void)readUserFormKeyChain {
    
    
}


-(void)getSellerInfo:(void(^)(BOOL success,NSString *meg))callback {
    }



-(void)resetUserInfo {
    if (!self.logining) {
        return;
    }
    [self getSellerInfo:nil];
}
#pragma --mark get
-(NSString *)device_token {
    
//    NSString *token = nil;
//    [self.lock lock];
//    token = _dev_token;
//    [self.lock unlock];
//    return token;
    return @"";
}

-(NSString *)cityId {
    return @"1";
}

-(BOOL)logining{
    return YES;
}



-(void)setDevice_token:(NSString *)device_token {
  
    
}

@end
