//
//  BindObject.m
//  mvvm
//
//  Created by 王亚军 on 14-8-23.
//  Copyright (c) 2014年 qing.ruijie. All rights reserved.
//

#import "BindObject.h"
@interface BindObject()
{
    NSMutableDictionary *oiDic;
    dispatch_queue_t    bindObjectQueue;
}
@end

#define ViewTag(view) [NSString stringWithFormat:@"%p",view]

@implementation BindObject
+(instancetype)shareBindObject
{
    static BindObject *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[BindObject alloc] init];
    });
    return _share;
}
-(instancetype)shareBindObject
{
    return [[[self class] alloc] init];
}
-(id)init
{
    self = [super init];
    if (self) {
        oiDic = [NSMutableDictionary dictionary];
        bindObjectQueue = dispatch_queue_create([@"bindObjectQueue" UTF8String], 0);
    }
    return self;
}
- (void)registerObject:(NSString *)oid Object:(id)obj {
   
    dispatch_async(bindObjectQueue, ^{
        if (!oid || !obj) {
            return;
        }
        NSMutableDictionary *oDic = [oiDic objectForKey:oid];
        if (!oDic) {
            oDic = [NSMutableDictionary dictionary];
            [oiDic setObject:oDic forKey:oid];
        }
        BindObjectUnit *unit = [oDic objectForKey:ViewTag(obj)];
        if (unit) {
            unit.countTag++;
            return;
        }
        unit = [[BindObjectUnit alloc] init];
        unit.countTag = 1;
        unit.obj = obj;
        [oDic setObject:unit forKey:ViewTag(obj)];
    });
}

-(void)delRegisterObject:(NSString *)oid Obj:(id)obj
{
   dispatch_async(bindObjectQueue, ^{
       if (!oid || !obj) {
           return;
       }
       NSMutableDictionary *oDic = [oiDic objectForKey:oid];
       if (oDic) {
           BindObjectUnit *unit = [oDic objectForKey:ViewTag(obj)];
           if (unit.countTag > 1) {
               unit.countTag--;
               return;
           }
           [oDic removeObjectForKey:ViewTag(obj)];
       }
   });
}
-(void)delRegisterOid:(NSString *)oid
{
   dispatch_async(bindObjectQueue, ^{
       if (!oid) {
           return;
       }
       NSMutableDictionary *oDic = [oiDic objectForKey:oid];
       if (oDic) {
           [oDic removeAllObjects];
       }

   });
}

-(void)updataObjectOid:(NSString *)oid withDic:(NSDictionary *)dic
{
    dispatch_async(bindObjectQueue, ^{
        if (!oid || !dic || dic.count <= 0) {
            return;
        }
        NSMutableDictionary *oDic = [oiDic objectForKey:oid];
        if (oDic) {
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [oDic enumerateKeysAndObjectsUsingBlock:^(id key1, id obj1, BOOL *stop) {
                    if ([obj1 isKindOfClass:[NSMutableDictionary class]]) {
                        NSMutableDictionary *gdic = obj1;
                        [gdic enumerateKeysAndObjectsUsingBlock:^(id key2, id obj2, BOOL *stop) {
                            BindObjectUnit *unit = obj2;
                            [unit.obj setValue:obj forKeyPath:key];
                        }];
                    }else
                    {
                        BindObjectUnit *unit = obj1;
                        [unit.obj setValue:obj forKeyPath:key];
                    }
                }];
                
            }];
        }
 
    });
}
-(void)registerObject:(NSString *)oid groupid:(NSString *)gid Objects:(NSArray *)objs
{
    dispatch_async(bindObjectQueue, ^{
        if (!oid || !gid || !objs || objs.count <= 0) {
            return;
        }
        NSMutableDictionary *oDic = [oiDic objectForKey:oid];
        if (!oDic) {
            oDic = [NSMutableDictionary dictionary];
            [oiDic setObject:oDic forKey:oid];
        }
        NSMutableDictionary *gdic = [oDic objectForKey:gid];
        if (!gdic) {
            gdic = [NSMutableDictionary dictionary];
            [oDic setObject:gdic forKey:gid];
        }
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BindObjectUnit *unit = [gdic objectForKey:ViewTag(obj)];
            if (!unit) {
                unit = [[BindObjectUnit alloc] init];
                unit.obj = obj;
                unit.countTag = 0;
                [gdic setObject:unit forKey:ViewTag(obj)];
            }
            unit.countTag++;
        }];

    });
}
-(void)delRegisterObject:(NSString *)oid groupid:(NSString *)gid
{
    dispatch_async(bindObjectQueue, ^{
        if (!oid || !gid) {
            return;
        }
        NSMutableDictionary *oDic = [oiDic objectForKey:oid];
        if (oDic) {
            [oDic removeObjectForKey:gid];
        }
    });
}

-(void)dealloc
{
    
}
@end
@implementation BindObjectUnit

-(void)dealloc
{
     NSLog(@"dealloc----%@",NSStringFromClass([self class]));
}

@end