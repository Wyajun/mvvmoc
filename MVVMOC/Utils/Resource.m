//
//  Resource.m
//  jiadao_ios
//
//  Created by 王亚军 on 15/6/12.
//  Copyright (c) 2015年 仲维涛. All rights reserved.
//

#import "Resource.h"

@interface ResourceManager : NSObject
@property(nonatomic,strong)NSCache *resoureCache;
+(instancetype)shareResourceManager;
-(UIImage *)resourceKey:(NSString *)key callBack:(UIImage * (^)(NSString *key))callBack;
@end



@implementation Resource
+(UIImage *)imageName:(NSString *)imageName {
    imageName = [imageName stringByAppendingString:@"@3x.png"];
  return [[ResourceManager shareResourceManager] resourceKey:imageName callBack:^UIImage *(NSString *key) {
      return  [Resource imageFormResource:imageName];
    }];
    
}
+(UIImage *)resizeImage:(NSString *)imgName {
    UIImage *image = [Resource imageName:imgName];
    CGFloat leftCap = image.size.width/2;
    CGFloat topCap = image.size.height/2;
    return  [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap,topCap-1  , leftCap-1 ) resizingMode:UIImageResizingModeTile];
}
+(UIImage *)imageFormResource:(NSString *)imageName {
    
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    return [UIImage imageWithData:data scale:3];
    
}
+(UIImage *)defaultCarImage {
    return  [Resource imageName:@"car_default_pic"];
}
@end

@implementation ResourceManager

+(instancetype)shareResourceManager {
    static ResourceManager *_share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[ResourceManager alloc] initSuper];
    });
    return _share;
}
-(instancetype)initSuper {
    self = [super init];
    if (self) {
        self.resoureCache = [[NSCache alloc] init];
        self.resoureCache.countLimit = 20;
    }
    return self;
}
-(UIImage *)resourceKey:(NSString *)key callBack:(UIImage * (^)(NSString *key))callBack{
    UIImage *image = [self.resoureCache objectForKey:key];
    if (!image) {
        image = callBack(key);
        if (image) {
            [self.resoureCache setObject:image forKey:key];
        }
    }
    return image;
}
@end